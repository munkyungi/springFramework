package mul.cam.a.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.BbsDao;
import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;

@Repository
public class BbsDaoImpl implements BbsDao {
	@Autowired
	SqlSession session;
	
	String ns = "Bbs.";

	@Override
	public List<BbsDto> bbslist(BbsParam bbs) {
		return session.selectList(ns + "bbslist", bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {
		return session.selectOne(ns + "getAllBbs", bbs);
	}
	
	@Override
	public BbsDto getBbs(int seq) {
		return session.selectOne(ns + "getBbs", seq);
	}

	@Override
	public int addBbslist(BbsDto dto) {
		return session.insert(ns + "addBbslist", dto);
	}
	
	@Override
	public int updateBbs(BbsDto dto) {
		return session.update(ns + "updateBbs", dto);
	}

	@Override
	public int deleteBbs(int seq) {
		return session.update(ns + "deleteBbs", seq);
	}
	
	// 답글
	@Override
	public int answerUp(int seq) {
		return session.update(ns + "answerUp", seq);
	}

	@Override
	public int answerIn(BbsDto dto) {
		return session.insert(ns + "answerIn", dto);
	}
	
	// 댓글
	@Override
	public int commentWrite(BbsComment comment) {
		return session.insert(ns + "commentWrite", comment);
	}
	
	@Override
	public List<BbsComment> commentList(int seq) {
		return session.selectList(ns + "commentList", seq);
	}

	// 조회수
	@Override
	public int getBbsRead(HashMap<String, Object> map) {
		return session.selectOne(ns + "getBbsRead", map);
	}

	@Override
	public int addBbsRead(HashMap<String, Object> map) {
		return session.insert(ns + "addBbsRead", map);
	}

	@Override
	public int updateReadCount(int seq) {
		return session.update(ns + "updateReadCount", seq);
	}

}
