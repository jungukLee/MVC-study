package com.Group.fo.Controller;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Group.fo.Service.BoardService;
import com.Group.fo.Service.GroupService;
import com.Group.fo.vo.model.Board;
import com.Group.fo.vo.model.Comment;

@RestController
public class RestJsonController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//main 더 불러오기
	@RequestMapping(value = "/groupMore", method = RequestMethod.GET)
	public List<Map<String, Object>> groupMore(@RequestParam("offset") int offset, @RequestParam("limit") int limit, Locale locale, Model model) throws Exception {
		logger.info("Group More! The client locale is {}.", locale);
		GroupService groupService = new GroupService();
		List<Map<String, Object>> groupList = groupService.printAllGroup(offset,limit);
		return groupList; 
	}
	
	//검색 ajax headSearch 
	@RequestMapping(value = "/headSearch", method = RequestMethod.GET)
	public List<Map<String, Object>> headSearch(@RequestParam("search") String searchValue, Locale locale, Model model) throws Exception {
		logger.info("headSearch! The client locale is {}.", locale);
		GroupService groupService = new GroupService();
		List<Map<String, Object>> groupList = groupService.searchedTitleIntroduce(searchValue);
		return groupList; 
	}
	
	//comment 생성
	//댓글 생성 insertComment		
	@PostMapping("/insertComment")
	public List<Map<String, Object>> insertComment(Comment comment, HttpServletRequest request) throws Exception {		
		HttpSession session = request.getSession(false);
		List<Map<String,Object>> commentList;
		if( session == null) {
			return Collections.emptyList();
		}else {
			BoardService boardService = new BoardService();
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			commentList = boardService.AjaxInsertComment(comment, memberIDX);
			for (Map<String, Object> data : commentList) {
				for (Map.Entry<String, Object> entry : data.entrySet()) {
				    String key = entry.getKey();
				    Object value = entry.getValue();
				    System.out.println("Key: " + key + ", Value: " + value);
				}
			}
			return commentList;
		}    
	}
	
	//댓글 수정후 출력 editComment 
	@PostMapping("/editComment")
	public List<Map<String, Object>> editComment(Comment comment, HttpServletRequest request) throws Exception {		
		HttpSession session = request.getSession(false);
		List<Map<String,Object>> commentList;
		if( session == null) {
			return Collections.emptyList();
		}else {
			BoardService boardService = new BoardService();
			commentList = boardService.commentUpdate(comment);
			return commentList;
		}    
	}
	
	//댓글 print printComment
	@PostMapping("/printComment")
	public List<Map<String, Object>> printComment(Comment comment, HttpServletRequest request) throws Exception {		
		HttpSession session = request.getSession(false);
		List<Map<String,Object>> commentList;
		if( session == null) {
			return Collections.emptyList();
		}else {
			System.out.println(comment.getFk_boardIDX());
			BoardService boardService = new BoardService();
			commentList = boardService.clickPrintComment(comment);
			return commentList;
		}    
	}
	
	//댓글 삭제 후 printComment delComment
	@PostMapping("/delComment")
	public List<Map<String, Object>> delComment(Comment comment, HttpServletRequest request) throws Exception {		
		HttpSession session = request.getSession(false);
		List<Map<String,Object>> commentList;
		if( session == null) {
			return Collections.emptyList();
		}else {
			BoardService boardService = new BoardService();
			commentList = boardService.commentDelAndSelect(comment);
			return commentList;
		}    
	}
	
	
}

//for (Map<String, Object> data : groupList) {
//for (Map.Entry<String, Object> entry : data.entrySet()) {
//    String key = entry.getKey();
//    Object value = entry.getValue();
//    System.out.println("Key: " + key + ", Value: " + value);
//}
//}