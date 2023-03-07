package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.MemberDao;
import mul.cam.a.dto.MemberDto;

@Repository
public class MemberDaoimpl implements MemberDao {
	// mybatis(db) 접근(생성)
	
	@Autowired // 자동생성
	SqlSession session;
	
	String ns = "Member.";	// namespace
	
	@Override
	public List<MemberDto> allMember() {
		return session.selectList(ns + "allMember");
	}

	@Override
	public int idCheck(String id) {
		return session.selectOne(ns + "idcheck", id);
	}

	@Override
	public int addMember(MemberDto dto) {
		return session.insert(ns + "addMember", dto);
	}

	@Override
	public MemberDto login(MemberDto dto) {
		return session.selectOne(ns + "login", dto);
	}
}
