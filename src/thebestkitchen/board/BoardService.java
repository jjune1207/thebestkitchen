package thebestkitchen.board;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import thebestkitchen.board.util.BoardListPageDto;
import thebestkitchen.board.util.PageCalculator;
import thebestkitchen.board.util.PageInputDto;
import thebestkitchen.mypage.JumunList;
import thebestkitchen.mypage.ProductHugi;
import thebestkitchen.mypage.ProductInquiry;
import thebestkitchen.mypage.hugiutil.HugiListPageDto;
import thebestkitchen.mypage.hugiutil.HugiPageCalculator;
import thebestkitchen.mypage.hugiutil.HugiPageInputDto;
import thebestkitchen.mypage.inquiryutil.InquiryListPageDto;
import thebestkitchen.mypage.inquiryutil.InquiryPageCalculator;
import thebestkitchen.mypage.inquiryutil.InquiryPageInputDto;
import thebestkitchen.mypage.jumunutil.JumunListPageDto;
import thebestkitchen.mypage.jumunutil.JumunPageCalculator;
import thebestkitchen.mypage.jumunutil.JumunPageInputDto;

public class BoardService {
	private static BoardService _instance;
	
	private BoardDao boardDao;
	private BoardService() throws Exception{
		boardDao=new BoardDao();
	}
	public static BoardService getInstance() throws Exception{
		if (_instance==null) {
			 _instance=new BoardService();
		}
		return _instance;
	}
	/**
	 *  게시판 작성
	 */
	public int createBoard(Board board) throws Exception{
		return boardDao.createBoard(board);
	}
	/**
	 * 공지사항 목록(관리자)
	 */
	public BoardListPageDto findBoardList(PageInputDto pageConfig) {
		int totalRecordCount=boardDao.getNoticeBoardCount();
		
		BoardListPageDto boardListPageDto=PageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
	
		List<Board> boarList=boardDao.findNoticeBoardList(boardListPageDto.getStartRowNum(),
															boardListPageDto.getEndRowNum());
		
		boardListPageDto.setList(boarList);
		
		return boardListPageDto;
	}
	/**
	 * 상품문의 목록(관리자)
	 */
	public BoardListPageDto findBoardQnaList(PageInputDto pageConfig) {
		int totalRecordCount=boardDao.getQnaBoardCount();
		
		BoardListPageDto boardListPageDto=PageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
	
		List<Board> boarList=boardDao.findQnaBoardList(boardListPageDto.getStartRowNum(),
				boardListPageDto.getEndRowNum());
		
		boardListPageDto.setList(boarList);
		
		return boardListPageDto;
	}
	/**
	 * 상품후기 목록(관리자)
	 */
	public BoardListPageDto findBoardReviewList(PageInputDto pageConfig) {
		int totalRecordCount=boardDao.getReviewBoardCount();
		
		BoardListPageDto boardListPageDto=PageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
		
		List<Board> boarList=boardDao.findReviewBoardList1(boardListPageDto.getStartRowNum(),
				boardListPageDto.getEndRowNum());
		
		boardListPageDto.setList(boarList);
		
		return boardListPageDto;
	}
	/**
	 * 문의사항 목록(사용자)
	 */
	public InquiryListPageDto findQnaList(InquiryPageInputDto pageConfig, String memberId) {
		int totalRecordCount=boardDao.getMemberQnaBoardCount(memberId);
		
		InquiryListPageDto boardListPageDto=InquiryPageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
	
		ArrayList<ProductInquiry> boarList=boardDao.findQnaBoardList(boardListPageDto.getStartRowNum(),
															boardListPageDto.getEndRowNum(), memberId);
		
		boardListPageDto.setList(boarList);
		
		return boardListPageDto;
	}
	/**
	 * 후기 목록(사용자)
	 */
	public HugiListPageDto findHugiList(HugiPageInputDto pageConfig, String memberId) {
		int totalRecordCount=boardDao.getMemberHugiBoardCount(memberId);
		
		HugiListPageDto boardListPageDto=HugiPageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
	
		ArrayList<ProductHugi> boarList=boardDao.findHugiBoardList(boardListPageDto.getStartRowNum(),
															boardListPageDto.getEndRowNum(), memberId);
		
		boardListPageDto.setList(boarList);
		return boardListPageDto;
	}
	/**
	 * 주문 목록(사용자)
	 */
	public JumunListPageDto findJumunList(JumunPageInputDto pageConfig, String memberId) {
		int totalRecordCount=boardDao.getMemberJumunCount(memberId);
		
		JumunListPageDto boardListPageDto=JumunPageCalculator.getPagingInfo(
				Integer.parseInt(pageConfig.getSelectPage()),
				pageConfig.getRowCountPerPage(),
				pageConfig.getPageCountPerPage(),
				totalRecordCount);
	
		ArrayList<JumunList> boarList=boardDao.findJumunList(boardListPageDto.getStartRowNum(),
															boardListPageDto.getEndRowNum(), memberId);
		
		boardListPageDto.setList(boarList);
		
		return boardListPageDto;
	}
	/**
	 * 게시물 1개
	 */
	public Board findBoard(int boardNo)throws Exception{
		Board board=boardDao.boardDetailView(boardNo);
		return board;
	}
	/**
	 * 조회수 증가
	 */
	public void updateHitCount(int boardNo) {
		boardDao.increaseReadCount(boardNo);
	}
	
	/**
	 * 게시판 수정
	 */
	public int update(Board board)throws SQLException{
		return boardDao.update(board);
	}
	/**
	 * 게시판 삭제
	 */
	public int remove(int boardno)throws Exception{
		return boardDao.remove(boardno);
	}
	/**
	 * 게시판 상세보기
	 */
	public Board detailView(int boardNo)throws Exception{
		Board board=boardDao.boardDetailView(boardNo);
		return board;
	}
	/**
	 * 답변 쓰기
	 */
	public int createReplay(Board board) {
		return boardDao.createReply(board);
	}
}
