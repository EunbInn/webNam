<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인</title>
<link rel="stylesheet" type="text/css" href="board.css">
<link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
	<div id="content-wrap">
		<h1>게 시 판</h1>
		<table border="1px solid black">
			<tr>
				<th>번호</th>
				<th id="title">제목</th>
				<th>작성 일자</th>
			</tr>
			<% 
			String id = "root";
			String pw = "0112";
			
			try {	
				Class.forName("com.mysql.cj.jdbc.Driver"); 
				Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
				Statement stmt = con.createStatement(); //stament 선언
				ResultSet rs = null;
				String queryT;
				
				queryT = "select artID, title, date from noticeBoard order by artID desc;";
				rs = stmt.executeQuery(queryT);
				
				String getEmpty = "";
				while (rs.next()) {
					int artID = rs.getInt(1);
					String title = rs.getString(2);
					String strDate = rs.getString(3);
					getEmpty = rs.getString(1);
					out.println("<tr>" +
							   "<td>" + artID + "</td>" +
							   "<td><a href='./oneView.jsp?artID=" + artID + "' class='title'>" + title + "</a></td>" +
							   "<td>" + strDate + "</td>" +
							   "</tr>");
				}
				
				if (getEmpty.equals("")) {
					out.println("<tr><td colspan='3'>작성된 게시글이 없습니다</td></tr>");
				}
				
				rs.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				String err = e.getMessage();
				out.println(err);
			} finally {
			}
			%>
		</table>
		<button class="btn" onclick="location.href='./write01.jsp'">글쓰기</button>
	</div>

</body>
</html>