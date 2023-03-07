package mul.cam.a.member;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.MemberDto;
import mul.cam.a.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	// 로그인
	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String login() {
		//System.out.println("MemberController login" + new Date());
		
		return "login";
	}

	@RequestMapping(value = "loginAf.do", method = RequestMethod.POST)
	public String login(Model model, HttpServletRequest req, MemberDto dto) {	// request, response는 필요할 때 파라미터에 추가
		
		MemberDto login = service.login(dto);
		
		String message = "";
		if(login != null) {
			// session 저장
			req.getSession().setAttribute("login", login);
			req.getSession().setMaxInactiveInterval(60*60*2); // 2시간 세션유지
			
			message = "LOGIN_YES";
		} else {
			message = "LOGIN_NO";
		}
		model.addAttribute("message", message);
		
		return "message";
	}
	
	// 회원가입
	@RequestMapping(value = "account.do", method = RequestMethod.GET)
	public String account() {
				
		return "account";
	}
	
	@ResponseBody
	@RequestMapping(value = "idcheck.do", method = RequestMethod.POST, produces = "application/String; charset=utf-8")
	public String idcheck(String id) {

		boolean isS = service.idCheck(id);
		
		String str = "NO";
		if(isS == false) { // id가 없으면 생성
			str = "YES";
		}
		
		return str;
	}

	@RequestMapping(value = "accountAf.do", method = RequestMethod.POST)
	public String accountAf(Model model, MemberDto dto) {
		
		boolean isS = service.addMember(dto);
		
		String message = "";
		if(isS) {
			message = "MEMBER_ADD_YES";
		} else {
			message = "MEMBER_ADD_NO";
		}
		model.addAttribute("message", message);
		
		return "message";
	}
	
	// 세션 확인
	@RequestMapping(value = "sessionOut.do", method = RequestMethod.GET)
	public String sessionOut(Model model) {
		String sessionOut = "로그인 해주십시오.";
		
		model.addAttribute("sessionOut", sessionOut);
		
		return "message";
	}
	
	// 로그아웃
	@GetMapping(value = "logoutAf.do")
	public String logoutAf(HttpServletRequest req) {
		req.getSession().invalidate();
		
		return "redirect:/login.do";
	}

}
