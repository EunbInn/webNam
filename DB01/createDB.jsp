<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection con;
	Statement stmt;
	String id = "root";
	String pw = "0112";
	try {		
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		stmt = con.createStatement(); //stament 선언
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String queryT = "create table examtableJSP("
						+ "name varchar(20),"
						+ "studentID int not null primary key,"
						+ "kor int, eng int, mat int);";
		
		long start = date.getTime();
		stmt.execute(queryT);
		
		date = new Date();
		long end = date.getTime();
		out.println("<h1><p>테이블 생성 완료</p></h1>");
		out.println(sdf.format(date.getTime()));
		out.println("<br>걸린 시간(ms) : " + (end - start));
		
		stmt.close();
		con.close();
	} catch (Exception e) {
		out.println("<h1><p>테이블이 이미 존재합니다</p></h1>");
	} finally {

	}
	%>
</body>
</html>