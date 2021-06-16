<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*,  
	java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" type="text/css" href="board.css">
<style>
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
	
	#date:focus {
		outline: none;
	}
	
	#input_title {
		width: 700px;
	}
	
	#article {
		width: 700px;
		height: 500px;
		resize: none;
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
	
		article = article.replaceAll("`","'");

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
					<th colspan="2">글쓰기</td>
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
						<input type="text" name="title" id="input_title" value="<%=title%>">
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
						<textarea id="article" name="article"><%=article%></textarea>
					</td>
				</tr>
			</table>
			<button class="btn" id="delete"><a href="./oneView.jsp?artID=<%=artID%>">취소</a></button>
			<input type="submit" class="btn" id="modify" value="수정" formaction="./modify02.jsp">
			<input type="submit" class="btn" id="delete" value="삭제" formaction="./delete.jsp">
			
			
		</form>
	</div>

</body>
</html>