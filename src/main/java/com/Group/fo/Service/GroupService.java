package com.Group.fo.Service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Map;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.Group.fo.vo.Dao.GroupDao;
import com.Group.fo.vo.Dao.MemberDao;
import com.Group.fo.vo.model.Group;

public class GroupService {
	GroupDao groupDao = new GroupDao();
	MemberDao memberDao = new MemberDao();
//	private final String uploadDir = "C:/Users/user/Desktop/serverImg";
	private final String uploadDir = "C:/Users/216/Desktop/serverImg";
	//모임 저장
	public int saveGroup(Group group) throws Exception {
		return  groupDao.insertGroup(group);
	}
	
	//이미지 저장 및 경로 리턴
	public String storeFile(MultipartFile file) throws Exception {
		if (file == null || file.isEmpty()) {
		   System.out.println("null입니다.");
			return null;     
		}else {
			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			String returnName = fileName;
		    //Path filePath = Path.of(uploadDir, fileName);
	        Path filePath = Paths.get(uploadDir, fileName); // Paths.get() 메서드를 사용하여 경로 생성
			System.out.println("Service filePath : " + filePath);
		    if (!Files.exists(filePath)) {
		        Files.createDirectories(filePath.getParent());
		    }

		    Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
		    System.out.println("Service fileName : " + fileName);
		    return returnName;
		}
	    
	}
    
	//모임 업데이트
	public int updateGroup(Group group) throws Exception {
		return  groupDao.updateGroupByGroup(group);
	}
	
	//모임 삭제
	public int deleteGroupAtAll(int groupIDX) throws Exception{
		return groupDao.deleteGroup(groupIDX);
	}
	
	//main page 리스트 n~m개 까지 출력
	public List<Map<String, Object>> printAllGroup(int offset, int limit) throws Exception {
		return groupDao.selectAllGroup(offset, limit );
	}
	
	// 선택한 Group id값에 대한 정보 긁업모아옴
	public List<Map<String, Object>> getGroupByGroupId(int id) throws Exception {
		return  groupDao.selectGroupByGroupId(id);
	}
	
	// 관심 모임 출력
	public List<Map<String, Object>> printMyInterest(int memberIDX) throws Exception {
		return groupDao.selectInterestGroup(memberIDX);
	}

	//모임 관심 추가
	public int saveInterest(int memberIDX, int groupIDX) throws Exception {
		int increase = groupDao.increaseInterest(groupIDX);
		if(  increase > 0 ) {
			return  groupDao.addInterest(memberIDX, groupIDX);
		}else {
			System.out.println("saveInterest의 increase가 0보다 적습니다.");
			return -2;
		}
		
	}
	
	//모임 관심 삭제
	public int delInterestByIDXs(int memberIDX, int groupIDX) throws Exception {
		int decrease = groupDao.decreaseInterest(groupIDX);
		if( decrease > 0 ) {
			return  groupDao.delInterest(memberIDX, groupIDX);
		}else {
			System.out.println("delInterestByIDXs의 decreaseInterest가 0보다 적습니다.");
			return -2;
		}
	}
	
	//모임 관심인지 아닌지 체크
	public boolean getCheckedInterest(int memberIDX, int groupIDX) throws Exception{
		int count = groupDao.checkInterest(memberIDX,groupIDX);
		if(count > 0) {
			System.out.println("service // 관심모임이 맞음");
			return true;
		}else {
			return false;
		}
	}
	
	// title, introduce로 group 검색
	public List<Map<String, Object>> searchedTitleIntroduce(String searchValue) throws Exception {
		return groupDao.selectSearchedTitleIntroduce(searchValue);
	}
	
	// 상세 검색group 검색 String 
	public List<Map<String, Object>> searchedDetailALL(String titleAndIntroduce, String country, String category, String generation) throws Exception {
		return groupDao.selectSearchedDetail(titleAndIntroduce,country,category,generation);
	}
	
	//내가 가입한 그룹 출력 
	public List<Map<String, Object>> signedGroup(int memberIDX) throws Exception {
		return groupDao.selectGroupByMemberIDX(memberIDX);
	}	
}
