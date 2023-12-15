<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>

<%@ include file="./common/header.jsp" %>


<div class="group_detail_wrap">
	  <span class="interest_button">관심</span>
	  <div class="imgBox">
	      <img src="./imgs/banner.png" alt="">
	  </div>
	
	  <div class="right_box">
	      <p class="detail_title">제목입니다. 제목입니다.</p>
	      <p class="detail_sub ">
	          <span>지역 : 서울</span>
	          <span>카테고리 : 운동</span>
	          <span>연령대 : 20 ~ 30</span>
	          <span>관심 : 7</span>
	      </p>
	      <p class="detail_introduce">
	          이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안
	          이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안
	          이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안
	          이 모임은 영국에서 날라와 15년동안
	          이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안이 모임은 영국에서 날라와 15년동안
	      </p>
	  </div>
	  
	  <!-- if groupmember -->
       <div class="comment_wrap">
           <div class="comment_input_wrap">
               <form action="">
                   <input type="text" class="comment_input" placeholder="댓글 입력">
                   <input type="submit" value="입력" class="comment_submit">
               </form>
           </div>

           <div class="written_wrap">
               <div class="written_box">
                   <p class="w_nickname">닉네임</p>
                   <p class="w_content">정말 멋진 모임입니다.</p>
                   <p class="w_date">
                       2023-11-30 
                       <span>수정</span>
                       <span>삭제</span>
                   </p>
                  
               </div>
           </div>
      	</div>
      	
      	<div class="comment_wrap">
            <div class="comment_input_wrap">
                <form action="">
                    <input type="text" class="comment_input" placeholder="댓글 입력">
                    <input type="submit" value="입력" class="comment_submit">
                </form>
            </div>

            <div class="written_wrap">
                <div class="written_box">
                    <p class="w_nickname">닉네임</p>
                    <p class="w_content">정말 멋진 모임입니다.</p>
                    <p class="w_date">
                        2023-11-30 
                        <span>수정</span>
                        <span>삭제</span>
                    </p>
                </div>
            </div>
           
        </div>

        <div class="member_list">
            <h2>멤버리스트</h2>
            <ul>
                <li>서울좋아</li>
                <li>운동가자</li>
                <li>티비비비</li>
            </ul>    
        </div>
        <!--if logout, not groupmember-->
         <!--
         <div class="home_box">
             <a href="#" class="goHome">홈으로</a>
         </div>
         -->
</div>

<%@ include file="./common/footer.jsp" %>
