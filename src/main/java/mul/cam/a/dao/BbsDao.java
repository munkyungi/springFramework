package mul.cam.a.dao;

import java.util.HashMap;
import java.util.List;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;

public interface BbsDao {
	
	List<BbsDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);
	
	BbsDto getBbs(int seq);
	
	int addBbslist(BbsDto dto);
	
	int updateBbs(BbsDto dto);
	
	int deleteBbs(int seq);
	
	// 답글
	int answerUp(int seq);
	
	int answerIn(BbsDto dto);
	
	// 댓글
	int commentWrite(BbsComment comment);
	
	List<BbsComment> commentList(int seq);
	
	// 조회수
	int getBbsRead(HashMap<String, Object> map);
	
	int addBbsRead(HashMap<String, Object> map);
	
	int updateReadCount(int seq);
}
