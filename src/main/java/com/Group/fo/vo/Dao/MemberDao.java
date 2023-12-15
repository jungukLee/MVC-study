package com.Group.fo.vo.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.Group.fo.Utils.DBConn;
import com.Group.fo.vo.model.Group;
import com.Group.fo.vo.model.Member;
import com.Group.fo.Utils.DbUtil;
import com.Group.fo.Utils.SHA256;



public class MemberDao {
		
		public int insertMember(Member member) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			SHA256 sha256 = new SHA256();
			String crypthogram_password = sha256.encrypt(member.getPassword());
			String query = "INSERT INTO member(id, password, nickname, age, gender, address, phone, email)"
					+ " VALUES (?,?,?,?,?,?,?,?);";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setString(1, member.getUserId());
			ppsm.setString(2, crypthogram_password);
			ppsm.setString(3, member.getNickname());
			ppsm.setString(4, member.getAge());
			ppsm.setString(5, member.getGender());
			ppsm.setString(6, member.getAddress());
			ppsm.setString(7, member.getPhone());
			ppsm.setString(8, member.getEmail());
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re;
		}
		
		//회원탈퇴
		@Transactional
		public int deleteMember(int memberIDX) throws SQLException {
			try (Connection conn = DBConn.dbConnection()) {
	        // 1. member 
		        try (PreparedStatement ppsm = conn.prepareStatement("DELETE FROM member WHERE memberIDX = ?")) {
		            ppsm.setInt(1, memberIDX);
		            ppsm.executeUpdate();
		        }
		        
		        // 2. group_board_comment 
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM group_board_comment WHERE fk_memberIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, memberIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }
		        
		        // 3. group_board
		        try (PreparedStatement ppsm = conn.prepareStatement("DELETE FROM group_board WHERE fk_memberIDX = ?")) {
		            ppsm.setInt(1, memberIDX);
		            ppsm.executeUpdate();
		        }
		        
		        // 4. dgroup 
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM dgroup WHERE fk_memberIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, memberIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }
		       
		        // 5. likes_group
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM likes_group WHERE fk_memberIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, memberIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }
		        // 6 group_members
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM group_members WHERE fk_memberIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, memberIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }    
		        return 1;		        
			} catch (SQLException e) {
	            // 롤백되면 예외가 발생하므로, 실패했을 때 -1을 반환
	            e.printStackTrace();
	            return -1;
	        }
		}
		
		public List<Map<String, Object>> selectMemberByUserId(String userId) throws Exception {
			Connection conn = DBConn.dbConnection();
			String query = "SELECT memberIDX, id, password, nickname, age, gender, address, phone, email" 
					+ " FROM member WHERE id = ?";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, userId);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			
			if (mapList.isEmpty()) {
		        return Collections.emptyList();
		    } else {
		        return mapList;
		    }
		}	
		
		public List<Map<String, Object>> selectMemberByUserIDX(int memberIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			String query = "SELECT * FROM member WHERE memberIDX = ?";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, memberIDX);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			
			if (mapList.isEmpty()) {
		        return Collections.emptyList();
		    } else {
		        return mapList;
		    }
		}
		
		//이미 모임에 가입되었는지 return
		public int ifGroupInMeber(int memberIDX, int groupIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			int count = -1;
			String query = "SELECT COUNT(*) as countCheck FROM group_members WHERE fk_groupIDX = ? AND fk_memberIDX = ? ;";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, groupIDX);
			psm.setInt(2, memberIDX);
			ResultSet rs = psm.executeQuery();

			if( rs.next() ) {
		    	count = rs.getInt("countCheck"); 
		    	System.out.println("ifGroupInMember  count : "+count);
		    	psm.close();
				rs.close();
		    	return count;
		    }else {
		    	psm.close();
				conn.close();
		    	return -1;
		    }
		}
		
		//그룹에 가입
		public int insertGroupMember(int memberIDX,int groupIDX,String status) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "INSERT INTO group_members(fk_memberIDX, fk_groupIDX,member_status ) VALUES(?,?,?);";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, memberIDX);
			ppsm.setInt(2, groupIDX);
			ppsm.setString(3, status);
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re;
		}
		
		// 관리자가 멤버 가입 승낙 status update Good
		public int UpdateStatusMember(int memberIDX, int groupIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "UPDATE group_members SET member_status = 'Good' "
					+ " WHERE fk_memberIDX = ? AND fk_groupIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);			
			ppsm.setInt(1,memberIDX);
			ppsm.setInt(2,groupIDX);	
			System.out.println(query);
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re; 
		}
		
		// 마이페이지 개인정보수정		
		public int UpdateMemberInfo(Member member) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "UPDATE member SET age = ? , gender = ?, address = ?, phone = ?, email = ?  "
					+ " WHERE memberIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);			
			ppsm.setString(1, member.getAge());
			ppsm.setString(2, member.getGender());
			ppsm.setString(3, member.getAddress());
			ppsm.setString(4, member.getPhone());
			ppsm.setString(5, member.getEmail());
			ppsm.setInt(6, member.getMemberIdx());
			System.out.println(query);
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re; 
		}
	
		//아이디 찾기
		public String SelectMemberId(Member member) throws Exception {
			Connection conn = DBConn.dbConnection();
			String userId = null;
			String query = "SELECT * FROM member Where phone = ? "
					+ " AND age = ?";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, member.getPhone());
			psm.setString(2, member.getAge());
			ResultSet rs = psm.executeQuery();			
			if( rs.next() ) {
		    	userId= rs.getString("id"); 
		    	System.out.println("userId  : "+userId);
		    	psm.close();
				rs.close();
				conn.close();
		    	return userId;
		    }else {
		    	psm.close();
				conn.close();
		    	return userId;
		    }
		}
		
		//비밀번호 찾기
		public int SelectMemberPw(Member member) throws Exception {
			Connection conn = DBConn.dbConnection();
			int userId = -1;
			String query = "SELECT * FROM member Where id= ? "
					+ " and email= ? "
					+ " and age = ? ;";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, member.getUserId());
			psm.setString(2, member.getEmail());
			psm.setString(3, member.getAge());
			ResultSet rs = psm.executeQuery();			
			if( rs.next() ) {
		    	userId= rs.getInt("memberIDX");
		    	System.out.println("유저가 존재합니다.  memberIDX : "+userId);
		    	psm.close();
				rs.close();
		    	conn.close();
				return userId;
		    }else {
		    	System.out.println("유저가 존재하지 않습니다.");
		    	System.out.println(member.getUserId() + member.getEmail() + member.getAge());
		    	psm.close();
				rs.close();
		    	conn.close();
		    	return userId;
		    }
		}
		
		// 비밀번호 수정
		public int UpdateMemberPw(Member member) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			SHA256 sha256 = new SHA256();
			System.out.println(member.getMemberIdx()+ " , "+member.getPassword() );
			String crypthogram_password = sha256.encrypt(member.getPassword());
			String query = "UPDATE member SET password = ? where memberIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);			
			ppsm.setString(1,crypthogram_password);
			ppsm.setInt(2,member.getMemberIdx());	
			System.out.println(query);
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re; 
		}
}	

