package com.Group.fo.vo.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.Group.fo.Utils.DBConn;
import com.Group.fo.Utils.DbUtil;
import com.Group.fo.vo.model.Group;
import com.Group.fo.vo.Dao.MemberDao; 
public class GroupDao {
	
		//모임 추가
		public int insertGroup(Group group) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "INSERT INTO dgroup(fk_memberIDX, title, country, category, generation, introduce,image_path)"
					+ " VALUES (?,?,?,?,?,?,?);";
			PreparedStatement ppsm = conn.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			ppsm.setInt(1, group.getFk_memberIdx() );
			ppsm.setString(2, group.getTitle());
			ppsm.setString(3, group.getCountry());
			ppsm.setString(4, group.getCategory());
			ppsm.setString(5, group.getGeneration());
			ppsm.setString(6, group.getIntroduce());
			ppsm.setString(7, group.getImage_path());
			re = ppsm.executeUpdate();
		    ResultSet generatedKeys = ppsm.getGeneratedKeys();
		    if (generatedKeys.next()) {
		        MemberDao memberDao = new MemberDao();
		    	int groupIDX = generatedKeys.getInt(1);
		        int i = memberDao.insertGroupMember(group.getFk_memberIdx(), groupIDX, "Master");
		        if( i < 0 ) {
		        	System.out.println("GroupDao insertGroupMember error");
		        	ppsm.close();
		        	conn.close();
		        	return -1;
		        }else {
		        	ppsm.close();
					conn.close();
					return i;
		        }
		    }else {
		    	System.out.println("GroupDao getGeneratedKey error");
		    	return -1;
		    }
			
		}	
				
		
		@Transactional
		public int deleteGroup(int groupIDX) throws SQLException {
			try (Connection conn = DBConn.dbConnection()) {
	        // 1. dgroup 테이블에서 groupIDX가 1인 행 삭제
		        try (PreparedStatement ppsm = conn.prepareStatement("DELETE FROM dgroup WHERE groupIDX = ?")) {
		            ppsm.setInt(1, groupIDX);
		            ppsm.executeUpdate();
		        }
		        
		        // 3. group_board_comment 테이블에서 groupIDX가 1인 group_board의 boardIDX 값을 가져오기
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM group_board_comment WHERE fk_boardIDX IN (SELECT boardIDX FROM group_board WHERE fk_groupIDX = ?)")) {
		            deleteGroupBoardCommentPpsm.setInt(1, groupIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }
		        
		        // 2. group_board 테이블에서 fk_groupIDX이 1인 행 삭제
		        try (PreparedStatement ppsm = conn.prepareStatement("DELETE FROM group_board WHERE fk_groupIDX = ?")) {
		            ppsm.setInt(1, groupIDX);
		            ppsm.executeUpdate();
		        }
		       
		        // 4. likes
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM likes_group WHERE fk_groupIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, groupIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }
		        // 5 members
		        try (PreparedStatement deleteGroupBoardCommentPpsm = conn.prepareStatement("DELETE FROM group_members WHERE fk_groupIDX = ?")) {
		            deleteGroupBoardCommentPpsm.setInt(1, groupIDX);
		            deleteGroupBoardCommentPpsm.executeUpdate();
		        }    
		        return 1;		        
			} catch (SQLException e) {
	            // 롤백되면 예외가 발생하므로, 실패했을 때 -1을 반환
	            e.printStackTrace();
	            return -1;
	        }
		}

		//모임 offset부터 limit까지 리턴
		public List<Map<String, Object>> selectAllGroup(int offset, int limit) throws Exception {
			Connection conn = DBConn.dbConnection();			
		    String query = "SELECT * FROM dgroup ORDER BY cread_at DESC LIMIT ? OFFSET ?;";    
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, limit);
	        psm.setInt(2, offset);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		// 모임 1개에 대한 정보
		public List<Map<String, Object>> selectGroupByGroupId(int groupIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			String query = "SELECT * FROM dgroup WHERE groupIDX = ?";
//			String query = "SELECT dg.*, count(lg.fk_memberIDX) as count_likes "
//					+ " FROM dgroup as dg, likes_group as lg "
//					+ " WHERE dg.groupIDX = lg.fk_groupIDX and groupIDX = ? "
//					+ " group by groupIDX;";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, groupIDX);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		//모임 업데이트
		public int updateGroupByGroup(Group group) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "UPDATE dgroup SET  title = ?"
					+ "  , cread_at = current_timestamp"
					+ "  , country = ?"
					+ "  , category = ?"
					+ "  , generation = ?"
					+ "  , introduce = ?"
					+ " WHERE groupIDX = ?";
			PreparedStatement ppsm = conn.prepareStatement(query);			
			ppsm.setString(1,group.getTitle());
			ppsm.setString(2,group.getCountry());
			ppsm.setString(3,group.getCategory());
			ppsm.setString(4,group.getGeneration());
			ppsm.setString(5,group.getIntroduce());
			ppsm.setInt(6, group.getGroupIdx()  );
			System.out.println(query);
			re = ppsm.executeUpdate();
			ppsm.close();
			conn.close();
			return re; 
		}
			
		//모임 관심이 눌러져있는지 체크
		public int checkInterest(int memberIDX, int groupIDX) throws Exception{
			Connection conn = DBConn.dbConnection();
			int count = -1;
			System.out.println("DAO memberIDX: "+memberIDX+" groupIDX : "+groupIDX);
			String query = "Select COUNT(*) FROM likes_group WHERE fk_memberIDX = ? AND fk_groupIDX = ?";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, memberIDX);
			ppsm.setInt(2, groupIDX);
			System.out.println(query);
			ResultSet re = ppsm.executeQuery();
			if( re.next()) {
				count = re.getInt(1);
			}
			re.close();
			ppsm.close();
			conn.close();
			return count;
		}
		
		
		//모임 관심에 추가
		public int addInterest(int memberIDX, int groupIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "INSERT INTO likes_group(fk_memberIDX, fk_groupIDX)"
					+ " VALUES (?,?);";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, memberIDX);
			ppsm.setInt(2, groupIDX);
			re = ppsm.executeUpdate();
			System.out.println(query);
			ppsm.close();
			conn.close();
			return re;
		}	
		
		
		
		//모임 관심삭제 by groupIDX all
		public int delInterest(int memberIDX, int groupIDX) throws Exception {
			Connection conn = DBConn.dbConnection();
			int re = -1;
			String query = "DELETE FROM likes_group WHERE fk_memberIDX = ? AND fk_groupIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, memberIDX);
			ppsm.setInt(2, groupIDX);
			re = ppsm.executeUpdate();
			System.out.println(query);
			ppsm.close();
			conn.close();
			return re;
		}
		
		//group 모임 수 증가
		public int increaseInterest(int groupIDX) throws Exception{
			int re= -1;
			Connection conn = DBConn.dbConnection();
			String query = "UPDATE dgroup SET likes = likes + 1 WHERE groupIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, groupIDX);
			re = ppsm.executeUpdate();
			System.out.println(query);
			ppsm.close();
			conn.close();
			return re;
		}
		
		//group 모임 수 다운
		public int decreaseInterest(int groupIDX) throws Exception{
			int re= -1;
			Connection conn = DBConn.dbConnection();
			String query = "UPDATE dgroup SET likes = likes + -1 WHERE groupIDX = ?;";
			PreparedStatement ppsm = conn.prepareStatement(query);
			ppsm.setInt(1, groupIDX);
			re = ppsm.executeUpdate();
			System.out.println(query);
			ppsm.close();
			conn.close();
			return re;
		}
		
		// 관심 모임 출력
		public List<Map<String, Object>> selectInterestGroup(int memberIDX) throws Exception {
			Connection conn = DBConn.dbConnection();			
		    String query = "SELECT * FROM dgroup WHERE groupIDX IN "
		    		+ "(SELECT fk_groupIDX FROM likes_group WHERE fk_memberIDX = ?);";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, memberIDX);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		//검색 title,intorcue 검색출력
		public List<Map<String, Object>> selectSearchedTitleIntroduce(String searchValue) throws Exception {
			Connection conn = DBConn.dbConnection();			
		    String query = "SELECT * FROM dgroup WHERE title LIKE CONCAT('%',?,'%')"
		    		+ " OR introduce LIKE CONCAT('%',?,'%')";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, searchValue);
			psm.setString(2, searchValue);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		//상세 검색 지역, 카테고리, 나이, 포함단어
		public List<Map<String, Object>> selectSearchedDetail(String titleAndIntroduce, 
				String country, String category, String generation ) throws Exception {
			Connection conn = DBConn.dbConnection();			
		    String query = "SELECT * FROM dgroup WHERE (title LIKE CONCAT('%',?,'%') "
		    		+ "OR introduce LIKE CONCAT('%',?,'%')) "
		    		+ "AND country = ? "
		    		+ "AND category = ? "
		    		+ "AND generation LIKE CONCAT('%',?,'%');";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, titleAndIntroduce);
			psm.setString(2, titleAndIntroduce);
			psm.setString(3, country);
			psm.setString(4, category);
			psm.setString(5, generation);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		//내가 가입한 그룹 출력 
		public List<Map<String, Object>> selectGroupByMemberIDX( int memberIDX ) throws Exception {
			Connection conn = DBConn.dbConnection();			
		    //String query = "SELECT * FROM dgroup WHERE fk_memberIDX = ?;";
			String query = "SELECT dg.* "
					+ " FROM dgroup dg, group_members as gm "
					+ " WHERE dg.groupIDX = gm.fk_groupIDX AND (member_status = 'Good' OR member_status ='Master') "
					+ " AND gm.fk_memberIDX = ?;";
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setInt(1, memberIDX);
			ResultSet rs = psm.executeQuery();
			DbUtil dbUtil = new DbUtil();
			List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
			rs.close();
			psm.close();
			conn.close();
			return mapList;
		}
		
		 
		
}
