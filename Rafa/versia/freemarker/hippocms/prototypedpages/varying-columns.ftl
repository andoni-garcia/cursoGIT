<#include "../../include/imports.ftl">

<@hst.include ref="carousel" />
<div class="container" ${hidebreadcrumbs???then("style='display:none'","")}>
	<@hst.include ref="breadcrumb"/>
</div>
<main class="smc-main-container">
	<@hst.include ref="title" />
	<div class="container">
		<div class="row">
			<div class="col-xl-8">
				<@hst.include ref="first-left"/>
			</div>
			<div class="col-xl-4 smc-sidebar">
				<@hst.include ref="first-right"/>
			</div>
		</div>
	</div>
	<@hst.include ref="central"/>
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<@hst.include ref="second-left"/>
			</div>
			<div class="col-md-4 smc-sidebar">
				<@hst.include ref="second-right"/>
			</div>
		</div>
	</div>
</main>
