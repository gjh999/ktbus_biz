package egovframework.let.mss.maa.web;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.cmm.util.ExtHttpRequestParam;
import egovframework.let.cmm.util.IBSheetUtil;
import egovframework.let.mss.maa.service.MaaService;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * 
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.19
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  이삼섭          최초 생성
 *  2009.06.29  한성곤	       2단계 기능 추가 (댓글관리, 만족도조사)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Controller
public class MaaController {

	@Resource(name = "maaService")
	private MaaService maaService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@RequestMapping({ "/mss/maa/mir3500.do" })
	public String getMir3500Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "3000000");

		Map<Object, Object> searchData = new HashMap<>();

		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			
			   String orgnztId = user.getOrgnztId();
		        if ("ORGNZT_0000000000000".equals(orgnztId)) {
		            orgnztId = "010006";
		        }
		        
			searchData.put("groupNm", user.getGroupNm());
			searchData.put("bizNo", user.getId()/*.substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10)*/);
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", orgnztId);
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "maa/mir3500";

	}
	
	
	@RequestMapping({ "/mss/maa/mm3600jList.do" })
	public ModelAndView selectEmp(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();

		if ("Y".equals(String.valueOf(map.get("isAdminYn")))) {
			// 입력한 조합원 정보 셋팅
			Map<String, String> jibuInfo = maaService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU", jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명			
			map.put("JOHAP", jibuInfo.get("CBCNM1").trim()); // 조합원명
			map.put("SAUP" ,jibuInfo.get("CBSAU").trim()); // 사업자번호
		} 
		List<?> data = this.maaService.mm3600jList(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView modelA = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return modelA;
	}
	

	@RequestMapping(value = "/mss/maa/mir3700.do")
	public String getMir3700Page(HttpServletRequest request, ModelMap model) throws Exception {
		return "maa/mir3700";

	}
	
	
	
	@RequestMapping({ "/mss/maa/mrr5110.do" })
	public String getMrr5110Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "3000000");

		Map<Object, Object> searchData = new HashMap<>();
		
		
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			
			   String orgnztId = user.getOrgnztId();
		        if ("ORGNZT_0000000000000".equals(orgnztId)) {
		            orgnztId = "010006";
		        }
			
			searchData.put("groupNm", user.getGroupNm());
			searchData.put("bizNo", user.getId()/*.substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10)*/);
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode",orgnztId);
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "maa/mrr5110";

	}
	
	@RequestMapping({ "/mss/maa/mrr5110List.do" })
	public ModelAndView Mrr5110List(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();

		if ("Y".equals(String.valueOf(map.get("isAdminYn")))) {
			// 입력한 조합원 정보 셋팅
			Map<String, String> jibuInfo = maaService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU", jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명			
			map.put("JOHAP", jibuInfo.get("CBCNM1").trim()); // 조합원명
			map.put("SAUP" ,jibuInfo.get("CBSAU").trim()); // 사업자번호
		} 
		List<?> data = this.maaService.mrr5110List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		map.put("HYMD", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView modelA = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return modelA;
	}
	
	@RequestMapping({ "/mss/maa/mrr5410.do" })
	public String getMrr5410Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "3000000");

		Map<Object, Object> searchData = new HashMap<>();

		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			
			   String orgnztId = user.getOrgnztId();
		        if ("ORGNZT_0000000000000".equals(orgnztId)) {
		            orgnztId = "010006";
		        }
		        
			searchData.put("groupNm", user.getGroupNm());
			searchData.put("bizNo", user.getId()/*.substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10)*/);
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", orgnztId);
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "maa/mrr5410";

	}
	
	@RequestMapping({ "/mss/maa/mrr5410List.do" })
	public ModelAndView Mrr5410List(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = maaService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
		}
		List<?> data = this.maaService.mrr5410List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		map.put("HYMD", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model4 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model4;
	}

}
