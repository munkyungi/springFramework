<%@page import="mul.cam.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String sessionOut = (String)request.getAttribute("sessionOut");
if(sessionOut != null && sessionOut.equals("") == false) {
	%>
	<script type="text/javascript">
		alert("<%=sessionOut %>");
		location.href = "login.do";
	</script>
	<%
}

MemberDto login = (MemberDto)session.getAttribute("login");

String message = (String)request.getAttribute("message");

if(message != null && message.equals("") == false){
	// 회원가입
	if(message.equals("MEMBER_ADD_YES")){
		%>
		<script type="text/javascript">
			alert("성공적으로 가입되었습니다!");
			location.href = "login.do";
		</script>
		<%	
	} else if(message.equals("MEMBER_ADD_NO")) {
		%>
		<script type="text/javascript">
			alert("다시 가입해 주십시오.");
			location.href = "account.do";
		</script>
		<%	
	}
	// 로그인
	else if(message.equals("LOGIN_YES")){
		%>
		<script type="text/javascript">
			let str = "<%=login.getId() %>";
			alert("환영합니다! " + str + "님");
			//alert("환영합니다!");
			location.href = "bbslist.do";
		</script>
		<%	
	} else if(message.equals("LOGIN_NO")){
		%>
		<script type="text/javascript">
			alert("아이디나 패스워드를 확인해주세요.");
			location.href = "login.do";
		</script>
		<%	
	}
}

String bbs = (String)request.getAttribute("bbs");
int seq = 0;
if(request.getAttribute("seq") != null){
	seq = (Integer)request.getAttribute("seq");
}


if(bbs != null && bbs.equals("") == false){
	// 글쓰기
	if(bbs.equals("BBS_YES")){
		%>
		<script type="text/javascript">
			alert("글이 등록되었습니다!");
			location.href = "bbslist.do";
		</script>
		<%	
	} else if(bbs.equals("BBS_NO")){
		%>
		<script type="text/javascript">
			alert("다시 작성해 주십시오.");
			location.href = "bbsWrite.do";
		</script>
		<%	
	}
	// 글 수정
		else if(bbs.equals("BBS_UP_YES")){
			%>
			<script type="text/javascript">
				alert("글이 수정되었습니다!");
				let seq = "<%=seq %>";
				location.href = "bbsDetail.do?seq=" + seq;
			</script>
			<%	
		} else if(bbs.equals("BBS_UP_NO")){
			%>
			<script type="text/javascript">
				alert("수정에 실패하였습니다.");
				let seq = "<%=seq %>";
				location.href = "updateBbs.do?seq=" + seq;
			</script>
			<%	
		}
	// 글 삭제
	else if(bbs.equals("BBS_DEL_YES")){
		%>
		<script type="text/javascript">
			alert("글이 삭제되었습니다!");
			location.href = "bbslist.do";
		</script>
		<%	
	} else if(bbs.equals("BBS_DEL_NO")){
		%>
		<script type="text/javascript">
			alert("삭제에 실패하였습니다.");
			location.href = "bbslist.do";
		</script>
		<%	
	}
	// 답글 작성
	else if(bbs.equals("BBS_COMMENT_YES")){
		%>
		<script type="text/javascript">
			alert("답글이 입력되었습니다!");
			location.href = "bbslist.do";
		</script>
		<%	
	} else if(bbs.equals("BBS_COMMENT_NO")){
		%>
		<script type="text/javascript">
			alert("답글입력에 실패하였습니다.");
			let seq = "<%=seq %>";
			location.href = "answer.do?seq=" + seq;
		</script>
		<%	
	}
}

String pds = (String)request.getAttribute("pds");
if(pds != null && pds.equals("") == false){
	// 자료 삭제
	if(pds.equals("PDS_DEL_YES")){
		%>
		<script type="text/javascript">
			alert("자료가 삭제되었습니다!");
			location.href = "pdslist.do";
		</script>
		<%	
	} else if(pds.equals("PDS_DEL_NO")){
		%>
		<script type="text/javascript">
			alert("자료 삭제에 실패했습니다.");
			location.href = "pdslist.do";
		</script>
		<%	
	}
	else if(pds.equals("PDS_UP_YES")){
		%>
		<script type="text/javascript">
			alert("자료가 수정되었습니다!");
			location.href = "pdslist.do";
		</script>
		<%	
	} else if(pds.equals("PDS_UP_NO")){
		%>
		<script type="text/javascript">
			alert("자료 수정에 실패했습니다.");
			location.href = "pdslist.do";
		</script>
		<%	
	}
}

%>