<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*,  
	java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 확인</title>
<link rel="stylesheet" type="text/css" href="board.css">
<style>
	body {
		display: flex;
		justify-content: center;
		text-align: center;
	}
	
	#content-wrap {
		display: flex;
		flex-direction: column;
		justify-content: center;
		items-align: center;
	}
	
	#title {
		width: 500px;
	}
	
	table {
		width: 850px;
		border-collapse: collapse;
		border: 2px solid black;
	}
	
	.category {
		width: 150px;
	}
	
	.content {
		text-align: left;
		padding:8px;
	}
	
	tr {
		border-bottom: 2px solid black;
	}
	
	#artID:focus {
		outline: none;
	}
</style>
</head>
<%
	String artID = "";
	String title = "";
	String strDate = "";
	String article = "";
	
	request.setCharacterEncoding("UTF-8");
	artID = request.getParameter("artID");
	
	String id = "root";
	String pw = "0112";
	
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String queryT;
		
		queryT = "select title, date, article from noticeBoard where artID=" + artID + ";";
		rs = stmt.executeQuery(queryT);
		
		while (rs.next()) {
			title = rs.getString(1);
			strDate = rs.getString(2);
			article = rs.getString(3);
		}
			
		article = article.replaceAll("\r\n","<br>");
		article = article.replaceAll("\u0020","&nbsp");

		rs.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		out.println(err);
	} finally {
	}
%>
<body>
	<div id="content-wrap">
		<form method="post">
			<table border="1px solid black">
				<tr>
					<th colspan="2">게시글 확인</td>
				</tr>
				<tr>
					<th class="category">번호</th>
					<td class="content">
						<input type="text" name="artID" id="artID" value="<%=artID%>" 
						style="border:none; font-size: 15px;" readonly>
					</td>
				</tr>
				<tr>
					<th class="category">제목</th>
					<td class="content">
						<%=title%>
					</td>
				</tr>
				<tr>
					<th class="category">일자</th>
					<td class="content">
						<%=strDate%>
					</td>
				</tr>
		
				<tr>
					<th class="category">내용</th>
					<td class="content">
						<%=article%>
					</td>
				</tr>
			</table>
			<button class="btn" id="back"><a href="./main.jsp">목록으로</a></button>
			<input type="submit" class="btn" id="modify" value="수정" formaction="./modify01.jsp">
		</form>
		
	</div>

</body>
</html>