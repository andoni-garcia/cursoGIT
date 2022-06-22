import "babel-polyfill";
import React from 'react';
import ReactDOM from 'react-dom';

class Form extends React.Component {

    state = { searchQuery: '' }


    doSearch = (event) => {

        this.setState({
            searchQuery: event.target.value
        }, () => {
            this.props.onSomething(this.state.searchQuery)
        })
    }

    resetForm = (event) => {
        event.preventDefault()
        this.setState({
            searchQuery: ''
        }, () => {
            this.props.resetResults()
        })
    }

    render() {

        return(
            <form className="row" onSubmit={this.resetForm}>
                <div className="form-group col-md-10">
                    <input
                        type="text"
                        className="form-control"
                        placeholder={this.props.formData.placeholder}
                        value={this.state.searchQuery}
                        onChange={this.doSearch}
                    />
                    <div className="search-inpage__submit">
                        <span className="icon-close"></span>
                    </div>
                </div>

                <div className="form-group col-md-2">
                    <button type="submit" className="btn btn-primary btn-full">{this.props.formData.buttonLabel}</button>
                </div>
            </form>
        )
    }
}

class Thead extends React.Component {
    state = {
        asc: false,
        sorted: false
    }

    testur = (header) => {
        this.props.onSort(header, this.state.asc)
        this.setState({
            asc: !this.state.asc,
            sorted: true
        })
    }

    getStuff = (header) => {
        let ret = ''
        if( header.label !== 'documents') {
            ret = <th onClick={() => this.testur(header.label)} key={header.label} data-sort="string"><span>{header.translation}</span></th>
        } else {
            ret = <th className="content-lister__resultsTable--noSort" key={header.label}><span>{header.translation}</span></th>
        }
        return ret
    }

    render() {

        return (
            <thead>
            <tr>
                {this.props.headers.map( header => (
                    this.getStuff(header)
                ))}
            </tr>
            </thead>
        )
    }
}


const Field = (props) => {
    return (
        <td dangerouslySetInnerHTML={ {__html: props.label} } />
    )
}

const FieldImage = (props) => {
    return (
        <td><img className="simbol-image" src={props.label} /></td>
    )
}

const Filesmodal = (props) => {
    return (
        <div className="filesModal content-lister__modal">
            <ul>
                {props.files.map(file=> {
                    return <li><a target="_blank" href={file.url}>{file.label}</a></li>
                })}
            </ul>
        </div>
    )
}

const Langmodal = (props) => {

    return (
        <li className="content-lister__resultsTable--modalTrigger content-lister__resultsTable__iconContainer">
            <a href="#"><i className="icon-small-plus"></i></a>
            <div className="langModal content-lister__modal">
                <ul>
                    {
                        props.langs.map(lang=> {
                            const files = lang.files.map(file => {
                                return <li><a target="_blank" href={file.url}>{file.label}</a></li>
                            });

                            return [<li>{lang.lang}</li>, files]
                        })
                    }
                </ul>
            </div>
        </li>
    )
}

class Documents extends React.Component {

    getList = (docs) => {

        let list = []
        let secondaryLanguages = docs.slice(0);
        let primaryLanguages = secondaryLanguages.splice(0,2)

        primaryLanguages.map(doc=> {
            if(doc.files.length === 0) {

                if( doc.lang != null ) {
                    list.push(<li className="content-lister__resultsTable__emptyLink">{doc.lang}</li>)
                }
            }
            else if(doc.files.length === 1) {
                list.push(<li><a target="_blank" href={doc.files[0].url}>{doc.lang}</a></li>)
            } else {
                list.push(
                    <li className="content-lister__resultsTable--modalTrigger">
                        <a href="#">
                            {doc.lang}
                        </a>
                        <Filesmodal files={doc.files} />
                    </li>
                )
            }
        })

        if( secondaryLanguages.length > 0) {
            list.push(<Langmodal langs={secondaryLanguages} />)
        } else {
            //list.push(<li className="content-lister__resultsTable__inactiveMoreLangs"><i className="icon-small-plus"></i></li>)
        }

        return list
    }

    render() {

        return (
            <td>
                <ul className="content-lister__resultsTable__langList">
                    {this.getList(this.props.documents)}
                </ul>
            </td>
        )
    }
}

const Tbody = (props) => {

    const getFields = (item) => {
        let fields = []
        props.fieldsToDisplay.map(h => {
            if (h.label === 'symbol') {
                fields.push(<FieldImage label={item[h.label]} />)
            } else {
                fields.push(<Field label={item[h.label]} />)
            }

        })
        return fields
    }

    return (
        <tbody>

        {props.items.map(i => {
            return (
                <tr>
                    {getFields(i)}
                    <Documents documents={i.documents} />
                </tr>
            )
        })}

        </tbody>
    )
}

class Thitem extends React.Component {

    getClassName = () => {
        let clz = ''
        if( this.props.sortable === true) {
            if( this.props.sorted === null) {
                clz = ''
            } else {
                if( this.props.sorted === true) {
                    clz = 'headerSortUp'
                } else {
                    clz = 'headerSortDown'
                }
            }
        } else {
            clz = 'content-lister__resultsTable--noSort'
        }

        return clz

    }

    thClicked = () => {
        if( this.props.sortable === true) {
            this.props.onSetHeaderSortInfo(this.props.code, this.getClassName)
        }
        // this.setClassName()
    }

    render() {
        return (
            <th className={this.getClassName()} onClick={this.thClicked}><span>{this.props.label}</span></th>
        )
    }
}

const Theader = (props) => {
    return (
        <thead>
        <tr>
            {props.headers.map( header => (
                <Thitem sorted={header.sorted} label={header.translation} onSort={props.onSort} onSetHeaderSortInfo={props.onSetHeaderSortInfo} code={header.label} sortable={header.sortable}/>
            ))}
        </tr>
        </thead>
    )
}

class Table extends React.Component {
    render() {
        if (this.props.itemsLength > 0) {
            return (
                <div className="row">
                    <div className="col-md-12">
                        <table className="content-lister__resultsTable">
                            <Theader
                                headers={this.props.headers}
                                onSort={this.props.onSort}
                                onSetHeaderSortInfo={this.props.onSetHeaderSortInfo}
                            />
                            <Tbody
                                items={this.props.items}
                                fieldsToDisplay={this.props.fieldsToDisplay}
                            />
                        </table>
                    </div>
                </div>
            )
        }
        return null
    }

}

class App extends React.Component {

    componentDidMount() {
        this.sortJson('model', true)
    }

    state = {
        items: this.props.data.items,
        headers: this.props.data.headers,
        fieldsToDisplay: this.props.data.fieldsToDisplay,
        formData: this.props.data.formData
    }

    filterData = (item, regex) => {
        let ret = false
        this.state.fieldsToDisplay.map(key => {
            if(item[key.label].match(regex)) {
                ret = true
            }
        })
        return ret
    }

    testFilter = (inp) => {
        let result = []
        let regex = new RegExp(inp, 'gi')
        this.props.data.items.map(item => {
            if( this.filterData(item, regex) ) {
                result.push(item)
            }
        })
        return result
    }


    testAppMethod = (x) => {
        this.setState({
            items: this.testFilter(x)
        })
    }

    resetResults =  () => {
        this.setState({
            items: this.props.data.items
        }, () => {
            this.sortJson('model', true)
            this.resetHeaderSort()
        })
    }

    sortJson = (key, asc) => {
        let array = this.state.items
        array.sort(function(a, b) {
            let x = a[key]; let y = b[key];
            if( asc === true) {
                return ((x < y) ? -1 : ((x > y) ? 1 : 0));
            } else {
                return ((x > y) ? -1 : ((x < y) ? 1 : 0));
            }
        });
        this.setState({
            items: array
        })
    }

    resetHeaderSort = () => {
        let headers = this.state.headers
        headers.map((h) => {
            h.sorted=null
        })
        console.log(headers)
    }

    setHeaderSortInfo = (label, callback) => {
        let headers = this.state.headers
        let headerId = this.state.headers.findIndex(x => x.label==label)
        let sortValue = headers[headerId].sorted

        headers.map((h) => {
            h.sorted = null
        })

        headers[headerId].sorted=!sortValue
        this.setState({
            headers: headers
        }, () => {
            this.sortJson(label, headers[headerId].sorted)
            callback()
        })
    }

    render() {

        return (
            <div>
                <Form
                    onSomething={this.testAppMethod}
                    resetResults={this.resetResults}
                    formData={this.state.formData}
                />
                <Table
                    headers={this.state.headers}
                    items={this.state.items}
                    fieldsToDisplay={this.state.fieldsToDisplay}
                    itemsLength={this.state.items.length}
                    onSort={this.sortJson}
                    onSetHeaderSortInfo={this.setHeaderSortInfo}
                />
            </div>
        )
    }
}

let generateFieldsToDisplay = (headers) => {
    let fieldsToDisplay = [];
    headers.map((h) => {
        if( h.label !== 'documents') {
            fieldsToDisplay.push({
                label: h.label
            })
        }
    })
    return fieldsToDisplay
}

if( $('#js--contentLister').length > 0 ) {
    let data = JSON.parse( $('#js--contentLister').html() )
    let processedHeaders = []
    let sortbl = ''
    for(var key in data.headers) {
        sortbl = key === 'documents' ? false : true
        processedHeaders.push({
            "label": key,
            "translation": data.headers[key],
            "sorted": null,
            "sortable": sortbl
        })
    }
    data.headers = processedHeaders
    data.fieldsToDisplay = generateFieldsToDisplay(data.headers)

    ReactDOM.render(
        <App data={data} />,
        document.getElementById('root')
    );
}
