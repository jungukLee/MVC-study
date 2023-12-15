<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>미래모임</title>
    <script src="resources/script/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="icon" href="resources/imgs/favi.ico" type="image/x-icon">
</head>
<body>
<script>
$(document).ready(function() {
    // input 요소에 이벤트를 바인딩합니다.
    $('#seach_head_input').on('input focus blur', function() {
    // 입력값이 있거나 focus가 되었을 때
        if ($(this).is(':focus') || $(this).val()) {
            $('.searched_wrap').css('display', 'block');
        } else {
        // 값이 없고 focus에서 벗어났을 때
            $('.searched_wrap').css('display', 'none');
        }
    });
    
    $('#seach_head_input').on('input', function() {
        var searchValue = $(this).val();
        $.ajax({
            url:'/headSearch',
            method:'GET',
            data:{search:searchValue},
            success:function(response){
                // 기존 결과를 비우기
                $("#searched_wrap").empty();

                if(searchValue != ""){
                    for (var i = 0; i < response.length; i++) {
                        // 데이터를 사용하여 원하는 방식으로 HTML 구성
                        var board = response[i];
                        var html = "<li>";
                        html += "<a href='/groupDetail?idx="+board.groupIDX+"'>";
                        html += "<span class='searched_title'>" +board.title +"</span>" ;
                        html += "<span class='sarched_wrap_area'>" +board.country +"</span>" ;
                        html += " <span class='sarched_wrap_ages'>"+ board.category + "</span>";
                        html += "</a>";
                        html += "</li>";
                        // 만들어진 HTML을 목록에 추가
                        $("#searched_wrap").append(html);
                    }               
                }       
            },
            error:function(xhr,status,error){
                console.log('AJAX 오류',error);
            }
        })
    });
});

</script>
<div id="wrapper">
        <header>  	
            <div class="header_wrap wrap">
            	<%
            		
       				HttpSession session = request.getSession(false);
	            	if( session == null ){
	            		out.println("<a href='/login'>로그인</a>");
       					out.println("<a href='/join'>회원가입</a>");
	            	}else{
	            		out.println("<a href='/myGroups'>내 모임</a>");
       					out.println("<a href='/myPage'>내 정보</a>");
       					out.println("<a href='/logoutService'>로그아웃</a>");
	            	}		
       			%>
            </div>
        </header>

        <nav>
            <div class="nav_wrap wrap">
               	<a href="/"><img src="resources/imgs/logo.png" alt="logo" id="logo"> </a>
                <div class="search_box">
                    <form action="searchedPageHandle" method="get"> 
                        <div>
                            <input type="text" id="seach_head_input" name="searchValue">
                            <ul class="searched_wrap accodient-box" id="searched_wrap">
                                <!-- 9 -->                                   
                            </ul>
                        </div> 
                        <!-- <input class="search_button"> -->
                        <input type="submit" class="search_button" value="">
                    </form>
                </div>
                <a href="/myInterest">관심 모임</a>
                <a href="/groupInsert">모임 생성</a>
                <a href="/searchedPage">모임 찾기</a>       
            </div>           
        </nav>

        <div class="banner">
            <img src="resources//imgs/banner.png" alt="취미를 찾으세요. 미래 모임에서">
        </div>
        
        

        