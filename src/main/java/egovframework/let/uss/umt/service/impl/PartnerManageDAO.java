package egovframework.let.uss.umt.service.impl;

import java.util.List;

import egovframework.let.uss.umt.service.PartnerManageVO;
import egovframework.let.uss.umt.service.UserDefaultVO;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * 일반회원관리에 관한 데이터 접근 클래스를 정의한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  JJY            최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("partnerManageDAO")
public class PartnerManageDAO extends EgovAbstractMapper{

    /**
     * 기 등록된 특정 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param userSearchVO 검색조건
     * @return List<PartnerManageVO> 기업회원 목록정보
     */
    @SuppressWarnings("unchecked")
	public List<PartnerManageVO> selectPartnerList(UserDefaultVO userSearchVO){
        return (List<PartnerManageVO>) list("partnerManageDAO.selectPartnerList", userSearchVO);
    }

    /**
     * 일반회원 총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return int 일반회원총갯수
     */
    public int selectPartnerListTotCnt(UserDefaultVO userSearchVO) {
        return (Integer)selectOne("partnerManageDAO.selectPartnerListTotCnt", userSearchVO);
    }

    /**
     * 화면에 조회된 일반회원의 정보를 데이터베이스에서 삭제
     * @param delId 삭제 대상 일반회원아이디
     */
    public void deletePartner(String delId){
        delete("partnerManageDAO.deletePartner_S", delId);
    }

    /**
     * 일반회원의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
     * @param partnerManageVO 일반회원 등록정보
     * @return String 등록결과
     */
    public int insertPartner(PartnerManageVO partnerManageVO){
        return insert("partnerManageDAO.insertPartner_S", partnerManageVO);
    }

    /**
     * 기 등록된 사용자 중 검색조건에 맞는일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param mberId 상세조회대상 일반회원아이디
     * @return PartnerManageVO 일반회원 상세정보
     */
    public PartnerManageVO selectPartner(String mberId){
        return (PartnerManageVO) selectOne("partnerManageDAO.selectPartner_S", mberId);
    }

    /**
     * 화면에 조회된일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
     * @param partnerManageVO 일반회원수정정보
     */
    public void updatePartner(PartnerManageVO partnerManageVO){
        update("partnerManageDAO.updatePartner_S",partnerManageVO);
    }

    /**
     * 일반회원 약관확인
     * @param stplatId 일반회원약관아이디
     * @return List 일반회원약관정보
     */
	public List<?> selectStplat(String stplatId){
    	return list("partnerManageDAO.selectStplat_S", stplatId);
    }

    /**
     * 일반회원 암호수정
     * @param passVO 기업회원수정정보(비밀번호)
     */
    public void updatePassword(PartnerManageVO passVO) {
        update("partnerManageDAO.updatePassword_S", passVO);
    }

    /**
     * 일반회원이 비밀번호를 기억하지 못할 때 비밀번호를 찾을 수 있도록 함
     * @param partnerManageVO 일반회원암호 조회조건정보
     * @return PartnerManageVO 일반회원 암호정보
     */
    public PartnerManageVO selectPassword(PartnerManageVO partnerManageVO){
    	return (PartnerManageVO) selectOne("partnerManageDAO.selectPassword_S", partnerManageVO);
    }

    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
     * @param checkId 중복체크대상 아이디
     * @return int 사용가능여부(아이디 사용회수 )
     */
    public int checkIdDplct(String checkId){
        return (Integer)selectOne("partnerManageDAO.checkIdDplct_S", checkId);
    }

}