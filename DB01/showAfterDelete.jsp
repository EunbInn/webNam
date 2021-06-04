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
	
	a:hover {
		text-decoration: underline;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	#back {
		margin-top: 10px;
		padding: 5px 10px;
	}
</style>
</head>
<%
	String name = "";
	String kor = "";
	String eng = "";
	String mat = "";
	String stuID = "";
%>
<body>
	<%
	String id = "root";
	String pw = "0112";
	request.setCharacterEncoding("UTF-8");
	name = request.getParameter("name");
	stuID = request.getParameter("stu_id");
	kor = request.getParameter("kor");
	eng = request.getParameter("eng");
	mat = request.getParameter("mat");
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement(); //stament 선언
		
		String queryT;
	%>
	<center>
		<h1>성적 수정 확인</h1>
		<table border="1px solid">
			<tr id="title">
				<th>이름</th>
				<th>학번</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
			</tr>
		<%
			
			int iStuID = Integer.parseInt(stuID);

			queryT = "delete from examtableJSP where studentID = " +iStuID + ";";
			
			stmt.execute(queryT);
			
			queryT = "select * from examtableJSP;";
			ResultSet rs = stmt.executeQuery(queryT);
				
			while (rs.next()) {
				out.println("<tr>" 
				+ "<td><a href='oneview.jsp?stu_id=" + rs.getInt(2) + "&name=" + rs.getString(1) + "' target='right'>" + rs.getString(1) + "</a></td>"
				+ "<td>" + rs.getInt(2) + "</td>" 
				+ "<td>" + rs.getInt(3) + "</td>" 
				+ "<td>" + rs.getInt(4) + "</td>" 
				+ "<td>" + rs.getInt(5) + "</td>" 
				+ "</tr>");
				
				
			}
			
			out.println("<div><b>" + stuID + "학번의 성적 데이터가 정상 삭제되었습니다</b></div><br>");
				
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			out.println(err);
			out.println("<br>ERROR : 조회할 데이터가 존재하지 않습니다");
		} finally {
			
		}
		%>
		</table>
		<button id="back" onclick="location.href='./modifyData.html'">뒤로 가기</button>
	</center>
</body>
</html>