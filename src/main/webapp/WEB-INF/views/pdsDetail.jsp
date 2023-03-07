<%@page import="mul.cam.a.dto.PdsDto"%>
<%@page import="mul.cam.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
MemberDto login = (MemberDto)session.getAttribute("login");

PdsDto pds = (PdsDto)request.getAttribute("pdsDto");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<!-- boorstrap -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<title>PDS Detail</title>

<style type="text/css">
th{
	background-color: #17a2b8;
	color: white;
}
pre{
	white-space: pre-wrap;
	word-break:break-all;
	overflow: auto;
}
</style>

</head>

<body>

<h2 style="margin-left: 20px; margin-top: 20px">자료 상세보기</h2>
<hr>

<div id="app" class="container">
	<table class="table table-striped">
		<colgroup>
			<col width="130">
			<col width="500">
		</colgroup>
		<tr>
			<th>작성자</th>
			<td><%=pds.getId() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=pds.getReadcount() %></td>
		</tr>
		<tr>
			<th>다운수</th>
			<td><%=pds.getDowncount() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=pds.getTitle() %></td>
		</tr>
		<tr>
			<th>파일</th>
			<td>
				<%=pds.getFilename() %>&ensp;
				<input type="button" value="다운로드" class="btn btn-info" onclick="fileDownload(<%=pds.getSeq() %>, '<%=pds.getNewfilename() %>', '<%=pds.getFilename() %>')">
			</td>
		</tr>
		<tr>
			<td colspan="2" style="background-color: white;">
				<pre style="font-size: 18px; font-family: 고딕, arial; background-color: white"><%=pds.getContent() %></pre>
			</td>
		</tr>
	</table>
	<br><br>
	
	<% 
	if(login.getId().equals(pds.getId())) {
		%>
		<button class="btn btn-info" type="button" onclick="location.href='updatePds.do?seq=<%=pds.getSeq() %>'">수정</button>
		<button class="btn btn-info" type="button" onclick="deletePds(<%=pds.getSeq() %>)">삭제</button>
		<%
	}
	%>
	<button class="btn btn-info" type="button" onclick="location.href='pdslist.do'">자료목록</button>
</div>

<form name="filedown" action="filedownload.do" method="post">
	<input type="hidden" name="newfilename">
	<input type="hidden" name="filename">
	<input type="hidden" name="seq">
</form>

<script type="text/javascript">
function deletePds( seq ) {
	if (confirm("정말 삭제하시겠습니까?") == true){
		location.href = "deletePdsAf.do?seq=" + seq;
	 }
}

function fileDownload(seq, newfilename, filename) {
	document.filedown.newfilename.value = newfilename;
	document.filedown.filename.value = filename;
	document.filedown.seq.value = seq;
	document.filedown.submit();
	
	setTimeout(replay, 100);	// 0.1초 뒤에 새로고침(reload)
}
function replay() {
	location.reload();
}
</script>

</body>

</html>