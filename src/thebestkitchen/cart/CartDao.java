package thebestkitchen.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import thebestkitchen.rdbms.ConnectionFactory;

public class CartDao {
	private DataSource dataSource;
	public CartDao(DataSource dataSource) throws Exception {
		this.dataSource = dataSource;
	}
	public CartDao() throws Exception{
		 InitialContext ic=new InitialContext();
	      dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
	}
	//장바구니추가
	public int insert(String m_id, int p_no, int c_qty, int c_totprice) throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_INSERT);
			pstmt.setInt(1,p_no);
			pstmt.setString(2,m_id);
			pstmt.setInt(3,c_qty);
			pstmt.setInt(4,c_totprice);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	//장바구니 수량 업데이트
	public int update(int p_no, int c_qty, String m_id) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_UPDATE);
			pstmt.setInt(1, c_qty);
			pstmt.setInt(2, c_qty);
			pstmt.setInt(3, p_no);
			pstmt.setInt(4, p_no);
			pstmt.setString(5, m_id);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	
	public  int updateOne(int p_no, int c_ty, String m_id) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_UPDATE_ONE);
			pstmt.setInt(1, c_ty);
			pstmt.setInt(2, p_no);
			pstmt.setString(3, m_id);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	
	//상품 출력
	
	public ArrayList<Cart> getCartItemList(String m_id) throws Exception{
		ArrayList<Cart> cartItemList= new ArrayList<Cart>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		/*
		select c.p_no,c.cart_qty,c.cart_tot_price ,p.p_name,p.p_price 
		from cart1 c join user1 u 
		on c.userid = u.userid join product1 p on c.p_no=p.p_no where u.userid='guard1';
		 */
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_GETITEM_LIST);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cartItemList.add(new Cart(rs.getInt("c_no"), rs.getInt("p_no"), 
									rs.getString("m_id"), rs.getInt("c_qty"), 
									rs.getInt("c_totprice"), rs.getInt("p_price"), 
									rs.getString("p_name"), rs.getString("p_desc")));
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return cartItemList;
		
	}

	//장바구니 하나 비우기
	
	public  int deleteCartItem(int p_no)  throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_DELETE_ONE);
			pstmt.setInt(1, p_no);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	
	//장바구니 전체비우기
	public  int deleteCart(String m_id)  throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_DELETE_ALL);
			pstmt.setString(1, m_id);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}
	//카트상품 중복체크
	public boolean isExistCart(int p_no , String m_id) throws Exception {
		Connection con =ConnectionFactory.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isExist=false;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_ISEXIST_CART);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			int count=0;
			if (rs.next()) {
				count=rs.getInt(1);
			}
			if(count==0) {
				isExist=false;
			}else {
				isExist=true;
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return isExist;
	}
	
	public boolean isExistJumun(int p_no , String m_id) throws Exception {
		Connection con =ConnectionFactory.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isExist=false;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_ISEXIST_JUMUN);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			int count=0;
			if (rs.next()) {
				count=rs.getInt(1);
			}
			if(count==0) {
				isExist=false;
			}else {
				isExist=true;
			}
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return isExist;
	}
	/*
	// 카트상품 카운트
	public int countCart(String m_id) throws Exception{
		Connection con =ConnectionFactory.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String countCart = "select count(*) from cart where m_id=?";
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(countCart);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			
		} finally {
			// TODO: handle finally clause
		}
		return 0;
	}
	*/
	
	//주문목록에 추가하기 
	public int addJumun(String p_name, String m_id, int c_qty, int c_totprice, int p_no)throws Exception{
		Connection con = null; 
		PreparedStatement pstmt = null;
		//p_no, m_id , p_desc,date,c_qty,c_totprice,3000,default,default
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(CartSQL.CART_INSERT_JUMUN);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, m_id);
			pstmt.setString(3, p_name);
			pstmt.setInt(4, c_qty);
			pstmt.setInt(5, c_totprice);
			int rows = pstmt.executeUpdate();
			return rows;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
	}


}
