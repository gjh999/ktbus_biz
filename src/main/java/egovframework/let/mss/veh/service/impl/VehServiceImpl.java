package egovframework.let.mss.veh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.let.mss.veh.service.VehService;

@Service("vehService")
public class VehServiceImpl implements VehService {

	private Logger logger = Logger.getLogger(VehServiceImpl.class);

	/** searchModeDAO */
	@Resource(name = "vehDAO")
	private VehDAO vehDAO;

	@Override
	public Map<String, String> selectJibuInfo(String jocode) {
		return vehDAO.selectJibuInfo(jocode);	
	}

	@Override
	public List<Map<String, Object>> selectGubn2(Map<String, Object> param) {
		return vehDAO.selectGubn2(param);
	}

	@Override
	public List<?> vehicleReplace(Map<String, Object> map) throws Exception {
		return vehDAO.vehicleReplace(map);
	}
	
	@Override
	public List<?> vehicleResult(Map<String, Object> map) throws Exception {
		return vehDAO.vehicleResult(map);
	}
	
	@Override
	public List<?> vehicleGraph(Map<String, Object> map) throws Exception {
		return vehDAO.vehicleGraph(map);
	}
	
	
}
