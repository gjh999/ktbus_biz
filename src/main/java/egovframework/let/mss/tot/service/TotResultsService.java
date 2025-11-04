package egovframework.let.mss.tot.service;

import java.util.List;
import java.util.Map;

public interface TotResultsService {

	public List<?> tot01List(Map<String, Object> map) throws Exception;

	public List<?> tot02List(Map<String, Object> map) throws Exception;

	public List<?> tot03List(Map<String, Object> map) throws Exception;
	
	public List<?> tot04List(Map<String, Object> map) throws Exception;
	
	public List<?> tot05List(Map<String, Object> map) throws Exception;
	
	public List<?> tot06List(Map<String, Object> map) throws Exception;
	
	public List<?> tot07List(Map<String, Object> map) throws Exception;
	
	public List<?> tot08List(Map<String, Object> map) throws Exception;
	
	public List<?> tot09List(Map<String, Object> map) throws Exception;

	public int countHomeLogCnt(Map<String, String> menuInfo);

	public Map<String, String> selectJibuInfo(String jocode);
	
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param);
	
	
}
