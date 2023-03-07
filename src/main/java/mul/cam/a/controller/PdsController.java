package mul.cam.a.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import mul.cam.a.dto.PdsDto;
import mul.cam.a.dto.PdsParam;
import mul.cam.a.service.PdsService;
import mul.cam.a.util.PdsUtil;

@Controller
public class PdsController {
	@Autowired
	PdsService service;
	
	// 자료 목록
	@RequestMapping(value = "pdslist.do", method = RequestMethod.GET)
	public String pdslist(Model model, PdsParam param) {
		List<PdsDto> list = service.pdslist(param);
		
		if(param.getChoice() == null || param.getChoice().equals("") || param.getSearch() == null || param.getSearch().equals("")) {
			param.setChoice("검색");
			param.setSearch("");
		}
		
		model.addAttribute("choice", param.getChoice());	// 검색 카테고리
		model.addAttribute("search", param.getSearch());	// 검색어
		model.addAttribute("pdslist", list);				// 자료 목록
		
		return "pdslist";
	}
	
	// 자료 올리기
	@GetMapping(value = "pdsWrite.do")
	public String pdsWrite() {
		return "pdsWrite";
	}
	
	@PostMapping(value = "pdsUpload.do")			// jsp 파일에서 준 id 값	// 업로드가 안 됐을 때 다시 하겠느냐 -> false	// 업로드 경로를 설정하기 위한 req
	public String pdsUpload(PdsDto dto, @RequestParam(value = "fileload", required = false) MultipartFile fileload, HttpServletRequest req) {

		// filename 취득
		String filename = fileload.getOriginalFilename();
		dto.setFilename(filename);	// 원본 파일명
		
		// upload 경로 설정
		// 1. server
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 2. folder
		//String fupload = "C:\\temp";
		
		System.out.println("fupload: " + fupload);
		
		// 파일명 충돌방지 명칭으로 변경(time)
		String newfilename = PdsUtil.getNewFileName(filename);
		dto.setNewfilename(newfilename);	// 변경된 파일명
		
		File file = new File(fupload + "/" + newfilename);
		try {
			// 실제 파일 업로드(생성+기입)
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
			// DB에 저장
			service.uploadPds(dto);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/pdslist.do";
	}
	
	// 자료 다운로드
	@PostMapping(value = "filedownload.do")
	public String filedownload(Model model, HttpServletRequest req, int seq, String filename, String newfilename) {
		// download 경로 설정
		// 1. server
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 2. folder
		//String fupload = "C:\\temp";
		
		// 다운로드 받을 파일
		File downloadFile = new File(fupload + "/" + newfilename);
		
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("filename", filename);
		model.addAttribute("seq", seq);
		
		return "downloadView";
	}
	
	
	// 자료 상세보기
	@GetMapping(value = "pdsDetail.do")
	public String pdsDetail(Model model, int seq) {
		
		PdsDto dto = service.getPds(seq);
		model.addAttribute("pdsDto", dto);
		
		return "pdsDetail";
	}
	
	
	// 자료 수정
	@GetMapping(value = "updatePds.do")
	public String updatePds(Model model, int seq) {
		PdsDto dto = service.getPds(seq);
		model.addAttribute("pdsDto", dto);
		
		return "updatePds";
	}
	
	@PostMapping(value = "updatePdsAf.do")
	public String updatePdsAf(Model model, PdsDto dto, @RequestParam(value = "fileload", required = false) MultipartFile fileload, HttpServletRequest req) {
		
		// filename 취득
		String filename = fileload.getOriginalFilename();
		
		if(filename != null && !filename.equals("")) {	// 수정한 파일이 있을 때
			dto.setFilename(filename);	// 원본 파일명
			
			// upload 경로 설정
			String fupload = req.getServletContext().getRealPath("/upload");
			
			// 파일명 충돌방지 명칭으로 변경(time)
			String newfilename = PdsUtil.getNewFileName(filename);
			dto.setNewfilename(newfilename);	// 변경된 파일명
			
			File file = new File(fupload + "/" + newfilename);
			try {
				// 실제 파일 업로드(생성+기입)
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());

			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {	// 파일이 변경되지 않음

		}
		
		// DB에 수정
		boolean isS = service.updatePds(dto);
		
		String pds = "";
		if(isS) {
			pds = "PDS_UP_YES";
		} else {
			pds = "PDS_UP_NO";
		}
		
		model.addAttribute("pds", pds);
		
		return "message";
	}
	
	// 자료 삭제
	@GetMapping(value = "deletePdsAf.do")
	public String deletePdsAf(Model model, int seq) {
		boolean isS = service.deletePds(seq);
		
		String pds = "";
		if(isS) {
			pds = "PDS_DEL_YES";
		} else {
			pds = "PDS_DEL_NO";
		}
		model.addAttribute("pds", pds);
		
		return "message";
	}
	

	
	
}
