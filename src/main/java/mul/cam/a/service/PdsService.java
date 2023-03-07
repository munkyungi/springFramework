package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.PdsDto;
import mul.cam.a.dto.PdsParam;

public interface PdsService {
	List<PdsDto> pdslist(PdsParam param);
	
	PdsDto getPds(int seq);
	
	boolean uploadPds(PdsDto dto);
	
	boolean updateDowncount(int seq);
	
	boolean updatePds(PdsDto dto);
	
	boolean deletePds(int seq);
}
