<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>


<div class="login_wrap join_wrap">
	<h2>모임 수정</h2>
    <form action="/groupEditService" method="post" class="join_form">
      	<!-- 제목 encType = "multipart/form-data"-->    
       <input type="hidden" name="GroupIdx" value="${groupInfo.groupIDX}">
       <input type="text" name="title" placeholder="제목" class="inputText" value="${groupInfo.title}" required >
       <!-- 지역 -->
       <select name="country" id="" class="inputSelect" required>
            <option disabled hidden>지역</option>
		    <option value="서울" ${groupInfo.country eq '서울' ? 'selected' : ''}>서울</option>
		    <option value="인천" ${groupInfo.country eq '인천' ? 'selected' : ''}>인천</option>
		    <option value="부산" ${groupInfo.country eq '부산' ? 'selected' : ''}>부산</option>
		    <option value="대구" ${groupInfo.country eq '대구' ? 'selected' : ''}>대구</option>
		    <option value="광주" ${groupInfo.country eq '광주' ? 'selected' : ''}>광주</option>
		    <option value="대전" ${groupInfo.country eq '대전' ? 'selected' : ''}>대전</option>
		    <option value="울산" ${groupInfo.country eq '울산' ? 'selected' : ''}>울산</option>
		    <option value="세종" ${groupInfo.country eq '세종' ? 'selected' : ''}>세종</option>
		    <option value="경기" ${groupInfo.country eq '경기' ? 'selected' : ''}>경기</option>
		    <option value="강원" ${groupInfo.country eq '강원' ? 'selected' : ''}>강원</option>
		    <option value="충청" ${groupInfo.country eq '충청' ? 'selected' : ''}>충청</option>
		    <option value="전라" ${groupInfo.country eq '전라' ? 'selected' : ''}>전라</option>
		    <option value="경상" ${groupInfo.country eq '경상' ? 'selected' : ''}>경상</option>
		    <option value="제주" ${groupInfo.country eq '제주' ? 'selected' : ''}>제주</option>
       </select>

      <!-- 카테고리 -->
        <select name="category" id="" class="inputSelect" required>
            <option disabled hidden>카테고리</option>
		    <option value="공부" ${groupInfo.category eq '공부' ? 'selected' : ''}>공부</option>
		    <option value="운동" ${groupInfo.category eq '운동' ? 'selected' : ''}>운동</option>
		    <option value="영화" ${groupInfo.category eq '영화' ? 'selected' : ''}>영화</option>
		    <option value="게임" ${groupInfo.category eq '게임' ? 'selected' : ''}>게임</option>
		    <option value="음식" ${groupInfo.category eq '음식' ? 'selected' : ''}>음식</option>
		    <option value="문화" ${groupInfo.category eq '문화' ? 'selected' : ''}>문화</option>
		    <option value="여행" ${groupInfo.category eq '여행' ? 'selected' : ''}>여행</option>
		    <option value="연애" ${groupInfo.category eq '연애' ? 'selected' : ''}>연애</option>
		    <option value="투자" ${groupInfo.category eq '투자' ? 'selected' : ''}>투자</option>
        </select>
        
        <input type="text" name="generation" value="${groupInfo.generation }" required placeholder="연령대 ( 예 : 20대 ~ 30대 )" class="inputText wid">
        
        <input type="text" name="introduce" value="${groupInfo.introduce}" required placeholder="모임 소개" class="inputText">

        <br>
        <a href="/" class="back_button">돌아가기</a>
        <input type="submit" value="모임수정 완료" class="submit_button">
    </form>
</div>
<script>
   function showImage() {
       var newImage = document.getElementById('image-show').lastElementChild;
       newImage.style.visibility = "visible";
       
       document.getElementById('image-upload').style.visibility = 'hidden';

       document.getElementById('fileName').textContent = null;     //기존 파일 이름 지우기
   }

   function loadFile(input) {
       var file = input.files[0];

       var name = document.getElementById('fileName');
       name.textContent = file.name;

       var newImage = document.createElement("img");
       newImage.setAttribute("class", 'img');

       newImage.src = URL.createObjectURL(file);   

       newImage.style.width = "300px";
       newImage.style.height = "150px";
       newImage.style.visibility = "hidden";   //버튼을 누르기 전까지는 이미지 숨기기
       newImage.style.objectFit = "contain";

       var container = document.getElementById('image-show');
       container.appendChild(newImage);
       showImage();
   };
</script>

<%@ include file="./common/footer.jsp" %>
