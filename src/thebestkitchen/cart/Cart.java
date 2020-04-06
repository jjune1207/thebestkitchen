package thebestkitchen.cart;

public class Cart {
	private String m_id;
	private String p_name;
	private String p_desc;
	private int p_no;
	private int c_no;
	private int c_qty;
	private int c_totprice;
	private int p_price;
	public int getP_price() {
		return p_price;
	}
	public Cart(int c_no, int p_no, String m_id, int c_qty, int c_totprice, int p_price, String p_name, String p_desc) {
		super();
		this.c_no = c_no;
		this.p_no = p_no;
		this.m_id = m_id;
		this.c_qty = c_qty;
		this.c_totprice = c_totprice;
		this.p_price = p_price;
		this.p_name = p_name;
		this.p_desc = p_desc;
	}
	public Cart(String p_name, String m_id, String p_desc, int c_qty, int p_price, int c_totprice, int p_no) {
		this.p_no = p_no;
		this.m_id = m_id;
		this.c_qty = c_qty;
		this.c_totprice = c_totprice;
		this.p_price = p_price;
		this.p_name = p_name;
		this.p_desc = p_desc;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
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
	public int getC_qty() {
		return c_qty;
	}
	public void setC_qty(int c_qty) {
		this.c_qty = c_qty;
	}
	public int getC_totprice() {
		return c_totprice;
	}
	public void setC_totprice(int c_totprice) {
		this.c_totprice = c_totprice;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_desc() {
		return p_desc;
	}
	public void setP_desc(String p_desc) {
		this.p_desc = p_desc;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	
}
