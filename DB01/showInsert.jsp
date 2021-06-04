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
			border: 1px solid black;
			text-align: center;
			width: 350px;
		}
		
		.title {
			padding: 5px 10px;
		}
		
		#box {
			display: inline-block;
			text-align: center;
		}
		
		#back {
			margin-bottom: 10px;
			margin-left: 277px;
		}
	</style>

</head>
	<%
	String name = "";
	String kor = "";
	String eng = "";
	String mat = "";
	String newID = "";
	%>
<body>

	<div id="box">
        <h3> 성적 입력 확인 </h3>
		
		<button id="back" onclick="history.back()">뒤로 가기</button>
		<table border="1px solid black">
	<%
	request.setCharacterEncoding("UTF-8");
	name = request.getParameter("name");
	kor = request.getParameter("kor");
	eng = request.getParameter("eng");
	mat = request.getParameter("mat");
	
	if (name.equals("") || kor.equals("") || eng.equals("") || mat.equals("")) {
	 out.println("<div>입력값이 존재하지 않습니다</div>");
	 return;
	}
	
	Connection con;
	Statement stmt;
	String id = "root";
	String pw = "0112";
	try {		
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		stmt = con.createStatement(); 
		
		
		String queryT = "select max(studentID) from examtableJSP;";
		ResultSet rs = stmt.executeQuery(queryT);
		int maxID = 0;
		while (rs.next()) {
			maxID = rs.getInt(1);
		}
		
		if (maxID == 0) {
			maxID = 20210000;
		}
		
		newID = String.format("%d", maxID + 1);
		stmt.execute(queryT);
		
		queryT = String.format("insert into examtableJSP values('%s', %s, %s, %s, %s);",
								name, newID, kor, eng, mat);

		stmt.execute(queryT);
		rs.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		if (err.contains("doesn't exist")){
			out.println("<div><b>조회할 데이터 테이블이 존재하지 않습니다</b></div>");
			return;
		}
	} finally {

	}
	%>
	
	
			<tr>
				<th class="title">이름</th>
				<td> <%=name%> </td>
			</tr>
			<tr>
				<th class="title">학번</th>
				<td> <%=newID%> </td>
			</tr>
			<tr>
				<th class="title">국어</th>
				<td> <%=kor%> </td>
			</tr>
			<tr>
				<th class="title">영어</th>
				<td> <%=eng%> </td>
			</tr>
			<tr>
				<th class="title">수학</th>
				<td> <%=mat%> </td>
			</tr>
		</table>   
    </div>
	
	
</body>
</html>