package thebestkitchen.jumun;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import thebestkitchen.cart.CartDao;

public class JumunDetailDao {

	private DataSource dataSource;
	private CartDao cartDao;
	private Jumun jumun;
	private JumunDetail jumunDetail;
	
	public JumunDetailDao() throws Exception {
		// TODO Auto-generated constructor stub
			
		InitialContext ic = new InitialContext();
		dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
		// System.out.println("JumunDao() 생성자 : " + this);
	}
	
	// jumunDetailDao test 생성자
	public JumunDetailDao(DataSource dataSource) throws Exception {
		this.dataSource = dataSource;
		System.out.println("JumunDetailDao()생성자 : " + this);
	}
	
	
	/*
	   주문 프로세스

		before_order.html > https://www.thetestkitchen.co.kr/common/order.html?ordersheetno=202002040001517830&cartnos=%5B1184683%5D
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
	public boolean insertOrder(JumunDetail jumunDetail) throws Exception {
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_DETAIL_INSERT);
			
			pstmt.setInt(1, jumunDetail.getJ_no());
			pstmt.setInt(2, jumunDetail.getP_no());
			pstmt.setInt(3, jumunDetail.getC_qty());
									
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

	
	
	// READ ALL
	// 한 주문의 전체 상품 출력
	public ArrayList<JumunDetail> selectAll() throws Exception {
		ArrayList<JumunDetail> jumunDetailList = new ArrayList<JumunDetail>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_DETAIL_SELECT_ALL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				jumunDetailList.add(new JumunDetail(rs.getInt("orderDetailsNum"), rs.getInt("j_no"), rs.getInt("p_no"),
						rs.getInt("c_qty")));
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
		
		return jumunDetailList;
	}
	
	
	
	// UPDATE???
	
	
	
	// DELETE
	// 주문 내역 취소? 삭제? > j_no? m_no?
	public boolean deleteOrder(int j_no) throws Exception {
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(JumunSQL.JUMUN_DETAIL_DELETE);
			
			pstmt.setInt(1, j_no);
									
			int deleteRowCount = pstmt.executeUpdate();
			if (deleteRowCount == 1)
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
}
