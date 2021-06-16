<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 - 후보 등록 확인</title>
<link rel="stylesheet" type="text/css" href="navigation.css">
<style>
</style>
</head>
<%
	String name = "";
	String kNum = "";
%>
<body>
	<div id="box">
		<!--gnu-->
		<div id="nav-box">
			<nav class="gnb">
				<ul class="nav-container">
					<li class="nav-item"><a href="./index.html">투표 페이지</a></li>
					<li class="nav-item checked"><a href="./memberMain.jsp">후보등록</a></li>
					<li class="nav-item"><a href="./voteMain.jsp">투표</a></li>
					<li class="nav-item"><a href="./showResult.jsp">개표결과</a></li>
				</ul>
			</nav>
		</div>
		<section>

		<%
		request.setCharacterEncoding("UTF-8");
		name = request.getParameter("name"); //후보명
		kNum = request.getParameter("kNum"); //기호
		String id = "root";
		String pw = "0112";
		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); 
			ResultSet rs = null;
			String queryT;
		%>

			<h1 id="header">후보 등록 확인</h1>
			<hr>
			<div id="content-wrap">
			<%
			queryT = "select max(kNum) from hubotable;"; //기호 자동생성을 위해 맥스 넘버를 미리 받아옴
			rs = stmt.executeQuery(queryT);
			
			int max = 0;
			while (rs.next()) {
				max = rs.getInt(1);
			}
			int newNum = max + 1;
			
			queryT = "insert into hubotable values(" + newNum + ",'" + name + "');";
			stmt.execute(queryT);
			
			out.println("<div>"+ name +"님의 후보 등록이 완료되었습니다</div>");

			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			out.println(err);
		} finally {
			
		}
		%>
			</div>
		</section>
	</div>

</body>
</html>