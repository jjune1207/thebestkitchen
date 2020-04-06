package thebestkitchen.board.test;
import java.sql.*;

import thebestkitchen.rdbms.ConnectionFactory;

public class BatchUpdateBoardMain 
{
	public static void main(String[] args) 
	{
		Connection con=null;
		Statement stmt=null;
		try{
		 con=ConnectionFactory.getConnection();
		 stmt=con.createStatement(
			 ResultSet.TYPE_SCROLL_SENSITIVE,
			 ResultSet.CONCUR_UPDATABLE);
		 con.setAutoCommit(false);

		 for(int i=1;i<=150;i++){
			stmt.addBatch(		
					"INSERT INTO"
					+" board(b_no, m_id, b_title, b_content, b_groupno, b_step, b_depth, b_type, p_no)" 
					+"VALUES( board_no_seq.nextval,"
							+"'test',"
					        +"'게시판타이틀',"
					        +"'content',"
					        +"board_no_seq.currval,"
					        +"1,"
					        +"0,"
					        +"'N',"
					        +"21)"
			 );
		 }
		 int[] updateCounts = stmt.executeBatch();
		 System.out.println("query 수:"+updateCounts.length);
		 con.commit();
		 System.out.println("success commit!!!!");
		}catch(SQLException e){
			e.printStackTrace();
			try{
				con.rollback();
				System.out.println("rollback !!!");
			}catch(SQLException e1){
				System.out.println("rollback fail!!!");
			}
		}finally{
			try{
				if(con!=null){
					con.close();
				}
			}catch(SQLException e){
				System.out.println("close 시 에러발생");
			}
		}

	}
}
