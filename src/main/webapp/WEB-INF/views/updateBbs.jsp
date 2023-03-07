<%@page import="mul.cam.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
BbsDto dto = (BbsDto)request.getAttribute("bbsDto");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<h1 style="margin-left: 20px; margin-top: 20px">수정하기</h1>

<div class="center">
	<form action="updateBbsAf.do" method="post">
		<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
		<table border="1" align="center">
			<col width="100">
			<col width="500">
			
			<tr>
				<th>작성자</th>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWdate() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" size="50" value="<%=dto.getTitle() %>">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" cols="50" name="content"><%=dto.getContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정하기">
					<button type="button" onclick="location.href='bbsDetail.do?seq=<%=dto.getSeq() %>'">수정취소</button>
				</td>
			</tr>
		</table>
		
	</form>
</div>

</body>

</html>