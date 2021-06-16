<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 업로드</title>
<link rel="stylesheet" type="text/css" href="board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	table {
		width: 850px;
		border-collapse: collapse;
		border: 2px solid black;
	}
	
	.category {
		width: 150px;
	}
	
	.content {
		text-align: left;
		padding:8px;
	}
	
	tr {
		border-bottom: 2px solid black;
	}
	
	#date:focus {
		outline: none;
	}
	
	#input_title {
		width: 700px;
	}
	
	#article {
		width: 700px;
		height: 500px;
		resize: none;
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
					<th class="category">번호</th>
					<td class="content">신규</td>
				</tr>
				<tr>
					<th class="category">제목</th>
					<td class="content">
						<input type="text" name="title" id="input_title" placeholder="제목을 입력해주세요">
					</td>
				</tr>
				<tr>
					<th class="category">일자</th>
					<td class="content">
						<% 
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						
						out.println(sdf.format(date.getTime()));
						%>
					</td>
				</tr>
		
				<tr>
					<th class="category">내용</th>
					<td class="content">
						<textarea name="article" id="article" placeholder="내용을 입력해주세요"></textarea>
					</td>
				</tr>
			</table>
			<button class="btn" id="back"><a href="./main.jsp">취소</a></button>
			<input type="submit" id="submit" class="btn" formaction="./write02.jsp" value="쓰기">
		</form>
	</div>
	
	<script>
		$(function() {
			$('#submit').click(function() {
				var title = $('#input_title').val();
				var article = $('#article').val();
				
				if ($.trim(title) == "") {
					alert('제목을 입력해주세요');
					return false;
				}
				
				if ($.trim(article) == "") {
					alert('내용을 입력해주세요');
					return false;
				}
				
				if ($.trim(title) != "" && $.trim(article) != "") {
					return true;
				}
			})
		})
	</script>

</body>
</html>