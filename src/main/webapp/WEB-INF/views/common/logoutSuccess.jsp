<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 완료</title>
</head>
<body>
	<script>
		var cur = window.location.href.split("=");
		if( cur[cur.length-1] == '1' ){
			alert("로그아웃!");
			location.href="/";	
		}else{
			alert("잘못된 접근입니다.");
			location.href="/main";
		}
</script>
</body>
</html>