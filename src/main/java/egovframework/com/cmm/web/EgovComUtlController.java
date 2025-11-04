package egovframework.com.cmm.web;

import egovframework.com.cmm.EgovWebUtil;
import org.egovframe.rte.fdl.property.EgovPropertyService;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 공통유틸리티성 작업을 위한 Controller 클래스
 * @author 공통 서비스 개발팀 JJY
 * @since 2009.03.02
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일                수정자           수정내용
 *  ----------   --------   ---------------------------
 *  2009.03.02   JJY        최초 생성
 *  2011.08.31   JJY        경량환경 템플릿 커스터마이징버전 생성
 *  2021.02.23   신용호       moveToPage() 화이트리스트 처리
 *	2023.05.30   박형준       moveToPage() 추가 보완 조치
 *
 *  </pre>
 */
@Controller
public class EgovComUtlController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovComUtlController.class);
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "egovPageLinkWhitelist")
    protected List<String> egovWhitelist;
	
	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value = "/EgovPageLink.do")
	public String moveToPage(@RequestParam(value="linkIndex",required=true,defaultValue="0") Integer linkIndex,
			HttpSession session, @RequestParam(value = "baseMenuNo", required = false) String baseMenuNo) {
		
		String link = "";
		
		// 화이트 리스트가 비었는지 확인
		if (egovWhitelist == null || egovWhitelist.isEmpty() || egovWhitelist.size() <= linkIndex) {
			
			LOGGER.debug("Page Link WhiteList Error! Please check whitelist!");
			
			link="cmm/error/egovError";
			
			return link;
		}
		
		link = egovWhitelist.get(linkIndex);
		
		link = link.replace(";", "");
		link = link.replace("%", "");
		link = link.replace(".", "");
		
		if(link.indexOf(",")>-1){
		    link=link.substring(0,link.indexOf(","));
		}
		
		// 선택된 메뉴정보를 세션으로 등록한다.
		if (baseMenuNo != null && !baseMenuNo.equals("")) {
			session.setAttribute("menuNo", baseMenuNo);
			session.setAttribute("baseMenuNo", baseMenuNo);
		}
		
		// 안전한 경로 문자열로 조치
		link = EgovWebUtil.filePathBlackList(link);
		
		return link;
	}

	/**
	 * validation rule dynamic java script
	 */
	@RequestMapping("/validator.do")
	public String validate() {
		return "cmm/validator";
	}
	
	@RequestMapping(value="/smarteditorMultiImageUpload.do")
	public void smarteditorMultiImageUpload(HttpServletRequest request, HttpServletResponse response){
		try {
			//파일정보
			String sFileInfo = "";
			//파일명을 받는다 - 일반 원본파일명
			String sFilename = request.getHeader("file-name");
			//파일 확장자
			String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".")+1);
			//확장자를소문자로 변경
			sFilenameExt = sFilenameExt.toLowerCase();
				
			//이미지 검증 배열변수
			String[] allowFileArr = {"jpg","png","bmp","gif"};

			//확장자 체크
			int nCnt = 0;
			for(int i=0; i<allowFileArr.length; i++) {
				if(sFilenameExt.equals(allowFileArr[i])){
					nCnt++;
				}
			}

			//이미지가 아니라면
			if(nCnt == 0) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_"+sFilename);
				print.flush();
				print.close();
			} else {
				//디렉토리 설정 및 업로드
				//String basepath = "C:/STS/workspace/ktbus_biz/src/main/webapp/contents/"; //로컬(개발자PC)
				String basepath = "/home/ktbus_biz/apache-tomcat-9.0.107/webapps/ROOT/contents/"; //운영서버
				
				//파일경로
				String filePath = basepath + "commoneditor"+ File.separator;
				
				File file = new File(filePath);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				String sRealFileNm = "";
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String today= formatter.format(new java.util.Date());
				sRealFileNm = today+UUID.randomUUID().toString() + sFilename.substring(sFilename.lastIndexOf("."));
				String rlFileNm = filePath + sRealFileNm;
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				InputStream inputStream = request.getInputStream();
				OutputStream outputStream=new FileOutputStream(rlFileNm);
				int numRead;
				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
				while((numRead = inputStream.read(bytes,0,bytes.length)) != -1){
					outputStream.write(bytes,0,numRead);
				}
				if(inputStream != null) {
					inputStream.close();
				}
				outputStream.flush();
				outputStream.close();
				
				///////////////// 이미지 /////////////////
				// 정보 출력
				sFileInfo += "&bNewLine=true";				
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName="+ sFilename;
				sFileInfo += "&sFileURL=/contents/commoneditor/"+sRealFileNm;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}