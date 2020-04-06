package thebestkitchen.member;

public class MemberSQL {
	//마이 페이지에 유저 정보 표시
	public static final String MEMBER_SHOW = 
			"select m_id, m_name"
			+ "from member";
	
	//사용자의 총 주문 건수
	public static final String MEMBER_TOT_JUMUN = 
			"select count(*) "
			+ "from jumun "
			+ "where m_id = ?";
	/*
	//회원의 주문 내역
	public static final String MEMBER_DETAIL_JUMUN = 
			"select p.p_name, b.b_title, b.b_date"
			+ "from product p"
			+ "inner join board b"
			+ "on";
	*/
	public static final String MEMBER_SET_DEFINE_OFF = 
			"set define off";
	//회원정보 변경을 하기 위해 회원정보를 가져오기
	public static final String MEMBER_GET = 
			"select m.m_id, m.m_pw, m.m_name, m.m_phone, m.m_retire, m.m_admin, md.md_address, md.md_birth, md.md_daddress,md.md_postcode "
			+ "from member m "
			+ "inner join member_detail md "
			+ "on m.m_id = md.m_id "
			+ "where m.m_id = ?";
	
	//회원정보 변경 버튼을 눌렀을 경우 업데이트
	public static final String MEMBER_UPDATE = 
			"update member "
			+ "set m_pw = ?, m_name = ?, m_phone = ? "
			+ "where m_id = ?";
	
	public static final String MEMBER_DETAIL_UPDATE = 
			"update member_detail "
			+ "set md_address = ?, md_birth = ?, md_postcode = ?, md_daddress = ? "
			+ "where m_id = ?";
	
	public static final String MEMBER_JUMUN_ADDRESS = 
			"update member_detail "
			+ "set md_address = ?, md_postcode = ?, md_daddress = ? "
			+ "where m_id = ?";
		
	//회원탈퇴를 위해 필요한 회원정보
	public static final String MEMBER_GET_RETIRE = 
			"select m_retire "
			+ "from member "
			+ "where m_id = ?";
	
	//회원탈퇴를 눌렀을 경우
	public static final String MEMBER_RETIRE = 
			"update member "
			+ "set m_retire = 'T'"
			+ "where m_id = ?";
	
	/*
	 *상품문의 내역	
	 */
	
	/*
	 * 회원가입(회원추가)
	 */
	public static final String MEMBER_CREATE =
			 "insert into member values(?,?,?,?,default,default)";
	public static final String MEMBER_DETAIL_CREATE =
			 "insert into member_detail values(?,default,default,null,null)";
	/*
	 * 아이디 찾기
	 */
	public static final String MEMBER_SEARCH_ID = 
			"SELECT m.m_id, m.m_pw, m.m_name, m.m_phone,m.m_retire, m.m_admin, md.md_address, md.md_birth"
			+" FROM MEMBER m"
			+" JOIN MEMBER_DETAIL md"
			+" ON m.m_id=md.m_id"
			+" WHERE m.m_name=? AND m.m_phone=?";
	/*
	 * 비밀번호 찾기
	 */
	public static final String MEMBER_SEARCH_PW =
			"SELECT * "
			+ " FROM MEMBER "
			+ "	WHERE m_id = ? AND m_name = ? ";
	/*
	 * 임시 비밀번호 발급
	 */
	public static final String MEMBER_UPDATE_TEMPPW = 
			"UPDATE member"
			+ " SET m_pw = ? WHERE m_id=?";
	/*
//	 * 회원리스트 출력
	 */
	public static final String MEMBER_FINDMEMBER_LIST =
			"SELECT m.m_id, m.m_pw, m.m_name, m.m_phone,m.m_retire, m.m_admin, md.md_address, md.md_birth,md.md_daddress,md.md_postcode "
			+ " FROM MEMBER m"
			+ " JOIN MEMBER_DETAIL md"
			+ " ON m.m_id=md.m_id";
	/*
	 * 아이디 중복확인
	 */
	public static final String MEMBER_EXISTEDMEMBER =
			"SELECT count(*) cnt FROM MEMBER" 
			+ " WHERE m_id=?";
	/*
	 * 배송정보 찾기
	 */
	public static final String MEMBER_FINDMEMBER_DELIVERY =
			"SELECT m.m_id, m.m_name, m.m_phone, md.md_address"
			+ " FROM MEMBER m"
			+ " JOIN MEMBER_DETAIL md"
			+ " ON m.m_id=md.m_id"
			+ " WHERE m.m_id=?";

	/*
	 * 탈퇴여부
	 */
	public static final String MEMBER_RETIRE_CHECK =
			"SELECT count(*) cnt FROM MEMBER" 
			+ " WHERE m_id=? AND m_retire='T'";
	/*
	 * 관리자여부
	 */
	public static final String MEMBER_ADMIN =
			"SELECT * "
			+ "FROM MEMBER "
			+ "WHERE m_admin='T' AND m_id = ?";
	
	

}
