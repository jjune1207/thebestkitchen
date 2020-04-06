package thebestkitchen.mypage;

import java.sql.Date;

public class ProductInquiry {
	//상품 번호
	private int p_no;
	
	//상품 이름
	private String p_name;
	
	//문의글 번호
	private int b_no;
	
	//문의 내용
	private String b_title;
	
	//등록일
	private Date b_date;	
	
	//게시판 타임
	private String b_type;
	
	//회원 아이디
	private String m_id;

	public ProductInquiry() {
		super();
	}

	public ProductInquiry(String p_name, String b_title, Date b_date, int p_no) {
		super();
		this.p_name = p_name;
		this.b_title = b_title;
		this.b_date = b_date;
		this.p_no = p_no;
	}

	public ProductInquiry(int p_no, String p_name, int b_no, String b_title, Date b_date) {
		super();
		this.p_no = p_no;
		this.p_name = p_name;
		this.b_no = b_no;
		this.b_title = b_title;
		this.b_date = b_date;
	}	

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public Date getB_date() {
		return b_date;
	}

	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	
	public String getB_type() {
		return b_type;
	}

	public void setB_type(String b_type) {
		this.b_type = b_type;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
}
