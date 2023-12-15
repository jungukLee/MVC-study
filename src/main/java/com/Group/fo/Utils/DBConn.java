package com.Group.fo.Utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
		
	public static Connection dbConnection() {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/mydb","root","dongyang");
			System.out.println("DB Connection");
			return conn;
		}catch(Exception e){
			System.out.println("오류"+e);
			return null;
		}
	}
	
}