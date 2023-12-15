<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<div class="login_wrap join_wrap">
    <h2>마이페이지</h2>
    <form action="" class="join_form">
        <!-- nickname -->
        <input type="text" name="nickname" placeholder="닉네임" class="inputText">

        <!-- pw -->               
        <input type="password" id="pw"name="pw" placeholder="현재 비밀번호" class="inputText">

        <input type="password" id="pw"name="pw" placeholder="변경할 비밀번호" class="inputText">
        <input type="password" id="pw_check" placeholder="비밀번호 확인" class="inputText">
        
        <!-- age  -->
        <input type="text" placeholder="생년월일 6자리 (예:000215)" class="inputText">

         <!-- gender -->
        <select name="genedr" id="" class="inputSelect mr20">
            <option selected disabled hidden>성별</option>
            <option value="man">남자</option>
            <option value="girl">여자</option>
        </select>
        <!-- address -->
        <select name="address" id="" class="inputSelect">
            <option selected disabled hidden>지역</option>
            <option value="서울">서울</option>
            <option value="인천">인천</option>
            <option value="부산">부산</option>
            <option value="대구">대구</option>
            <option value="광주">광주</option>
            <option value="대전">대전</option>
            <option value="울산">울산</option>
            <option value="세종">세종</option>
            <option value="경기">경기</option>
            <option value="강원">강원</option>
            <option value="충청">충청</option>
            <option value="전라">전라</option>
            <option value="경상">경상</option>
            <option value="제주">제주</option>
        </select>

        <!-- phone -->
        <input type="text" name="phone" placeholder="번호 ( 예 : 01024984595 )" class="inputText wid">

        <!-- email -->
        <input type="text" name="email" placeholder="이메일 ( 예 : Hello@google.com )" class="inputText">

        <a href="/" class="back_button">돌아가기</a>
        <input type="submit" value="수정하기" class="submit_button">
    </form>
</div>

<%@ include file="./common/footer.jsp" %>
