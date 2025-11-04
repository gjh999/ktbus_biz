package egovframework.let.mss.tot.service.impl;

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

@Repository("totAbstractDAO")
public class TotAbstractDAO extends EgovAbstractMapper {

	@Override
	@Resource(name = "egov.sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}

	public List<?> tot01List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot01List", map);
	}

	public List<?> tot02List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot02List", map);
	}

	public List<?> tot03List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot03List", map);
	}
	
	public List<?> tot04List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot04List", map);
	}
	
	public List<?> tot05List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot05List", map);
	}
	
	public List<?> tot06List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot06List", map);
	}
	
	public List<?> tot07List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot07List", map);
	}
	
	public List<?> tot08List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot08List", map);
	}
	
	public List<?> tot09List(Map<String, Object> map) throws Exception {
		return selectList("totAbstractDAO.tot09List", map);
	}

	public int countHomeLogCnt(Map<String, String> menuInfo) {
		return update("totAbstractDAO.countHomeLogCnt", menuInfo);
	}

	public Map<String, String> selectJibuInfo(String jocode) {
		return selectOne("totAbstractDAO.selectJibuInfo", jocode);
	}
	
	public List<Map<String, Object>> selectGubn2(Map<String, Object>param) {
		return selectList("totAbstractDAO.selectGubn2", param);
	}
	
}
