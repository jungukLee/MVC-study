package com.Group.fo.Controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Group.fo.Service.BoardService;
import com.Group.fo.Service.GroupService;
import com.Group.fo.vo.Dao.BoardDao;
import com.Group.fo.vo.model.Board;
import com.Group.fo.vo.model.Group;
///

@Controller
public class BoardController {
		private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
		
		//[모임 게시판]
		@RequestMapping(value = "/groupBoard", method = RequestMethod.GET)
		public String groupBoard(@RequestParam("idx") int groupIDX, @RequestParam("title") String title, HttpServletRequest request,
				Locale locale, Model model) throws Exception {
			logger.info("groupBoard Page! The client locale is {}.", locale);
			HttpSession session = request.getSession(false);
			System.out.println(groupIDX + "모임의 게시판 페이지입니다.");
			if(session == null) {
				return "common/pleaseLogin";
			}else {
				boolean flag = false;
				int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
				String memberNickName = (String)session.getAttribute("nickname");
				BoardService boardService = new BoardService();
				//boardList
				List<Map<String, Object>> boardList = boardService.printAllBoard(groupIDX);
				// memberList
				List<Map<String, Object>> memberList = boardService.printMemberList(groupIDX);
				for (Map<String, Object> data : memberList) {
					boolean temp = false;
					for (Map.Entry<String, Object> entry : data.entrySet()) {
					    String key = entry.getKey();
					    Object value = entry.getValue();
					    System.out.println("Key: " + key + ", Value: " + value);		    
					    
					    //먼저 그룹안에 memberIDX에 속해있는지 검사를 함
					    if("fk_memberIDX".equals(key)) {
					    	int fkMemberIDX = Integer.parseInt(value.toString());
					    	if(fkMemberIDX == memberIDX) {
					    		System.out.println("일단 멤버안에 속해있긴 함");
					    		temp = true;
					    	}
					    }
					    
					    // 그룹안에 멤버가 있으면서 status가 Waiting이 아닐때!
					    if(temp && "member_status".equals(key)) {
					    	String memberStatus = value.toString();
					    	System.out.println("일단 우리멤버인데, 멤버의 status는 ? : "+memberStatus);
					    	if( !memberStatus.equals("Waiting") ) {
					    		flag = true;
					    	}
					    }
					    /*
					    if ("fk_memberIDX".equals(key)) {
					    	int fkMemberIDX = Integer.parseInt(value.toString());
			                if (fkMemberIDX == memberIDX  ) {
			                	System.out.println(fkMemberIDX + " " + memberIDX + " 그룹의 멤버입니다.");
		                		temp = true;
			                	break;  // 이미 일치하는 경우이므로 더 이상 비교할 필요가 없음
			                }
			            }
					    
					    //만약 wating 혹은 good이든 일단 그룹의 멤버일경우
					    if(temp && "member_status".equals(key) ) {
					    	String status_value = value.toString();
					    	if( status_value == "Waiting" ) {
					    		flag = false;
					    	}else {
					    		flag =true;
					    	}
					    }
			           */ 
					    System.out.println("---------------");
					}
				}
				if(flag == false) {
					return "redirect:/sucessGroupInsert?rs=10";
				}
				//required			
				if( !memberList.isEmpty()){
					model.addAttribute("masterIDX",(String)memberList.get(0).get("masterIDX"));
				}else {
					model.addAttribute("masterIDX",-1);
				}
				
				model.addAttribute("boardList",boardList);
				model.addAttribute("memberList",memberList);
				model.addAttribute("title", title);
				model.addAttribute("groupIDX", groupIDX);
				model.addAttribute("nickname",memberNickName);
				//board
				model.addAttribute("memberIDX",memberIDX);
				//member
				
				
				return "groupBoard";
			}
		}
		
		//모임 추가
		@PostMapping("/insertBoard")
		public String insertBoard(@RequestParam("groupIDX") int groupIDX, @RequestParam("content") String content,
				@RequestParam("groupTitle") String groupTitle, HttpServletRequest request, RedirectAttributes attributes)  throws Exception {			
			HttpSession session = request.getSession(false);
			if(session == null) {
				return "common/pleaseLogin";
			}else {	
				String memberNickName = (String)session.getAttribute("nickname");
				int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
				System.out.println(memberNickName + " " + memberIDX +"  "+groupIDX);

				BoardService boardService = new BoardService();
				int result = boardService.saveBoard(groupIDX, memberIDX,content);
				
				attributes.addAttribute("idx", groupIDX);
			    attributes.addAttribute("title", groupTitle);
			    
				if(result > 0) {
					System.out.println("Baord Insert 완료");
					return "/groupBoard";
				}else {
					System.out.println("Baord Insert 실패");
					return "오류";
				}
			}	
		}
		

		// 게시글 수정 /editBoard
		@PostMapping("/editBoard")
		public String editBoard(@RequestParam("groupTitle") String groupTitle,Board board, 
				Model model, RedirectAttributes attributes)  throws Exception {	
		    System.out.println(board.getContent()+board.getBoardIDX()+ " "+ groupTitle +" " + board.getFk_groupIDX());
			
		    attributes.addAttribute("idx", board.getFk_groupIDX());
		    attributes.addAttribute("title", groupTitle);
		
		    //BoardDao boardDao = new BoardDao();
		    BoardService boardService = new BoardService();
		    
		    int rs = boardService.boardUpdate(board);
		    if(rs > 0 ) {
		    	return "groupBoard";	
		    }else {
		    	return "/";
		    }	   
		}		
		
		// 게시글 삭제 delBoard 
		@PostMapping("/delBoard")
		public String delBoard(@RequestParam("title") String groupTitle,
				@RequestParam("boardIDX") int boardIDX, @RequestParam("groupIDX") int groupIDX,   
				Model model, RedirectAttributes attributes)  throws Exception {	
	
		    attributes.addAttribute("idx", groupIDX);
		    attributes.addAttribute("title", groupTitle);
		
		    BoardService boardService = new BoardService();
		    int rs = boardService.boardDelete(boardIDX);
		    
		    if(rs > 0 ) {
		    	return "groupBoard";	
		    }else {
		    	return "/";
		    }	   
		}
				
}
