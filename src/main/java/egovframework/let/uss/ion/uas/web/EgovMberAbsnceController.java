package egovframework.let.uss.ion.uas.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.ion.uas.service.EgovMberAbsnceService;
import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 사용자부재에 대한 controller 클래스를 정의한다.
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
@Controller
public class EgovMberAbsnceController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovMberAbsnceService")
	private EgovMberAbsnceService egovMberAbsnceService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 사용자부재 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/uss/ion/uas/selectMberAbsnceListView.do")
	public String selectMberAbsnceListView() throws Exception {

		return "/uss/ion/uas/EgovMberAbsnceList";
	}

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param mberAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/selectMberAbsnceList.do")
	public String selectMberAbsnceList(@RequestParam("selAbsnceAt") String selAbsnceAt, @ModelAttribute("mberAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userAbsnceVO.getPageUnit());
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt(selAbsnceAt);
		userAbsnceVO.setUserAbsnceList(egovMberAbsnceService.selectMberAbsnceList(userAbsnceVO));

		model.addAttribute("mberAbsnceList", userAbsnceVO.getUserAbsnceList());

		int totCnt = egovMberAbsnceService.selectMberAbsnceListTotCnt(userAbsnceVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/uas/EgovMberAbsnceList";
	}

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param mberAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/getMberAbsnce.do")
	public String selectMberAbsnce(@RequestParam("mberId") String mberId, @ModelAttribute("mberAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		userAbsnceVO.setUserId(mberId);
		model.addAttribute("mberAbsnce", egovMberAbsnceService.selectMberAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		UserAbsnceVO vo = (UserAbsnceVO) model.get("mberAbsnce");

		if (vo.getRegYn().equals("N"))
			return "/uss/ion/uas/EgovMberAbsnceRegist";
		else
			return "/uss/ion/uas/EgovMberAbsnceUpdt";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/addViewMberAbsnce.do")
	public String insertMberAbsnceView(@RequestParam("mberId") String mberId, @ModelAttribute("mberAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {
		userAbsnceVO.setUserId(mberId);
		model.addAttribute("mberAbsnce", egovMberAbsnceService.selectMberAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/uas/EgovMberAbsnceRegist";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/addMberAbsnce.do")
	public String insertMberAbsnce(@ModelAttribute("mberAbsnce") UserAbsnce userAbsnce, @ModelAttribute("mberAbsnceVO") UserAbsnceVO userAbsnceVO, BindingResult bindingResult,
			ModelMap model) throws Exception {

		beanValidator.validate(userAbsnce, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("mberAbsnceVO", userAbsnceVO);
			return "/uss/ion/msi/EgovMainImageRegist";
		} else {
			LoginVO mber = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(mber.getId());
			// userAbsnce.setLastUpdusrId("jung");

			model.addAttribute("mberAbsnce", egovMberAbsnceService.insertMberAbsnce(userAbsnce, userAbsnceVO));
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));

			return "/uss/ion/uas/EgovMberAbsnceUpdt";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/updtMberAbsnce.do")
	public String updateMberAbsnce(@ModelAttribute("mberAbsnce") UserAbsnce userAbsnce, BindingResult bindingResult, ModelMap model) throws Exception {

		if (bindingResult.hasErrors()) {
			model.addAttribute("mberAbsnceVO", userAbsnce);
			return "/uss/ion/uas/EgovMberAbsnceUpdt";
		} else {

			LoginVO mber = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(mber.getId());
			//userAbsnce.setLastUpdusrId("jung");

			egovMberAbsnceService.updateMberAbsnce(userAbsnce);
			return "forward:/uss/ion/uas/getMberAbsnce.do";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/removeMberAbsnce.do")
	public String deleteMberAbsnce(@ModelAttribute("mberAbsnce") UserAbsnce userAbsnce, ModelMap model) throws Exception {

		egovMberAbsnceService.deleteMberAbsnce(userAbsnce);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/ion/uas/selectMberAbsnceList.do";
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param mberAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/removeMberAbsnceList.do")
	public String deleteMberAbsnceList(@RequestParam("mberIds") String mberIds, @ModelAttribute("mberAbsnce") UserAbsnce userAbsnce, ModelMap model) throws Exception {

		String[] strMberIds = mberIds.split(";");

		for (int i = 0; i < strMberIds.length; i++) {
			userAbsnce.setUserId(strMberIds[i]);
			egovMberAbsnceService.deleteMberAbsnce(userAbsnce);
		}

		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/ion/uas/selectMberAbsnceList.do";
	}

	/**
	 * MyPage에 사용자부재정보를 제공하기 위해 목록을 조회한다.
	 * @param mberAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/uss/ion/uas/selectMberAbsnceMainList.do")
	public String selectMberAbsnceMainList(@ModelAttribute("mberAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt("A");
		userAbsnceVO.setUserAbsnceList(egovMberAbsnceService.selectMberAbsnceList(userAbsnceVO));

		model.addAttribute("mberAbsnceList", userAbsnceVO.getUserAbsnceList());

		return "/uss/ion/uas/EgovMberAbsnceMainList";
	}
}
