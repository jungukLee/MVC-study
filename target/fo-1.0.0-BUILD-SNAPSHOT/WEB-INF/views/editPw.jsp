<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

 <div class="join_wrap mb40">
     <h2>비밀번호 변경</h2>
     <form action="" class="join_form">
         <!-- pw -->
         <input type="password" id="pw"name="pw" placeholder="비밀번호" class="inputText">
         <input type="password" id="pw_check" placeholder="비밀번호 확인" class="inputText">
         
         <a href="/" class="back_button">홈으로</a>
         <input type="submit" value="비밀번호 변경" class="submit_button">
     </form>
 </div>

<%@ include file="./common/footer.jsp" %>
