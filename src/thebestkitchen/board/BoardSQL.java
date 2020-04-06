package thebestkitchen.board;

public class BoardSQL {

	public final static String BOARD_CREATE="INSERT INTO board(b_no, m_id, b_title, b_content, b_groupno, " +
											" b_step, b_type, p_no) " + 
											" VALUES( board_no_seq.nextval, ?, ?, ?, board_no_seq.currval," + 
											"1, ?, ?)";

	public final static String BOARD_UPDATE="UPDATE board SET b_title=?, b_content=? WHERE b_no=?";

	public final static String BOARD_DELETE="DELETE board WHERE b_no = ?";

	public final static String BOARD_VIEW_COUNT="UPDATE board SET b_count=b_count+1 WHERE b_no=?";
	
	public final static String BOARD_NOTICE_TOT_COUNT="SELECT COUNT(*) FROM board WHERE b_type='N'";

	public final static String BOARD_QNA_TOT_COUNT="SELECT COUNT(*) FROM board WHERE b_type='Q'";

	public final static String BOARD_QNA_MEMBER_COUNT="SELECT COUNT(*) FROM board WHERE (b_type='Q' and m_id = ?) or "
			+ "(b_type = 'Q' and b_groupno = any ("
			+ "select b_groupno "
			+ "from board "
			+ "where m_id = ?))";
	
	public final static String BOARD_JUMUN_MEMBER_COUNT="SELECT COUNT(*) FROM jumun WHERE m_id = ?";
	
	public final static String BOARD_REVIEW_TOT_COUNT="SELECT COUNT(*) FROM board WHERE b_type='R'";
	
	public final static String BOARD_REVIEW_MEMBER_COUNT="SELECT COUNT(*) FROM board WHERE (b_type='R' and m_id = ?) OR "
			+ "(b_type = 'R' and b_groupno = any ("
			+ "select b_groupno "
			+ "from board "
			+ "where m_id = ?))";

	public final static String BOARD_STEP_GROUPNO="UPDATE board SET b_step = b_step + 1 WHERE b_step > ? AND b_groupno = ? ";

	public final static String BOARD_CREATE_REPLY="INSERT INTO board (b_no, m_id, b_title, b_content, b_groupno, " +
												  " b_step, b_depth, b_type, p_no ) " +
												  " VALUES ( board_no_seq.nextval, ?, ?, ?, ?, " +
												  " ?, ?, ? ,?)";
}
