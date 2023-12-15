<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<c:if test="${!empty userSearchValue}">
    <h2 class="recommend">검색 결과 : ${userSearchValue}</h2>
</c:if>
 


<div class="detail_search_wrap">
	<h2 onclick="openDetail()">상세 검색</h2>
	<div class="search_wrap" id="detail_wrap">
	
	    <form action="searchDetail" method="get" class="join_form"  encType = "multipart/form-data">
	        <!-- 지역 -->
	        <select name="country" id="" class="inputSelect" required>
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
	
	        <!-- 카테고리 -->
	        <select name="category" id="" class="inputSelect" required>
	            <option value="공부">공부</option>
	            <option value="운동">운동</option>
	            <option value="영화">영화</option>
	            <option value="게임">게임</option>
	            <option value="음식">음식</option>
	            <option value="문화">문화</option>
	            <option value="여행">여행</option>
	            <option value="연애">연애</option>
	            <option value="투자">투자</option>
	        </select>
	
	        <br>
	        <input type="text" name="generation" placeholder="나이" class="inputText wid" required>
	        
	        <input type="text" name="introduce" placeholder="포함 단어" class="inputText wid mr20" required>
	        <input type="submit" value="검색" class="submit_button">
	    </form>
	</div>
</div>

<div class="section">
    <ul class="list_box wrap" id="main_groupListWrap">
    	<c:choose>
    		<c:when test="${empty groupList}" >
				<h2 style="font-size: 20px; padding: 0px 0px 34px 0;">생성된 모임이 없습니다...</h2>
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

<script>
	var i = 0;
	function openDetail(){
		if(i == 0){
			document.getElementById("detail_wrap").style.display = "none";
			i = 1
		}else{
			document.getElementById("detail_wrap").style.display = "";
			i = 0
		}
	}
</script>

<%@ include file="./common/footer.jsp" %>
