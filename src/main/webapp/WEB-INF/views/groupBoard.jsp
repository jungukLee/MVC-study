<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>미래모임</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <script src="resources/script/jquery-3.7.1.min.js"></script>
    <link rel="icon" href="resources/imgs/favi.ico" type="image/x-icon">
</head>
<body class="bgcolorGray"> 

    
<body class="bgcolorGray"> 
    <div class="xray disNone" id="xray" onclick="allClose()"></div>
    <h2 class="board_title">${title}</h2>
    <div class="GroupBoard_wrap">
        <aside class="memebers_wrap">
            <ul class="left_members accodient-box ">
                <h3>멤버 목록</h3>
           	  <c:forEach var="member" items="${memberList}" >                
                	 <c:if test="${member.member_status eq 'Good' or member.member_status eq 'Master'}">
                		<li>${member.nickname}</li>
                	 </c:if>          
                </c:forEach>
                
            </ul>
          
            <c:if test="${masterIDX eq memberIDX}">
	            <ul class="left_members accodient-box">
	                <h3>가입 대기</h3>
	                 <c:forEach var="member" items="${memberList}" > 
	                	 <c:if test="${member.member_status eq 'Waiting'}">
	                		<li  style='cursor: pointer;' onclick="goMember(${member.fk_memberIDX},'${member.nickname}')">${member.nickname}</li>
	                	 </c:if>
	                </c:forEach>
	            </ul>
            </c:if>
        </aside>
        
        
        <div class="right_wrap">
            <ul class="boards accodient-box">  
            	<c:forEach var="board" items="${boardList}" >         
                <li>
                    <div class="comment_title">
                        <p>${board.nickname}
                        
                        <fmt:parseDate var="parsedDate" value="${board.cread_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
    					<fmt:formatDate var="formattedDate" value="${parsedDate}" pattern="yyyy-MM-dd"/>					    
					    <span>${formattedDate}</span>
                            <c:if test="${board.fk_memberIDX eq memberIDX}">  
	                            <span class="comment_edits" onclick='editBoard(${board.boardIDX},"${board.content}")'>수정</span>
                				<span class="comment_edits" onclick="delBoard(${board.boardIDX},'${title}',${groupIDX})">삭제</span>
                            </c:if>                          
                        </p>
                    </div>
                    <div class="comment_content he90">
                        <p>${board.content}</p>
                    </div>
                    <div class="comment_bottoms">
                        <p> 댓글 ${board.commentCount}개 </p>
                        <button onclick='open_comment(${board.boardIDX})'>댓글 달기</button>
                    </div>
                </li>
      			</c:forEach>
            </ul>        
            <ul class="comment_box disNone" id="comment_box">
                <span class="del_wrap" onclick="allClose()">X</span>
                <div class="posrela accodient-box" id="comment_div">               
				<!-- 여기에 댓글 ajax추가 삭제 -->
			 	</div>
                <div class="addComment_box" id="commentBox">
                    <form action="/addComment" method="post" id="addCommentForm">
						<input type="hidden" name="fk_boardIDX" value="">
						<input type="hidden" name="commentIDX" value="1" id="commentIDXinput">							        	    	
		        	    <!--  -->
                        <input type="text" name="content" placeholder="내용 입력" class="comment_input" required>
                        <input type="submit" value="작성" class="comment_submit">
                    </form>
                </div>
            </ul>
        </div>

        <div class="addBoard"> 
            <a href="/myGroups">홈으로</a>
            <button onclick="addBoard()">글 작성</button>
        </div>

        <div class="addBaord_wrap"  id="addBoardBox">
            <span class="close_addBoard" onclick="allClose()">X</span>
            <p class="addBoard_nick">${nickname}</p>
            <form action="/insertBoard" method="post" id="addForm">   
            	<input type="hidden" name="groupIDX" value="${groupIDX}">
        	    <input type="hidden" name="groupTitle" value="${title}">	
                <input type="text" name="content" placeholder="내용 입력" class="inin" required>
                <input type="submit" value="작성" class="inins">
            </form>
        </div>
        
        <div class="addBaord_wrap"  id="editBoardBox">
            <span class="close_addBoard" onclick="allClose()">X</span>
            <p class="addBoard_nick">${nickname}</p>          
            <form action="/editBoard" method="post" id="editForm">
            	<input type="hidden" name="boardIDX" value="">	   
            	<input type="hidden" name="groupTitle" value="${title}">	
        	    <input type="hidden" name="fk_groupIDX" value="${groupIDX}">     	   
        	    <input type="text" name="content" placeholder="내용 입력" class="inin" value="">            
                <input type="submit" value="작성" class="inins">
            </form>
        </div>
   
    </div>
    
<script>

    function goMember(idx,name){
    	if(${masterIDX eq memberIDX}){
            test = confirm(name+" 님 가입을 승낙하시겠습니까?");
            if(test){
            	$.ajax({
                    type: "POST",
                    url: "/addMemberInGroup",
                    data: {fk_groupIDX:${groupIDX}, fk_memberIDX:idx}, // 폼 데이터를 직렬화하여 전송
                    success: function(data) {
                    	alert(name +" 가입 완료")
                        console.log(data)
                    	location.reload();
                    },
                    error: function(error) {
                        // 오류 시 실행할 로직
                        alert("오류")
                        console.log(error);
                    	location.reload();
                    }
                });             
            }else{
                alert(name+" 가입 거절")
                location.reload()
            }
        }else{
        	alert(1);
        }
    }
	//댓글 불러오기
    function open_comment(boardIDX){
       	openXray()       	
       	console.log(boardIDX)
        var commentBox = document.getElementById('comment_box')
        commentBox.style.display = 'block'        
   	    var boardIDXInput = $("#addCommentForm input[name='fk_boardIDX']");
       	boardIDXInput.val(boardIDX);
       	$('.comment_input').val("")
        $('.comment_submit').val("작성")
        $('#commentIDXinput').val(1)
        $.ajax({
            type: "POST",
            url: "/printComment",
            data: {fk_boardIDX:boardIDX}, // 폼 데이터를 직렬화하여 전송
            success: function(data) {
                // 성공 시 실행할 로직
                successHandler(data)
                console.log(data)
            	//location.reload();
            },
            error: function(error) {
                // 오류 시 실행할 로직
                alert("오류")
                console.log(error);
            }
        });
    }

    function addBoard(){
        var addBoardBox = document.getElementById('addBoardBox')
        addBoardBox.style.display = 'block'
       	openXray()
    }
    
	//게시글 수정시 게시글창 열고 input값 조정
    function editBoard(idx, content){	
	    console.log('idx:', idx);
	    openXray()
	    var editBoardBox = document.getElementById('editBoardBox');
	    editBoardBox.style.display = 'block';
	    // 기존에 있는 input[name='boardIDX']를 찾아 값을 설정
	    var boardIDXInput = $("#editForm input[name='boardIDX']");
	    var boardContentInput = $("#editForm input[name='content']");	  
	    boardIDXInput.val(idx);
	    boardContentInput.val(content);	    
    }
  
    function openXray(){
		var xray = document.getElementById('xray')
        xray.style.display = 'block'
    }
    function allClose(){
        var commentBox = document.getElementById('comment_box')
        var addBoardBox = document.getElementById('addBoardBox')
        var editBoardBox = document.getElementById('editBoardBox')
        var xray = document.getElementById('xray')
        commentBox.style.display = 'none'
        addBoardBox.style.display = 'none'
        xray.style.display = 'none'
        editBoardBox.style.display = 'none'
    }
    
    
    //게시글 삭제
    function delBoard(boardIDX, title, groupIDX){
    	var data = {
    			"boardIDX" : boardIDX,
    			"title" : title,
    			"groupIDX":groupIDX
    	}
    	// Ajax 요청 수행
        $.ajax({
            type: "POST",
            url: "/delBoard",
            data: data,
            success: function(response) {
                alert("삭제 완료")
            	location.reload();
            },
            error: function(error) {
                alert("삭제 오류")
                console.log(error);
            }
        });
    }
    
    //게시글 수정 ajax
    $("#editForm").submit(function(event) {
        event.preventDefault();

        // Ajax 요청 수행
        $.ajax({
            type: "POST",
            url: "/editBoard",
            data: $(this).serialize(), // 폼 데이터를 직렬화하여 전송
            success: function(response) {
                alert("수정되었습니다.")
            	location.reload();
            },
            error: function(error) {
                alert("오류")
                console.log(error);
            }
        });
    });
  
    //게시글 생성
    $("#addForm").submit(function(event) {
        event.preventDefault();
  
        // Ajax 요청 수행
        $.ajax({
            type: "POST",
            url: "/insertBoard",
            data: $(this).serialize(),
            success: function(response) {
                alert("입력되었습니다.");
                location.reload();
            },
            error: function(error) {
                alert("오류");
                console.log(error);
            }
        });
    });
    
 	//댓글 수정 input 값 넣기
    function updateCommentInput(commentIDX, content){	
	    console.log('commentIdx:', commentIDX);
	    $('.comment_input').focus()
	    $("#commentBox input[name='content']").val(content);
	    $('.comment_submit').val("수정")
	    $('#commentIDXinput').val(commentIDX)
    }
    
    //댓글 comment 생성  OR 댓글 commen t 수정 addCommentForm
    $("#addCommentForm").submit(function(event) {
        // 폼의 기본 동작을 막음
        event.preventDefault();
        var status = $('#commentIDXinput').val()
        //수정일경우
        if(status != "1"){
        	$.ajax({
                type: "POST",
                url: "/editComment",
                data: $(this).serialize(),
                success: function(data) {
                	alert("수정되었습니다.")
                    successHandler(data)
                    $('.comment_input').val("")
                    $('#commentIDXinput').val("1")
                 	$('.comment_submit').val("작성")
                    console.log(data)
                },
                error: function(error) {
                    alert("오류");
                    console.log(error);
                }
            });
        }else{
        	//작성일 때
        	$.ajax({
                type: "POST",
                url: "/insertComment",
                data: $(this).serialize(),
                success: function(data) {
                	alert('작성되었습니다.')
                    successHandler(data)
                    scrollDown()
                    $('.comment_input').val("")
                    console.log(data)
                },
                error: function(error) {
                    alert("오류");
                    console.log(error);
                }
            });
        }        
    });
 
      
    function delComment(commentIDX,boardIDX) {
        // 삭제 로직을 처리하는 함수, commentIDX를 사용하여 해당 댓글을 찾을 수 있음
        console.log('DeleteComment', commentIDX);
        $.ajax({
            type: "POST",
            url: "/delComment",
            data: {commentIDX:commentIDX,fk_boardIDX:boardIDX },        
            success: function(data) {
            	alert('삭제되었습니다.')
                successHandler(data)
                console.log(data)
            },
            error: function(error) {
                alert("오류");
                console.log(error);
            }
        });
    }
    
    
    function padZero(num) {
        return num < 10 ? '0' + num : num;
    }
    
    function scrollDown(){
        $('#comment_div').scrollTop( $('#comment_div')[0].scrollHeight )
    }
    
    
    function successHandler(data){
        $('#comment_div').empty();
    	 for (var i = 0; i < data.length; i++) {
   	        var nickname = data[i].nickname;
   	        var created_at = new Date(data[i].cread_at);
   	        var formatted_date = created_at.getFullYear() + '-' + padZero(created_at.getMonth() + 1) + '-' + padZero(created_at.getDate());
   	        var value = data[i].content;
   	        var currentMemberIDX = ${memberIDX}; 
   	        var showEditDeleteButtons = (currentMemberIDX == data[i].fk_memberIDX);
   	        newCommentHtml = '<li>' +
   	            '<p class="comment_title">' +
   	            nickname +
   	            '<span>' + formatted_date + '</span>' +
   	            (showEditDeleteButtons ? '<span class="comment_edits" onclick="updateCommentInput(' + data[i].commentIDX + ', \'' + value + '\')">수정</span>' : '') +
   	            (showEditDeleteButtons ? '<span class="comment_edits" onclick="delComment(' + data[i].commentIDX + ', ' + data[i].fk_boardIDX + ')">삭제</span>' : '') +
   	            '</p>' +
   	            '<p class="comment_content board_comment">' +
   	            value +
   	            '</p>' +
   	            '</li>';
   	        $('#comment_div').append(newCommentHtml); 	     	
   	    }
    }
    
    
    
</script>
</body>

</body>

</html>