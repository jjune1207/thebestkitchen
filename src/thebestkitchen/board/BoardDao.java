package thebestkitchen.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import thebestkitchen.mypage.JumunList;
import thebestkitchen.mypage.ProductHugi;
import thebestkitchen.mypage.ProductInquiry;
import thebestkitchen.rdbms.RdbmsDao;


public class BoardDao extends RdbmsDao{
	
	public BoardDao() {
		System.out.println("BoardDao생성자");
	}
	
	
	/**
	 *  게시판 작성
	 */
	public int createBoard(Board board) throws Exception{
		Connection conn=null;
		PreparedStatement pstmt=null;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_CREATE);
			pstmt.setString(1, board.getM_id());
			pstmt.setString(2, board.getB_title());
			pstmt.setString(3, board.getB_content());
			pstmt.setString(4, board.getB_type());
			pstmt.setInt(5, board.getP_no());
			int result=pstmt.executeUpdate();
			return result;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			conn.close();
		}
		return 0;
	}
	
	/**
	 * 공지사항 목록(관리자)
	 */
	public ArrayList<Board> findNoticeBoardList(int start, int last){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Board> boards=new ArrayList<Board>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          b_no, m_id, b_title, b_date, b_groupno, b_step, b_depth, b_type, b_count ");
			sql.append("      FROM ");
			sql.append("        board ");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='N' ");
			sql.append(")");
			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				Board board=new Board();
				board.setB_no(rs.getInt(2));
				board.setM_id(rs.getString(3));
				board.setB_title(rs.getString(4));
				board.setB_date(rs.getDate(5));
				board.setB_groupNo(rs.getInt(6));
				board.setB_step(rs.getInt(7));
				board.setB_depth(rs.getInt(8));
				board.setB_type(rs.getString(9));
				board.setB_count(rs.getInt(10));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
			}
	/**
	 * 상품문의 목록(관리자)
	 */
	public ArrayList<Board> findQnaBoardList(int start, int last){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Board> boards=new ArrayList<Board>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          b_no, m_id, b_title, b_date, b_groupno, b_step, b_depth, b_type, b_count");
			sql.append("      FROM ");
			sql.append("        board ");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='Q' ");
			sql.append(")");
			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				Board board=new Board();
				board.setB_no(rs.getInt(2));
				board.setM_id(rs.getString(3));
				board.setB_title(rs.getString(4));
				board.setB_date(rs.getDate(5));
				board.setB_groupNo(rs.getInt(6));
				board.setB_step(rs.getInt(7));
				board.setB_depth(rs.getInt(8));
				board.setB_type(rs.getString(9));
				board.setB_count(rs.getInt(10));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
			}
	/**
	 * 구매후기 목록(관리자)
	 */
	public ArrayList<Board> findReviewBoardList1(int start, int last){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Board> boards=new ArrayList<Board>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          b_no, m_id, b_title, b_date, b_groupno, b_step, b_depth, b_type, b_count ");
			sql.append("      FROM ");
			sql.append("        board ");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='R' ");
			sql.append(")");
			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				Board board=new Board();
				board.setB_no(rs.getInt(2));
				board.setM_id(rs.getString(3));
				board.setB_title(rs.getString(4));
				board.setB_date(rs.getDate(5));
				board.setB_groupNo(rs.getInt(6));
				board.setB_step(rs.getInt(7));
				board.setB_depth(rs.getInt(8));
				board.setB_type(rs.getString(9));
				board.setB_count(rs.getInt(10));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
			}
	/**
	 * 문의 목록(사용자)
	 */
	public ArrayList<ProductInquiry> findQnaBoardList(int start, int last, String memberId){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<ProductInquiry> boards=new ArrayList<ProductInquiry>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          p.p_name, b.b_title, b.b_date, p.p_no, b.b_type, b.b_no, b.m_id ");
			sql.append("      FROM ");
			sql.append("        product p inner join board b on b.p_no = p.p_no where b.m_id = ?");
			sql.append("        OR b.b_groupno = any"
					+ "			("
					+ "				select b_groupno "
					+ "				from board "
					+ "				where m_id = ?"
					+ "			) ");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='Q' ");
			sql.append(")");
			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			pstmt.setInt(3, start);
			pstmt.setInt(4, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				ProductInquiry board = new ProductInquiry();
				board.setP_name(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_date(rs.getDate(4));
				board.setP_no(rs.getInt(5));
				board.setB_type(rs.getString(6));
				board.setB_no(rs.getInt(7));
				board.setM_id(rs.getString(8));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
	}
	/**
	 * 후기 목록(사용자)
	 */
	public ArrayList<ProductHugi> findHugiBoardList(int start, int last, String memberId){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<ProductHugi> boards=new ArrayList<ProductHugi>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          p.p_name, b.b_title, b.b_date, p.p_no, b.b_type, b.b_no, b.m_id ");
			sql.append("      FROM ");
			sql.append("        product p inner join board b on b.p_no = p.p_no where b.m_id = ?");
			sql.append("        OR b.b_groupno = any"
					+ "			("
					+ "				select b_groupno"
					+ "				from board"
					+ "				where m_id = ?"
					+ "			)");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='R' ");
			sql.append(")");
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			pstmt.setInt(3, start);
			pstmt.setInt(4, last);
			System.out.println(last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				ProductHugi board = new ProductHugi();
				board.setP_name(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_date(rs.getDate(4));
				board.setP_no(rs.getInt(5));
				board.setB_type(rs.getString(6));
				board.setB_no(rs.getInt(7));
				board.setM_id(rs.getString(8));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
	}
	/**
	 * 주문 목록
	 */
	public ArrayList<JumunList> findJumunList(int start, int last, String memberId){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<JumunList> boards=new ArrayList<JumunList>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          j.j_no, p.p_name, j.j_qty, j.j_price, p.p_no, j.j_payment ");
			sql.append("      FROM ");
			sql.append("        jumun j inner join product p on j.p_no = p.p_no where j.m_id = ?");
			sql.append("      order by j.j_no asc ");
			sql.append("   ) s");
			sql.append(")");			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, memberId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				JumunList board = new JumunList();
				board.setJ_no(rs.getLong(2));
				board.setP_name(rs.getString(3));
				board.setJ_qty(rs.getInt(4));
				board.setJ_price(rs.getInt(5));
				board.setP_no(rs.getInt(6));
				board.setJ_payment(rs.getString(7));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
	}
	/**
	 * 리뷰 목록
	 */
	public ArrayList<Board> findReviewBoardList(int start, int last){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Board> boards=new ArrayList<Board>();
		
		try {
			conn=getConnection();
			
			StringBuffer sql=new StringBuffer(500);
			sql.append("SELECT * ");
			sql.append("FROM ");
			
			sql.append("(");
			sql.append("  SELECT ");
			sql.append("      rownum idx, s.* ");
			sql.append("  FROM ");
			
			sql.append("  ( ");
			sql.append("      SELECT ");
			sql.append("          b_no, m_id, b_title, b_date, b_groupno, b_step, b_depth, b_type, b_count ");
			sql.append("      FROM ");
			sql.append("        board ");
			sql.append("      ORDER BY b_groupno DESC, b_step ASC ");
			sql.append("   ) s");
			sql.append(" WHERE b_type='R' ");
			sql.append(")");
			
			sql.append("WHERE idx >= ? AND idx <= ?");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, last);
			rs= pstmt.executeQuery();
			
			while (rs.next()) {
				Board board=new Board();
				board.setB_no(rs.getInt(2));
				board.setM_id(rs.getString(3));
				board.setB_title(rs.getString(4));
				board.setB_date(rs.getDate(5));
				board.setB_groupNo(rs.getInt(6));
				board.setB_step(rs.getInt(7));
				board.setB_depth(rs.getInt(8));
				board.setB_type(rs.getString(9));
				boards.add(board);
			}
		}catch (Exception ex) {
				ex.printStackTrace();
			}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(Exception ex) {
					}
				if(conn !=null)
					try {
						conn.close();
					}catch(Exception ex) {
					}
			}
				return boards;
			}
		
	/**
	 * 게시물 수정
	 */
	public int update(Board board) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_UPDATE);
			pstmt.setString(1, board.getB_title());
			pstmt.setString(2, board.getB_content());
			pstmt.setInt(3, board.getB_no());
			count=pstmt.executeUpdate();
		} catch(Exception ex) {
			count=0;
			ex.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			}catch (Exception ex) {
			}
			try {
				if (conn!=null) 
					conn.close();
				}catch (Exception ex) {
				}
			}
			return count;
		}
	
	/**
	 * 게시판 삭제
	 */
	public int remove(int boardNo) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_DELETE);
			pstmt.setInt(1, boardNo);
			count=pstmt.executeUpdate();
		} catch(Exception ex) {
			count=0;
			ex.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			}catch (Exception ex) {
			}
			try {
				if (conn!=null) 
					conn.close();
				}catch (Exception ex) {
				}
			}
			return count;
		}		
	/**
	 * 게시판 상세보기	
	 */
	public Board boardDetailView(int boardNo) throws SQLException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Board board=null;
		try {
			conn=getConnection();
			StringBuffer sql=new StringBuffer(300);
			sql.append("SELECT ");
			sql.append("b_no, m_id, b_title, ");
			sql.append("b_content, b_count, ");
			sql.append("b_groupno, b_step, b_depth, p_no ");
			sql.append("FROM board ");
			sql.append("WHERE b_no=?");
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, boardNo);
			rs=pstmt.executeQuery();
			rs=pstmt.executeQuery();
			if (rs.next()) {
				board=new Board();
				board.setB_no(rs.getInt(1));
				board.setM_id(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_count(rs.getInt(5));
				board.setB_groupNo(rs.getInt(6));
				board.setB_step(rs.getInt(7));
				board.setB_depth(rs.getInt(8));
				board.setP_no(rs.getInt(9));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
			return board;
		}
	/**
	 * 게시물 총 수(공지사항)
	 */
	public int getNoticeBoardCount() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_NOTICE_TOT_COUNT);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
			return count;
		}
	/**
	 * 게시물 총 수(문의)
	 */
	public int getQnaBoardCount() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_QNA_TOT_COUNT);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
			return count;
		}
	/**
	 * 게시물 총 수(리뷰)
	 */
	public int getReviewBoardCount() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_REVIEW_TOT_COUNT);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
			return count;
		}
	
	/**
	 * 조회수 증가
	 */
	public void increaseReadCount(int number) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_VIEW_COUNT);
			pstmt.setInt(1, number);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch(Exception ex) {
			}
			try {
				if(conn!=null)
				   conn.close();
			} catch(Exception ex) {
			}
		}
	}
	/**
	 * 게시판 답변 존재여부
	 */
	public boolean countReplay(Board board)throws SQLException{
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Boolean isExist=false;
		int cnt=0;
		try {
			conn=getConnection();
			StringBuffer sql=new StringBuffer(300);
			sql.append("SELECT ");
			sql.append("count(*) cnt ");
			sql.append("FROM board ");
			sql.append("WHERE b_groupno = ? ");
			sql.append("AND b_depth >= ? ");
			sql.append("AND b_step >= ? ");
			sql.append("ORDER BY b_step,b_depth ASC");
			
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, board.getB_groupNo());
			pstmt.setInt(2, board.getB_depth());
			pstmt.setInt(3, board.getB_step());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			if (cnt>1) {
				isExist=true;
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
			}catch(Exception ex) {
			}
			try {
				if (pstmt!=null) 
					pstmt.close();
				}catch (Exception ex) {
				}
			try {
				if (conn!=null) 
					releaseConnection(conn);
			}catch (Exception ex) {
			}
		}
		return isExist;
	}
	/**
	 * 답변 작성
	 */
	
	public int createReply(Board board) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int count=0;
		try {
			//댓글 작성 전 해당 게시판 정보 조회
			Board temp=boardDetailView(board.getB_no());
			
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_STEP_GROUPNO);
			pstmt.setInt(1, temp.getB_step());
			pstmt.setInt(2, temp.getB_groupNo());
			pstmt.executeUpdate();
			pstmt.close();
			
			//댓글작성
			pstmt=conn.prepareStatement(BoardSQL.BOARD_CREATE_REPLY);
			pstmt.setString(1, board.getM_id());
			pstmt.setString(2, board.getB_title());
			pstmt.setString(3, board.getB_content());
			pstmt.setInt(4, temp.getB_groupNo());
			pstmt.setInt(5, temp.getB_step()+1);
			pstmt.setInt(6, temp.getB_depth()+1);
			pstmt.setString(7, board.getB_type());
			pstmt.setInt(8, board.getP_no());
			
			count=pstmt.executeUpdate();
		} catch (Exception ex) {
			count=0;
			ex.printStackTrace();
		}finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception ex) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
			}
		}
		return count;
	}

	/**
	 * 사용자의 총 문의 개수
	 */
	public int getMemberQnaBoardCount(String memberId) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_QNA_MEMBER_COUNT);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
		
		return count;
	}
	/**
	 * 사용자의 총 후기 개수
	 */
	public int getMemberHugiBoardCount(String memberId) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_REVIEW_MEMBER_COUNT);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
		System.out.println(count);
		return count;
	}
	/**
	 * 사용자의 총 주문 개수
	 */
	public int getMemberJumunCount(String memberId) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(BoardSQL.BOARD_JUMUN_MEMBER_COUNT);
			pstmt.setString(1, memberId);
			rs=pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if (rs!=null) 
					rs.close();
				}catch(Exception ex) {
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(Exception ex) {
				}
				try {
					if(conn!=null)
						conn.close();
				}catch(Exception ex) {
				}
			}
		
		return count;
	}
		
	
	
	
}
