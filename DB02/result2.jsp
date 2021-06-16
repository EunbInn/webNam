<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>투표 - 개표 확인</title>
	<link rel="stylesheet" type="text/css" href="navigation.css">
	<style>
		#name {
			width: 140px;
			background-color: #faf1e6;
			padding: 5px 2px 5px 15px;
			color: #064420;
			text-align: left;
		}

		img {
			margin-top: 4px;
		}

		#back {
			margin-top: 10px;
			width: 95px;
			height: 35px;
			padding: 5px 15px;
			border: 2px solid #064420;
			border-radius: 7px;
			background-color: #064420;
			color: #fdfaf6;
			font-weight: bold;
			cursor: pointer;
		}

		#back:hover {
			background-color: #e4efe7;
			color: #064420;
		}
	</style>
</head>
<% // 전역변수 선언
	String kNum = ""; //기호
	String name = ""; // 이름
	int[] age = {10, 20, 30, 40, 50, 60, 70, 80, 90}; //연령은 default 이므로 배열로 선언
	int vCnt = 0; //득표수
	double vPer = 0; //특표율
%>
<body>
	<div id="box">
		<div id="nav-box">
			<nav class="gnb">
				<ul class="nav-container">
					<li class="nav-item"><a href="./index.html">투표 페이지</a></li>
					<li class="nav-item"><a href="./memberMain.jsp">후보등록</a></li>
					<li class="nav-item"><a href="./voteMain.jsp">투표</a></li>
					<li class="nav-item checked"><a href="./showResult.jsp">개표결과</a></li>
				</ul>
			</nav>
		</div>
		<section>

		<%
		kNum = request.getParameter("kNum");
		name = request.getParameter("name");
		String id = "root";
		String pw = "0112";

		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //statement 선언
			ResultSet rs = null;
			String queryT;
		%>

			<h1 id="header"><%=name%>
				후보 득표 현황
			</h1>
			<hr>
			<div id="content-wrap">
				<div id="wrap">
					<table>
			<%
			for (int i = 0; i < age.length; i++) {
				out.println("<tr>" + 
								"<th id='name'>" + age[i] +" 대</th>");
				queryT = "select count(age) as vCnt ,(count(age)/(select count(*) from votetable where kNum = " + kNum + "))*100"
						+ " from votetable where kNum = " + kNum + " and age = " + age[i] + " group by age;";
				rs = stmt.executeQuery(queryT);
				String getEmpty = "";
				while (rs.next()) {
					vCnt = rs.getInt(1);
					vPer = rs.getDouble(2);
					getEmpty = rs.getString(1);
					out.println("<td>" 
							+ "<img src='./line.PNG' style='width:" + (vPer * 5) + "px; height:17px' alt=''>&nbsp" 
							+ vCnt + " (" + String.format("%.1f",vPer) + "%)" + "</td>"
							+ "</tr>");
				}
				
				if (getEmpty.equals("")) {
					vCnt = 0;
					vPer = 0;
					out.println("<td>" 
						+ "<img src='./line.PNG' style='width:0px; height:80%' alt=''>&nbsp"
						+ vCnt + " (" + String.format("%.1f",vPer) + "%)" + "</td>"
						+ "</tr>");
				}
			}				
				rs.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				String err = e.getMessage();
				out.println(err);
				if (err.contains("doesn't exist")){
					out.println("<div><b>조회할 데이터 테이블이 존재하지 않습니다</b></div>");
					return;
				}
			} finally {
				
			}
			%>
					</table>
				</div>
				<button id="back" onclick="history.back()">뒤로 가기</button>
			</div>

		</section>
	</div>

</body>
</html>