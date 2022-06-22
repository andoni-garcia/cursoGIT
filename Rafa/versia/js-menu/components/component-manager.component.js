(function(globalConfig) {
    var components = {};
    var actions = {};
    var MEMORY_CACHE = {};
    var CACHE_VALID_TIME = 60 * 1000;//1 min

    function ComponentManager() {}

    ComponentManager.init = init;
    ComponentManager.registerComponent = registerComponent;
    ComponentManager.deregisterComponent = deregisterComponent;
    ComponentManager.list = getAll;
    ComponentManager.getAll = getAll;
    ComponentManager.getComponentById = getComponentById;
    ComponentManager.checkForActions = checkForActions;
    ComponentManager.cache = cache;
    ComponentManager.getETechOnlineStatus = cache('ETECH_ONLINE_STATUS', _getETechOnlineStatus, CACHE_VALID_TIME);
    ComponentManager.getCadenasOnlineStatus = cache('CADENAS_STATUS', _getCadenasOnlineStatus, CACHE_VALID_TIME);

    function init() {
        console.debug('[ComponentManager]', 'init');
        initializeEvents();
    }

    function checkForActions() {
        //Execute an action
        var url = new URL(window.location.href);
        var componentId = url.searchParams.get('componentId');
        var action = url.searchParams.get('action');
        var actionParams = url.searchParams.get('actionParams') || [];
        var component = getComponentById(componentId);

        var data = [actionParams];
        try {
            //TODO Avoid not to try to decode always
            data = JSON.parse(decodeURI(actionParams));
        } catch(e) {
            // It's empty because it will generate to much console noise until the above TODO is resolved
            //console.error('[ComponentManager]', 'Error parsing "actionParams"', e);
        }

        var actionAlreadyExecuted = actions[componentId + action];
        var actionErrored = actionAlreadyExecuted && actions[componentId + action] === 'ERROR';
        var canExecuteAction = !actionAlreadyExecuted || actionErrored;
        if (component && action && canExecuteAction) {
            console.log('[ComponentManager]', 'executingAction', componentId, component);
            var promise = component[action].apply(component, data);
            actions[componentId + action] = 'STARTING';

            if (promise && promise.always) {
                promise
                    .fail(function () {
                        actions[componentId + action] = 'ERROR';
                    }.bind(this, componentId, action))
                    .always(function (componentId, action) {
                        setActionAsExecuted(componentId, action);
                    }.bind(this, componentId, action));
            } else {
                setActionAsExecuted(componentId, action);
            }
        }
    }

    function initializeEvents() {
        $(document).on('smc.registercomponent', function (event, componentId, component) {
            registerComponent(componentId, component);
        });

        $(document).on('smc.deregistercomponent', function (event, componentId) {
            deregisterComponent(componentId);
        });
    }

    function registerComponent(componentId, component) {
        console.debug('[ComponentManager]', 'registerComponent', componentId, component);
        if (components[componentId]) {
            console.warn('[ComponentManager]', 'registerComponent', 'overriding existing component', componentId);
        }
        components[componentId] = component;

        checkForActions();
    }

    function deregisterComponent(componentId) {
        console.debug('[ComponentManager]', 'deregisterComponent', componentId);
        delete components[componentId];
    }

    function getAll() {
        return components;
    }

    function getComponentById(componentId) {
        return components[componentId];
    }

    function setActionAsExecuted(componentId, action) {
        console.debug('[ComponentManager]', 'setActionAsExecuted', componentId, action);
        actions[componentId + action] = 'DONE';

        //Removes the url params after the use
        if (window.history && window.history.replaceState) {
            var url = new URL(window.location.href);
            url.searchParams.delete('componentId');
            url.searchParams.delete('action');
            url.searchParams.delete('actionParams');
            
            window.history.replaceState({}, window.document.title, url.toString());
        }
    }

    //TODO Extract logic from Product Toolbar
    function _getETechOnlineStatus() {
        return $.getJSON(globalConfig.productToolbar.urls.getETechOnlineStatus);
    }

    //TODO Extract logic from Product Toolbar
    function _getCadenasOnlineStatus() {
        return $.getJSON(globalConfig.productToolbar.urls.getCadenasOnlineStatus);
    }

    /**
     * Allows to cache any method (with promise)
     */
    function cache(cacheKey, func, time) {
        return function () {
            var def = $.Deferred();

            var cacheItem = MEMORY_CACHE[cacheKey];
            var isValidCache = cacheItem && (cacheItem.date.getTime() + time) > new Date().getTime();
            if (isValidCache) {
                def.resolve(cacheItem.response);
                return def.promise();

            } else {
                cacheItem = null;

                return func.call(this)
                    .then(_storeCacheAndReturn.bind(this, cacheKey));
            }
        }
    }

    function _storeCacheAndReturn(cacheKey, response) {
        var def = $.Deferred();

        MEMORY_CACHE[cacheKey] = {
            date: new Date(),
            response: response
        };

        def.resolve(response);

        return def.promise();
    }

    ComponentManager.init();
    ComponentManager.checkForActions();

    globalConfig.ComponentManager = globalConfig.ComponentManager || ComponentManager;
})(window.smc);