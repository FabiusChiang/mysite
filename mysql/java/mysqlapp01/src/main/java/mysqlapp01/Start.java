package mysqlapp01;

import java.sql.*;

public class Start {

	public static void main(String[] args) {
		System.out.println("this is a Java demo");
		
		try{  
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection(  
					"jdbc:mysql://127.0.0.1:3306/testdb","root","123456");  
			Statement stmt=con.createStatement();  
			ResultSet rs=stmt.executeQuery("select * from test_table_01");  
			while(rs.next()){
				System.out.println(rs.getInt(1)+"  "+rs.getString(2));
			}
			con.close();  
		}catch(Exception e){ 
			System.out.println(e);
		}
	}
}