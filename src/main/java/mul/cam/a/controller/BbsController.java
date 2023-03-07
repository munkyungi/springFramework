package mul.cam.a.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;
import mul.cam.a.service.BbsService;

@Controller
public class BbsController {

	@Autowired
	BbsService service;
	
	// 글 목록
	@GetMapping(value = "bbslist.do")
	public String bbslist(Model model, BbsParam param) {
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();	// 0 1 2 3 ...
		int start = 1 + (pn * 10);		// 1 11 21 ...
		int end = (pn + 1) * 10;		// 10 20 30 ...
		
		param.setStart(start);
		param.setEnd(end);
		
		List<BbsDto> list = service.bbslist(param);
		
		// 총 글의 개수
		int len = service.getAllBbs(param);
		// 페이지의 총수
		int pageBbs = len / 10;	// 10개씩 페이지를 나눠 보여줌
		if((len%10) > 0) {		// 10개로 나눴을 때 페이지가 딱 떨어지지 않으면 페이지 수 +1
			pageBbs = pageBbs + 1;
		}
		
		if(param.getChoice() == null || param.getChoice().equals("") || param.getSearch() == null || param.getSearch().equals("")) {
			param.setChoice("검색");
			param.setSearch("");
		}
		
		model.addAttribute("bbslist", list); 						// 게시판 리스트
		model.addAttribute("pageBbs", pageBbs);						// 총 페이지 수
		model.addAttribute("pageNumber", param.getPageNumber());	// 현재 페이지
		model.addAttribute("choice", param.getChoice());			// 검색 카테고리
		model.addAttribute("search", param.getSearch());			// 검색어
		
		return "bbslist";
	}
	
	
	// 글쓰기
	@GetMapping(value = "bbsWrite.do")
	public String bbsWrite() {
		return "bbsWrite";
	}
	
	@RequestMapping(value = "bbsWriteAf.do", method = RequestMethod.POST)
	public String bbsWriteAf(Model model, BbsDto dto) {
		dto.setTitle(dto.getTitle().replace("\"", "&quot;")); // 큰따옴표 치환
		
		boolean isS = service.addBbslist(dto);
		
		String bbs = "";
		if(isS) {
			bbs = "BBS_YES";
		} else {
			bbs = "BBS_NO";
		}
		model.addAttribute("bbs", bbs);
		
		return "message";
	}
	
	
	// 글 읽기
	@GetMapping(value = "bbsDetail.do")
	public String bbsDetail(Model model, HttpServletRequest req, int seq) {
		
		// 조회수 설정값 준비
		MemberDto login = (MemberDto)req.getSession().getAttribute("login");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", login.getId());
		map.put("seq", seq);
		
		// 조회수 설정
		if(!service.getBbsRead(map)) {		// 현재 계정으로 조회한 적이 없으면, 기록 저장
			service.updateReadCount(seq);	// 조회수 증가
		}
		
		BbsDto dto = service.getBbs(seq);
		model.addAttribute("bbsDto", dto);
		
		return "bbsDetail";
	}
	
	
	// 글 수정
	@GetMapping(value = "updateBbs.do")
	public String updateBbs(Model model, int seq) {
		BbsDto dto = service.getBbs(seq);
		model.addAttribute("bbsDto", dto);
		
		return "updateBbs";
	}
	
	@RequestMapping(value = "updateBbsAf.do", method = RequestMethod.POST)
	public String updateBbsAf(Model model, BbsDto dto) {
		boolean isS = service.updateBbs(dto);
		
		String bbs = "";
		if(isS) {
			bbs = "BBS_UP_YES";
		} else {
			bbs = "BBS_UP_NO";
		}
		model.addAttribute("seq", dto.getSeq());
		model.addAttribute("bbs", bbs);
		
		return "message";
	}

	// 글 삭제
	@GetMapping(value = "deleteBbsAf.do")
	public String deleteBbsAf(Model model, int seq) {
		boolean isS = service.deleteBbs(seq);
		
		String bbs = "";
		if(isS) {
			bbs = "BBS_DEL_YES";
		} else {
			bbs = "BBS_DEL_NO";
		}
		model.addAttribute("bbs", bbs);
		
		return "message";
	}
	
	
	// 답글 작성
	@GetMapping(value = "answer.do")
	public String answer(Model model, int seq) {
		BbsDto dto = service.getBbs(seq);
		model.addAttribute("bbsDto", dto);
		
		return "answer";
	}
	
	@RequestMapping(value = "answerAf.do", method = RequestMethod.POST)
	public String answerAf(Model model, BbsDto dto) {
		boolean isS = service.answer(dto);
		
		String bbs = "";
		if(isS) {
			bbs = "BBS_COMMENT_YES";
		} else {
			bbs = "BBS_COMMENT_NO";
		}
		model.addAttribute("seq", dto.getSeq());
		model.addAttribute("bbs", bbs);
		
		return "message";
	}
	
	
	// 댓글 작성
	@PostMapping(value = "commentAf.do")
	public String commentAf(BbsComment comment) {
		boolean isS = service.commentWrite(comment);

		return "redirect:/bbsDetail.do?seq=" + comment.getSeq();
	}
	
	@ResponseBody
	@GetMapping(value = "commentList.do")
	public List<BbsComment> commentList(int seq) {
		List<BbsComment> list = service.commentList(seq);
		return list;
	}
}
