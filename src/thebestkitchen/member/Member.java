package thebestkitchen.member;

/*
 *  사용자관리를 위하여 필요한 도메인클래스(VO,DTO)
 *  Member 테이블의 각컬럼에해당하는 멤버를 가지고있다
 */

public class Member {
	/*
	 * 이름       널?       유형           
	 * -------- -------- ------------  
	 * M_ID     NOT NULL VARCHAR2(60) 
	 * M_PW              VARCHAR2(60) 
	 * M_NAME            VARCHAR2(60) 
	 * M_PHONE           VARCHAR2(60) 
	 * M_RETIRE          CHAR(1)      
	 * M_ADMIN           CHAR(1)      
	 */
	/*
	 * 이름         널?       유형            
	 * ---------- -------- ------------- 
	 *	M_ID       NOT NULL VARCHAR2(100) 
	 *	MD_ADDRESS          VARCHAR2(255) 
	 *	MD_BIRTH            VARCHAR2(255)
	 */
	private String m_id;
	private String m_pw;
	private String m_name;
	private String m_phone;
	private String m_retire;
	private String m_admin;
	private String md_address;
	private String md_daddress;
	private String md_postcode;
	private String md_birth;
	
	//기본생성자
	public Member() {
		
	}
	//필수정보만 필요
	public Member(String m_id, String m_pw, String m_name, String m_phone) {
		super();
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_phone = m_phone;
	}
	//배송지 필요
	public Member(String m_id, String m_pw, String m_name, String m_phone, String md_address, String md_daddress, String md_postcode) {
		super();
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_phone = m_phone;
		this.md_address = md_address;
		this.md_daddress = md_daddress;
		this.md_postcode = md_postcode;
	}
	//모든 정보 필요
	public Member(String m_id, String m_pw, String m_name, String m_phone, String m_retire,String m_admin,
			String md_address, String md_birth, String md_daddress, String md_postcode) {
		super();
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_phone = m_phone;
		this.m_retire = m_retire;
		this.m_admin = m_admin;
		this.md_address = md_address;
		this.md_daddress = md_daddress;
		this.md_postcode = md_postcode;
		this.md_birth = md_birth;
	}
	
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}


	public String getM_pw() {
		return m_pw;
	}


	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}


	public String getM_name() {
		return m_name;
	}


	public void setM_name(String m_name) {
		this.m_name = m_name;
	}


	public String getM_phone() {
		return m_phone;
	}


	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}


	public String getM_retire() {
		return m_retire;
	}


	public void setM_retire(String m_retire) {
		this.m_retire = m_retire;
	}


	public String getM_admin() {
		return m_admin;
	}


	public void setM_admin(String m_admin) {
		this.m_admin = m_admin;
	}

	public String getMd_address() {
		return md_address;
	}

	public void setMd_address(String md_address) {
		this.md_address = md_address;
	}

	public String getMd_birth() {
		return md_birth;
	}

	public void setMd_birth(String md_birth) {
		this.md_birth = md_birth;
	}
	
	public String getMd_daddress() {
		return md_daddress;
	}
	
	public void setMd_daddress(String md_daddress) {
		this.md_daddress = md_daddress;
	}
	
	public String getMd_postcode() {
		return md_postcode;
	}
	
	public void setMd_postcode(String md_postcode) {
		this.md_postcode = md_postcode;
	}
	
	public String getM_id() {
		return m_id;
	}

	/*
	 * 아이디 저장 체크
	 */
//	public boolean isSaveId() {
//		boolean isSaveId=false;
//		if() {
//			isSaveId=true;
//		}
//		return isSaveId;
//	}
//	
	/*
	 *패쓰워드 일치여부 검사 
	 */
	public boolean isMatchPassword(String pw){
		boolean isMatch=false;
		if(this.m_pw.equals(pw)){
			isMatch=true;
		}
		return isMatch;
	}
}
	