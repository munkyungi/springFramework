<%@page import="mul.cam.a.dto.PdsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
List<PdsDto> list = (List<PdsDto>)request.getAttribute("pdslist");

String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
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

<title>PDS List</title>

<style type="text/css">
.table th, .table td {
	text-align: center;
	vertical-align: middle!important;	
}
</style>

</head>

<body>

<h1 style="margin-left: 20px; margin-top: 20px">자료실</h1>
<hr>
<a href="bbslist.do" class="btn btn-outline-primary" style="margin-left: 20px">게시판</a>
<hr>

<div align="center">
	<table class="table table-hover table-sm" style="width: 1000px">
		<colgroup>
			<col width="50">
			<col width="100">
			<col width="300">
			<col width="50">
			<col width="50">
			<col width="50">
			<col width="100">
		</colgroup>
		
		<thead>
			<tr class="bg-info" style="color: white;">
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>파일</th>
				<th>조회수</th>
				<th>다운수</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		<tbody>
			<%
			if(list == null || list.size() == 0){
			%>
				<tr>
					<td colspan="7">작성된 글이 없습니다.</td>
				</tr>
			<%
			}
			else {
				for(int i=0; i<list.size(); i ++){
					PdsDto pds = list.get(i);
					%>
					<tr>
						<td><%=i+1 %></td>
						<td><%=pds.getId() %></td>
						<td>
							<a href="pdsDetail.do?seq=<%=pds.getSeq() %>">
								<%=pds.getTitle() %>
							</a>
						</td>
						<td>
							<input type="button" value="다운로드" class="btn btn-info" onclick="fileDownload(<%=pds.getSeq() %>, '<%=pds.getNewfilename() %>', '<%=pds.getFilename() %>')">
						</td>
						<td><%=pds.getReadcount() %></td>
						<td><%=pds.getDowncount() %></td>
						<td><%=pds.getRegdate().substring(0, 10) %></td>
					</tr>
					<%
				}
			}
			%>
		</tbody>
		
	</table>
	<br><br>
	<%-- 검색 --%>
	
	<table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
		<tr>
			<td style="padding-left: 3px">
				<select class="custom-select" id="choice" name="choice">
					<option selected>검색</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
			</td>
			<td style="padding-left: 5px" class="align-middle">
				<input type="text" class="form-control" id="search" name="search" onkeyup="enterKeyEvent()" placeholder="검색어" value="">
			<td style="padding-left: 5px">
				<span>
					<button type="button" class="btn btn-info" onclick="searchBtn()">검색</button>
				</span>
			</td>
		</tr>
	</table>
	<br>
	
	<button type="button"class="btn btn-info"  onclick="pdsWrite()">자료추가</button>
</div>

<form name="filedown" action="filedownload.do" method="post">
	<input type="hidden" name="newfilename">
	<input type="hidden" name="filename">
	<input type="hidden" name="seq">
</form>

<script type="text/javascript">
let search = "<%=search %>";

//검색어가 있을 시, 처리
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");

	// 한줄로 요약 가능
	// document.getElementById("choice").value = "<%=choice %>";
}

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	/*
	if(choice == ""){
		alert("카테고리를 선택해 주십시오.");
		return;
	}
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오.");
		return;
	}
	*/
	
	location.href = "pdslist.do?choice=" + choice + "&search=" + search;
}

function pdsWrite() {
	location.href = "pdsWrite.do";
}

// jsp를 이용하여 submit으로 값 보내주기
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