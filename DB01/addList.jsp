<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB Page</title>
	<style>
		table {
			border-collapse: collapse;
			border: 1px solid black;
			text-align: center;
		}
	</style>
</head>
<body>
    <div>
        <h3> 성적 입력 하기 </h3>
    </div>
    <div id="box">
		<form action="showInsert.jsp" method="post">
			<input type="submit" value="추가" id="submit">
			<table border="1px solid black">
				<tr>
					<th class="title">이름</th>
					<td>
						<input type="text" class="inputbox"maxlength="5">
					</td>
				</tr>
				<tr>
					<th class="title">학번</th>
					<td>자동 부여</td>
				</tr>
				<tr>
					<th class="title">국어</th>
					<td>
						<input type="number" class="inputbox" placeholder="0~100" max="100" min="0">
					</td>
				</tr>
				<tr>
					<th class="title">영어</th>
					<td>
						<input type="number" class="inputbox" placeholder="0~100" max="100" min="0">
					</td>
				</tr>
				<tr>
					<th class="title">수학</th>
					<td>
						<input type="number" class="inputbox" placeholder="0~100" max="100" min="0">
					</td>
				</tr>
			</table>
        </form>
    </div>
</body>
</html>
