<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인</title>
<style>
	#content-wrap {
		display: flex;
		flex-direction: column;
		justify-content: center;
		items-align: center;
	}
	
	#btn {
		width: 100px;
		height: 30px;
		padding: 5px 10px;
		border-radius: 5px;
		border: 1px solid black;
	}

	table {
		width: 900px;
		border-collapse: collapse;
		border: 2px solid black;
	}
</style>
</head>
<body>
	<div id="content-wrap">
		<table border="1px solid black">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성 일자</th>
			</tr>
			<% 
				
			%>
		</table>
		<button id="btn" onclick="location.href='./write.jsp'">글쓰기</button>
	</div>

</body>
</html>