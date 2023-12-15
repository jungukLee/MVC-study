<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<div class="login_wrap join_wrap">
    <h2>로그인</h2>
    <form action="" class="join_form">
        <!-- id -->
        <input type="text" name="id" placeholder="아이디" class="inputText">
       
        <!-- pw -->
        <input type="password" id="pw"name="pw" placeholder="비밀번호" class="inputText">
        
        <a href="/" class="back_button">돌아가기</a>
        <input type="submit" value="로그인" class="submit_button">
        <div class="serch_info">
            <a href="/findId">아이디 찾기 </a>
            <a href="/findPw">비밀번호 찾기</a>
        </div>
    </form>
</div>

<%@ include file="./common/footer.jsp" %>
