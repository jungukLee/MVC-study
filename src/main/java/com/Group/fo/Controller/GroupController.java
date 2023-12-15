package com.Group.fo.Controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Group.fo.Service.GroupService;
import com.Group.fo.Service.MemberService;
import com.Group.fo.vo.model.Group;

@Controller
public class GroupController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//모임 생성페이지
	@RequestMapping(value = "/groupInsert", method = RequestMethod.GET)
	public String groupInsert(Locale locale, Model model) {
		logger.info("GroupInsert page! The client locale is {}.", locale);
		return "groupInsert";
	}
	
	//그룹 삭제  /groupDel
	@PostMapping("/groupDel")
	public String groupDel(@RequestParam int groupIDX, Model model)  throws Exception {	
		GroupService groupService = new GroupService();
		int rs = groupService.deleteGroupAtAll(groupIDX);
		if(rs > 0 ) {
			return "redirect:/sucessGroupInsert?rs=16";
		}else {
			return "redirect:/sucessGroupInsert?rs=17";

		}
	}
	
	//글 수정 페이지 이동
	@PostMapping("/groupEdit")
	public String groupEdit(@RequestParam int groupIDX, Model model)  throws Exception {	
		GroupService groupService = new GroupService();
		List<Map<String, Object>> groupList = groupService.getGroupByGroupId(groupIDX);
		Map<String,Object> groupInfo = groupList.get(0);
		model.addAttribute("groupInfo",groupInfo);
		for (Map.Entry<String, Object> entry : groupInfo.entrySet()) {
		    String key = entry.getKey();
		    Object value = entry.getValue();
		    System.out.println(key + ": " + value);
		}
		return "groupEdit";
	}
	
	//모임 수정
	@PostMapping("/groupEditService")
	public String handlegroupEditService(Group group)  throws Exception {	
		System.out.println("-2-");		
		GroupService groupService = new GroupService();
		int result = groupService.updateGroup(group);
		
		if(result == 1) {
			System.out.println("Group Update 완료");
			return "redirect:/sucessGroupInsert?rs=3?idx="+group.getGroupIdx();
		}else {
			System.out.println("Group Update 실패");
			return "redirect:/sucessGroupInsert?rs=2";
		}
		
	}
	
	//모임 상세 페이지
	@RequestMapping(value = "/groupDetail", method = RequestMethod.GET)
	public String groupDetail(@RequestParam("idx") int idx, Locale locale, Model model,
							  HttpServletRequest request) throws Exception {
		logger.info("GroupDetail page! The client locale is {}.", locale);
		//모임 상세 데이터 가져오는 부분
		GroupService groupService = new GroupService();
		List<Map<String, Object>> groupList = groupService.getGroupByGroupId(idx);
		Map<String,Object> groupInfo = groupList.get(0);	
		
		model.addAttribute("idx",idx);
		model.addAttribute("groupInfo",groupInfo);	
		// 모임 관심이 눌려있는지 가져오기
		HttpSession session = request.getSession(false);
		if(session != null) {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			int groupIDX = idx;
			System.out.println("memberIDX : "+memberIDX + " groupIDX : "+groupIDX);
			boolean checkInterest = groupService.getCheckedInterest(memberIDX, groupIDX);		
			if(checkInterest) {
				System.out.println("관심 모임입니다.");
				model.addAttribute("interestStatus", "Yes");
			}else {
				System.out.println("관심 모임이 아닙니다.");
				model.addAttribute("interestStatus", "No");
			}
		}else {
			model.addAttribute("interestStatus", "None");
		}
		return "groupDetail";
	}

	//관심모임 추가 addInterest
	@PostMapping("/addInterest")
	public String addInterest(@RequestParam("idx") int idx,@RequestParam int memberIDX, @RequestParam int groupIDX,
		RedirectAttributes attributes)  throws Exception {	
		System.out.println("memberIDX : "+memberIDX +" groupIDX : "+groupIDX);		
		System.out.println("관심모임 추가 / idx : "+idx);
		attributes.addAttribute("idx", idx);
		GroupService groupService = new GroupService();
		int result = groupService.saveInterest(memberIDX, groupIDX);
		if(result ==1) {
			return "redirect:/groupDetail";
		}else {
			return "/testDB";
		}
	}
	
	//관심모임 삭제 delInterest
		@PostMapping("/delInterest")
		public String delInterest(@RequestParam("idx") int idx,@RequestParam int memberIDX, @RequestParam int groupIDX,
				RedirectAttributes attributes)  throws Exception {	
			System.out.println("memberIDX : "+memberIDX +" groupIDX : "+groupIDX);
			System.out.println("관심모임 삭제 / idx : "+idx);
			attributes.addAttribute("idx", idx);
			GroupService groupService = new GroupService();
			int result = groupService.delInterestByIDXs(memberIDX, groupIDX);
			if(result > 0 ) {
				System.out.println("관심 모임 삭제 완료");
				return "redirect:/groupDetail";
			}else {
				System.out.println("관심 모임 삭제 에러");
				return "/testDB";
			}
		}
	
	//내 관심 모임 출력
	@RequestMapping(value = "/myInterest", method = RequestMethod.GET)
	public String myInterest(HttpServletRequest request, Locale locale, Model model) throws Exception {
		logger.info("myInterest Page! The client locale is {}.", locale);
		HttpSession session = request.getSession(false);
		if(session == null) {
			return "common/pleaseLogin";
		}else {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			GroupService groupService = new GroupService();
			List<Map<String, Object>> groupList = groupService.printMyInterest(memberIDX);
			model.addAttribute("groupList",groupList);
			return "myInterest";
		}
	
	}
	
	//[내 정보] 내가 가입한 모임
	@RequestMapping(value = "/myGroups", method = RequestMethod.GET)
	public String myGroups(HttpServletRequest request, Locale locale, Model model) throws Exception {
		logger.info("myGropus Page! The client locale is {}.", locale);
		HttpSession session = request.getSession(false);
		if(session == null) {
			return "common/pleaseLogin";
		}else {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			GroupService groupService = new GroupService();
			List<Map<String, Object>> groupList = groupService.signedGroup(memberIDX);
			model.addAttribute("groupList",groupList);
			return "myGroups";
		}
	}

	//그룹 insert 체킹 
	@RequestMapping(value = "/sucessGroupInsert", method = RequestMethod.GET)
	public String sucessGroupInsert(Locale locale, Model model) {
		logger.info("sucessGroupInsert The client locale is {}.", locale);
		return "common/groupInsertSuccess";
	}
		
	//모임 생성
	@PostMapping("/groupInsertService")
	public String handleGroupInsert(Group group, @RequestParam("img_file") MultipartFile file)  throws Exception {	
		System.out.println("모임 생성");
		GroupService groupService = new GroupService();		
		if (file == null || file.isEmpty()) {
			 group.setImage_path(null);	
		}else {
			String fileName = groupService.storeFile(file);
	        System.out.println("Controller : " + fileName);
	        group.setImage_path(fileName);	
		}		
        int result = groupService.saveGroup(group);
		if(result == 1) {
			System.out.println("Group Insert 완료");
			return "redirect:/sucessGroupInsert?rs=1";
		}else {
			System.out.println("Group Insert 실패");
			return "redirect:/sucessGroupInsert?rs=2";
		}
	}
		
}


