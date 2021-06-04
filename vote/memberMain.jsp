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
		
		String queryT;
	%>
	<>
		<h1>후보 등록</h1>
        <hr>
		<table>

		<%

			queryT = "select * from hubotable;";
			ResultSet rs = stmt.executeQuery(queryT);
				
			while (rs.next()) {
				out.println("<form method="post"><tr>" 
				+ "<td><a href='oneview.jsp?stu_id=" + rs.getInt(2) + "&name=" + rs.getString(1) + "' target='right'>" + rs.getString(1) + "</a></td>"
				+ "<td class="title-num">기호</td>" 
				+ "<td name="kNum">" + rs.getInt(1) + "</td>" 
				+ "<td class="title-name">후보명</td>" 
                + "<td name="name">" + rs.getString(2) + "</td>" 
                + "<td><input type="submit" class="delete" formaction="afterDelete.jsp"></td>" 
				+ "</tr></form>");
                out.println(rs.getInt(1));
                if (rs.getInt(1) == 0) {
                    out.println("<td colspan="3">등록된 후보가 없습니다</td>>");
                    break;
                }
			}
            
				
			
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
		
		</table>
	</center>
</body>
</html>