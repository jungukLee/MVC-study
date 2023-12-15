<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>미래모임</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="icon" href="resources/imgs/favi.ico" type="image/x-icon">
</head>
<body>
<div id="wrapper">
        <header>
            <div class="header_wrap wrap">
                <a href="/login">로그인</a>
                <a href="/join">회원가입</a>
                <!--  로그인 후에는 로그아웃, 내 모임, 내 정보 -->
            </div>
        </header>

        <nav>
            <div class="nav_wrap wrap">
               	<a href="/"><img src="resources/imgs/logo.png" alt="logo" id="logo"> </a>
                <div class="search_box">
                    <input type="text">
                    <button class="search_button"></button>
                </div>
                <a href="myInterest">관심 모임</a>
                <a href="groupInsert">모임 생성</a>
                <a href="searchedPage">모임 찾기</a>
            </div>
        </nav>

        <div class="banner">
            <img src="resources//imgs/banner.png" alt="취미를 찾으세요. 미래 모임에서">
        </div>
        
        