<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*,  
	java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 완료</title>

</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String artID = request.getParameter("artID");
	String title = request.getParameter("title");
	String article = request.getParameter("article");
	
	String id = "root";
	String pw = "0112";
	
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement();
		String queryT;

		queryT = String.format("update noticeBoard set title = '%s', article = '%s' where artID = %s;", title, article, artID);
		stmt.executeUpdate(queryT);

		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		out.println(err);
	} finally {
		response.sendRedirect("./oneView.jsp?artID=" + artID);
	}
	%>
</body>
</html>