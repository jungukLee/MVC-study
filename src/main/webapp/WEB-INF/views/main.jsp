<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<h2 class="recommend">모임 추천</h2>

<div class="section">
    <ul class="list_box wrap" id="main_groupListWrap">
    	<c:choose>
    		<c:when test="${empty groupList}" >
				<h2>생성된 모임이 없습니다.</h2>
    		</c:when>
    		<c:when test="${!empty groupList}" >
				<c:forEach var="board" items="${groupList}" >
					<li>
			            <a href="/groupDetail?idx=${board.groupIDX} ">
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
			                    <p class="group_text">${board.introduce}
			                    </p>
			                    <p class="group_info"> 
			                        <span>${board.country}</span>
			                        <span>${board.generation}</span> 
			                        <span>관심인원 : ${board.likes}명</span>
			                    </p>
			                </div>
			            </a>
			        </li>
				</c:forEach>
			</c:when>
    	</c:choose>
    </ul>
</div>

<c:set var="groupListSize" value="${fn:length(groupList)}" />
<c:if test="${groupListSize ge 12}">
    <div class="more_box" id="moreList">
	     <button class="more_list">더 불러오기</button>
	 </div>
</c:if>
 
 
 <script>
 	$(document).ready(function() {
 		var offset = 12;
 		var limit = 6;
 		
 		$('#moreList').click(function(){
 			$.ajax({
 				url:"/groupMore",
 				method:'GET',
 				data:{offset:offset, limit:limit},
 				success: function(data){
 					console.log(data);
 					handleSuccess(data);
 				},
 				error:function(error){
 					console.log("Error",error)
 				}
 			});
 		});
	 	function handleSuccess(data) {
	 	      if (data.length > 0) {
	 	    	 for (var i = 0; i < data.length; i++) {
	 	    	    var board = data[i];
	 	    	    var html = "<li>";
	 	    	    html += "<a href='/groupDetail?idx=" + board.groupIDX + "'>";
	 	    	    html += "<div class='top'>";
	 	    	    html += "<p class='type reading'>" + board.category + "</p>";
	 	    	    html += "<p class='title'>" + board.title + "</p>";
	 	    	    html += "</div>";
	 	    	    html += "<div class='middle'>";
	 	    	    if (board.image_path) {
	 	    	    	var boardImagePath = '/image/' + board.image_path;
	 	    	    	html += '<img src="' + boardImagePath + '" alt="Uploaded Image">';
	 	    	    } else {
	 	    	        html += "<img src='resources/imgs/banner.png' alt=''>";
	 	    	    }
	 	    	    html += "</div>";
	 	    	    html += "<div class='bottom'>";
	 	    	    html += "<p class='group_text'>" + board.introduce + "</p>";
	 	    	    html += "<p class='group_info'>";
	 	    	    html += "<span>" + board.country + "</span>";
	 	    	    html += "<span>" + board.generation + "</span>";
	 	    	    html += "<span>관심인원 : " + board.likes + "명</span>";
	 	    	    html += "</p>";
	 	    	    html += "</div>";
	 	    	    html += "</a>";
	 	    	    html += "</li>";
	 	    	    $("#main_groupListWrap").append(html);
	 	    	}		 	      
	 	        // offset 업데이트
	 	        offset += limit;
	 	      } else {
	 	        // 데이터가 더 이상 없는 경우 처리
	 	        $("#moreList").attr("disabled", true).text("모든 데이터를 불러왔습니다");
	 	      }
	 	    }
	 	  });
 </script>

<%@ include file="./common/footer.jsp" %>

