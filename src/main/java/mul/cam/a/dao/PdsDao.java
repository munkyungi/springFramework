package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.PdsDto;
import mul.cam.a.dto.PdsParam;

public interface PdsDao {
	List<PdsDto> pdslist(PdsParam param);
	
	PdsDto getPds(int seq);
	
	int uploadPds(PdsDto dto);
	
	int updateDowncount(int seq);
	
	int updatePds(PdsDto dto);
	
	int deletePds(int seq);
}
