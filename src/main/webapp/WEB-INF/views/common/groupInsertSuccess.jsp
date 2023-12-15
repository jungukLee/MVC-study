<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>미래 모임</title>
</head>
<body>
	<script>
		var cur = window.location.href.split("=");
	
		if( cur[1] == '1' ){
			alert("모임 생성 완료!");
			location.href="/";	
		}else if(cur[1] == '10'){
			alert('오류')
			location.href="/";
		}else if( cur[1] == '11' ){
			alert('ID가 존재하지 않습니다.')
			location.href="/findPw";
		}else if( cur[1] == '12' ){
			alert('비밀번호가 변경되었습니다.')
			location.href="/login";
		}else if( cur[1] == '13' ){
			alert('비밀번호 수정 오류입니다. 다시해주세요')
			location.href="/findPw";
		}else if( cur[1] == '14' ){
			alert('개인 정보 수정 완료')
			location.href="/myPage";
		}else if( cur[1] == '15' ){
			alert('개인정보 수정 오류입니다. 다시해주세요')
			location.href="/myPage";
		}else if( cur[1] == '16' ){
			alert('모임 삭제가 완료되었습니다.')
			location.href="/";
		}else if( cur[1] == '17' ){
			alert('모임 삭제 오류입니다.')
			location.href="/";
		}else if( cur[1] == '18' ){
			alert('회원 탈퇴 완료')
			location.href="/";
		}else if( cur[1] == '19' ){
			alert('회원탈퇴 오류')
			location.href="/";
		}else if( cur[1].split("?")[0] == '3'){			
			alert("모임 수정 완료!");
			location.href="/groupDetail?idx="+cur[2];
		}else if(cur[1].split("?")[0] == '5'){
			alert('글 작성 완료!')
			window.history.go(-1)
			location.reload();
		}else if(cur[1].split("?")[0] == '6'){
			alert('글 작성 실패!')
			window.history.go(-1)
		    location.reload();
		}else if(cur[1].split("?")[0] == '7'){
			alert('글 수정 완료!')
			window.history.go(-1)
		    location.reload();
		}else if(cur[1].split("?")[0] == '8'){
			alert('글 수정 실패!')
			window.history.go(-1)
		    location.reload();
		}else{
			alert("예외")
			//alert("모임 생성 실패");
			//location.href="/groupInsert";
		}

</script>
</body>
</html>