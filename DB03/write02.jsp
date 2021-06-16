<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*,  
	java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 업로드</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String strDate = request.getParameter("date");
	String article = request.getParameter("article");
	int newID = 0;
	
	article = article.replaceAll("'","`");
	
	String id = "root";
	String pw = "0112";
	
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String queryT;
		
		queryT = "select max(artID) from noticeBoard;";
		rs = stmt.executeQuery(queryT);
		
		int max = 0;
		while (rs.next()) {
			max = rs.getInt(1);
		}
		newID = max + 1;

		queryT = String.format("insert into noticeBoard values(%d, '%s', now(), '%s');", newID, title, article);
		stmt.execute(queryT);

		rs.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		out.println(err);
	} finally {
		response.sendRedirect("./oneView.jsp?artID=" + newID);
	}
	%>
</body>
</html>