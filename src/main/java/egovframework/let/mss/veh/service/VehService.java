package egovframework.let.mss.veh.service;

import java.util.List;
import java.util.Map;

public interface VehService {

	public Map<String, String> selectJibuInfo(String jocode);
	
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param);
	
	public List<?> vehicleReplace(Map<String, Object> map) throws Exception;
	
	public List<?> vehicleResult(Map<String, Object> map) throws Exception;

	public List<?> vehicleGraph(Map<String, Object> map) throws Exception;
}
