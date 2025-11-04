package egovframework.let.mss.maa.service;

import java.util.List;
import java.util.Map;

public interface MaaService {

	public List<?> mm3600jList(Map<String, Object> map) throws Exception;

	public Map<String, String> selectJibuInfo(String jocode);
	
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param);
	
	public List<?> mrr5110List(Map<String, Object> map) throws Exception;
	
	public List<?> mrr5410List(Map<String, Object> map) throws Exception;
	
}
