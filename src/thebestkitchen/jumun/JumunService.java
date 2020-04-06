package thebestkitchen.jumun;

import java.util.ArrayList;

import thebestkitchen.cart.CartDao;
import thebestkitchen.product.ProductDao;

public class JumunService {
	
	// session id, hashmapping 카트에서 넘어올 시 재작성
	private JumunDao jumunDao;
	private static JumunService _instance;
	
	public JumunService() throws Exception {
		// productDao = new ProductDao();
		// cartDao = new CartDao();
		jumunDao = new JumunDao();		
	}
	
	public static JumunService getinstance() throws Exception {
		if (JumunService._instance == null)
			JumunService._instance = new JumunService();
		
		return JumunService._instance;
	}
		
	
	// Create Order
	public boolean insertOrder(Jumun jumun) throws Exception {
		return jumunDao.insertOrder(jumun);
	}
	
	
	// Select All
	public ArrayList<Jumun> selectAll() throws Exception {
		return jumunDao.selectAll();
	}
	
	
	// Select One
	public Jumun selectByOne(String m_id) throws Exception {
		return jumunDao.selectByOne(m_id);
	}
	
	
	// m_id Jumun All
	public ArrayList<Jumun> m_idJumunList(String m_id) throws Exception {
		return jumunDao.m_idJumunList(m_id);
	}
	
	
	// Delete
	public int deleteOrder(String m_id) throws Exception {
		return jumunDao.deleteOrder(m_id);
	}
	
	
	// Modify
	public Jumun modifyPayment(String m_id) throws Exception {
		return jumunDao.modifyPayment(m_id);
	}

}
