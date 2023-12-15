<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

 <div class="join_wrap mb40">
     <h2>비밀번호 변경</h2>
     <form action="/editPwService" method="post" class="join_form" id="editPwForm">
        
        <input type="hidden" name="memberIdx" value="${memberIDX}" >
        
         <!-- pw -->
         <input type="password" id="pw"name="password" placeholder="비밀번호" class="inputText">
         <input type="password" id="pw_check" placeholder="비밀번호 확인" class="inputText">
         
         <a href="/" class="back_button">홈으로</a>
         <input type="submit" value="비밀번호 변경" class="submit_button">
     </form>
 </div>

<%@ include file="./common/footer.jsp" %>
<script>	
	$('#editPwForm').submit(function(event) {
	    var pw = $('#pw').val();
	    var pw_check = $('#pw_check').val();
	
	    if (pw !== pw_check) {
	        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
	        event.preventDefault(); // 폼 전송을 막음
	    }
	});	
</script>