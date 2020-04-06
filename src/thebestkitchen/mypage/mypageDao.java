package thebestkitchen.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class mypageDao {
	private DataSource dataSource;
	
	public mypageDao() throws Exception {
		InitialContext ic=new InitialContext();
		dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
	}
	
	public mypageDao(DataSource dataSource) throws Exception {
		this.dataSource = dataSource;
	}
	
	//사용자 한 명의 주문 내역
	public ArrayList<JumunList> jumunprint(String memberId) throws Exception {
		ArrayList<JumunList> jumunList = new ArrayList<JumunList>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(mypageSQL.jumun_get);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				jumunList.add(new JumunList(rs.getLong("j_no"), rs.getString("p_name"), 
											rs.getInt("j_qty"), rs.getInt("j_price"),
											rs.getInt("p_no"), rs.getString("j_payment")));				
			}			
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return jumunList;
	}
	
	//사용자 한 명의 상품 후기
	public ArrayList<ProductInquiry> inquiryprint(String memberId) throws Exception {
		ArrayList<ProductInquiry> inquiryList = new ArrayList<ProductInquiry>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(mypageSQL.inquiry_get);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				inquiryList.add(new ProductInquiry(rs.getString("p_name"),
													rs.getString("b_title"), rs.getDate("b_date"),
													rs.getInt("p_no")));				
			}			
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		
		return inquiryList;
	}
}
