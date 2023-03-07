package mul.cam.a.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.BbsDao;
import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.service.BbsService;

@Service
public class BbsServiceImpl implements BbsService {
	@Autowired
	BbsDao dao;

	@Override
	public List<BbsDto> bbslist(BbsParam bbs) {
		return dao.bbslist(bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {
		return dao.getAllBbs(bbs);
	}

	@Override
	public BbsDto getBbs(int seq) {
		return dao.getBbs(seq);
	}
	
	@Override
	public boolean addBbslist(BbsDto dto) {
		int count = dao.addBbslist(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean updateBbs(BbsDto dto) {
		int count = dao.updateBbs(dto);
		return count>0?true:false;
	}

	@Override
	public boolean deleteBbs(int seq) {
		int count = dao.deleteBbs(seq);
		return count>0?true:false;
	}
	
	// 답글
	@Override
	public boolean answer(BbsDto dto) {
		dao.answerUp(dto.getSeq());
		int count = dao.answerIn(dto);
		
		return count>0?true:false;
	}
	
	// 댓글
	@Override
	public boolean commentWrite(BbsComment comment) {
		int count = dao.commentWrite(comment);
		return count>0?true:false;
	}
	
	@Override
	public List<BbsComment> commentList(int seq) {
		return dao.commentList(seq);
	}

	// 조회수
	@Override
	public boolean getBbsRead(HashMap<String, Object> map) {
		int count = dao.getBbsRead(map);
		if(count>0) {
			return true;
		} else {
			dao.addBbsRead(map);
			return false;
		}
	}

	@Override
	public boolean updateReadCount(int seq) {
		int count = dao.updateReadCount(seq);
		return count>0?true:false;
	}

}
