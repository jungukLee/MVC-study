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

import com.Group.fo.Service.GroupService;
import com.Group.fo.vo.model.Group;
///insertBoard

@Controller
public class SearchController {
		private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
		//[검색] head input으로 검색했을 때
		@RequestMapping(value = "/searchedPageHandle", method = RequestMethod.GET)
		public String searchedPage(@RequestParam("searchValue") String searchValue, Locale locale, Model model) throws Exception {
			logger.info("searchedHandlerPage! The client locale is {}.", locale);
			GroupService groupService = new GroupService();
			List<Map<String, Object>> groupList = groupService.searchedTitleIntroduce(searchValue);
			model.addAttribute("groupList",groupList);
			model.addAttribute("userSearchValue",searchValue);
			return "searchedPage";
		}
		
		
		//[검색]그냥 모임찾기 이동했을 때
		@RequestMapping(value = "/searchedPage", method = RequestMethod.GET)
		public String searchedPage(Locale locale, Model model) {
			logger.info("searchedPage Page! The client locale is {}.", locale);
			return "searchedPage";
		}
		
		//[검색] [상세 검색 눌렀을 때] searchDetail
		@RequestMapping(value = "/searchDetail", method = RequestMethod.GET)
		public String searchDetail(@RequestParam("country") String country, @RequestParam("category") String category,
								   @RequestParam("generation") String generation, @RequestParam("introduce") String introduce,
			Locale locale, Model model) throws Exception {
			logger.info("searchDetail Page! The client locale is {}.", locale);
			GroupService groupService = new GroupService();
			List<Map<String,Object>> groupList = groupService.searchedDetailALL(introduce, country, category, generation);
			model.addAttribute("groupList",groupList);
			return "searchedPage";
		}
}
