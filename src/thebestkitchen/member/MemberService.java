package thebestkitchen.member;

import java.util.ArrayList;

import thebestkitchen.exception.ExistedMemberException;
import thebestkitchen.exception.PasswordMismatchException;
import thebestkitchen.exception.MemberNotFoundException;
import thebestkitchen.exception.MemberRetireException;


public class MemberService {
	
	private MemberDao memberDao;
	private static MemberService _instance;
	
	public MemberService() throws Exception{
		memberDao=new MemberDao();
		System.out.println("MemberService()생성자:"+this);
	}
	public static MemberService getInstance() throws Exception {
		if(MemberService._instance == null) {
			MemberService._instance = new MemberService();
		}
		return MemberService._instance;
	}
	
	/*
	 * 회원가입
	 */
	public void create(Member member) throws Exception, ExistedMemberException{
		//1. 아이디중복체크, 회원탈퇴여부체크
		if(memberDao.existedMember(member.getM_id()) && memberDao.retireCheck(member.getM_id())) {
			throw new ExistedMemberException(member.getM_id()+"는 이미 존재하는 아이디입니다.");
		}
		memberDao.createMember(member);
		memberDao.createMemberDetail(member);
	}
	/*
	 * 로그인
	 */
	public Member login(String memberId,String memberPw) throws Exception,MemberNotFoundException,PasswordMismatchException{
		//memberDao.setDefineOff();
		//1.아이디존재여부
		Member member = memberDao.selectById(memberId);
		if(member==null) {
			throw new MemberNotFoundException(memberId+"는 존재하지 않는 아이디입니다.");
		}
		//2.비밀번호일치여부
		if(!member.isMatchPassword(memberPw)) {
			throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
		}
		//3.회원탈퇴여부
		if(member.getM_retire().equals("T")) {
			throw new  MemberRetireException("탈퇴한 회원입니다.");
		}

		return member;
		
	}
	/*
	 * 회원 1명 보기
	 */
	public Member findMember(String memberId) throws Exception, MemberNotFoundException{
		Member member = memberDao.selectById(memberId);
		if(member==null) {
			throw new MemberNotFoundException(memberId+"는 존재하지 않는 아이디입니다.");
		}
		return member;
	}
//	/*
//	 * 회원 리스트
//	 */
//	public ArrayList<Member> findMemberList() throws Exception{
//		return memberDao.findMemberList();
//	}

	/*
	 * 아이디중복체크
	 */
	public boolean isDuplcateMemberId(String memberId) throws Exception{
		boolean isExist = memberDao.existedMember(memberId);
		if(isExist) {
			return true;
		}else {
			return false;
		}
	}	
	
	/*
	 * 아이디 찾기
	 */

	public String findMemberId(String memberName, String memberPhone) throws Exception, MemberNotFoundException{
		Member member = memberDao.findId(memberName,memberPhone);
		if(member==null) {
			throw new MemberNotFoundException("존재하지 않는 정보입니다.");
		}
		return member.getM_id();
	}
	
	/*
	 * 비밀번호 찾기
	 */
	
	public String findMemberPw(String memberId, String memberName) throws Exception, MemberNotFoundException{
		Member member = memberDao.findPw(memberId,memberName);
		if(member==null) {
			throw new MemberNotFoundException("존재하지 않는 정보입니다.");
		}
		memberDao.createTempPw(member);
		member = memberDao.findPw(member.getM_id(), member.getM_name());
		return member.getM_pw();
//		return member;
	}
	
	/*
	 * 관리자여부확인
	 */
	public boolean adminCheck(String memberId) throws Exception{
		Member isAdmin = memberDao.adminCheck(memberId);
		if(isAdmin!=null) {
			return true;
		}else {
			return false;
		}
	}
	/*
	 * 탈퇴여부확인
	 */
	public boolean retireCheck(String memberId) throws Exception{
		boolean isRetire = memberDao.retireCheck(memberId);
		if(isRetire) {
			return true;
		}else {
			return false;
		}
	}
	/*
	 * 회원탈퇴
	 */
	public void retire(String memberId) throws Exception {
		memberDao.retire(memberId);
	}
	
	/*
	 * 회원수정
	 */
	public void update(Member member) throws Exception {
		memberDao.update(member);
		memberDao.update_detail(member);
	}
	/*
	 * 회원배송정보만 업데이트
	 */
	public void updateAddress(String md_address, String md_postcode,String md_daddress, String m_id) throws Exception {
		memberDao.updateAddress(md_address, md_postcode, md_daddress, m_id);
	}
	/*
	 * 회원배송정보
	 */
	public Member findDeliveryInfo(String memberId) throws Exception {
		return memberDao.findMemberDelivery(memberId);
		
	}
	
	/*
	 * 회원의 주문 건수 확인
	 */
	public int getjumuncount(String memberId) throws Exception {
		return memberDao.getjumuncount(memberId);
	}
	
	
	
}




