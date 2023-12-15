<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%@ include file="./common/header.jsp" %>

<%

    // 세션에서 memberIDX 값을 가져옴
    Map<String, Object> groupInfo = (Map<String, Object>) request.getAttribute("groupInfo");
	String fk_memberIDX = (String) groupInfo.get("fk_memberIDX");
	boolean canEdit = false;
	boolean noLogin = true;
	String memberIDX ="";
	if(session != null){
		Object memberIDXobject = session.getAttribute("memberIDX");
		memberIDX =  (memberIDXobject != null) ? (String) session.getAttribute("memberIDX") : null;
		if( fk_memberIDX != null && memberIDX != null ){
			canEdit = fk_memberIDX.equals(memberIDX);	
		}			
	}else{
		noLogin = false;
	}
%>

<div class="group_detail_wrap">	  
	  <span class="interest_button unliked" id="interestBt">관심</span>
	  <!-- unliked liked -->  
	  <div class="imgBox">		
			<c:choose>
			    <c:when test="${not empty groupInfo.image_path}">
			        <!--  <img src="${group.fileUrl}" alt="Uploaded Image"> -->
			        <img src="<spring:url value='/image/${groupInfo.image_path}'/>" alt="Uploaded Image">	
			    </c:when>					    
			    <c:otherwise>
			        <img src="resources/imgs/banner.png" alt="">
			    </c:otherwise>
			</c:choose>
	  </div>
	
	  <div class="right_box">
	      <p class="detail_title">${groupInfo.title}</p>
	      <p class="detail_sub ">
	      	<span>모임장 : ${groupInfo.fk_nickName}</span>    
          	<span>지역 : ${groupInfo.country}</span>
            <span>카테고리 : ${groupInfo.category}</span>
            <span>연령대 : ${groupInfo.generation}</span>
            <span>관심 : ${groupInfo.likes}</span>
	      </p>
	      <p class="detail_introduce">${groupInfo.introduce}</p>
	  </div>

	  <% if (canEdit) { %>
		<div class="home_box">
	         <a href="/" class="goHome mr20">홈으로</a>
	         <form action="/groupEdit" method="post" class="editForm mr20">
	         	<input type="hidden" name="groupIDX" value="${groupInfo.groupIDX}">
	         	<input type="submit" class="goHome editButton" value="수정하기">
	         </form>
	           <form action="/groupDel" method="post" class="editForm">
	         	<input type="hidden" name="groupIDX" value="${groupInfo.groupIDX}">
	         	<input type="submit" class="goHome editButton" value="삭제하기">
	         </form>	     		     	
	     </div>
       <% } else if ( noLogin) { %>
      	 <div class="home_box">
	         <a href="/" class="goHome">홈으로</a>	      
	      	  <button class="goHome editButton" id="joiningBt">가입 신청</button>	
	     </div>
       <% } else  { %>
        <div class="home_box">
	         <a href="/" class="goHome">홈으로</a>	      	    
	     </div>      
       <% } %>   
</div>

<script>
	$(document).ready(function(){
		
		$('#joiningBt').click(function(){
			var memberIDX = '<%=memberIDX%>'
			var groupIDX = "${groupInfo.groupIDX}"
			$.ajax({
				type:"post",
				url: "/insertGroupInMember",
				data : {memberIDX : memberIDX, groupIDX:groupIDX},
				success : function(data){
					if( data == "1" ) {
						alert("가입이 대기중입니다");
					}else if(data == "2") {
						alert("가입신청이 완료되었습니다.");
					}else {
						alert("가입 에러");
					}
				},error:function(xhr, status, error){
					alert("가입신청 에러!");
					console.log("xhr:", xhr);
		            console.log("status:", status);
		            console.log("error:", error);
				}
			})			
		})
		
		var str = "${interestStatus}"
		var temp = 1;
		function toggleClass(str){
			if( str == "Yes"  ){
				$('#interestBt').addClass("liked");
				$('#interestBt').removeClass("unliked");
			}else if(str == "No"){
				$('#interestBt').addClass("unliked");
				$('#interestBt').removeClass("liked");
			}
		}
		toggleClass(str)
		
		if(str != "None"){
			$('#interestBt').click(function(){
				var memberIDX = '<%=memberIDX%>'
				var groupIDX = "${groupInfo.groupIDX}"
				var idx = ${idx}
				if(str == "Yes"){
					$('#interestBt').css("background-color","rgb(249, 249, 249)")
					$('#interestBt').css("color","#333");
					$.ajax({
						type:"post",
						url: "/delInterest",
						data : {memberIDX : memberIDX, groupIDX:groupIDX,idx:idx},
						success : function(data){
							console.log("삭제")
							str = "No"
							//location.reload();
						},error:function(error){
							console.log("삭제 에러")
						}
					})
				}else{
					$('#interestBt').css("background-color","#ed4747")
					$('#interestBt').css("color","#fff");
					$.ajax({
						type:"post",
						url: "/addInterest",
						data : {memberIDX : memberIDX, groupIDX:groupIDX,idx:idx},
						success : function(data){
							console.log("추가")
							str = "Yes"
							//location.reload();
						},
						error:function(error){
							console.log("추가 에러")
						}
					})
				}	
				console.log(memberIDX)
				console.log(groupIDX)
			})
		}else{
			if(str == "None" ){
				$('#interestBt').click(function(){
					alert("로그인 하세요.");
					location.href="/login"
				})				
			}
		}
		
	})
	
</script>


<%@ include file="./common/footer.jsp" %>
