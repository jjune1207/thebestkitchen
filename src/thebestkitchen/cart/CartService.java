package thebestkitchen.cart;

import java.util.ArrayList;

import thebestkitchen.exception.ExistedCartException;


public class CartService {
	private CartDao cartDao;
	public CartService() throws Exception{
		cartDao=new CartDao();
	}
	//insert
	
	public synchronized int insert(int p_no, String m_id, int c_qty, int c_totprice,int p_price) throws Exception{
		if(cartDao.isExistCart(p_no,m_id)) {
			return cartDao.updateOne(p_no, c_qty, m_id);
		}
	    return cartDao.insert(m_id, p_no, c_qty, c_totprice);
	}
	//수량 update 밖에서 오는것 추가 할것
	/*
	public synchronized int productToCartW(int c_no, int c_qty, int p_price) throws Exception{
		
		return 0;
	}
	*/
	//cart출력
	public synchronized ArrayList<Cart> getCartItemList(String m_id) throws Exception{
		return cartDao.getCartItemList(m_id);
	}
	//개별삭제
	public  int deleteCartItem(int p_no)  throws Exception{
		return cartDao.deleteCartItem(p_no);
	}
	//카트비우기
	public synchronized int deleteCart(String m_id)  throws Exception{
		return cartDao.deleteCart(m_id);
	}
	//카트 아이템 총개수 출력
	/*public synchronized int countCart(String m_id)  throws Exception{
		return cartDao.countCart(m_id);
	}
	*/
	
	public synchronized int update(int p_no, int c_qty, String m_id)  throws Exception{
		return cartDao.update(p_no,c_qty, m_id);
	}
	public synchronized int addJumun(String p_name, String m_id, int c_qty, int p_price, int c_totprice, int p_no)throws Exception{
		if(cartDao.isExistJumun(p_no,m_id)) {
			throw new ExistedCartException("이미 주문목록에 추가된 상품입니다.");
		}
		return cartDao.addJumun(p_name, m_id, c_qty, c_totprice, p_no);
	}
	

}
