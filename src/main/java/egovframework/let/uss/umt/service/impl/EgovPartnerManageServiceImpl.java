package egovframework.let.uss.umt.service.impl;

import java.util.List;

import egovframework.let.sec.rgm.service.AuthorGroup;
import egovframework.let.sec.rgm.service.impl.AuthorGroupDAO;
import egovframework.let.uss.umt.service.EgovMberManageService;
import egovframework.let.uss.umt.service.EgovPartnerManageService;
import egovframework.let.uss.umt.service.PartnerManageVO;
import egovframework.let.uss.umt.service.PartnerManageVO;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.utl.sim.service.EgovFileScrty;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 일반회원관리에 관한비지니스클래스를 정의한다.
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
@Service("partnerManageService")
public class EgovPartnerManageServiceImpl extends EgovAbstractServiceImpl implements EgovPartnerManageService {

	/** partnerManageDAO */
	@Resource(name="partnerManageDAO")
	private PartnerManageDAO partnerManageDAO;

	/** egovUsrCnfrmIdGnrService */
	@Resource(name="egovUsrCnfrmIdGnrService")
	private EgovIdGnrService idgenService;
	
	/** authorGroupDAO */
	@Resource(name="authorGroupDAO")
	private AuthorGroupDAO authorGroupDAO;

	/**
	 * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param partnerManageVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	@Override
	public int insertPartner(PartnerManageVO partnerManageVO) throws Exception  {
		
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		partnerManageVO.setUniqId(uniqId);
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword(partnerManageVO.getPassword(), partnerManageVO.getEntrprsMberId());
		partnerManageVO.setPassword(pass);
		
		int result = 0;
		try {
			String bizNo = partnerManageVO.getBizNo1() + "-" + partnerManageVO.getBizNo2() + "-" + partnerManageVO.getBizNo3();
			String corpNo = partnerManageVO.getCorpNo1() + "-" + partnerManageVO.getCorpNo2();
			partnerManageVO.setBizNo(bizNo);
			partnerManageVO.setBizNo(corpNo);
		    result = partnerManageDAO.insertPartner(partnerManageVO);
		    // 회원가입시 유저권한 매핑 테이블에도 넣어줘야함
			AuthorGroup authorGroup = new AuthorGroup();
			authorGroup.setUniqId(uniqId);
			authorGroup.setMberTyCode("USR");
			authorGroup.setAuthorCode("ROLE_PARTNER");
			authorGroupDAO.insertAuthorGroup(authorGroup);
		} catch (NullPointerException e) { // NullPointerException 처리
		    System.err.println("널 포인터 예외 발생: 데이터가 null일 수 있습니다.");
		    e.printStackTrace();
		} catch (Exception e) { // 기타 모든 예외 처리
		    System.err.println("예상치 못한 에러 발생: " + e.getMessage());
		    e.printStackTrace();
		}
		return result;
	}

	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param uniqId 상세조회대상 일반회원아이디
	 * @return partnerManageVO 일반회원상세정보
	 * @throws Exception
	 */
	@Override
	public PartnerManageVO selectMber(String uniqId) {
		PartnerManageVO partnerManageVO = partnerManageDAO.selectMber(uniqId);
		return partnerManageVO;
	}

	/**
	 * 기 등록된 회원 중 검색조건에 맞는 회원들의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<PartnerManageVO> 일반회원목록정보
	 */
	@Override
	public List<PartnerManageVO> selectMberList(UserDefaultVO userSearchVO) {
		return partnerManageDAO.selectMberList(userSearchVO);
	}

    /**
     * 일반회원 총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return 일반회원총갯수(int)
     */
    @Override
	public int selectMberListTotCnt(UserDefaultVO userSearchVO) {
    	return partnerManageDAO.selectMberListTotCnt(userSearchVO);
    }

	/**
	 * 화면에 조회된 일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param partnerManageVO 일반회원수정정보
	 * @throws Exception
	 */
	@Override
	public void updateMber(PartnerManageVO partnerManageVO) throws Exception {
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword(partnerManageVO.getPassword(), partnerManageVO.getEntrprsMberId());
		partnerManageVO.setPassword(pass);
		partnerManageDAO.updateMber(partnerManageVO);
	}

	/**
	 * 화면에 조회된 사용자의 정보를 데이터베이스에서 삭제
	 * @param checkedIdForDel 삭제대상 일반회원아이디
	 * @throws Exception
	 */
	@Override
	public void deleteMber(String checkedIdForDel)  {
		String [] delId = checkedIdForDel.split(",");
		for (int i=0; i<delId.length ; i++){
			String [] id = delId[i].split(":");
			if (id[0].equals("USR03")){
		        //업무사용자(직원)삭제
			}else if(id[0].equals("USR01")){
				//일반회원삭제
				partnerManageDAO.deleteMber(id[1]);
			}else if(id[0].equals("USR02")){
				//기업회원삭제
			}
		}
	}

	/**
	 * 일반회원 약관확인
	 * @param stplatId 일반회원약관아이디
	 * @return 일반회원약관정보(List)
	 * @throws Exception
	 */
	@Override
	public List<?> selectStplat(String stplatId)  {
        return partnerManageDAO.selectStplat(stplatId);
	}

	/**
	 * 일반회원암호수정
	 * @param partnerManageVO 일반회원수정정보(비밀번호)
	 * @throws Exception
	 */
	@Override
	public void updatePassword(PartnerManageVO partnerManageVO) {
		partnerManageDAO.updatePassword(partnerManageVO);
	}

	/**
	 * 일반회원이 비밀번호를 기억하지 못할 때 비밀번호를 찾을 수 있도록 함
	 * @param passVO 일반회원암호 조회조건정보
	 * @return partnerManageVO 일반회원암호정보
	 * @throws Exception
	 */
	@Override
	public PartnerManageVO selectPassword(PartnerManageVO passVO) {
		PartnerManageVO partnerManageVO = partnerManageDAO.selectPassword(passVO);
		return partnerManageVO;
	}

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	@Override
	public int checkIdDplct(String checkId) {
		return partnerManageDAO.checkIdDplct(checkId);
	}

}