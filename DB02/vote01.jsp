<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	
<title>투표 - 투표 내역 확인</title>
<link rel="stylesheet" type="text/css" href="navigation.css">
</head>
<%
	String age = "";
	String kNumName = "";
	String kNum = "";
	String name = "";
%>
<body>
	<div id="box">
		<div id="nav-box">
			<nav class="gnb">
				<ul class="nav-container">
					<li class="nav-item"><a href="./index.html">투표 페이지</a></li>
					<li class="nav-item"><a href="./memberMain.jsp">후보등록</a></li>
					<li class="nav-item checked"><a href="./voteMain.jsp">투표</a></li>
					<li class="nav-item"><a href="./showResult.jsp">개표결과</a></li>
				</ul>
			</nav>
		</div>
		<section>
    
		<%
		String id = "root";
		String pw = "0112";
		request.setCharacterEncoding("UTF-8");
		age = request.getParameter("age");
		kNumName = request.getParameter("kNumName");
		kNum = kNumName.split("번")[0];
		name = kNumName.split("번")[1];
		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //stament 선언
			
			String queryT;
		%>

			<h1 id="header">투표 내역 확인</h1>
			<hr>
			<div id="content-wrap">
				
			<%
			queryT = String.format("insert into votetable values(%s, %s);", kNum, age);
			stmt.execute(queryT);
			
			out.println("<div>기호 "+ kNum + "번 " + name +" 후보에게 정상 투표되었습니다</div>");
				
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