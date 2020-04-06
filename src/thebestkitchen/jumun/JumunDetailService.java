package thebestkitchen.jumun;

import java.util.ArrayList;

public class JumunDetailService {

	/*
	 * Oracle SQL Table
	 * 이름              널?       유형
	 * --------------- -------- ----------
	 * ORDERDETAILSNUM NOT NULL NUMBER(20)
	 * J_NO            NOT NULL NUMBER(20)
	 * P_NO            NOT NULL NUMBER(20)
	 * CART_STOCK      NOT NULL NUMBER(20)
	 * 주문상세번호_pk_seq
	 * 주문번호_fk
	 * 제품번호_fk
	 * 제품 총 주문수
	 */
	
	/*
	private int orderDetailsNum;
	private int j_no;
	private int p_no;
	private int cart_stock;
	 */
	
	// private JumunDao jumunDao;
	private JumunDetailDao jumunDetailDao;
	
	private static JumunDetailService _instance;
	
	public JumunDetailService() throws Exception {
		// productDao = new ProductDao();
		// cartDao = new CartDao();
		jumunDetailDao = new JumunDetailDao();		
	}
	
	public static JumunDetailService getinstance() throws Exception {
		if (JumunDetailService._instance == null)
			JumunDetailService._instance = new JumunDetailService();
		
		return JumunDetailService._instance;
	}
	
	
	
	// Create Order
	public boolean insertOrder(JumunDetail jumunDetail) throws Exception {
		return jumunDetailDao.insertOrder(jumunDetail);
	}

	
	// Select All
	public ArrayList<JumunDetail> selectAll() throws Exception {
		return jumunDetailDao.selectAll();
	}
	
		
	// Delete
	public boolean deleteOrder(int j_no) throws Exception {
		return jumunDetailDao.deleteOrder(j_no);
	}
}
