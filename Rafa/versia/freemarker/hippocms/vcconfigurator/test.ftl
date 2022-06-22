<#include "../../include/imports.ftl">
<div class="container">
	<h1> Selseries </h1>
	
	<#--  variable creada para obtener el link del doaction  -->
	<@hst.actionURL var="actionLink"/>
	<form action="${actionLink}" method="get">
	  
	  <div class="form-group">
	    <label for="inputConjunto">Cargar un conjunto</label>
	    <#--  es necesario poner name para que el formMap lo coja  -->
	    <input type="text" class="form-control" id="inputConjunto" aria-describedby="conjuntoHelp" placeholder="Introduzca un conjunto" name="inputConjunto">
	    <small id="conjuntoHelp" class="form-text text-muted">Ejemplo 'CJ_034'.</small>
	  </div>
	  
	  <button type="submit" class="btn btn-default">Cargar</button>
	  
	  
	</form>
</div>