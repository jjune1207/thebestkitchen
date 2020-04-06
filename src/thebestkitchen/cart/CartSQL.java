package thebestkitchen.cart;

public class CartSQL {
	public final static String CART_INSERT
				="insert into cart(c_no,p_no,m_id,c_qty,c_totprice)"
			  + " values(cart_no_seq.nextval,?,?,?,?)";
	public final static String CART_UPDATE
				="update cart set c_qty = ? ,c_totprice = ? * "
						+ "(select p_price from product "
						+ "where p_no=?) "
						+ "where p_no = ? and m_id=?";
	public final static String CART_UPDATE_ONE
				="update cart set c_qty = c_qty+? where p_no = ? and m_id=? ";
	public final static String CART_GETITEM_LIST
				="select p.p_name, p.p_price, p.p_desc, p.p_no, "
						+ "c.c_no, c.c_totprice, c.c_qty, c.m_id "
						+ "from cart c inner join product p "
						+ "on c.p_no = p.p_no "
						+ "where c.m_id = ? ";
	public final static String CART_DELETE_ONE
				="delete from cart where p_no = ?";
	public final static String CART_DELETE_ALL
				="delete from cart where m_id = ?";
	public final static String CART_ISEXIST_CART
				="select count(*) from cart where p_no=? and m_id= ? ";
	public final static String CART_INSERT_JUMUN
				="INSERT INTO jumun VALUES"
						+ " (to_number(concat(replace(to_char(sysdate, 'YYYY/MM/DD'), '/', ''), "
						+ " to_char(lpad(jumun_no_seq.nextval, 3, 0)))),"
						+ " ?,?, ?, sysdate, ?, ?, 3000, null, null,default)";
	public final static String CART_ISEXIST_JUMUN
				="select count(*) from jumun where p_no=? and m_id=? and j_payment='N'";
		
	
}
