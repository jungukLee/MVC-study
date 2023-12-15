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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Group.fo.vo.model.Member;
import com.Group.fo.vo.Dao.MemberDao;
import com.Group.fo.Service.MemberService;
import com.Group.fo.Utils.SHA256;


@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model, HttpServletRequest request) {
		logger.info("Login Page! The client locale is {}.", locale);
		request.getSession().invalidate();
		return "login";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Locale locale, Model model) {
		logger.info("Join Page! The client locale is {}.", locale);
		return "join";
	}
	
	//회원탈퇴 /delMember
	@RequestMapping(value = "/delMember", method = RequestMethod.GET)
	public String delMember(Locale locale, Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);	
		if(session != null) {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			MemberService memberService = new MemberService();
			int rs = memberService.DeleteMemberAtAll(memberIDX);
			if (rs > 0 ) {
				session.invalidate();
				return "redirect:/sucessGroupInsert?rs=18";
			}else {
				return "redirect:/sucessGroupInsert?rs=19";
			}
		}else {	
			return "/common/pleaseLogin";
		}
	}
	
	//
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String findId(Locale locale, Model model) {
		logger.info("findId Page! The client locale is {}.", locale);
		return "findId";
	}
	
	//ID 찾기 /searchIDservice
	@PostMapping("/searchIDservice")
	@ResponseBody
	public String searchIDservice(Member member,Model model)  throws Exception {		
		MemberService memberService = new MemberService();
		String rs = memberService.FindUserId(member);
		if( rs == null) {
			System.out.println("findId null");
			return "no";
		}else {
			System.out.println("ID 찾음 id : "+rs);
			return rs;
		}
	}
	
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPw(Locale locale, Model model) {
		logger.info("findPw Page! The client locale is {}.", locale);
		return "findPw";
	}
	
	//비밀번호 찾기 로직 /checkPwService
	@PostMapping("/checkPwService")
	public String checkPwService(Member member, Model model, RedirectAttributes redirectAttributes)  throws Exception {		
		MemberService memberService = new MemberService();
		int rs = memberService.FindUserPw(member);	
		if( rs >= 0 ) {
            redirectAttributes.addAttribute("memberIDX", rs);
	        System.out.println("ID 존재함 rs : "+rs);
			//return "redirect:/EditPw?memberIDX="+rs;
	        return "redirect:/EditPw";
		}else {
			System.out.println("ID 없음 id : "+rs);
			return "redirect:/sucessGroupInsert?rs=11";
		}
	}
	
	@PostMapping("/editPwService")
	public String editPwService(Member member, Model model)  throws Exception {		
		MemberService memberService = new MemberService();
		System.out.println("controller : "+member.getMemberIdx() + ", "+member.getPassword());
		int rs = memberService.EditUserPw(member);		
		System.out.println(rs);
		if( rs > 0 ) {
			System.out.println("비밀번호 변경 완료");			
	        return "redirect:/sucessGroupInsert?rs=12";
		}else {
			System.out.println("비밀번호 변경 오류");
			return "redirect:/sucessGroupInsert?rs=13";
		}
	}
	
	//비밀번호 수정 페이지
	@RequestMapping(value = "/EditPw", method = RequestMethod.GET)
	public String EditPw(@RequestParam("memberIDX") int memberIDX, Locale locale, Model model) {
		logger.info("Edit Page! The client locale is {}.", locale);
		model.addAttribute("memberIDX",memberIDX);
		return "editPw";
	}
	
	//마이페이지 open
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Locale locale, Model model,HttpServletRequest request) throws Exception {
		logger.info("My Page! The client locale is {}.", locale);
		HttpSession session = request.getSession(false);
		if(session != null) {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			MemberService memberService = new MemberService();
			List<Map<String, Object>> memberList = memberService.myPageGetMember(memberIDX);			
			if (!memberList.isEmpty()) {
			    Map<String, Object> firstMemberMap = memberList.get(0);
			    model.addAttribute("memberInfo", firstMemberMap);
			}
		}else {	
			return "/common/pleaseLogin";
		}	
		return "myPage";
	}
	
	//개인정보 수정 EditMyInfo
	@PostMapping("/EditMyInfo")
	public String EditMyInfo(Member member, Model model, HttpServletRequest request)  throws Exception {		
		HttpSession session = request.getSession(false);			
		if(session != null) {
			int memberIDX = Integer.parseInt((String)session.getAttribute("memberIDX"));
			MemberService memberService = new MemberService();
			member.setMemberIdx(memberIDX);
			int rs = memberService.UpdateMemberInfo(member);	
			if( rs > 0 ) {
				System.out.println("정보 수정 완료");			
		        return "redirect:/sucessGroupInsert?rs=14";
			}else {
				System.out.println("정보 수정 오류");
				return "redirect:/sucessGroupInsert?rs=15";
			}
		}else {	
			return "/common/pleaseLogin";
		}			
	}
	
	//회원가입 
	@RequestMapping(value = "/successJoin", method = RequestMethod.GET)
	public String successJoin(Locale locale, Model model) {
		logger.info("success JOIN The client locale is {}.", locale);
		return "common/joinSuccess";
	}
	
	@PostMapping("/joinService")
	public String handleJoin(Member member)  throws Exception {		
		MemberService memberService = new MemberService();
		int result = memberService.saveMember(member);
		if(result == 1) {
			System.out.println("SQL Insert 완료");
			return "redirect:/successJoin?rs=1";
		}else {
			System.out.println("SQL Insert 실패");
			return "redirect:/successJoin?rs=2";
		}
	}
	
	//로그인 
	@RequestMapping(value = "/successLogin", method = RequestMethod.GET)
	public String successLogin(Locale locale, Model model) {
		logger.info("successLogin The client locale is {}.", locale);
		return "common/loginSuccess";
	}
	
	//로그인
	@PostMapping("/loginService")
	public String handleLogin( HttpServletRequest request,  @RequestParam String id, @RequestParam String pw )  throws Exception {		
		MemberService memberService = new MemberService();
		List<Map<String, Object>> userInfo = memberService.getMemberByUserId(id);
		
		if( userInfo.isEmpty() ) {
			System.out.println("존재하지 않는 회원");
			return "redirect:/successLogin?rs=2";
		}else {
			System.out.println(userInfo.get(0).get("password"));			
			String userPw = (String) userInfo.get(0).get("password");
			SHA256 sha256 = new SHA256();
			String cryptogram = sha256.encrypt(pw);
			if( userPw.equals(cryptogram) ) {
		        request.getSession().invalidate();
				HttpSession session = request.getSession();
				session.setAttribute("memberIDX", (String)userInfo.get(0).get("memberIDX") );
				session.setAttribute("nickname",  (String)userInfo.get(0).get("nickname"));
				session.setMaxInactiveInterval(1800);
				System.out.println("로그인 성공" +userInfo.get(0).get("memberIDX"));
				return "redirect:/successLogin?rs=1";
			}else {
				System.out.println("로그인 실패");
				return "redirect:/successLogin?rs=2";
			}
		}		
	}

	//로그아웃
	@RequestMapping(value = "/logoutSuccess", method = RequestMethod.GET)
	public String logoutSuccess(Locale locale, Model model) {
		logger.info("successLogin The client locale is {}.", locale);
		return "common/logoutSuccess";
	}

	//로그아웃
	@RequestMapping(value = "/logoutService", method = RequestMethod.GET)
	public String logoutService(HttpServletRequest request, Locale locale, Model model) {
		logger.info("logoutService The client locale is {}.", locale);
		
		if( (request.getSession(false)) == null) {
			return "redirect:/logoutSuccess?rs=2";
		}else {
			request.getSession().invalidate();	
			return "redirect:/logoutSuccess?rs=1";
		}
	}
	
	
	//멤버 모임에 가입 신청	
	@PostMapping("/insertGroupInMember")
	@ResponseBody
	public String insertGroupInMember(@RequestParam("groupIDX") int groupIDX, @RequestParam("memberIDX") int memberIDX, 
			RedirectAttributes attributes)  throws Exception {		
		MemberService memberService = new MemberService();
		attributes.addAttribute("idx",groupIDX);
		String rs = memberService.JoinMemberInGroup(memberIDX, groupIDX);
		if("ed".equals(rs)) {
			System.out.println("Controller rs : "+rs);
			return "1";
		}else if( "yes".equals(rs)) {
			System.out.println("Controller rs :"+rs);
			return "2";
		}else {
			System.out.println("Controller rs : "+rs);
			return "3";
		}
	}
	
	//멤버 가입 승낙 addMemberInGroup
	@PostMapping("/addMemberInGroup")
	@ResponseBody
	public String addMemberInGroup( RedirectAttributes attributes, @RequestParam("fk_groupIDX")  int groupIDX,
			@RequestParam("fk_memberIDX") int memberIDX )  throws Exception {		
		MemberService memberService = new MemberService();
		//attributes.addAttribute("idx",groupIDX);
		int rs = memberService.MasterApplyMember(memberIDX, groupIDX);
		if(rs > 0){
			return "1";
		}else {
			return "-1";
		}
	}
}
