<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post">
	<security:csrfInput/>
	<h4>진짜 로그아웃?</h4>
	<input type="submit" value="응로그아웃!"/>
</form>
</body>
</html>