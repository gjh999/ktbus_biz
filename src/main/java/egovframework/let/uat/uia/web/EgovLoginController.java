package egovframework.let.uat.uia.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.util.PasswordEncoderForMigration;
import egovframework.com.cmm.util.SimpleSHA1PasswordEncoder;
import egovframework.let.cmm.util.ObjectUtil;
import egovframework.let.cmm.util.StringUtil;
import egovframework.let.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.uss.umt.service.EgovMberManageService;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.MberManageVO;
import egovframework.let.uss.umt.service.UserManageVO;
import egovframework.let.utl.sim.service.EgovClntInfo;
import egovframework.let.utl.sim.service.EgovFileScrty;

import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;


/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
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
@Controller
public class EgovLoginController {

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;
	
	/** userManageService */
	@Resource(name = "userManageService")
	private EgovUserManageService userManageService;
	
	/** cmmnDetailCodeManageService */
	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovLoginPolicyService */
	@Resource(name = "egovLoginPolicyService")
	EgovLoginPolicyService egovLoginPolicyService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** TRACE */
	@Resource(name = "leaveaTrace")
	LeaveaTrace leaveaTrace;

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "uat/uia/EgovLoginUsr";
	}

	/**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionSecurityLogin.do")
	public String actionSecurityLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {

		// 접속IP
		String userIp = EgovClntInfo.getClntIP(request);
		
		// 1. 일반 로그인 처리 (loginType에 따른 분기)
		LoginVO resultVO = new LoginVO();
		LoginPolicyVO loginPolicyVO = new LoginPolicyVO();
		String loginType = loginVO.getLoginType();
		String orgPassword = loginVO.getPassword();
		
		if("user".equals(loginType)) {
			resultVO = loginService.actionLogin(loginVO);
			loginPolicyVO.setEmplyrId(resultVO.getId());
			loginPolicyVO = egovLoginPolicyService.selectLoginPolicy(loginPolicyVO);
		} else {
			// nmcb 조합 DB 조회
			resultVO = loginService.nmcbLogin(loginVO);
			
			PasswordEncoderForMigration passwordEncoderForMigration = new PasswordEncoderForMigration((PasswordEncoder)new BCryptPasswordEncoder(), new PasswordEncoder[] { (PasswordEncoder)new SimpleSHA1PasswordEncoder() });
			//PasswordEncoder passwordEncoder = new PasswordEncoderForMigration(new BCryptPasswordEncoder(),new SimpleSHA1PasswordEncoder());
		      
		     /*
		     if(!passwordEncoderForMigration.matches(orgPassword, resultVO.getPassword())) {
		    	 System.out.print("다름4");
		    	 resultVO.setId("");
		     } else {
		    	 System.out.print("같음44");
		     }*/
			
			if(!ObjectUtils.isEmpty(resultVO.getId())) {
				// 회원정보가 없으면 등록 있으면 수정
				orgPassword = resultVO.getPassword();
				loginVO.setPassword(orgPassword);
				//String enpassword = EgovFileScrty.encryptPassword(orgPassword, resultVO.getId());
				//loginVO.setPassword(enpassword);
				LoginVO checkVO = loginService.actionLogin(loginVO);
				
				UserManageVO userManageVO = new UserManageVO();
				userManageVO.setEmplyrId(resultVO.getId());
				userManageVO.setPassword(orgPassword);
				userManageVO.setEmplyrNm(resultVO.getName());
				userManageVO.setOrgnztId(resultVO.getOrgnztId());
				userManageVO.setOrgnztNm(resultVO.getCompanyName());
				userManageVO.setPasswordHint("P01");
				userManageVO.setPasswordCnsr(resultVO.getUniqId());
				userManageVO.setEmplyrSttusCode("P");
				userManageVO.setOfcpsNm(resultVO.getCompanyName());
				userManageVO.setGroupId(resultVO.getGroupId());
				
				CmmnDetailCode cmmnDetailCode = new CmmnDetailCode();
				cmmnDetailCode.setCodeId("COM025");
				cmmnDetailCode.setCodeNm(resultVO.getCompanyName());
				cmmnDetailCode.setCode(resultVO.getOrgnztId());
				
				CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
				
				if(ObjectUtils.isEmpty(vo)) {
					cmmnDetailCode.setFrstRegisterId(loginVO.getUniqId());
			    	cmmnDetailCodeManageService.insertCmmnDetailCode(cmmnDetailCode);
			    	
			    	// 조직명 추가
			    	userManageService.insertOrgnztId(userManageVO);
				}
				
				if(!ObjectUtils.isEmpty(checkVO.getId())) {
					userManageService.updateUser(userManageVO);
					resultVO.setUniqId(checkVO.getUniqId());
				} else {
					
					String uniqId = userManageService.insertUser(userManageVO);
					resultVO.setUniqId(uniqId);
				}
			}
			loginPolicyVO.setEmplyrId(resultVO.getId());
			loginPolicyVO.setLmttAt("N");
		}

		boolean loginPolicyYn = true;

		

		if (loginPolicyVO == null) {
			loginPolicyYn = true;
		} else {
			if (loginPolicyVO.getLmttAt().equals("Y")) {
				if (!userIp.equals(loginPolicyVO.getIpInfo())) {
					loginPolicyYn = false;
				}
			}
		}
		if("A".equals(resultVO.getEmplyrSttusCode())) {
			model.addAttribute("message", "회원가입 승인대기중입니다.");
			return "uat/uia/EgovLoginUsr";
			
		} else if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn && "USR".equals(resultVO.getUserSe())) {

			// 2. spring security 연동
			request.getSession().setAttribute("LoginVO", resultVO);

			UsernamePasswordAuthenticationFilter springSecurity = null;

			ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
						
			Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
			
			if (beans.size() > 0) {
				
				springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
				springSecurity.setUsernameParameter("egov_security_username");
				springSecurity.setPasswordParameter("egov_security_password");
				springSecurity.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(request.getServletContext().getContextPath() +"/egov_security_login", "POST"));
				
			} else {
				throw new IllegalStateException("No AuthenticationProcessingFilter");
			}
			
			springSecurity.doFilter(new RequestWrapperForSecurity(request, resultVO.getUserSe()+ resultVO.getId(), resultVO.getUniqId()), response, null);
			
			return "forward:/cmm/main/mainPage.do"; // 성공 시 페이지.. (redirect 불가)

		} else {

			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
	}

	
	/**
	 * 로그인 후 메인화면으로 들어간다
	 * @param
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionMain.do")
	public String actionMain(HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {
				
		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		// isAuthenticated = true;
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 2. 메인 페이지 이동
		return "forward:/cmm/main/mainPage.do";
	}

	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("LoginVO", null);
		
		return "redirect:/egov_security_logout";
	}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}
	
	@Override
	public String getServletPath() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getRequestURI() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("egov_security_username")) {
			return username;
		}

		if (name.equals("egov_security_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}