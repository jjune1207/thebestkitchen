package thebestkitchen.mypage;

public class JumunList {
	//주문 번호
	private long j_no;
	
	//상품 이름
	private String p_name;
	
	//상품 수량
	private int j_qty;
	
	//상품 가격
	private int j_price;
	
	//상품 번호
	private int p_no;
	
	//결제 여부
	private String j_payment;
	
	public JumunList() {
		super();
	}

	public JumunList(long j_no, String p_name, int j_qty, int j_price, int p_no, String j_payment) {
		super();
		this.j_no = j_no;
		this.p_name = p_name;
		this.j_qty = j_qty;
		this.j_price = j_price;
		this.p_no = p_no;
		this.j_payment = j_payment;
	}

	public String getJ_payment() {
		return j_payment;
	}

	public void setJ_payment(String j_payment) {
		this.j_payment = j_payment;
	}

	public long getJ_no() {
		return j_no;
	}

	public void setJ_no(long l) {
		this.j_no = l;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
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
	
	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	
	
}
