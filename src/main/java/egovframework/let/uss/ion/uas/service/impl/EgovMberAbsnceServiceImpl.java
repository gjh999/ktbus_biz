package egovframework.let.uss.ion.uas.service.impl;

import java.util.List;

import egovframework.let.uss.ion.uas.service.EgovMberAbsnceService;
import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
/**
 * 사용자부재에 대한 ServiceImpl 클래스를 정의한다.
 * 사용자부재에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 사용자부재의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Service("egovMberAbsnceService")
public class EgovMberAbsnceServiceImpl extends EgovAbstractServiceImpl implements EgovMberAbsnceService {

	@Resource(name="mberAbsnceDAO")
	private MberAbsnceDAO mberAbsnceDAO;

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return List - 사용자부재 목록
	 */
	public List<UserAbsnceVO> selectMberAbsnceList(UserAbsnceVO userAbsnceVO) throws Exception {
		return mberAbsnceDAO.selectMberAbsnceList(userAbsnceVO);
	}

	/**
	 * 사용자부재정보목록 총 갯수를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return int - 사용자부재 카운트 수
	 */
	public int selectMberAbsnceListTotCnt(UserAbsnceVO userAbsnceVO) throws Exception {
		return mberAbsnceDAO.selectMberAbsnceListTotCnt(userAbsnceVO);
	}

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectMberAbsnce(UserAbsnceVO userAbsnceVO) throws Exception {
		return mberAbsnceDAO.selectMberAbsnce(userAbsnceVO);
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO insertMberAbsnce(UserAbsnce userAbsnce, UserAbsnceVO userAbsnceVO) throws Exception {
		mberAbsnceDAO.insertMberAbsnce(userAbsnce);
		userAbsnceVO.setUserId(userAbsnce.getUserId());
		return selectMberAbsnce(userAbsnceVO);
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param mberAbsnce - 사용자부재 model
	 */
	public void updateMberAbsnce(UserAbsnce userAbsnce) throws Exception {
		mberAbsnceDAO.updateMberAbsnce(userAbsnce);
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param mberAbsnce - 사용자부재 model
	 */
	public void deleteMberAbsnce(UserAbsnce userAbsnce) throws Exception {
		mberAbsnceDAO.deleteMberAbsnce(userAbsnce);
	}

	/**
	 * 사용자부재정보가 특정화면에 반영된 결과를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectMberAbsnceResult(UserAbsnceVO userAbsnceVO) throws Exception {
		return null;
	}
}
