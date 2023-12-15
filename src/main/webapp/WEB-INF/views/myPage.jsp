<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>

<!-- 

private int memberIdx;
private String nickname;
private String age;
private String gender;
private String address;
private String phone;
private String email;

service로 값 가져오고
현재비밀번호랑 service랑 맞을 경우로 체크
 -->

<div class="login_wrap join_wrap">
    <h2>마이페이지</h2>
    <form action="EditMyInfo" method="post" class="join_form">
      
        <!-- age  -->
        <input type="text" name="age" value="${memberInfo.age}" placeholder="생년월일 6자리 (예:000215)" class="inputText">

         <!-- gender -->
        <select name="gender" id="" class="inputSelect mr20">
            <option value="남자" ${memberInfo.gender eq '남자' ? 'selected' : ''} >남자</option>
            <option value="여자" ${memberInfo.gender eq '여자' ? 'selected' : ''}>여자</option>
        </select>
        <!-- address -->
        <select name="address" id="" class="inputSelect">
            <option value="서울" ${memberInfo.country eq '서울' ? 'selected' : ''}>서울</option>
		    <option value="인천" ${memberInfo.country eq '인천' ? 'selected' : ''}>인천</option>
		    <option value="부산" ${memberInfo.country eq '부산' ? 'selected' : ''}>부산</option>
		    <option value="대구" ${memberInfo.country eq '대구' ? 'selected' : ''}>대구</option>
		    <option value="광주" ${memberInfo.country eq '광주' ? 'selected' : ''}>광주</option>
		    <option value="대전" ${memberInfo.country eq '대전' ? 'selected' : ''}>대전</option>
		    <option value="울산" ${memberInfo.country eq '울산' ? 'selected' : ''}>울산</option>
		    <option value="세종" ${memberInfo.country eq '세종' ? 'selected' : ''}>세종</option>
		    <option value="경기" ${memberInfo.country eq '경기' ? 'selected' : ''}>경기</option>
		    <option value="강원" ${memberInfo.country eq '강원' ? 'selected' : ''}>강원</option>
		    <option value="충청" ${memberInfo.country eq '충청' ? 'selected' : ''}>충청</option>
		    <option value="전라" ${memberInfo.country eq '전라' ? 'selected' : ''}>전라</option>
		    <option value="경상" ${memberInfo.country eq '경상' ? 'selected' : ''}>경상</option>
		    <option value="제주" ${memberInfo.country eq '제주' ? 'selected' : ''}>제주</option>
        </select>

        <!-- phone -->
        <input type="text" name="phone" value="${memberInfo.phone}" placeholder="번호 ( 예 : 01024984595 )" class="inputText wid">

        <!-- email -->
        <input type="text" name="email" value="${memberInfo.email }" placeholder="이메일 ( 예 : Hello@google.com )" class="inputText">

        <a href="/" class="back_button">돌아가기</a>
        <input type="submit" value="수정하기" class="submit_button">       
    </form>
   	<div class="serch_info">
   	     <a href="/delMember">회원탈퇴</button> 
    </div>
</div>

<%@ include file="./common/footer.jsp" %>

<script>
</script>
