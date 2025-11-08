package egovframework.let.mss.veh.web;

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
import egovframework.let.mss.veh.service.VehService;

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
public class VehController {

	@Resource(name = "vehService")
	private VehService vehService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@RequestMapping({ "/mss/veh/vehicleReplace.do" })
	public String getVehiclePage(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "7000000");

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
			searchData.put("bizNo", user.getId());
			searchData.put("companyName", user.getOrgnztNm());
			searchData.put("johapcode",orgnztId);
			searchData.put("groupId", user.getGroupId());
		}
		model.addAttribute("searchData", searchData);
		return "veh/vehicleReplace";

	}
	
	@RequestMapping({ "/mss/veh/vehicleResult.do" })
	public String getVehicleResult(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "7000000");

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
		return "veh/vehicleResult";

	}
	
	@RequestMapping({ "/mss/veh/vehicleApproval.do" })
	public String getVehicleApproval(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "7000000");

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
		return "veh/vehicleApproval";

	}
	
	@RequestMapping({ "/mss/veh/vehicleGraph.do" })
	public String getVehicleGraph(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "7000000");

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
		return "veh/vehicleGraph";

	}


}
