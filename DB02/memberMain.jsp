<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<title>투표 - 후보 등록</title>
<link rel="stylesheet" type="text/css" href="navigation.css">
<style>
	table {
		text-align: center;
	}
	.title-num, .title-name {
		background-color: #faf1e6;
		color: #064420;
		padding: 5px 7px;
	}

	#number {
		width: 250px;
	}

	.inputBox {
		padding: 5px;
		width: 170px;
	}

	.input {
		padding: 5px 20px;
		margin-right: -10px;
		border: 2px solid #064420;
		border-radius: 7px;
		background-color: #064420;
		color: #fdfaf6;
		font-weight: bold;
		cursor: pointer;
	}

	.delete {
		padding: 0;
		margin-right: -10px;
		border: none;
		font-weight: bold;
		cursor: pointer;
	}

	.input:hover {
		background-color: #e4efe7;
		color: #064420;
	}

	.delete a {
		display: inline-block;
		padding: 5px 20px;
		text-decoration: none;
		cursor: unset;
		color: black;
		border: 2px solid #064420;
		border-radius: 7px;
		background-color: #064420;
		color: #fdfaf6;
	}

	.delete a:hover {
		background-color: #e4efe7;
		color: #064420;
	}
</style>
</head>
<%
	int newNum = 0;
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
		String id = "root";
		String pw = "0112";
		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //stament 선언
			
			String queryT;
		%>

			<h1 id="header">후보 등록</h1>
			<hr>
			<div id="content-wrap">
				<table>

			<%
			queryT = "select max(kNum) from hubotable;";
			ResultSet rs = stmt.executeQuery(queryT);
			int max = 0;
			while (rs.next()) {
				max = rs.getInt(1);
			}
			newNum = max + 1;

			queryT = "select * from hubotable;";
			rs = stmt.executeQuery(queryT);
			while (rs.next()) {
				out.println("<tr class='line'>" 
				+ "<th class='title-num'>기호</th>" 
				+ "<td name='kNum'>" + rs.getInt(1) + "</td>" 
				+ "<th class='title-name'>후보명</th>" 
				+ "<td name='name'>" + rs.getString(2) + "</td>" 
				+ "<td><button class='delete'>"
				+ "<a href='./member02.jsp?kNum=" + rs.getInt(1) + "&name=" + rs.getString(2) + "'>"
				+ "삭제</a></button></td>" 
				+ "</tr>");
				if (rs.getString(2).equals("")) break;					
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
					<tr>
						<form method='post'>
							<th class='title-num'>기호</th>
							<td id="number"><%=newNum%></td>
							<th class='title-name'>후보명</th>
							<td><input type="text" id="name" name="name" maxlength="20"
								class="inputBox" placeholder="이름 입력"></td>
							<td><input type='submit' id="submit" class='input' 
								value="등록" formaction='member01.jsp'></td>
						</form>
					</tr>
				</table>
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