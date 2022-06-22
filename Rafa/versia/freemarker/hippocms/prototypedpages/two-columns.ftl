<#include "../../include/imports.ftl">

<@hst.include ref="carousel" />
<div class="container" ${hidebreadcrumbs???then("style='display:none'","")}>
         <@hst.include ref="breadcrumb"/>
</div>
<main class="smc-main-container">
	<@hst.include ref="title" />
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<@hst.include ref="left"/>
			</div>
			<div class="col-md-4 smc-sidebar">
				<@hst.include ref="right"/>
			</div>
		</div>
	</div>
</main>
