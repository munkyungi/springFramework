<%@page import="mul.cam.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDto login = (MemberDto)session.getAttribute("login");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>PDS Write</title>
</head>

<body>

<h1 style="margin-left: 20px; margin-top: 20px">자료 업로드</h1>
<hr>

<div align="center">
<form action="pdsUpload.do" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>
				<%=login.getId() %>
				<input type="hidden" name="id" value="<%=login.getId() %>">
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" size="50">
			</td>
		</tr>
		<tr>
			<th>파일업로드</th>
			<td>
				<input type="file" name="fileload">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="10" cols="50" name="content"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="업로드">
			</td>
		</tr>
	</table>
</form>
</div>


</body>

</html>