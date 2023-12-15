<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<div class="login_wrap join_wrap">
    <h2>아이디 찾기</h2>
    <form action="/searchIDservice" method="post" class="join_form" id="serarchIDform">
        <!-- email -->
        <input type="text" name="phone" placeholder="전화번호" class="inputText">
       
        <!-- age -->
        <input type="text" id="pw" name="age" placeholder="생년월일 6자리" class="inputText">
        
        <a href="/findPw" class="back_button">비밀번호 찾기</a>
        <input type="submit" value="아이디 찾기" class="submit_button">
    </form>
</div>

<%@ include file="./common/footer.jsp" %>
<script>
	$("#serarchIDform").submit(function(event) {
	    event.preventDefault();
	
	    // Ajax 요청 수행
	    $.ajax({
	        type: "POST",
	        url: "/searchIDservice",
	        data: $(this).serialize(), // 폼 데이터를 직렬화하여 전송
	        success: function(response) {
	            if(response == "no"){
	            	alert("존재하는 ID가 없습니다.");
	            }else{
	            	alert("ID는 ["+response+"] 입니다.");
	            }
	        },
	        error: function(error) {
	            alert("오류")
	            console.log(error);
	        }
	    });
	});
</script>