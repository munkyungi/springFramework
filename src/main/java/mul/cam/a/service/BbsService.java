package mul.cam.a.service;

import java.util.HashMap;
import java.util.List;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;

public interface BbsService {

	List<BbsDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);
	
	BbsDto getBbs(int seq);
	
	boolean addBbslist(BbsDto dto);
	
	boolean updateBbs(BbsDto dto);
	
	boolean deleteBbs(int seq);
	
	// 답글
	boolean answer(BbsDto dto);
	
	// 댓글
	boolean commentWrite(BbsComment comment);
	
	List<BbsComment> commentList(int seq);
	
	// 조회수
	boolean getBbsRead(HashMap<String, Object> map);
	
	boolean updateReadCount(int seq);
}
