package egovframework.let.mss.veh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

/**
 * EgovComAbstractDAO.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 23.
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 23.   서준식        최초 생성
 *      </pre>
 */

@Repository("vehDAO")
public class VehDAO extends EgovAbstractMapper {

	@Override
	@Resource(name = "egov.sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}

	public Map<String, String> selectJibuInfo(String jocode) {
		return selectOne("vehDAO.selectJibuInfo", jocode);
	}
	
	public List<Map<String, Object>> selectGubn2(Map<String, Object>param) {
		return selectList("vehDAO.selectGubn2", param);
	}
	
	public List<?> vehicleReplace(Map<String, Object> map) throws Exception {
		return selectList("vehDAO.vehicleReplace", map);
	}
	
	public List<?> vehicleResult(Map<String, Object> map) throws Exception {
		return selectList("vehDAO.vehicleResult", map);
	}
	
	public List<?> vehicleGraph(Map<String, Object> map) throws Exception {
		return selectList("vehDAO.vehicleGraph", map);
	}
	
}
