package thebestkitchen.mypage;

public class mypageSQL {
	//주문내역 획득
	public static final String jumun_get = 
			"select j.j_no, p.p_name, j.j_qty, j.j_price, p.p_no "
			+ "from jumun j "
			+ "inner join product p "
			+ "on j.p_no = p.p_no "
			+ "where j.m_id = ?";
	
	//상품문의 획득
	public static final String inquiry_get =
			"select p.p_name, b.b_title, b.b_date, p.p_no "
			+ "from product p "
			+ "inner join board b "
			+ "on b.p_no = p.p_no "
			+ "where b.m_id = ?";
}

