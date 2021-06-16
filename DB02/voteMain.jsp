<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
<title>투표 하기</title>
<link rel="stylesheet" type="text/css" href="navigation.css">
<style>
	
	.selectBox {
		width: 200px;
		height: 30px;
		margin: 10px;
		border: 1px solid gray;
	}

	.input {
		padding: 5px 20px;
		margin-left: 10px;
		border: 2px solid #064420;
		border-radius: 7px;
		background-color: #064420;
		color: #fdfaf6;
		font-weight: bold;
		cursor: pointer;
	}
	
	.input:hover {
		background-color: #e4efe7;
		color: #064420;
	}


</style>
</head>
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
		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //stament 선언
			ResultSet rs = null;
			String queryT;
		%>

			<h1 id="header">투표하기</h1>
			<hr>
			<div id="content-wrap">
				<form method="post">
					<!--셀렉트박스 인자 값 기호&이름 /디폴트타입 빈칸 :none-->
					<select name="kNumName" id="kNumName" class="selectBox">
						<option value='none' selected>후보 선택</option> 

			<%
				queryT = "select * from hubotable;";
				rs = stmt.executeQuery(queryT);
				
				int kNum = 0;
				String name = "";
				while (rs.next()) {
					kNum = rs.getInt(1);
					name = rs.getString(2);
					out.println(
					"<option value='" + kNum + "번" + name+ "'>" 
					+ kNum + "번 " + name 
					+ "</option>" 
					);
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
					</select>
					<!--셀렉트박스 인자 값 연령대 /디폴트타입 빈칸 :none-->
					<select name="age" id="age" class="selectBox">
						<option value="none" selected>연령대 선택</option>
						<option value="10">10대</option>
						<option value="20">20대</option>
						<option value="30">30대</option>
						<option value="40">40대</option>
						<option value="50">50대</option>
						<option value="60">60대</option>
						<option value="70">70대</option>
						<option value="80">80대</option>
						<option value="90">90대</option>
					</select>
					
					<input type='submit' id="submit" class='input' value="투표" formaction='vote01.jsp'>
				</form>
			</div>

		</section>
	</div>
	<script>
		/*submit을 보냈을 때, 빈칸일 시 alert 보내기*/
		$(function() {
			$('#submit').click(function() {
				var age = $('#age').val();
				var kNumName = $('#kNumName').val();

				if (kNumName == "none") {
					alert('후보를 선택해주세요');
					return false;
				}
				
				if (age == "none") {
					alert('본인의 연령대를 선택해주세요');
					return false;
				} 

				if (kNumName != "none" && age != "none"){
					return true;

				}
			});
		
		
		})
		
	</script>
</body>
</html>