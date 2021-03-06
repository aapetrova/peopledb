<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>The MPDL People</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/boxAligner.css" rel="stylesheet">
</head>
<body>
<div class="col-xs-11 vertical-center" align="center">
<div class="container">
<%@ include file="../WEB-INF/include/header.jsp" %>
		<h2>Email dispatch</h2>
		<c:choose>
			<c:when test="${not empty message}">
				<p class="alert alert-success"><strong>${message}</strong></p>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${not empty error}">
				<p class="alert alert-danger"><strong>${error}</strong></p>
			</c:when>
			<c:otherwise>
				<table class="table-responsive">
			<tr>
				<th class="col-md-4">Subject: </th>
				<td class="col-md-4">${subject}</td>
			</tr>
			<tr>
				<th class="col-md-4">Content: </th>
				<td class="col-md-4">${content}</td>
			</tr>
		</table>
			</c:otherwise>
		</c:choose>
	<%@ include file="../WEB-INF/include/footer.jsp" %>
</div>
</div>
</body>
</html>