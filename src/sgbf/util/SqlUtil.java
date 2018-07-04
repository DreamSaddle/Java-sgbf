package sgbf.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SqlUtil {

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public static Connection getConn() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/sgbf", "root", "123456");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public static void getClose(Connection conn, PreparedStatement stam, ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stam != null)
					stam.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			} finally {
				try {
					if (conn != null)
						conn.close();
				} catch (Exception e3) {
					e3.printStackTrace();
				}
			}
		}
	}
}
