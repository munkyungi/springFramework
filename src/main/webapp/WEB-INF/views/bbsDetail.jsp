<%@page import="mul.cam.a.dto.BbsDto"%>
<%@page import="mul.cam.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
MemberDto login = (MemberDto)session.getAttribute("login");

BbsDto dto = (BbsDto)request.getAttribute("bbsDto");
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

<title>BBS Detail</title>

<style type="text/css">
th{
	background-color: #007bff;
	color: white;
}
pre{
	white-space: pre-wrap;
	word-wrap: break-word;
}
</style>

</head>

<body>

<h1 style="margin-left: 20px; margin-top: 20px">상세 글보기</h1>
<hr>

<div id="app" class="container">

	<table class="table table-striped">
		<colgroup>
			<col width="150">
			<col width="500">
		</colgroup>
		<tr>
			<th>작성자</th>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=dto.getWdate() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=dto.getReadcount() %></td>
		</tr>
		<%-- <tr>
			<th>답글정보</th>
			<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
		</tr> --%>
		<tr>
			<!-- <th>제목</th> -->
			<td colspan="2" style="font-size: 22px; font-weight: bold;"><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<!-- <th>내용</th> -->
			<td colspan="2" style="background-color: white;">
				<pre style="font-size: 18px; font-family: 고딕, arial; background-color: white"><%=dto.getContent() %></pre>
			</td>
		</tr>
	</table>
	<br><br>
	
	<% 
	if(login.getId().equals(dto.getId())) {
		%>
		<button class="btn btn-primary" type="button" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
		<button class="btn btn-primary" type="button" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
		<%
	}
	%>
	<button class="btn btn-primary" type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>
	<button class="btn btn-primary" type="button" onclick="location.href='bbslist.do'">글목록</button>
</div>


<script type="text/javascript">
function answerBbs( seq ) {
	location.href = "answer.do?seq=" + seq;
}
function updateBbs( seq ) {
	location.href = "updateBbs.do?seq=" + seq;
}
function deleteBbs( seq ) {
	if (confirm("정말 삭제하시겠습니까?") == true){
		location.href = "deleteBbsAf.do?seq=" + seq;
	 }
}
</script>


<%-- 댓글 --%>

<div id="app" class="container" style="margin-top: 50px">
	<form action="commentAf.do" method="post">
	<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
	<input type="hidden" name="id" value="<%=login.getId() %>">
	<table>
		<colgroup>
			<col width="1000px">
			<col width="150px">
		</colgroup>
		<tr>
			<td>comment</td>
			<td style="padding-left: 20px">&nbsp;</td>
		</tr>
		<tr>
			<td>
				<textarea rows="3" class="form-control" name="content"></textarea>
			</td>
			<td style="padding-left: 20px">
				<button type="submit" class="btn btn-primary btn-block p-4">완료</button>
			</td>
		</tr>
	</table>
	</form>
	<br><br>
	
	<table>
		<colgroup>
			<col width="100px">
			<col width="1000px">
			<col width="200px">
		</colgroup>
		<tbody id="tbody">
			
		</tbody>
	</table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type:"get",
		url:"commentList.do",
		data:{"seq":<%=dto.getSeq() %>},
		success:function(list){
			$("#tbody").html("");
			
			$.each(list, function(index, item){
				let str = "<tr>" 
						+	"<td>" + item.id + "</td>"
						+	"<td>" + item.content + "</td>"
						+	"<td>" + item.wdate + "</td>"
						+ "</tr>";
				$("#tbody").append(str);
			});
		},
		error:function(){
			alert('error');
		}
	});
});
</script>


</body>

</html>