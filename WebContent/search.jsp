<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/CustomTagLib" prefix="cg" %>
<!DOCTYPE html>
<html>
<jsp:include page="static/layouts/header.jsp"/>
	<div class="jumbotron">
		<div class="container-fluid">
		 <form class="form-horizontal" action="update.jsp" method="POST">
		 <div class="container">
		 <div class="well">
		 	
		 <c:choose>
		 	<c:when test="${empty param.supplierNo && empty param.panNo && empty param.source}">
	            <c:redirect url="index.jsp" >
	                <c:param name="errMsg" value="Please enter either PAN or Supplier Number." />
	            </c:redirect>
        	</c:when>
        	<c:when test="${not empty param.supplierNo && not cg:isValidSupplierNo(param.supplierNo)}">
        		<c:redirect url="index.jsp" >
	                <c:param name="errMsg" value="Invalid Supplier Number." />
	            </c:redirect>
        	</c:when>
        	<c:when test="${not empty param.panNo && not cg:isValidPan(param.panNo)}">
        		<c:redirect url="index.jsp" >
	                <c:param name="errMsg" value="Invalid PAN Number." />
	            </c:redirect>
        	</c:when>
        	<c:when test="${not empty param.source && not empty param.errMsg}">
        		<div class="alert alert-error alert-dismissible fade in">
				    <button type="button" class="close" data-dismiss="alert">&times;</button>
				    <span class="glyphicon glyphicon-warning-sign offset-right" aria-hidden="true"></span><c:out value="${param.errMsg}" />
				</div>
        	</c:when>
        	
        	<c:otherwise>
	        	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
	                           url="jdbc:mysql://localhost/gst_db" user="root"  password=""/>
	                           
	            <sql:query dataSource="${dbsource}" var="result">
		            SELECT * from gst_details where supplier_no = ? OR pan = ?;
		            <sql:param value="${param.supplierNo}" />
		            <sql:param value="${fn:toUpperCase(param.panNo)}" />
	        	</sql:query>
	        	
	        	<c:choose>
	        	<c:when test="${not empty result && fn:length(result.rows) == 1}">
	        	<c:set var="supplierInfo" value="${result.rows[0]}"/>
	        		<!-- supplier info panel start -->
				 	<div class="panel panel-success">
							<div class="panel-heading panel-heading-extended">
								<h5 class="panel-title panel-title-subtitle"><b>Supplier Info linked to 
									<c:choose>
										<c:when test="${not empty param.supplierNo}"> Supplier No : <c:out value="${param.supplierNo}"></c:out></c:when>
										<c:otherwise> PAN No : <c:out value="${param.panNo}"></c:out></c:otherwise>
									</c:choose>
								</b></h5>
							</div>
							<div class="panel-body">
							
								<c:if test="${not empty param.errMsg}">
									<div class="well well-sm">
								 		<div class="alert alert-error alert-dismissible fade in">
										    <button type="button" class="close" data-dismiss="alert">&times;</button>
										    <span class="glyphicon glyphicon-warning-sign offset-right" aria-hidden="true"></span>
												<c:out value="${param.errMsg}"></c:out>
										</div>
								 	</div>
							 	</c:if>
							
								  <div class="form-group">
								    <label class="col-sm-2 control-label">Supplier No</label>
								    <div class="col-sm-2">
								      <p class="form-control-static">${supplierInfo.supplier_no}</p>
								    </div>
								    
								    <label class="col-sm-2 control-label">Supplier Name</label>
								    <div class="col-sm-6">
								      <p class="form-control-static">${supplierInfo.supplier_name}</p>
								    </div>
								  </div>
								  
								  <div class="form-group">
								    <label class="col-sm-2 control-label">Vendor Site Code</label>
								    <div class="col-sm-2">
								      <p class="form-control-static">${supplierInfo.vendor_site_code}</p>
								    </div>
								    
								    <label class="col-sm-2 control-label">Site RAO</label>
								    <div class="col-sm-6">
								      <p class="form-control-static">${supplierInfo.site_rao}</p>
								    </div>
								  </div>
								  
								  <div class="form-group">
								    <label class="col-sm-2 control-label">PAN No.</label>
								    <div class="col-sm-2">
								      <p class="form-control-static">${supplierInfo.pan}</p>
								    </div>
								    
								    <label class="col-sm-2 control-label">Address</label>
								    <div class="col-sm-6">
								      <p class="form-control-static">${supplierInfo.address}</p>
								    </div>
								  </div>
								  
								  <div class="form-group">
								    <label class="col-sm-2 control-label">GST No.</label>
								    <div class="col-sm-3">
								      <input type="text" class="form-control" name="gstin" placeholder="GST No" 
								      	pattern="[0-9]{2}[A-Z_a-z]{5}[0-9]{4}[A-Z_a-z]{1}[0-9]{1}[Z_z]{1}[0-9_A-Z_a-z]{1}" autofocus value="${supplierInfo.gstin}" 
								      	required oninvalid="this.setCustomValidity('Invalid GST Number')" oninput="setCustomValidity('')" style="text-transform: uppercase"/>
								    </div>
								    
								    <c:if test="${not empty supplierInfo.entered_on}">
								    	<label class="col-sm-2 control-label">Updated On</label>
									    <div class="col-sm-2">
									      <p class="form-control-static">${supplierInfo.entered_on}</p>
									    </div>
								    </c:if>
								  </div> 
								 
								 <input type="hidden" value="${supplierInfo.supplier_no}" name="supplierNo"/>
								 
								  <div class="form-group">
								  		<div class="col-sm-5"></div>
								  		<div class="btn-group" role="group">
										    <button type="submit" class="btn btn-primary" name="update">
										    <span class="glyphicon glyphicon-floppy-open" aria-hidden="true"></span> Update</button>
										</div>
								  </div>
								  		
							</div>
						</div>
				 	<!-- supplier info panel end -->
	        	</c:when> 
	        	<c:when test="${not empty result && fn:length(result.rows) > 1}">
	        		<div class="alert alert-error alert-dismissible fade in">
					    <button type="button" class="close" data-dismiss="alert">&times;</button>
					    <span class="glyphicon glyphicon-warning-sign offset-right" aria-hidden="true"></span>
						More than One Supplier Info found with linked with this Supplier Number or PAN Number.
					</div>
	        	</c:when>
	        	<c:otherwise>
					<c:redirect url="index.jsp" >
		                <c:param name="errMsg" value="No Supplier info found with this Supplier/PAN No"></c:param>
		            </c:redirect>
	        	</c:otherwise>
	        	</c:choose>
        	</c:otherwise>
        </c:choose>
		 </div>
		</div>
	</form>
	</div>
</div>
<jsp:include page="static/layouts/footer.jsp"/>
</html>