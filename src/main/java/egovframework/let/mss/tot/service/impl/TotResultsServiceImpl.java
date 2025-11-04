package egovframework.let.mss.tot.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.let.mss.tot.service.TotResultsService;

@Service("totResultsService")
public class TotResultsServiceImpl implements TotResultsService {

	private Logger logger = Logger.getLogger(TotResultsServiceImpl.class);

	/** searchModeDAO */
	@Resource(name = "totAbstractDAO")
	private TotAbstractDAO totAbstractDAO;

	@Override
	public List<?> tot01List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot01List(map);
	}

	@Override
	public List<?> tot02List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot02List(map);
	}

	@Override
	public List<?> tot03List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot03List(map);
	}
	
	@Override
	public List<?> tot04List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot04List(map);
	}
	
	@Override
	public List<?> tot05List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot05List(map);
	}

	@Override
	public List<?> tot06List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot06List(map);
	}

	@Override
	public List<?> tot07List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot07List(map);
	}
	
	@Override
	public List<?> tot08List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot08List(map);
	}

	@Override
	public List<?> tot09List(Map<String, Object> map) throws Exception {
		return totAbstractDAO.tot09List(map);
	}

	@Override
	public int countHomeLogCnt(Map<String, String> menuInfo) {
		return totAbstractDAO.countHomeLogCnt(menuInfo);		
	}

	@Override
	public Map<String, String> selectJibuInfo(String jocode) {
		return totAbstractDAO.selectJibuInfo(jocode);	
	}

	@Override
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param) {
		return totAbstractDAO.selectGubn2(param);
	}
	
	
	
}
