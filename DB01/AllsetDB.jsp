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
	String id = "root";
	String pw = "0112";
	String[] name = {"나연","정연","사나","모모","미나","지효","다현","채영","쯔위"};
	try {
		
		
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement(); //stament 선언
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		long start = date.getTime();
		String queryT;
		
		queryT = "select max(studentID) from examtableJSP;";
		ResultSet rs = stmt.executeQuery(queryT);
		int maxID = 0;
		while (rs.next()) {
			maxID = rs.getInt(1);
		}
		
		if (maxID == 0) {
			maxID = 20210000;
		}
		
		int cnt = 0;
		for (int i = 0; i < name.length; i++) {
			int kor = (int)(Math.random()*100);
			int eng = (int)(Math.random()*100);
			int mat = (int)(Math.random()*100);
			cnt++;
			String stu_id = maxID + cnt + "";
			queryT = String.format("insert into examtableJSP values('%s', %s, %d, %d, %d);",
									name[i], stu_id, kor, eng, mat);
			stmt.execute(queryT);
		}
		date = new Date();
		long end = date.getTime();
			
		out.println("<h1><p>실습 데이터 입력완료</p></h1>");
		out.println("<br>" + sdf.format(date.getTime()));
		out.println("<br>걸린 시간(ms):" + (end - start));
		
		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		if (err.contains("doesn't exist")){
			out.println("<div><b>데이터 테이블이 존재하지 않습니다</b></div>");
			return;
		} else if (err.contains("Duplicate")) {
			out.println("<div><b>중복된 입력입니다</b></div>");
			return;
		}
	} finally {
		
	}
	%>
</body>
</html>