<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
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
		
		.inputbox {
			border: 1px solid;
			width: 200px;
			height: 15px;
			
		}
		
		#box {
			display: inline-block;
			text-align: center;
		}
		
		#submit {
			margin-bottom: 10px;
			margin-left: 10px;
		}
		
		#modify,
		#delete {
			margin-top: 10px;
		}
		
		#modify {
			margin-left: 120px;
		}
		
		#delete {
			margin-left: 10px;
		}
		
		#reset {
			margin-left: 30px;
			color: red;
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
	request.setCharacterEncoding("UTF-8");
	stuID = request.getParameter("stuID");
	Connection con;
	Statement stmt;
	String id = "root";
	String pw = "0112";
	try {		
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://192.168.23.34:3306/kopoctc", id, pw);
		stmt = con.createStatement(); 
		
		if (stuID.equals("")) stuID = "0"; //학번 공란으로 넘길 시 처리
		
		String queryT = String.format("select * from examtableJSP where studentID = %s;", stuID);
		ResultSet rs = stmt.executeQuery(queryT);
		while (rs.next()) {
			name = rs.getString(1);
			kor = rs.getString(3);
			eng = rs.getString(4);
			mat = rs.getString(5);	
		}
		
		if (name.equals("")) { //찾는 값이 존재하지 않을 경우 데이터 찾아지지 않으니 처리
			name = "해당 학번 존재하지 않음";
			stuID = "";
			
			
		} else {
			
		}
	
		rs.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		String err = e.getMessage();
		if (err.contains("doesn't exist")){
			name = "조회할 데이터 테이블이 존재하지 않습니다";
			stuID = "";
		}
	} finally {

	}
	%>    
    	
	<div id="box">
        <h3> 성적 조회 / 수정 </h3>
		<form action="./showModify.jsp" method="post">
			<span>조회할 학번</span>
			<input type="number" id="stuID" name="stuID" max="99999999">
			<input type="submit" value="조회" id="submit">
		</form>
		
		<form method="post">
			<table border="1px solid black">
				<tr>
					<th class="title">이름</th>
					<td>
						<input type="text" name="name" id="name" class="inputbox" 
						value="<%=name%>" maxlength="20">
					</td>
				</tr>
				<tr>
					<th class="title">학번</th>
					<td>
						<input type="number" id="stu_id" name="stu_id" value="<%=stuID%>" class="inputbox" readonly="true" />
					</td>
				</tr>
				<tr>
					<th class="title">국어</th>
					<td>
						<input type="number" id="kor" name="kor" class="inputbox" 
						value="<%=kor%>" max="100" min="0">
					</td>
				</tr>
				<tr>
					<th class="title">영어</th>
					<td>
						<input type="number" id="eng" name="eng" class="inputbox" 
						value="<%=eng%>" max="100" min="0">
					</td>
				</tr>
				<tr>
					<th class="title">수학</th>
					<td>
						<input type="number" id="eng" name="mat" class="inputbox" 
						value="<%=mat%>" max="100" min="0">
					</td>
				</tr>
			</table>
			
			<% 
			if(name.equals("해당 학번 존재하지 않음")){
				
			} else {
				out.println("<input type='submit' value='수정' id='modify' formaction='./showAfterModify.jsp'>");
				out.println("<input type='submit' value='삭제' id='delete' formaction='./showAfterDelete.jsp'>");
				out.println("<input type='reset' value='입력 초기화' id='reset'>");
			}
			%>
		</form>	
        
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
			$('#modify').click(function() {
				var name = $('#name').val();
				var kor = $('#kor').val();
				var eng = $('#eng').val();
				var mat = $('#mat').val();

				if (name == "해당 학번 존재하지 않음") {
					alert('수정/삭제할 학번을 우선 입력해주세요');
					return false;
				}
				if (!getFilter(name) || name.length > 20 || name == "") {
					alert('이름 형식이 잘못되었습니다.');
					return false;
				} 

				if (kor == "") {
					alert('국어 성적란을 확인해주세요');
					return false;
				}
				
				if (eng == "") {
					alert('영어 성적란을 확인해주세요');
					return false;
				}
				
				if (mat == "") {
					alert('수학 성적란을 확인해주세요');
					return false;
				}

				if (getFilter(name) && name != "" &&
					kor != "" && eng != "" && mat != ""){
				
					return true;

				}
				
				
			});
			$('#delete').click(function() {
				let name = $("#name").val();
				if (name == "해당 학번 존재하지 않음") {
					alert('수정/삭제할 학번을 우선 입력해주세요');
					return false;
				} else {

					return true;
				}
			});
		})
			
		
	</script>
</body>


</html>