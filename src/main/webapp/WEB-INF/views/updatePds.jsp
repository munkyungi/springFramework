<%@page import="mul.cam.a.dto.PdsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
PdsDto pds = (PdsDto)request.getAttribute("pdsDto");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>PDS Update</title>
</head>

<body>

<h2 style="margin-left: 20px; margin-top: 20px">자료 수정하기</h2>
<hr>

<div align="center">
<form action="updatePdsAf.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="seq" value="<%=pds.getSeq() %>">
	<table border="1">
		<tr>
			<th>작성자</th>
			<td><%=pds.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=pds.getRegdate() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" size="50" value="<%=pds.getTitle() %>">
			</td>
		</tr>
		<tr>
			<th>파일명</th>
			<td>
				<%=pds.getFilename() %>
				<!-- 파일이 변경되지 않았을 경우를 위해 -->
				<input type="hidden" name="filename" value="<%=pds.getFilename() %>">
				<input type="hidden" name="newfilename" value="<%=pds.getNewfilename() %>">
			</td>
		</tr>
		<tr>
			<th>수정파일</th>
			<td>
				<input type="file" name="fileload">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="10" cols="50" name="content"><%=pds.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정하기">
				<button type="button" onclick="location.href='pdsDetail.do?seq=<%=pds.getSeq() %>'">수정취소</button>
			</td>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">

</script>

</body>

</html>