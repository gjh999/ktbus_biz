package egovframework.let.mss.tot.web;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.cmm.util.ExtHttpRequestParam;
import egovframework.let.cmm.util.IBSheetUtil;
import egovframework.let.mss.tot.service.TotResultsService;
import egovframework.let.mss.tot.web.TotController;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TotController {
	private Logger logger = Logger.getLogger(getClass());

	@Resource(name = "totResultsService")
	private TotResultsService totResultsService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@RequestMapping({ "/mss/tot/tot01.do" })
	public String getTot01Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
						+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot01";
	}

	@RequestMapping({ "/mss/tot/tot02.do" })
	public String getTot02Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		
		Map<Object, Object> searchData = new HashMap<>();
		
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot02";
	}

	@RequestMapping({ "/mss/tot/tot03.do" })
	public String getTot03Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot03";
	}

	@RequestMapping({ "/mss/tot/tot04.do" })
	public String getTot04Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot04";
	}

	@RequestMapping({ "/mss/tot/tot05.do" })
	public String getTot05Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot05";
	}

	@RequestMapping({ "/mss/tot/tot06.do" })
	public String getTot06Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		
		
		
		model.addAttribute("searchData", searchData);
		return "tot/tot06";
	}

	@RequestMapping({ "/mss/tot/tot07.do" })
	public String getTot07Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot07";
	}

	@RequestMapping({ "/mss/tot/tot08.do" })
	public String getTot08Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot08";
	}

	@RequestMapping({ "/mss/tot/tot09.do" })
	public String getTot09Page(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "2000000");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated.booleanValue())
			return "uat/uia/EgovLoginUsr";
		Map<Object, Object> searchData = new HashMap<>();
		LoginVO user = EgovUserDetailsHelper.isAuthenticated().booleanValue()
				? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated().booleanValue() && user != null) {
			searchData.put("groupNm", user.getGroupNm());
			if (!"ORGNZT_0000000000000".equals(user.getOrgnztId()))
				searchData.put("bizNo", user.getId().substring(0, 3) + "-" + user.getId().substring(3, 5) + "-"
					+ user.getId().substring(5, 10));
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode", user.getOrgnztId());
		}
		model.addAttribute("searchData", searchData);
		return "tot/tot09";
	}

	@RequestMapping({ "/mss/tot/tot01List.do" })
	public ModelAndView selectEmp(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();

		if ("Y".equals(String.valueOf(map.get("isAdminYn")))) {
			// 입력한 조합원 정보 셋팅
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU", jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명			
			map.put("JOHAP", jibuInfo.get("CBCNM1").trim()); // 조합원명
			map.put("SAUP" ,jibuInfo.get("CBSAU").trim()); // 사업자번호
		} 
		List<?> data = this.totResultsService.tot01List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT01");
		menuInfo.put("HTMNAME", "수입분담금");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView modelA = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
//		modelA.addObject("load", map); 
		return modelA;
	}
	@RequestMapping({ "/mss/tot/tot02List.do" })
	public ModelAndView selectEmp02(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model)
			throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if ("Y".equals(String.valueOf(map.get("isAdminYn")))) {
			// 입력한 조합원 정보 셋팅
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU", jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP", jibuInfo.get("CBCNM1").trim()); // 조합원명
		}
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT02");
		menuInfo.put("HTMNAME", "사고발생율");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		List<?> data = this.totResultsService.tot02List(map);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model1 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model1;
	}

	@RequestMapping({ "/mss/tot/tot03List.do" })
	public ModelAndView selectEmp03(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if ("Y".equals(String.valueOf(map.get("isAdminYn")))) {
			// 입력한 조합원 정보 셋팅
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU", jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP", jibuInfo.get("CBCNM1").trim()); // 조합원명
		}
		List<?> data = this.totResultsService.tot03List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT03");
		menuInfo.put("HTMNAME", "사고일자별접수");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model2 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model2;
	}

	@RequestMapping({ "/mss/tot/tot04List.do" })
	public ModelAndView selectEmp04(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
		}
		List<?> data = this.totResultsService.tot04List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT04");
		menuInfo.put("HTMNAME", "운전자별사고건수");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model3 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model3;
	}

	@RequestMapping({ "/mss/tot/tot05List.do" })
	public ModelAndView selectEmp05(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
		}
		List<?> data = this.totResultsService.tot05List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT05");
		menuInfo.put("HTMNAME", "만기갱신안내");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model4 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model4;
	}

	@RequestMapping({ "/mss/tot/tot06List.do" })
	public ModelAndView selectEmp06(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
		}
		List<?> data = this.totResultsService.tot06List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT06");
		menuInfo.put("HTMNAME", "자부담금대상");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model5 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model5;
	}

	@RequestMapping({ "/mss/tot/tot07List.do" })
	public ModelAndView selectEmp07(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
		}
		List<?> data = this.totResultsService.tot07List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT07");
		menuInfo.put("HTMNAME", "환급금이체내역");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model6 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model6;
	}

	@RequestMapping({ "/mss/tot/tot08List.do" })
	public ModelAndView selectEmp08(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		if( "Y".equals(String.valueOf(map.get("isAdminYn")))){
			// 입력한 조합원 정보 셋팅 
			Map<String, String> jibuInfo = totResultsService.selectJibuInfo(String.valueOf(map.get("JOCODE")));
			map.put("JIBU" ,jibuInfo.get("CBFLD1")); // 관리지부
			map.put("JIBUNM", jibuInfo.get("CASIDO")); // 관리지부명
			map.put("JOHAP" ,jibuInfo.get("CBCNM1").trim()); // 조합원명			
			map.put("CBSAU" ,jibuInfo.get("CBSAU").trim()); // 사업자번호 			
		}
		List<?> data = this.totResultsService.tot08List(map);
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		Map<String, String> menuInfo = new HashMap<>();
		menuInfo.put("IYMD", today);
		menuInfo.put("CACOD", String.valueOf(map.get("JOCODE")));
		menuInfo.put("CANAME", String.valueOf(map.get("JOHAP")));
		menuInfo.put("HTMLID", "TOT08");
		menuInfo.put("HTMNAME", "계약유효차량");
		menuInfo.put("CNT", "1");
		this.totResultsService.countHomeLogCnt(menuInfo);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model8 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model8;
	}

	@RequestMapping({ "/mss/tot/tot09List.do" })
	public ModelAndView selectEmp09(ExtHttpRequestParam _req, @RequestParam Map<String, Object> map, ModelMap model,
			LoginVO loginVO) throws Exception {
		IBSheetUtil ibUtil = new IBSheetUtil();
		List<?> data = this.totResultsService.tot09List(map);
		System.out.println("param" + map);
		ibUtil.setData(data);
		ModelAndView model7 = new ModelAndView("jsonView", (Map) ibUtil.getSearchJSON());
		return model7;
	}
}
