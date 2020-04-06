package thebestkitchen.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.UUID;

import javax.naming.InitialContext;
import javax.sql.DataSource;


/*
 Member 테이블에서 회원 추가,삭제,검색,수정등의 작업을 한다.
 */
public class MemberDao {
	private DataSource dataSource;
	
    public MemberDao(DataSource dataSource) throws Exception{
		this.dataSource = dataSource;
	}
   
	public MemberDao() throws Exception {
		InitialContext ic=new InitialContext();
		dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
	}
	
	/**
	 * @author 은정
	 * @param member
	 * @throws Exception
	 */
	/*
	 * member 테이블에 회원 추가
	 */
	public void createMember(Member member) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_CREATE);
			pstmt.setString(1, member.getM_id());
			pstmt.setString(2, member.getM_pw());
			pstmt.setString(3, member.getM_name());
			pstmt.setString(4, member.getM_phone());
			pstmt.executeUpdate();			
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	/**
	 * @author 은정
	 * @param member
	 * @throws Exception
	 */
	/*
	 * member_detail 테이블에 회원 추가
	 */
	public void createMemberDetail(Member member) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();			
			pstmt = con.prepareStatement(MemberSQL.MEMBER_DETAIL_CREATE);
			pstmt.setString(1, member.getM_id());
			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	
	/**
	 * @author 정연
	 * @param member
	 * @throws Exception
	 */
	
	/*
	 * 회원정보 수정
	 */
	public void update(Member member) throws Exception{
		Connection con = null;	
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_UPDATE);
			pstmt.setString(1, member.getM_pw());
	        pstmt.setString(2, member.getM_name());
	        pstmt.setString(3, member.getM_phone());
	        pstmt.setString(4, member.getM_id());			
			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}	
	
	public void update_detail(Member member) throws Exception{
		Connection con = null;	
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_DETAIL_UPDATE);
	        pstmt.setString(1, member.getMd_address());
	        pstmt.setString(2, member.getMd_birth());
	        pstmt.setString(3, member.getMd_postcode());
	        pstmt.setString(4, member.getMd_daddress());
	        pstmt.setString(5, member.getM_id());		
			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}	
	public void updateAddress(String md_address, String md_postcode,String md_daddress, String m_id) throws Exception{
		Connection con = null;	
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_JUMUN_ADDRESS);
			pstmt.setString(1, md_address);
	        pstmt.setString(2, md_postcode);
	        pstmt.setString(3, md_daddress);
	        pstmt.setString(4, m_id);			
			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}	
	
	/**
	 * @author 정연
	 * @param member
	 * @throws Exception
	 */
	/*
	 * 회원 탈퇴
	 */
	public void retire(String memberId) throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_RETIRE);
			pstmt.setString(1, memberId);
			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}				
	}
	/**
	 * @author 정연
	 * @param member
	 * @throws Exception
	 */
	/*
	 * 회원정보 가져오기
	 */
	public Member selectById(String memberId) throws Exception{
		Member tempmem = null;
		Connection con = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_GET);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tempmem = new Member(rs.getString("m_id"),rs.getString("m_pw"),
						rs.getString("m_name"),rs.getString("m_phone"),
						rs.getString("m_retire"),rs.getString("m_admin"),
						rs.getString("md_address"), rs.getString("md_birth"), 
						rs.getString("md_daddress"),rs.getString("md_postcode"));
			}
			
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		
		return tempmem;
	}
	/*
	 * 회원정보 가져오기
	 */
	public void setDefineOff() throws Exception{
		Connection con = null;		
		PreparedStatement pstmt = null;

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_SET_DEFINE_OFF);
			pstmt.execute();	
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	/**
	 * @author 은정
	 * @param member
	 * @throws Exception
	 */
	/*
	 * 아이디찾기
	 */
	public Member findId(String memberName, String memberPhone) throws Exception {
		Member member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_SEARCH_ID);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberPhone);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new Member(rs.getString("m_id"),rs.getString("m_pw"),
									rs.getString("m_name"),rs.getString("m_phone"));
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return member;
	}
	/**
	 * @author 은정
	 * @param member
	 * @throws Exception
	 */
	/*
	 * 비밀번호 찾기 (비밀번호 찾을 회원검사)
	 */
	public Member findPw(String memberId, String memberName) throws Exception {
		Member member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_SEARCH_PW);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberName);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new Member(rs.getString("m_id"), rs.getString("m_pw"),
									rs.getString("m_name"),rs.getString("m_phone"));
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return member;
	}
	/**
	 * @author 은정
	 * @param member
	 * @throws Exception
	 */
	/*
	 * 임시비밀번호 발급
	 */
	public void createTempPw(Member findMember) throws Exception {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		//임시 비밀번호 발급
		String tempPw = UUID.randomUUID().toString().replaceAll("-", ""); // - 를 제거
		tempPw = tempPw.substring(0, 10); //tempPw를 앞에서부터 10자리 잘라 줌        	
	
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_UPDATE_TEMPPW);
			pstmt.setString(1, tempPw);
			pstmt.setString(2, findMember.getM_id());
			pstmt.executeUpdate();

		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	
	/*
	 * 모든 회원정보를 데이터베이스에서 찾아서 
	 * List<Member> 컬렉션 에 저장하여 반환
	 */
	public ArrayList<Member> findMemberList() throws Exception {
		ArrayList<Member> memberList= new ArrayList<Member>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_FINDMEMBER_LIST);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				memberList.add(new Member(rs.getString("m_id"),rs.getString("m_pw"),
										  rs.getString("m_name"),rs.getString("m_phone"),
										  rs.getString("m_retire"),rs.getString("m_admin"),										  
										  rs.getString("md_address"),rs.getString("md_birth"),
										  rs.getString("md_daddress"),rs.getString("md_postcode")
								));
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return memberList;
	}
	/**
	 * @author 은정
	 * @param memberId
	 * @throws Exception
	 */
	/*
	 * 아이디 중복체크
	 */
	public boolean existedMember(String memberId)throws Exception{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		try{
			con=dataSource.getConnection();
			pstmt=con.prepareStatement(MemberSQL.MEMBER_EXISTEDMEMBER);
			pstmt.setString(1, memberId);
			rs=pstmt.executeQuery();
			int count=0;
			if(rs.next()){
				count=rs.getInt("cnt");
			}
			if(count==1){
				return true;
			}else{
				return false;
			}
		}finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(con!=null)
				con.close();
		}
		
	}
	/*
	 * 회원배송정보
	 */
	public Member findMemberDelivery(String memberId) throws Exception {
		Member member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_FINDMEMBER_DELIVERY);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new Member(rs.getString("m_id"),
									null, rs.getString("m_name"),
									rs.getString("m_phone"),rs.getString("md_address"),
									rs.getString("md_daddress"),rs.getString("md_postcode"));
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return member;
	}
	/*
	 * 회원탈퇴여부
	 */
	public boolean retireCheck(String memberId)throws Exception{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		try{
			con=dataSource.getConnection();
			pstmt=con.prepareStatement(MemberSQL.MEMBER_RETIRE_CHECK);
			pstmt.setString(1, memberId);
			rs=pstmt.executeQuery();
			int count=0;
			if(rs.next()){
				count=rs.getInt("cnt");
			}
			if(count==1){
				return true;
			}else{
				return false;
			}
		}finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(con!=null)
				con.close();
		}
		
	}
	/**
	 * @author 정연
	 * @param member
	 * @throws Exception
	 */
	//사용자의 총 주문 건수
	public int getjumuncount(String memberId) throws Exception{
		int count = 0;
		Connection con = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_TOT_JUMUN);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			
			return count;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}			
	}
	/*
	 * 관리자여부확인
	 */
	public Member adminCheck(String memberId) throws Exception{
		Member member = null;
		Connection con = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(MemberSQL.MEMBER_ADMIN);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new Member(rs.getString("m_id"),rs.getString("m_pw"),
						  rs.getString("m_name"),rs.getString("m_phone"),
						  rs.getString("m_retire"),rs.getString("m_admin"),										  
						  null,null,
						  null,null);
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		
		return member;
	}
	
}
