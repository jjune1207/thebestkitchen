package thebestkitchen.rdbms;
import java.sql.*;
public class  ConnectionFactory
{
	public static final String ODRIVER="oracle.jdbc.driver.OracleDriver";
	public static final String URL=
		"jdbc:oracle:thin:whyjyo/team2@182.237.126.19:1521:XE";
	public ConnectionFactory(){
		
	}
	public static Connection getConnection(){
		Connection con=null;
		try{
			Class.forName(ODRIVER);
			con=DriverManager.getConnection(URL);
		}catch(ClassNotFoundException e){
			System.out.println("ConnectionFactory.java Line 13");
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("ConnectionFactory.java Line 15");
		}
		return con;
	}
	public void close(){
		
	}

}
