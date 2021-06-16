<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.text.ArrayList, 
	java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인</title>
<style>
	body {
		display: flex;
		justify-content: center;
		text-align: center;
	}
	
	#content-wrap {
		display: flex;
		flex-direction: column;
		justify-content: center;
		items-align: center;
	}
	
	#title {
		width: 500px;
	}
	
	.btn {
		cursor: pointer;
		margin-top: 10px;
		width: 100px;
		height: 30px;
		padding: 5px 10px;
		border-radius: 5px;
		border: 1px solid black;
		margin-left: auto;
		margin-right: 2px;
	}

	table {
		width: 900px;
		border-collapse: collapse;
		border: 2px solid black;
	}
	
	tr {
		border-bottom: 2px solid black;
	}
</style>
</head>
<body>
	<div id="content-wrap">
		<form method="post">
			<table border="1px solid black">
				<tr>
					<th colspan="2">글쓰기</td>
				</tr>
				<tr>
					<th>번호</th>
					<td>신규</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="input-title" placeholder="제목을 입력해주세요"></td>
				</tr>
				<tr>
					<th>일자</th>
					<td>
					<% 
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					//out.println(sdf.format(date.getTime()));
					%>
					</td>
				</tr>
				<tr>
				
				</tr>
			</table>
			<button class="btn" onclick="history.back()">취소</button>
			<input type="submit" class="btn" onclick="">쓰기</button>
		</form>
	</div>

</body>
</html>