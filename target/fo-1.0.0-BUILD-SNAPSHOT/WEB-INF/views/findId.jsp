<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<div class="login_wrap join_wrap">
    <h2>아이디 찾기</h2>
    <form action="" class="join_form">
        <!-- email -->
        <input type="text" name="phone" placeholder="전화번호" class="inputText">
       
        <!-- age -->
        <input type="text" id="pw" name="age" placeholder="생년월일 6자리" class="inputText">
        
        <a href="/findPw" class="back_button">비밀번호 찾기</a>
        <input type="submit" value="아이디 찾기" class="submit_button">
    </form>
</div>

<%@ include file="./common/footer.jsp" %>
