<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<h2 class="recommend">검색 결과 : 제목입니다. </h2>

<div class="detail_search_wrap">
	<h2 onclick="openDetail()">상세 검색</h2>
	<div class="search_wrap" id="detail_wrap">
	
	    <form action="" class="join_form"  encType = "multipart/form-data">
	        <!-- 지역 -->
	        <select name="country" id="" class="inputSelect">
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
	
	        <!-- 카테고리 -->
	        <select name="category" id="" class="inputSelect">
	            <option selected disabled hidden>카테고리</option>
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
	        <input type="text" name="generation" placeholder="나이" class="inputText wid">
	        
	        <input type="text" name="introduce" placeholder="포함 단어" class="inputText wid mr20">
	        <input type="submit" value="검색" class="submit_button">
	    </form>
	</div>
</div>
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

 <div class="more_box">
     <button class="more_list">더 불러오기</button>
 </div>


<%@ include file="./common/footer.jsp" %>
