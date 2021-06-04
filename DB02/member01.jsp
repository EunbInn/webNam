<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
			ResultSet rs = null;
			String queryT;
		%>

			<h1 id="header">후보 등록 확인</h1>
			<hr>
			<div id="content-wrap">
			<%
			queryT = "select max(kNum) from hubotable;";
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
	<script>
		function getFilter(name) {
			var filter = /^[가-힣\s]+$/;
			var filter2 = /^[a-zA-Z\s]+$/;
			if (filter.test(name) || filter2.test(name)) {
				return true;
			} else {
				return false;
			}
		}
		$(function() {
			$('#submit').click(function() {
				var name = $('#name').val();
				var kNum = $('#kNum').val();

				if (kNum == "") {
					alert('기호 입력란을 확인해주세요');
					return false;
				}
				
				if (!getFilter(name) || name.length > 20 || name == "") {
					alert('이름 형식이 잘못되었습니다.');
					return false;
				} 

				if (getFilter(name) && name != "" &&
					kNum != ""){
					return true;

				}
			});
		
		})
			
		
	</script>
</body>
</html>