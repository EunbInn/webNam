<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>투표 - 개표 확인</title>
<link rel="stylesheet" type="text/css" href="navigation.css">
<style>
	#name {
		width: 170px;
		background-color: #faf1e6;
		padding: 5px 7px;
		text-align: left;
	}

	#name a {
		color: #064420;
		text-decoration: none;
	}

	#name a:hover {
		color: blue;
		text-decoration: underline;
	}

	img {
		margin-top: 3px;
}
</style>
</head>
<%
	int vCnt = 0;
	double vPer = 0;
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
		String id = "root";
		String pw = "0112";

		try {	
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
			Statement stmt = con.createStatement(); //stament 선언
			ResultSet rs = null;
			String queryT;
		%>

			<h1 id="header">개표 결과</h1>
			<hr>
			<div id="content-wrap">
				<table>
			<%	
			ArrayList<Integer> kNumArr = new ArrayList<Integer>(); 
			ArrayList<String> nameArr = new ArrayList<String>();
			
			queryT = "select kNum, name from hubotable order by kNum;";	
			rs = stmt.executeQuery(queryT);	
			while (rs.next()) { // array에 우선 넣기
				kNumArr.add(rs.getInt(1));
				nameArr.add(rs.getString(2));
			}
			
			if (kNumArr.size() == 0) { //array size가 0이면 후보자가 없는 걸로 간주하고 리턴
				out.println("<tr><th>현재 등록된 후보자가 없습니다</th></tr>");
				rs.close();
				stmt.close();
				con.close();
				return;
			}
			
			int kNum = 0;
			String name= "";
			for (int i = 0; i < kNumArr.size(); i++) {
				kNum = kNumArr.get(i);
				name = nameArr.get(i);
				out.println("<tr>"
						+ "<th id='name'>" 
						+ "<a href='./result2.jsp?kNum=" + kNum + "&name=" + name + "'>"
						+ "기호 " + kNum + "번 " + name +"</th>");
				queryT = "select count(kNum) as vCnt ,(count(kNum)/(select count(*) from votetable as a))*100"
						+ " from votetable where kNum = " + kNum + " group by kNum;";
				rs = stmt.executeQuery(queryT);
				String getEmpty = ""; //쿼리 실행 시 받을 값이 없는 경우 분리
				while(rs.next()) {
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
							+ vCnt + " (" + String.format("%.1f",vPer) + "%)" + "</td>");
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
		</section>
	</div>

</body>
</html>