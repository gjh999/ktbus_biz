package egovframework.let.mss.maa.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.let.mss.maa.service.MaaService;

@Service("maaService")
public class MaaServiceImpl implements MaaService {

	private Logger logger = Logger.getLogger(MaaServiceImpl.class);

	/** searchModeDAO */
	@Resource(name = "maaDAO")
	private MaaDAO maaDAO;

	@Override
	public List<?> mm3600jList(Map<String, Object> map) throws Exception {
		return maaDAO.mm3600jList(map);
	}

	@Override
	public Map<String, String> selectJibuInfo(String jocode) {
		return maaDAO.selectJibuInfo(jocode);	
	}

	@Override
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param) {
		return maaDAO.selectGubn2(param);
	}

	@Override
	public List<?> mrr5110List(Map<String, Object> map) throws Exception {
		return maaDAO.mrr5110List(map);
	}
	
	@Override
	public List<?> mrr5410List(Map<String, Object> map) throws Exception {
		return maaDAO.mrr5410List(map);
	}
	
	
	
}
