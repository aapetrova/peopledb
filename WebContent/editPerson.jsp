<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="../WEB-INF/include/db.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

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
			<h2>Edit person</h2>
			<div class="jumbotron">
			<form method="post" action="EditPersonServlet">
				<c:forEach items="${personData.rows}" var="personInfo">
					<input type="hidden" name="person_id" value="${personInfo.person_id}"/>
					<h3>Basic Data</h3>
					<table>
					<c:set var = "groupName" scope = "session" value = "Basic Data"/>
					<c:forEach items="${propertySet.rows}" var="current">
						<c:if test="${current.group_name ne groupName}">
							<c:set var = "groupName" scope = "session" value = "${current.group_name}"/>
							<tr><td colspan=2 align="center"><h3>${groupName}</h3></td></tr>
						</c:if>
						<tr>
							<td><label for="${current.db_name}">${current.name}</label></td>
							<c:set var = "type" scope = "session" value = "${current.type}"/>
							<c:choose>
								<c:when test="${'boolean' eq type}">
									<c:choose>
										<c:when test="${current.required eq true}">
											<td><label class="radio-inline"><input type="radio" id="${current.db_name}" name="${current.db_name}" value="TRUE" required/>Yes</label>
												<label class="radio-inline"><input type="radio" id="${current.db_name}" name="${current.db_name}" value="FALSE" required/>No</label>
											</td>
										</c:when>
										<c:otherwise>
											<td><label class="radio-inline"><input type="radio" id="${current.db_name}" name="${current.db_name}" value="TRUE"/>Yes</label>
												<label class="radio-inline"><input type="radio" id="${current.db_name}" name="${current.db_name}" value="FALSE"/>No</label>
											</td>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${'decimal' eq type}">
									<c:set var = "col" scope = "session" value = "${current.db_name}"/>
									<c:choose>
										<c:when test="${current.required eq true}">
											<td><input class="form-control" type="number" step="0.0001" name="${current.db_name}" value="${personInfo[col]}" required/></td>
										</c:when>
										<c:otherwise>
											<td><input class="form-control" type="number" step="0.0001" name="${current.db_name}" value="${personInfo[col]}"/></td>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:set var = "col" scope = "session" value = "${current.db_name}"/>
									<c:choose>
										<c:when test="${current.required eq true}">
											<td><input class="form-control" type="${current.type}" name="${current.db_name}" value="${personInfo[col]}" required/></td>
										</c:when>
										<c:otherwise>
											<td><input class="form-control" type="${current.type}" name="${current.db_name}" value="${personInfo[col]}"/></td>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					</table>
					<button type="submit" class="btn btn-primary" name="save" value="Save">Save</button>
					<button type="submit" class="btn btn-danger" name="delete_user" value="${personInfo[person_id]}"
							formmethod="post" formaction="DeleteUserServlet"
							onclick="return confirm('Are you sure you want to delete this user?')">Delete person</button>
				</c:forEach>
			</form>
			</div>
			</c:otherwise>
			</c:choose>
			</div>
			<%@ include file="../WEB-INF/include/footer.jsp" %>
		</div>
</body>
</html>