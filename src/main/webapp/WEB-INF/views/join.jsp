<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>미래모임</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="icon" href="resources/imgs/favi.ico" type="image/x-icon">
</head>
<body class="bgcolorGray"> 

    <div class="join_wrap">
        <h2>회원가입</h2>
        <form action="/joinService" method="post" class="join_form">
            <!-- id -->
            <input type="text" name="userId" placeholder="아이디" class="inputText" required>
           
            <!-- pw -->
            <input type="password" id="pw" name="password" placeholder="비밀번호" class="inputText" required>
            
            <!-- nickname -->
            <input type="text" name="nickname" placeholder="닉네임" class="inputText" required>
    
            <!-- age  -->
            <input type="text" name="age" placeholder="생년월일 6자리 (예:000215)" class="inputText" required>

            <!-- gender -->
            <select name="gender" id="" class="inputSelect mr20" required>
                <option selected disabled hidden>성별</option>
                <option value="남자">남자</option>
                <option value="여자">여자</option>
            </select>

            <!-- address -->
            <select name="address" id="" class="inputSelect" required>
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
            <input type="text" name="phone" placeholder="번호 ( 예 : 01024984595 )" class="inputText wid" required>
       
            <!-- email -->
            <input type="text" name="email" placeholder="이메일 ( 예 : Hello@google.com )" class="inputText" required>
            
            <a href="/" class="back_button">돌아가기</a>
            <input type="submit" value="회원가입" class="submit_button" required>

        </form>
    </div>
<!--
     
  o`id` VARCHAR(45) NULL,
  o`password` VARCHAR(2000) NULL,
  o`ninkname` VARCHAR(15) NULL,
  o`age` VARCHAR(45) NULL,
  o`gender` VARCHAR(45) NULL,
  o`address` VARCHAR(100) NULL,
  o`phone` VARCHAR(45) NULL,
  o`email` VARCHAR(45) NULL,
    -->

</body>

</html>