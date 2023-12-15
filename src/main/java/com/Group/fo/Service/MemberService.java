package com.Group.fo.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


import com.Group.fo.vo.Dao.MemberDao;
import com.Group.fo.vo.model.Group;
import com.Group.fo.vo.model.Member;


public class MemberService {
	MemberDao memberDao = new MemberDao();
	
	public int saveMember(Member member) throws Exception {
		int re = 0;
		if (adminUserIsExist(member.getUserId()))
			return -2;
		return  memberDao.insertMember(member);
	}
	
	public List<Map<String, Object>> getMemberByUserId(String id) throws Exception {
		return  memberDao.selectMemberByUserId(id);
	}
	
	// 마이페이지
	public List<Map<String, Object>> myPageGetMember(int memberIDX) throws Exception {
		return  memberDao.selectMemberByUserIDX(memberIDX);
	}
	
	//회원탈퇴 deleteMember
	public int DeleteMemberAtAll(int memberIDX) throws Exception {
		return memberDao.deleteMember(memberIDX);
	}
	
	//마이페이지 수정 UpdateMemberInfo
	public int UpdateMemberInfo(Member member) throws Exception {
		return  memberDao.UpdateMemberInfo(member);
	}
	
	
	public boolean adminUserIsExist(String userId) throws Exception {
		boolean re = false;

		List<Map<String, Object>> list = memberDao.selectMemberByUserId(userId);
		if (list.size() > 0) {
			re = true;
		}
		return re;
	}
	
	
	//멤버 모임에 가입신청 insertGroupInMember
	public String JoinMemberInGroup(int memberIDX, int groupIDX) throws Exception {
		MemberDao memberDao = new MemberDao();
		int count = memberDao.ifGroupInMeber(memberIDX, groupIDX);
		if( count >= 1) {
			System.out.println("Service JoinMemberInGroup  count : "+count);
			return "ed";
		}else if(count == 0 ){
			int rs =  memberDao.insertGroupMember(memberIDX, groupIDX,"Waiting");
			System.out.println("Service JoinMemberInGroup  count : "+count);
			if(rs > 0 ) {
				System.out.println("Service insertGroupMember  rs : "+rs);
				return "yes";	
			}else {
				System.out.println("Service insertGroupMember  rs : "+rs);
				return "error";
			}	
		}else {
			return "count select error";
		}
	}
	
	//그룹 만들 때 mater로 본인도 넣어야함 insertGroupMember insertGroupMember(int memberIDX,int groupIDX,String status)
	public int insertMaster(int memberIDX, int groupIDX, String status ) throws Exception {
		int re = memberDao.insertGroupMember(memberIDX, groupIDX, status);
		if ( re < 0 )
			return -2;
		else {
			return re;
		}
	}
	
	// 그룹 주인이 가입 승낙시 status "good"으로 변경 UpdateStatusMember
	public int MasterApplyMember(int memberIDX, int groupIDX) throws Exception {
		return memberDao.UpdateStatusMember(memberIDX, groupIDX); 
	}
	
	//아이디 찾기
	public String FindUserId(Member membmer) throws Exception {
		return memberDao.SelectMemberId(membmer);
	}
		
		
	//비밀번호 찾기
	public int FindUserPw(Member membmer) throws Exception {
		return memberDao.SelectMemberPw(membmer);
	}
	
	
	
	//비밀번호 찾기 SelectMemberPw
	public int EditUserPw(Member membmer) throws Exception {
		return memberDao.UpdateMemberPw(membmer);
	}
}
