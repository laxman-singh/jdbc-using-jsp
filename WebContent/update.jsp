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
		 
		 	<c:if test="${empty param.gstin}">
	            <c:redirect url="search.jsp" >
	            	<c:param name="source" value="update page" />
	                <c:param name="errMsg" value="Please Enter GST Number" />
	            </c:redirect>
        	</c:if>
        	<c:if test="${not empty param.gstin && not cg:isValidGstin(param.gstin)}">
        		<c:redirect url="search.jsp" >
	            	<c:param name="source" value="update page" />
	                <c:param name="errMsg" value="Invalid GSTIN Number" />
	            </c:redirect>
        	</c:if>
        
        	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/gst_db" user="root"  password=""/>
           
            <c:choose>
	            <c:when test="${not empty param.gstin && not empty param.supplierNo}">              
		            <sql:update dataSource="${dbsource}" var="result">
			            update gst_details set gstin = ?, entered_on = NOW() where supplier_no = ?;
			            <sql:param value="${fn:toUpperCase(param.gstin)}" />
			            <sql:param value="${param.supplierNo}" />
		        	</sql:update>
		        </c:when>
		        <c:otherwise>
		        	<c:redirect url="search.jsp" >
			        	<c:param name="source" value="update page" />
		                <c:param name="errMsg" value="Please Enter GSTIN Number" />
		            </c:redirect>
		        </c:otherwise>
		    </c:choose>
        	
        	<c:choose>
        		<c:when test="${result >= 1}">
	        		<c:redirect url="index.jsp" >
		                <c:param name="successMsg" value="Supplier Info with Supplier Number : ${param.supplierNo} Updated Successfully..!!" />
		            </c:redirect>
        		</c:when> 
        		<c:otherwise>
	        		<div class="alert alert-error alert-dismissible fade in">
					    <button type="button" class="close" data-dismiss="alert">&times;</button>
					    <span class="glyphicon glyphicon-warning-sign offset-right" aria-hidden="true"></span>
					     <b>Supplier Info with Supplier Number : <c:out value="${param.supplierNo}"/> failed to Updated ..!! </b>
					</div>
        		</c:otherwise>
        	</c:choose>
		 </div>
		</div>
	</form>
	</div>
</div>
<jsp:include page="static/layouts/footer.jsp"/>
</html>