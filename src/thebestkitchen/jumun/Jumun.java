package thebestkitchen.jumun;

import java.sql.Date;

//주문 dto
public class Jumun {
	
	/*
	 * Oracle SQL Table
	 *     j_no         number(20)        NOT NULL,
	 *     p_no         number(20)        NOT NULL,
	 *     m_id         VARCHAR2(100)     NOT NULL,
	 *     j_desc       VARCHAR2(4000)    NOT NULL,
	 *     j_date       DATE              NOT NULL,
	 *     j_qty        number(20)        NOT NULL,
	 *     j_price      number(20)        NOT NULL,
	 *     j_dprice     number(20)        NOT NULL,
	 *     j_address    varchar2(4000)     NOT NULL,
	 *     j_phone      varchar2(100)     NOT NULL,
	 *     CONSTRAint JUMUN_PK PRIMARY KEY (j_no)	  
	 */
	
	// 주문 번호
	private int j_no;
	
	// 상품 번호
	private int p_no;
	
	// 회원 아이디
	private String m_id;
	
	// 주문 설명 
	private String j_desc;
	
	// 주문 날짜 
	private Date j_date;
	
	// 주문 수량 
	private int j_qty;
	
	// 주문 가격 
	private int j_price;
	
	// 배송비 
	private int j_dprice;
	
	// 배송지 
	private String j_address;
	
	// 배송 연락처 
	private String j_phone;
		
	
	// Jumun 모델 복사
	public void CopyData(Jumun param) 
	{
		this.j_no = param.getJ_no();
	    this.p_no = param.getP_no();
	    this.m_id = param.getM_id();
	    this.j_desc = param.getJ_desc();
	    this.j_date = param.getJ_date();
	    this.j_qty = param.getJ_qty();
	    this.j_price = param.getJ_price();
	    this.j_dprice = param.getJ_dprice();
	    this.j_address = param.getJ_address();
	    this.j_phone = param.getJ_phone();
	}
	
	
	// Constructor
	public Jumun() {
		// TODO Auto-generated constructor stub
	}
	
	
	public Jumun(int p_no, String m_id, String j_desc, Date j_date, int j_qty, int j_price, int j_dprice, String j_address,
			String j_phone) {
		super();
		this.p_no = p_no;
		this.m_id = m_id;
		this.j_desc = j_desc;
		this.j_date = j_date;
		this.j_qty = j_qty;
		this.j_price = j_price;
		this.j_dprice = j_dprice;
		this.j_address = j_address;
		this.j_phone = j_phone;
	}


	public Jumun(int j_no, int p_no, String m_id, String j_desc, Date j_date, int j_qty, int j_price, int j_dprice,
			String j_address, String j_phone) {
		super();
		this.j_no = j_no;
		this.p_no = p_no;
		this.m_id = m_id;
		this.j_desc = j_desc;
		this.j_date = j_date;
		this.j_qty = j_qty;
		this.j_price = j_price;
		this.j_dprice = j_dprice;
		this.j_address = j_address;
		this.j_phone = j_phone;
	}

	
	// Getters and Setters
	public int getJ_no() {
		return j_no;
	}

	public void setJ_no(int j_no) {
		this.j_no = j_no;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getJ_desc() {
		return j_desc;
	}

	public void setJ_desc(String j_desc) {
		this.j_desc = j_desc;
	}

	public Date getJ_date() {
		return j_date;
	}

	public void setJ_date(Date j_date) {
		this.j_date = j_date;
	}

	public int getJ_qty() {
		return j_qty;
	}

	public void setJ_qty(int j_qty) {
		this.j_qty = j_qty;
	}

	public int getJ_price() {
		return j_price;
	}

	public void setJ_price(int j_price) {
		this.j_price = j_price;
	}

	public int getJ_dprice() {
		return j_dprice;
	}

	public void setJ_dprice(int j_dprice) {
		this.j_dprice = j_dprice;
	}

	public String getJ_address() {
		return j_address;
	}

	public void setJ_address(String j_address) {
		this.j_address = j_address;
	}

	public String getJ_phone() {
		return j_phone;
	}

	public void setJ_phone(String j_phone) {
		this.j_phone = j_phone;
	}


	@Override
	public String toString() {
		return "Jumun [j_no=" + j_no + ", p_no=" + p_no + ", m_id=" + m_id + ", j_desc=" + j_desc + ", j_date=" + j_date
				+ ", j_qty=" + j_qty + ", j_price=" + j_price + ", j_dprice=" + j_dprice + ", j_address=" + j_address
				+ ", j_phone=" + j_phone + "]\n";
	}
	

}