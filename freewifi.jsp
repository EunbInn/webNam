<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- file reader, buffered reader 클래스 import -->
<%@ page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.lang.Math" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script></script>
<style>
	#wifibox {
		width: 900px;
		text-align: center;
	}
	
	#title {
		background-color: #CCCCFF;
	}
	
	a {
		text-decoration: none;
		color: #333333;
	}
	
	a:hover {
		text-decoration: underline;
		color: red;
	}
	
	#page {
		margin-top: 7px;
		margin-bottom: 7px;
		font-weight: bold;
		color: gray;
		text-align: left;
	}
	
	#box {
		display: inline-block;
	}
	
	table {
		border-collapse: collapse;
		border: solid 1px black;
	}
</style>
</head>
	<%int fromPT = 0;
	  int cntPT = 10; 
	  int totalCnt = 0;
	  int nowPage = 0;
	  %>
<body>
	<a href="http://192.168.23.34:8080/freewifi.jsp?from=<%= fromPT%>&cnt=<%=cntPT%>"></a>
	<center>
		<div id="box">
		<!--제목 및 테이블 첫줄 출력-->
			<h2>전국 무료 와이파이 표준 데이터</h2>
			<table id="wifibox" border="1px solid">
				<tr id="title">
					<th>번호</th>
					<th>주소</th> 
					<th>위도</th>
					<th>경도</th>
					<th>거리</th>
				</tr>
				<%				
				try {
					//총 데이터 값을 주기 위해 파일 한 번 미리 읽음,,
					String file = application.getRealPath("./freewifi.txt");
					BufferedReader br = new BufferedReader(new FileReader(file));
					String line;
					int total = -1; // 첫줄 안 읽는 대신 변수 -1로 초기화
					while ((line = br.readLine()) != null) {
						total++;
					}
					//총 카운트
					totalCnt = total;
					
					//리스트 번호 카운트
					int cnt = 0;
					
					//overflow, nullpoint, number format 예외처리를 위한 try,catch문
					try { 
						fromPT = Integer.parseInt(request.getParameter("from"));
						cntPT = Integer.parseInt(request.getParameter("cnt"));
					} catch (NumberFormatException e) {
						fromPT = 1;
						cntPT = 10;
					} catch (Exception e) {
						fromPT = 1;
						cntPT = 10;
					}
					
					//integer값 범위 내에서 0보다 작으면 1로, 마지막 수보다 크면
					if (fromPT <= 0) {
						fromPT = 1;
					} else if (fromPT > totalCnt) {
						fromPT = 1 + totalCnt - (totalCnt % cntPT);
					}

					if (cntPT <= 0) {
						cntPT = 10;
					}
					
					double lat = 37.651046682507; //우리 집 위도 더블 변수에 저장
					double lng = 127.32063430997; //우리 집 경도 더블 변수에 저장
					br = new BufferedReader(new FileReader(file));
					if ((line = br.readLine()) == null) {
						return;
					}
					while ((line = br.readLine()) != null) {
						cnt++;
						if (cnt < fromPT) continue;
						if (cnt >= fromPT + cntPT) continue;
						String[] field = line.split("\t");
						if (field[12].equals("")) field[12] = "0.0";
						if (field[13].equals("")) field[13] = "0.0";
						double dist = Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat, 2) + Math.pow(Double.parseDouble(field[13])-lng, 2));
						if (field[12].equals("0.0")) dist = 0;
						

						out.println("<tr>\n" 
						+ "<td>" + cnt + "</td>\n" 
						+ "<td>" + field[9] + "</td>\n" 
						+ "<td>" + field[12] + "</td>\n"
						+ "<td>" + field[13] + "</td>\n" 
						+ "<td>" + dist + "</td>\n" 
						+ "</tr>");
					}
					br.close();
					
					

				} catch (IOException e) {

				}
				%>	
				</table>
				<%
				int firstReport = 1;
				int pageNumber = cntPT - 1; //from값 구해서 넣어주기 위해 카운트 -1 변수로 저장
				int maxPage = 10; //한 화면에 보여줄 페이지 수
				nowPage = (fromPT / cntPT) + ((fromPT / (double)cntPT)> (int)(fromPT / cntPT)? 1:0);	
				int endPage = (totalCnt/cntPT) + ((totalCnt/(double)cntPT) > (totalCnt/cntPT)? 1:0);
				int nowGroup = (nowPage/maxPage) + ((nowPage/(double)maxPage) > (nowPage/maxPage)? 1:0);
				int gEnd = nowGroup * maxPage; //페이지 그룹의 마지막페이지
				int gStart = (nowGroup * maxPage) - 9; //그룹의 첫페이지
				int nowview = (nowPage*cntPT) - (cntPT - 1); //현재페이지
				int nextview = fromPT + cntPT; //다음페이지
				int previous = fromPT - cntPT; //이전페이지
				int lastPage = (endPage-1)*cntPT + 1;
				
				//첫페이지보다 작아지거나 마지막페이지보다 커질 때 그룹넘버 체인지
				if (fromPT < (gStart * cntPT) - pageNumber) {
					gStart = (nowGroup - 1) * maxPage - 9;
					gEnd = (nowGroup - 1) * maxPage;
				} else if (fromPT > gEnd * cntPT) {
					gStart = (nowGroup + 1) * maxPage - 9;
					gEnd = (nowGroup + 1) * maxPage;
				}
				
				//이전페이지나 다음페이지를 누를때 첫줄보다 작아지거나 마지막줄보다 커지면 각 최소, 최댓값으로 지정
				if (previous <= firstReport) {
					previous = firstReport;
				} else if (nextview >= totalCnt) {
					nextview = (endPage-1)*cntPT + 1;
				}
				if (gEnd >= endPage) gEnd = endPage;
				if (gStart <= 1) {
					gStart = 1;
					gEnd = 10; 
				}
				
				%>
				<div id="page">page: <%=nowPage%></div>
				<a href="freewifi.jsp?from=<%=firstReport%>&cnt=<%=cntPT%>">[맨앞으로]</a>
				<a href="freewifi.jsp?from=<%= previous%>&cnt=<%=cntPT%>">&lt;&lt;</a>
				<%
				for (int i = gStart; i <= gEnd; i++) {
					%>
				<a href="freewifi.jsp?from=<%=((i*cntPT)-(cntPT-1)) %>&cnt=<%=cntPT%>">[<%= i %>]</a>
				<%
				}
				
				%>
				<a href="freewifi.jsp?from=<%=nextview%>&cnt=<%=cntPT%>">&gt;&gt;</a>
				<a href="freewifi.jsp?from=<%=lastPage%>&cnt=<%=cntPT%>">[맨뒤로]</a>
				
		</div>
	</center>
</body>
</html>