<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../WEB-INF/include/db.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>The MPDL People</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/boxAligner.css" rel="stylesheet">
</head>
<body>
	<div class="vertical-center" align="center">
		<%@ include file="../WEB-INF/include/header.jsp" %>
		<div class="container">
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
					<h2>Search Results</h2>
					<c:choose>
					<c:when test="${not empty resultData.rows}">
						<form method="get" action="QueryServlet">
						<div class="input-group col-xs-3 result-options">
						<span class="input-group-btn">
						<c:choose>
							<c:when test="${fn:contains(message, 'DESC')}">
								<button name="sort_by" class="btn btn-default" value="ASC"><i class="fa fa-sort-asc"></i>Sort by</button>
							</c:when>
							<c:otherwise>
								<button name="sort_by" class="btn btn-default" value="DESC"><i class="fa fa-sort-desc"></i>Sort by</button>
							</c:otherwise>
						</c:choose>
						</span>
						<input name="current_query" type="hidden" value="${message}"/>
							<select name="sort_criteria" class="dropdown form-control">
								<c:forEach items="${nameList}" var="colName" varStatus="status">
									<c:choose>
										<c:when test="${fn:contains(fn:substringAfter(message, 'ORDER BY'), dbNameList[status.index])}">
											<option value="${dbNameList[status.index]}" selected>${colName}</option>
										</c:when>
										<c:otherwise>
											<option value="${dbNameList[status.index]}">${colName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						</form>
						<form method="get" action="EmailListServlet">
					 	<table class="table-striped table-hover table-responsive"> 
					 	<thead> 
					 		<th class="col-md-2"></th>
					 		<c:forEach items="${nameList}" var="colHead">
					 			<th>${colHead}</th>
					 		</c:forEach>
					 	</thead> 
					 	<c:forEach items="${resultData.rows}" var="currentRow">
					 		<tr>
						 		<td class="check">
						 			<input type="checkbox" name="toChoose" value="person${currentRow.person_id}"></input>
						 		</td>
					 			<c:forEach items="${dbNameList}" var="colName">
					 				<td class="col-md-2">${currentRow[colName]}</td>
					 			</c:forEach>
					 			<td class="col-md-2">
					 				<button class="btn btn-default btn-sm" type="submit" formmethod="get" formaction="EditPersonServlet" name="person_id" value="${currentRow.person_id}" class="btn btn-outline">Edit</button>
					 			</td>
					 		</tr>
					 	</c:forEach>
						</table>
						<div class="result-options">
							<button id="sendMail" type="submit" class="btn btn-primary"><i class="fa fa-envelope fa-fw"></i>Email selected</button>
							<button name="editSelected" type="submit" class="btn btn-primary" formmethod="post" formaction="BatchEditServlet" value=1><i class="fa fa-pencil fa-fw"></i>Edit selected</button>
						</div>
						</form>
					</c:when>
					<c:otherwise>
						<p class="alert alert-info"><strong>The search did not return any matches. Try refining your search criteria.</strong></p>
					</c:otherwise>
					</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
	</div>
	<%@ include file="../WEB-INF/include/footer.jsp" %>
</body>
</html>