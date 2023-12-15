package com.Group.fo.Service;

import com.Group.fo.Utils.DBConn;
import com.Group.fo.vo.Dao.BoardDao;
import com.Group.fo.vo.model.Board;
import com.Group.fo.vo.model.Comment;
import com.Group.fo.vo.model.Group;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.Map;


public class BoardService {
	BoardDao boardDao = new BoardDao();
	
	//게시글 저장
	public int saveBoard(int groupIDX, int memberIDX, String comment) throws Exception {
		return  boardDao.InsertBoard(groupIDX, memberIDX, comment);
	}
	
	//selectAllBoard 게시글 전부 긁어오기
	public List<Map<String, Object>> printAllBoard(int groupIDX) throws Exception {
		return boardDao.selectAllBoard(groupIDX);
	} 
	
	// 게시판 업데이트
	public int boardUpdate(Board board) throws Exception {
		return  boardDao.updateBoardByBoard(board);
	}
	
	//게시글 삭제
	public int boardDelete(int boardIDX) throws Exception {
		int rs = boardDao.commentDelByBoardIDX(boardIDX);
		if(rs > 0) {
			return  boardDao.delBoardByAjax(boardIDX);	
		}else {
			System.out.println(boardIDX+"댓글 삭제 오류. 게시글 삭제를 진행합니다.");
			return  boardDao.delBoardByAjax(boardIDX);	
		}
	}
	
	//전체 조회
	public List<Map<String, Object>> clickPrintComment(Comment comment) throws Exception {
		Connection conn = DBConn.dbConnection();
		List<Map<String, Object>> commentList = boardDao.SelectComment(conn, comment);
		conn.close();
		return commentList;
	}
	
	//ajax로 댓글 입력
	public List<Map<String, Object>> AjaxInsertComment(Comment comment,int memberIDX) throws Exception {
		Connection conn = DBConn.dbConnection();
		int insertRs = boardDao.insertComment(conn, comment, memberIDX);
		if( insertRs > 0 ) {
			List<Map<String, Object>> commentList = boardDao.SelectComment(conn, comment);
			conn.close();
			return commentList;
		}else {
			conn.close();
			return Collections.emptyList();
		}
	}
	
	// update 이후 select로 출력 updateCommentByCommentIDX
	public List<Map<String, Object>> commentUpdate(Comment comment) throws Exception {
		Connection conn = DBConn.dbConnection();
		int insertRs = boardDao.updateCommentByCommentIDX(conn, comment);
		if( insertRs > 0 ) {
			List<Map<String, Object>> commentList = boardDao.SelectComment(conn, comment);
			conn.close();
			return commentList;
		}else {
			conn.close();
			return Collections.emptyList();
		}
	}
	
	//comment delete이후 select로 출력
	public List<Map<String, Object>> commentDelAndSelect(Comment comment) throws Exception {
		Connection conn = DBConn.dbConnection();
		int delRs = boardDao.DelteCommentByCommentIDX(conn, comment);
		if( delRs > 0 ) {
			List<Map<String, Object>> commentList = boardDao.SelectComment(conn, comment);
			conn.close();
			return commentList;
		}else {
			conn.close();
			return Collections.emptyList();
		}
	}
	
	//board 멤버 리스트 추 출력
	//selectAllBoard 게시글 전부 긁어오기
	public List<Map<String, Object>> printMemberList(int groupIDX) throws Exception {
		return boardDao.SelectMemberList(groupIDX);
	} 
		
}
