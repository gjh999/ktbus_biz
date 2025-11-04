package egovframework.let.cmm.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * 
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일              수정자           수정내용
 *  ----------  --------   ---------------------------
 *  2011.08.31  JJY        최초 생성
 *  2021.08.12  신용호            추가 URL 생성
 *
 *      </pre>
 */
public class ViewHelper {
	public static final String JSON_VIEW_NAME = "jsonView";

	public static final String JQGRID_VIEW_NAME = "jqGridView";

	public static final String DOWNLOAD_VIEW_NAME = "downloadView";

	public static final String EXCEL_DOWNLOAD_VIEW_NAME = "excelDownView";

	public static ModelAndView getJsonView(Map<String, Object> jobj) {
		return new ModelAndView("jsonView", jobj);
	}

	public static ModelAndView getExcelView(Object object) {
		Map<String, Object> map = (Map<String, Object>) object;
		return new ModelAndView("excelDownView", map);
	}

	/*
	public static ModelAndView getDownloadView(FileDownloadInfo downLoadInfo) {
		Map<String, Object> map = new HashMap<>();
		map.put(ViewerSupport.FILE_SOURCE_KEY, downLoadInfo);
		return new ModelAndView("downloadView", map);
	}
	*/

	/*
	public static ModelAndView getJqGridView(NavigatorInfo navigator) {
		navigator.sync();
		Map<String, Object> map = new HashMap<>();
		map.put("page", Integer.valueOf(navigator.getPageNo()));
		map.put("size", Integer.valueOf(navigator.getPageSize()));
		map.put("records", Integer.valueOf(navigator.getTotalCnt()));
		map.put("total", Long.valueOf(navigator.getPageCount()));
		map.put("rows", navigator.getList());
		map.put("LISTOPVALUE", navigator.getListOpValue());
		map.put("param", navigator.getParam());
		return new ModelAndView("jqGridView", map);
	}
	*/

	/*
	public static ModelAndView getDatatableView(NavigatorInfo navigator) {
		navigator.sync();
		Map<String, Object> map = new HashMap<>();
		map.put("recordsTotal", Integer.valueOf(navigator.getTotalCnt()));
		map.put("recordsFiltered", Integer.valueOf(navigator.getTotalCnt()));
		map.put("data", navigator.getList());
		return new ModelAndView("jqGridView", map);
	}
	*/

	/*
	public static <T> String getJqGridView(ModelMap model, BaseVO paramVO, List<T> gridList) {
		Integer currentPage = paramVO.getMiv_pageNo();
		Integer pageSize = paramVO.getMiv_pageSize();
		Integer totalCount = Integer.valueOf(0);
		Integer maxPage = Integer.valueOf(0);
		if (gridList != null && gridList.size() > 0) {
			totalCount = Integer.valueOf(((BaseVO) gridList.get(0)).getTotal_cnt());
			maxPage = Integer.valueOf((totalCount.intValue() - 1) / pageSize.intValue() + 1);
		}
		model.addAttribute("page", currentPage);
		model.addAttribute("size", pageSize);
		model.addAttribute("records", totalCount);
		model.addAttribute("total", maxPage);
		model.addAttribute("rows", gridList);
		return "jqGridView";
	}
	*/
}
