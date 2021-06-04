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
		border-collapse: collpase;
		text-align: center;
	}
	
	#title {
		background-color: #FFCC66;
	}
</style>
</head>
<body>
	<%
	String id = "root";
	String pw = "0112";
	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		Statement stmt = con.createStatement(); //stament 선언
		ResultSet rs;
		String queryT;
	%>
	<center>
		<table border="1px black solid">
			<tr id="title">
				<th>이름</th>
				<th>학번</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
			</tr>
		<%
			try {
				queryT = "select * from examtableJSP;";
				rs = stmt.executeQuery(queryT);
				
				while (rs.next()) {
		%>
				<tr>
					<td><a href="onview.jsp?id=<%=rs.getInt(2)%>" target="right"><%=rs.getStirng(1)%>></td>
					<td><%=rs.getInt(2)%></td>
					<td><%=rs.getInt(3)%></td>
					<td><%=rs.getInt(4)%></td>
					<td><%=rs.getInt(5)%></td>
				</tr>
		
		<%
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
	</center>
</body>
</html>