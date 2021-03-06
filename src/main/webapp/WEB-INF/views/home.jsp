<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Home</title>
</head>
<body>
<h1>한국인식산업</h1>

<sec:authorize access="isAnonymous()">
<p><a href="<c:url value="/login/loginForm" />">로그인</a></p>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
<form:form action="${pageContext.request.contextPath}/logout" method="POST">
    <input type="submit" value="로그아웃" />
</form:form>
</sec:authorize>

<h3>
    [<a href="<c:url value="/intro/introduction.do" />">소개 페이지</a>]
    [<a href="<c:url value="/admin/adminHome.do" />">관리자 홈</a>]
</h3>
</body>
</html>

<!-- https://github.com/kdevkr/spring-demo-security -->
<!-- https://m.blog.naver.com/PostView.nhn?blogId=sam_sist&logNo=220964537132&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F -->
