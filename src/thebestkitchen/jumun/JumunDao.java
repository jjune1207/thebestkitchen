package thebestkitchen.jumun;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sun.prism.Presentable;

import thebestkitchen.cart.CartDao;

public class JumunDao {
	private DataSource dataSource;
	private CartDao cartDao;
	private Jumun jumun;
	
	public JumunDao() throws Exception {
		// TODO Auto-generated constructor stub
		InitialContext ic = new InitialContext();
		dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
		// System.out.println("JumunDao() 생성자 : " + this);
	}
	
	// jumunDao test 생성자
	public JumunDao(DataSource dataSource) throws Exception {
		this.dataSource = dataSource;
		System.out.println("UserDao()생성자 : " + this);
	}
	
	
	/*
	   주문 프로세스

		before_order.html > https://www.thetestkitchen.co.kr/common/order.html?ordersheetno=20200204000XXXXX0&cartnos=%5B1184683%5D
		
		> ordersheetno=date|order#|time&cartnos=?????

		> 비회원 패스(!)
		> 회원 로그인 상태
		> 웹 페이지, 서버 연결
		
		> 카트 불러오기 (I?)
			> 상품 주문 가능 여부 확인((재고 - 주문수량) > 0)
			> 총 상품 금액 계산
			> 배송비 책정 여부 확인
			> 쿠폰 할인 여부 패스(!)
		> 배송 정보 입력
			> 배송요구사항 외 null이나 잘못된 문자 있을시 실패 반환
		> 사용자 주문 사항, 약관 동의
		> 에스크로 서비스 호출
			> 성공
				> 주문 내역 출력
				> 카트 내역 삭제 (D)
				> 주문 번호 생성, 카트 내 상품 주문수량, 주문 정보, 배송 정보 DB 저장 (C, R?)
				> *extra* 배송장번호 Delivery DB와 연동
			> 실패
				> 에스크로 서비스 재호출 되도록 주문 페이지 유지 
	 */
	

	// CREATE	
	// 주문 추가, 주문 디테일 필요.
	public boolean insertOrder(Jumun jumun) throws Exception {
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_INSERT);
			// int j_no, int p_no, String m_id, String j_desc, Date j_date, int j_qty, int j_price,
			// int j_dprice, String j_address, String j_phone
			pstmt.setInt(1, jumun.getP_no());
			pstmt.setString(2, jumun.getM_id());
			pstmt.setString(3, jumun.getJ_desc());			
			pstmt.setInt(4, jumun.getJ_qty());
			pstmt.setInt(5, jumun.getJ_price());
			pstmt.setInt(6, jumun.getJ_dprice());
			pstmt.setString(7, jumun.getJ_address());
			pstmt.setString(8, jumun.getJ_phone());
						
			int insertRowCount = pstmt.executeUpdate();
			if (insertRowCount == 1)
				isSuccess = true;
						
		} catch (Exception e) {
			// TODO: handle exception
			isSuccess = false;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		
		return isSuccess;
	}

	
	
	// READ ONE
	// 주문 한개에 대한 내역
	public Jumun selectByOne(String m_id) throws Exception {
		Jumun jumun = new Jumun();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_SELECT_BY_ONE);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				jumun = new Jumun(rs.getInt("j_no"), rs.getInt("p_no"), rs.getString("m_id"),
						rs.getString("j_desc"), rs.getDate("j_date"), rs.getInt("j_qty"),
						rs.getInt("j_price"), rs.getInt("j_dprice"), rs.getString("j_address"), rs.getString("j_phone"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		
		return jumun;
	}
	
	
	
	// READ ALL
	// 계정의 주문 전체 내역 출력
	public ArrayList<Jumun> selectAll() throws Exception {
		ArrayList<Jumun> jumunList = new ArrayList<Jumun>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_SELECT_ALL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				jumunList.add(new Jumun(rs.getInt("j_no"), rs.getInt("p_no"), rs.getString("m_id"),
						rs.getString("j_desc"), rs.getDate("j_date"), rs.getInt("j_qty"),
						rs.getInt("j_price"), rs.getInt("j_dprice"), rs.getString("j_address"), rs.getString("j_phone")));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		
		return jumunList;
	}
	
	
	
	// UPDATE???
	
	
	
	// DELETE
	// 주문 내역 취소? 삭제? > j_no? m_no?
	public int deleteOrder(String m_id) throws Exception {
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_DELETE);
			pstmt.setString(1, m_id);
			int deleteRowCount = pstmt.executeUpdate();
			return deleteRowCount;			
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}

	}
	
	
	
	// m_id > jumunList
	public ArrayList<Jumun> m_idJumunList(String m_id) throws Exception {
		ArrayList<Jumun> m_idJumunList = new ArrayList<Jumun>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_SELECT_BY_ONE);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				m_idJumunList.add(new Jumun(rs.getInt("p_no"), rs.getString("m_id"),
						rs.getString("j_desc"), rs.getDate("j_date"), rs.getInt("j_qty"),
						rs.getInt("j_price"), rs.getInt("j_dprice"), rs.getString("j_address"), rs.getString("j_phone")));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		
		return m_idJumunList;
	}
	
	
	
	// MODIFY
		// SQL TABLE 변경
		public Jumun modifyPayment(String m_id) throws Exception {
			// TODO Auto-generated method stub
			Jumun jumun = new Jumun();
			Connection conn = null;
			PreparedStatement pstmt = null;
					
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(JumunSQL.JUMUN_MODIFY);
				pstmt.setString(1, m_id);	
				pstmt.executeUpdate();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			}
			
			return jumun;
		}
		
		
}
