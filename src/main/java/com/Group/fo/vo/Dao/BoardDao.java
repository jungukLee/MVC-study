package com.Group.fo.vo.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.Group.fo.Utils.DBConn;
import com.Group.fo.Utils.DbUtil;
import com.Group.fo.vo.model.Board;
import com.Group.fo.vo.model.Comment;
import com.Group.fo.vo.model.Group;

public class BoardDao {
	//게시판 글 추가 
	public int InsertBoard(int groupIDX, int memberIDX, String comment) throws Exception {
		Connection conn = DBConn.dbConnection();
		int re = -1;
		String query = "INSERT INTO group_board (fk_groupIDX,fk_memberIDX,content) "
				+ "VALUES (?,?,?);";
		PreparedStatement ppsm = conn.prepareStatement(query);
		ppsm.setInt(1, groupIDX);
		ppsm.setInt(2, memberIDX);
		ppsm.setString(3, comment);
		re = ppsm.executeUpdate();
		System.out.println(query);
		ppsm.close();
		conn.close();
		return re;
	} 
	
	//게시판 글 가져오기 조회하기
	public List<Map<String, Object>> selectAllBoard(int groupIDX) throws Exception {
		Connection conn = DBConn.dbConnection();			
	     //String query = "SELECT * FROM group_board WHERE fk_groupIDX = ?  ORDER BY cread_at DESC;";    
	     String query = "SELECT  gb.*, m.nickname AS nickname, COUNT(gbc.commentIDX) AS commentCount "
					+ " FROM group_board AS gb "
					+ " JOIN member AS m ON gb.fk_memberIDX = m.memberIDX "
					+ " LEFT JOIN group_board_comment AS gbc ON gb.boardIDX = gbc.fk_boardIDX "
					+ " WHERE gb.fk_groupIDX = ? "
					+ " GROUP BY gb.boardIDX "
					+ " ORDER BY gb.cread_at DESC;";
		PreparedStatement psm = conn.prepareStatement(query);
		psm.setInt(1, groupIDX);
		ResultSet rs = psm.executeQuery();
		DbUtil dbUtil = new DbUtil();
		List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
		System.out.println(query);
		rs.close();
		psm.close();
		conn.close();
		return mapList;
	}
	
	//게시판 글 수정
	public int updateBoardByBoard(Board board) throws Exception {
		Connection conn = DBConn.dbConnection();
		int re = -1;
		String query = "UPDATE group_board SET content = ?"
				+ "  , cread_at = current_timestamp "
				+ " WHERE boardIDX = ?";
		PreparedStatement ppsm = conn.prepareStatement(query);			
		ppsm.setString(1,board.getContent());
		ppsm.setInt(2, board.getBoardIDX());
		System.out.println(query);
		re = ppsm.executeUpdate();
		ppsm.close();
		conn.close();
		return re; 
	}
	
	//게시판 글 삭제
	public int delBoardByAjax(int boardIDX) throws Exception {
		Connection conn = DBConn.dbConnection();
		int re = -1;
		String query = "DELETE FROM group_board WHERE boardIDX = ?;";
		PreparedStatement ppsm = conn.prepareStatement(query);			
		ppsm.setInt(1, boardIDX);
		System.out.println(query);
		re = ppsm.executeUpdate();
		ppsm.close();
		conn.close();
		return re; 
	}
	
	// 게시판 글 삭제하면 댓글 글 전부 삭제
	public int commentDelByBoardIDX(int boardIDX) throws Exception{
		Connection conn = DBConn.dbConnection();
		int re = -1;
		try {
		    // 안전 모드 해제
		    String disableSafeUpdatesQuery = "SET SQL_SAFE_UPDATES = 0;";
		    try (PreparedStatement disableSafeUpdatesPpsm = conn.prepareStatement(disableSafeUpdatesQuery)) {
		        disableSafeUpdatesPpsm.executeUpdate();
		    }

		    // DELETE 실행
		    String deleteQuery = "DELETE FROM group_board_comment WHERE fk_boardIDX = ?;";
		    try (PreparedStatement deletePpsm = conn.prepareStatement(deleteQuery)) {
		        deletePpsm.setInt(1, boardIDX);
		        System.out.println(deleteQuery);
		        re = deletePpsm.executeUpdate();
		    }
		} finally {
		    // 안전 모드 다시 활성화
		    String enableSafeUpdatesQuery = "SET SQL_SAFE_UPDATES = 1;";
		    try (PreparedStatement enableSafeUpdatesPpsm = conn.prepareStatement(enableSafeUpdatesQuery)) {
		        enableSafeUpdatesPpsm.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            conn.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		}
	
		return re;
	}
	
	
	// comment insert / not conn.close 
	public int insertComment(Connection conn, Comment comment,int memberIDX) throws SQLException {
		int re = -1;
		String query = "INSERT INTO group_board_comment ( fk_boardIDX,fk_memberIDX,content)"
	    		+ " VALUES ( ?,?,?)";
	    PreparedStatement psm = conn.prepareStatement(query);
		System.out.println("INSET"+" boardIDX : "+comment.getFk_boardIDX() + "memberIDX" + memberIDX + " content : " + comment.getContent());

	    psm.setInt(1, comment.getFk_boardIDX());
	    psm.setInt(2, memberIDX);
		psm.setString(3, comment.getContent());		
		re = psm.executeUpdate();
		System.out.println(query);		
		psm.close();
		return re;
	}
	
	//comment update / not conn close
	
	public int updateCommentByCommentIDX(Connection conn, Comment comment) throws SQLException {
		int re = -1;
		String query = "UPDATE group_board_comment SET cread_at = current_timestamp(), "
				+ " content = ? WHERE commentIDX = ?";
	    PreparedStatement psm = conn.prepareStatement(query);
		System.out.println("Update content : "+comment.getContent()+ "commentIDX" + comment.getCommentIDX() );
	    psm.setString(1, comment.getContent());
	    psm.setInt(2, comment.getCommentIDX());		
		re = psm.executeUpdate();
		System.out.println(query);		
		psm.close();
		return re;
	}
	
	// 댓글 삭제
	public int DelteCommentByCommentIDX(Connection conn, Comment comment) throws SQLException {
		int re = -1;
		String query = "DELETE FROM group_board_comment WHERE commentIDX = ?;";
	    PreparedStatement psm = conn.prepareStatement(query);
	    psm.setInt(1, comment.getCommentIDX());		
		re = psm.executeUpdate();
		System.out.println(query);		
		psm.close();
		return re;
	} 
	

	
	// comment select / not conn.close 
	public List<Map<String, Object>> SelectComment(Connection conn,Comment comment)throws Exception {
		String query = "SELECT gbc.*, m.nickname AS nickname FROM member m "
				+ "INNER JOIN group_board_comment gbc ON m.memberIDX = gbc.fk_memberIDX "
				+ "WHERE gbc.fk_boardIDX = ?;";  
		PreparedStatement getstmt = conn.prepareStatement(query);				
		getstmt.setInt(1, comment.getFk_boardIDX());
		ResultSet rs = getstmt.executeQuery();
		DbUtil dbUtil = new DbUtil();
		List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
		System.out.println(query);
		rs.close();
		getstmt.close();
		return mapList;		
	}
	
	// 게시글마다 댓글 count 하기
	public int countCommentByboardIDX(Connection conn, Comment comment) throws SQLException {
		int re = -1;
		String query = "SELECT count(*) as commentCount  FROM group_board as g_b, "
				+ "group_board_comment as g_b_c "
				+ "WHERE g_b_c.fk_boardIDX IN (g_b.boardIDX) AND g_b.boardIDX = ?;";
	    PreparedStatement psm = conn.prepareStatement(query);
	    psm.setInt(1, comment.getCommentIDX());		
	    ResultSet rs = psm.executeQuery();
		System.out.println(query);		

	    if( rs.next() ) {
	    	int res = rs.getInt("commentCount"); 
			psm.close();
			rs.close();
	    	return res;
	    }else {
	    	return 0;
	    }
	}
		
	// 게시판 memberList 가져오기
	public List<Map<String, Object>> SelectMemberList(int groupIDX)throws Exception {
		Connection conn = DBConn.dbConnection();
		String query = "SELECT DISTINCT gm.*,\r\n"
				+ " (SELECT m.nickname FROM member m WHERE m.memberIDX = gm.fk_memberIDX AND gm.fk_groupIDX = ?) as nickname, "
				+ " (SELECT dg.fk_memberIDX FROM dgroup dg WHERE dg.groupIDX = gm.fk_groupIDX) as masterIDX "
				+ " FROM group_members gm "
				+ " JOIN dgroup dg ON gm.fk_groupIDX = dg.groupIDX "
				+ " WHERE gm.fk_groupIDX = ?;";  
		
		PreparedStatement getstmt = conn.prepareStatement(query);				
		getstmt.setInt(1, groupIDX);
		getstmt.setInt(2, groupIDX);
		ResultSet rs = getstmt.executeQuery();
		DbUtil dbUtil = new DbUtil();
		List<Map<String, Object>> mapList = dbUtil.getResultMapRows(rs);
		System.out.println(query);
		conn.close();
		rs.close();
		getstmt.close();
		return mapList;		
	}
	
}
