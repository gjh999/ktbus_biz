package egovframework.let.uat.uia.service.impl;

import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.umt.service.PartnerManageVO;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@Repository("loginDAO2")
public class LoginDAO2 extends EgovAbstractMapper {
	@Resource(name = "egov.sqlSessionTemplate2")
    private SqlSession sqlSessionTemplate2;
    
    /**
	 * nmcb 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO nmcbLogin(LoginVO vo) throws Exception {
    	return (LoginVO)sqlSessionTemplate2.selectOne("loginDAO2.nmcbLogin", vo);
    }
    
    /**
	 * nmcb 조합(파트너) 아이디를 찾는다 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public PartnerManageVO nmcbSearch(LoginVO vo) throws Exception {
    	return (PartnerManageVO)sqlSessionTemplate2.selectOne("loginDAO2.nmcbSearch", vo);
    }

}
