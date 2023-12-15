<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<h2 class="recommend">내 관심 모임들 </h2>
<div class="section">
    <ul class="list_box wrap">
        <li>
            <a href="#">
                <div class="top">
                    <p class="type reading">공부</p>
                    <p class="title">제목입니다 제목 입니다 제목 입니다.</p>
                </div>

                <div class="middle">
                    <img src="./imgs/banner.png" alt="">
                </div>
                <div class="bottom">
                    <p class="group_text">네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                        네 저희는 수원에서 같이 어쩌고 저쩌고
                    </p>
                    <p class="group_info"> 
                        <span>고양시</span>
                        <span>20~30대</span> 
                        <span>관심인원 : 6명</span>
                    </p>
                </div>
            </a>
        </li>
       
    </ul>
</div>

<div class="more_box">
    <button class="more_list">더 불러오기</button>
</div>

<%@ include file="./common/footer.jsp" %>
