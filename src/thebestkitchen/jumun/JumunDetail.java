package thebestkitchen.jumun;

public class JumunDetail {

	/*
	 * Oracle SQL Table
	 * 이름              널?       유형
	 * --------------- -------- ----------
	 * ORDERDETAILSNUM NOT NULL NUMBER(20)
	 * J_NO            NOT NULL NUMBER(20)
	 * P_NO            NOT NULL NUMBER(20)
	 * C_QTY	       NOT NULL NUMBER(20)
	 * 주문상세번호_pk_seq
	 * 주문번호_fk
	 * 제품번호_fk
	 * 제품 총 주문수
	 */
	
	private int orderDetailsNum;
	private int j_no;
	private int p_no;
	private int c_qty;
	
	public JumunDetail() {
		// TODO Auto-generated constructor stub
	}

	public JumunDetail(int orderDetailsNum, int j_no, int p_no, int c_qty) {
		super();
		this.orderDetailsNum = orderDetailsNum;
		this.j_no = j_no;
		this.p_no = p_no;
		this.c_qty = c_qty;
	}

	public int getOrderDetailsNum() {
		return orderDetailsNum;
	}

	public void setOrderDetailsNum(int orderDetailsNum) {
		this.orderDetailsNum = orderDetailsNum;
	}

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

	public int getC_qty() {
		return c_qty;
	}

	public void setC_qty(int c_qty) {
		this.c_qty = c_qty;
	}

	@Override
	public String toString() {
		return "JumunDetail [orderDetailsNum=" + orderDetailsNum + ", j_no=" + j_no + ", p_no=" + p_no + ", c_qty="
				+ c_qty + "]";
	}
		
	
}
