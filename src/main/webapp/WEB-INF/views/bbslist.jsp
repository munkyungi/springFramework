<%@page import="mul.cam.a.dto.MemberDto"%>
<%@page import="mul.cam.a.util.Utility"%>
<%@page import="mul.cam.a.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
MemberDto login = (MemberDto)session.getAttribute("login");
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
<!-- pagination -->
<script type="text/javascript" src="./jquery/jquery.twbsPagination.min.js"></script>

<title>BBS List</title>

<style type="text/css">
.table th, .table td {
	text-align: center;
	vertical-align: middle!important;
}
</style>

</head>

<body>

<%

List<BbsDto> list = (List<BbsDto>)request.getAttribute("bbslist");

String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
int pageBbs = (Integer)request.getAttribute("pageBbs");			// 10개씩 나눴을 때 보여줄 페이지 개수
int pageNumber = (Integer)request.getAttribute("pageNumber");	// 현재 페이지

%>

<h1 style="margin-left: 20px; margin-top: 20px">List</h1>
<hr>

<a href="logoutAf.do" class="btn btn-outline-secondary" style="margin-left: 20px">log-out</a>
<a href="pdslist.do" class="btn btn-outline-success">자료실</a>
<hr>

<div align="center">
	<table class="table table-hover table-sm" style="width: 1000px">
		<colgroup>
			<col width="70">
			<col width="600">
			<col width="100">
			<col width="150">
		</colgroup>
		
		<thead>
			<tr class="bg-primary" style="color: white;">
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성자</th>
			</tr>
		</thead>
		
		<tbody>
			<%
			if(list == null || list.size() == 0){
			%>
				<tr>
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>
			<%
			}
			else {
				for(int i=0; i<list.size(); i++)
				{
					BbsDto dto = list.get(i);
					%>
					<tr>
						<th><%=i + 1 %></th>
						<td>
							<%=Utility.arrow(dto.getDepth()) %> <%-- Utility static 함수 호출 --%>
							
							<% if(dto.getDel() == 0) { %>
								<a href="bbsDetail.do?seq=<%=dto.getSeq() %>">
								<%=dto.getTitle() %>
								</a>
							<%} else if(dto.getDel() == 1) {%>
								삭제된 게시글 입니다.
							<%} %>
						</td>
						<td><%=dto.getReadcount() %></td>
						<td><%=dto.getId() %></td>
					</tr>
					<%
				}
			}
			%>
		</tbody>
	</table>
	<br>
	
	<%-- <%
	for(int i=0; i<pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지일 때
			%>
			<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
				<%=i+1 %>
			</span>
			<%
		} else {
			%>
			<a href="#none" title="<%=i+1%>페이지" onclick="goPage(<%=i %>)" style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
			</a>
			<%
		}
	}
	%> --%>
	<div class="container">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination" style="justify-content: center;"></ul>
	    </nav>
	</div>
	<br>
	
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
				<input type="text" class="form-control" id="search" name="search" onkeyup="enterKeyEvent()" placeholder="검색어" value="<%=search %>">
			<td style="padding-left: 5px">
				<span>
					<button type="button" class="btn btn-primary" onclick="searchBtn()">검색</button>
				</span>
			</td>
		</tr>
	</table>
	<br>
	
	<a href="bbsWrite.do" class="btn btn-primary">글쓰기</a>
</div>

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
	
	location.href = "bbslist.do?choice=" + choice + "&search=" + search;
}

function goPage(pageNumber) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;

	location.href = "bbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;
}


//페이지
$('#pagination').twbsPagination({
	startPage: <%=pageNumber+1 %>,
    totalPages: <%=pageBbs %>,
    visiblePages: 10,
    first: '<span srid-hidden="true">«</span>',
    prev: "이전",
    next: "다음",
    last: '<span srid-hidden="true">»</span>',
    initiateStartPageClick: false,			// onPageClick이 처음에 실행되지 않게
    onPageClick: function (event, page) {	// 페이지 클릭할 때마다 들어오는 함수
    	let choice = document.getElementById('choice').value;
    	let search = document.getElementById('search').value;
    	
    	location.href = "bbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page-1);
    }
})
</script>

</body>

</html>