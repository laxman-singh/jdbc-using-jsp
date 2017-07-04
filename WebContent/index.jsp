<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<jsp:include page="static/layouts/header.jsp"/>
	<div class="jumbotron">
		<div class="container-fluid">
		 <form class="form-filter" action="search.jsp" method="POST">
		 <div class="container">
		 <div class="well">
		 	<div class="well well-sm">
		 		<c:if test="${not empty param.errMsg}">
			 		<div class="alert alert-error alert-dismissible fade in">
					    <button type="button" class="close" data-dismiss="alert">&times;</button>
					    <span class="glyphicon glyphicon-warning-sign offset-right" aria-hidden="true"></span><c:out value="${param.errMsg}" />
					</div>
				</c:if>
				<c:if test="${not empty param.successMsg}">
					<div role="alert" class="alert alert-success alert-dismissible alert-full fade in">
					    <button type="button" class="close" data-dismiss="alert">&times;</button>
					    <div class="container">
					        <span class="glyphicon glyphicon-ok-sign offset-right" aria-hidden="true"></span>
					        <b>${param.successMsg}</b>
					    </div>
					</div> 
				</c:if>
				<br/>
				<div class="row">
					<div class="col-sm-3">
			            <div class="form-group">
			                <label>Supplier Number</label>
			                <input placeholder="Supplier Number" class="form-control validate" title="Enter Supplier Number to search" name="supplierNo" type="text" 
						    	pattern="^\d+$" autofocus
						    	oninvalid="this.setCustomValidity('Invalid Supplier Number')" oninput="setCustomValidity('')" /> 
			            </div>
			        </div>
			        <div class="col-xs-1">
			            <div class="form-group">
			            	<label>OR</label>
			            </div>
			        </div>
			        <div class="col-sm-3">
			            <div class="form-group">
			                <label>PAN Number</label>
			                <input placeholder="PAN Number" class="form-control validate" name="panNo" type="text" 
						    	pattern="[A-Z_a-z]{5}[0-9]{4}[A-Z_a-z]{1}" autofocus
						    	oninvalid="this.setCustomValidity('Invalid PAN Number')" oninput="setCustomValidity('')" style="text-transform: uppercase" /> 
			            </div>
			        </div>
			        <div class="col-sm-3">
			            <div class="form-actions">
			                <button type="submit" class="btn btn-primary btn-raised" name="search"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 
				        	Search Supplier Detail Using Supplier/PAN Number</button> 
			            </div>
			        </div>
				</div>
		 	</div>
		 </div>
		</div>
	</form>
	</div>
</div>
<jsp:include page="static/layouts/footer.jsp"/>
</html>