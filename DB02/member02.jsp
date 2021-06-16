<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>투표 - 후보 삭제 확인</title>
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
		name = request.getParameter("name");
		kNum = request.getParameter("kNum");
		String id = "root";
		String pw = "0112";
		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //stament 선언
			
			String queryT;
		%>

			<h1 id="header">후보 삭제 확인</h1>
			<hr>
			<div id="content-wrap">
		<%
			queryT = "delete from votetable where kNum=" + kNum + ";"; // 투표데이터 삭제
			stmt.execute(queryT);
			
			queryT = "delete from hubotable where kNum =" + kNum + ";"; //후보데이터 삭제
			stmt.execute(queryT);
			
			out.println("<div>"+ name +"님의 이름이 후보 명단에서 삭제되었습니다</div>");
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			out.println(err);
			if (err.contains("Duplicate")){
				out.println("<div><b>중복된 입력 입니다</b></div>");
				return;
			}
		} finally {
			
		}
		%>
			</div>
		</section>
	</div>

</body>
</html>