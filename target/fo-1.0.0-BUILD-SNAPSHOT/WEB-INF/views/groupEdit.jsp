<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>


<div class="login_wrap join_wrap">
    <h2>모임 수정</h2>
    <form action="" class="join_form"  encType = "multipart/form-data">
        <!-- 제목 -->
        <input type="text" name="title" placeholder="제목" class="inputText">
       
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
        
        <input type="text" name="generation" placeholder="연령대 ( 예 : 20대 ~ 30대 )" class="inputText wid">
        
        <input type="text" name="generation" placeholder="모임 소개 ( 카카오톡 오픈채팅 링크를 첨부 )" class="inputText">

        <div class="filebox button">
            <label for="chooseFile">이미지 선택</label>
            <div class="fileInput">
                <p id="fileName"></p>
            </div>                    
            <input type="file" id="chooseFile" name="chooseFile" accept="image/*" onchange="loadFile(this)">
        </div>

        <div class="image-show" id="image-show"></div>
        
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
