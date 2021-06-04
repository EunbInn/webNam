<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border-collapse: collapse;
		border: solid 1px black;
		width: 900px;
		text-align: center;
		font-size: 20px;
	}
	
	#title {
		background-color: #FFCC66;
	}
	
	#back {
		margin: 20px;
		width: 100px;
		padding:10px;
	}
</style>
</head>
<body>
	<center>
	<%
	String id = "root";
	String pw = "0112";
	String name = request.getParameter("name");
	
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement(); //stament 선언
		
		String queryT;
		out.println("<h1>[" + name + "]의 성적 조회</h1>");
		
	%>
	
		<div></div>
		<table border="1px solid">
			<tr id="title">
				<th>이름</th>
				<th>학번</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
			</tr>
		<%
			try {
				String getID = request.getParameter("stu_id");
				int stu_id = Integer.parseInt(getID);
				queryT = String.format("select * from examtableJSP where studentID = %d;", stu_id);
				ResultSet rs = stmt.executeQuery(queryT);
				
				while (rs.next()) {
					out.println("<tr>" 
					+ "<td>" + rs.getString(1) + "</td>"
					+ "<td>" + rs.getInt(2) + "</td>" 
					+ "<td>" + rs.getInt(3) + "</td>" 
					+ "<td>" + rs.getInt(4) + "</td>" 
					+ "<td>" + rs.getInt(5) + "</td>" 
					+ "</tr>");
		
				}
				
			} catch (Exception e){
				out.println("<br>ERROR : 조회할 데이터가 존재하지 않습니다");
			}
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			
		} finally {
			
		}
		%>
		</table>
		<button id="back" onclick="history.back()">뒤로 가기</button>
	</center>
</body>
</html>