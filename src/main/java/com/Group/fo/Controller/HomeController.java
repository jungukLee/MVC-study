package com.Group.fo.Controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Group.fo.Service.GroupService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		GroupService groupService = new GroupService();
		List<Map<String, Object>> groupList = groupService.printAllGroup(0,12);
		model.addAttribute("groupList",groupList);
		return "main"; 
	}
	
   @RequestMapping(value = "/testDB", method = RequestMethod.GET)
	public String testDb(Locale locale, Model model) {
		logger.info("TestDB! The client locale is {}.", locale);
		//model.addAttribute("userName","김이박");
		return "testDB";
	}
	
   @RequestMapping(value = "/pleaseLogin", method = RequestMethod.GET)
	public String pleaseLogin(Locale locale, Model model) {
		logger.info("TestDB! The client locale is {}.", locale);
		//model.addAttribute("userName","김이박");
		return "common/pleaseLogin";
	}
	
}

/*
 input name값으로 입력한 데이터를 @RequestParam으로 받을 수 있음
 name = "m_id" 그 때 name값과 똑같게 @RequestParam String m_id 
 String 말고 Integer로 받을 경우 알아서 형변환 해줌
 
 근데 입력값이 너무 받을 경우 VO 객체를 활요함
 MemberVo 클래스를 만든 다음에   

  */
