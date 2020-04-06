package thebestkitchen.jumun;

import java.sql.Date;

public class JumunSQL {
	
	public final static String JUMUN_INSERT =
			// ordernumber 생성, p_no, m_id, j_desc, j_date, j_qty, j_price, j_dprice, j_address, j_phone
			"INSERT INTO jumun VALUES"
			+ " (to_number(concat(replace(to_char(sysdate, 'YYYY/MM/DD'), '/', ''), "
			+ " to_char(lpad(jumun_no_seq.nextval, 3, 0)))),"
			+ " ?, ?, ?, sysdate, ?, ?, ?, ?, ?)";
	
	public final static String JUMUN_SELECT_BY_ONE =
			"SELECT * FROM jumun WHERE m_id = ? and j_payment = 'N'" ;
	
	public final static String JUMUN_SELECT_ALL =
			"SELECT * FROM jumun";
	
	public final static String JUMUN_DELETE =
			"DELETE FROM jumun where m_id = ? AND j_payment = 'N'";
			
	public final static String JUMUN_MODIFY =
			"UPDATE jumun SET j_payment = 'Y' WHERE j_payment = 'N' AND m_id = ?";
	
	public final static String JUMUN_DETAIL_INSERT =
			"INSERT INTO jumun_detail VALUES (jumun_detail_seq.nextval, ?, ?, ?)";
	
	public final static String JUMUN_DETAIL_SELECT_ALL =
			"SELECT * FROM jumun_detail WHERE j_no = ?";
	
	public final static String JUMUN_DETAIL_DELETE =
			"DELETE FROM jumun_detail WHERE j_no = ?";

}
