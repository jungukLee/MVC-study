<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<h2 class="recommend">가입한 모임</h2>
<div class="section">
    <ul class="list_box wrap" id="main_groupListWrap">
    	<c:choose>
    		<c:when test="${empty groupList}" >
				<h2 style="font-size: 20px; padding: 0px 0px 34px 0;">가입한 모임이 없습니다....</h2>
    		</c:when>
    		<c:when test="${!empty groupList}" >
				<c:forEach var="board" items="${groupList }" >
					<li class="goBoard">
			         	<div class="go_GroupBoard">
			                 <a href="/groupBoard?idx=${board.groupIDX}&title=${board.title}">입장하기</a>		     
			            </div>
			                <div class="top">
			                    <p class="type reading">${board.category}</p>
			                    <p class="title">${board.title}</p>
			                </div>
			
			                <div class="middle">
		                       <c:choose>
								    <c:when test="${not empty board.image_path}">									    
									     <img src="<spring:url value='/image/${board.image_path}'/>" alt="Uploaded Image">										
									</c:when>				    
								    <c:otherwise>
								        <img src="resources/imgs/banner.png" alt="">
								    </c:otherwise>								
								</c:choose>	  
			                </div>
			                <div class="bottom">
			                    <p class="group_text">${board.introduce}</p>
			                    <p class="group_info"> 
			                        <span>${board.country}</span>
			                        <span>${board.generation}</span> 
			                        <span>관심인원 : ${board.likes}명</span>
			                    </p>
			                </div>
			        </li>
				</c:forEach>
			</c:when>
    	</c:choose>
    </ul>
</div>
<%@ include file="./common/footer.jsp" %>
