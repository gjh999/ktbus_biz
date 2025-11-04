package egovframework.let.mss.maa.service;

import java.io.Serializable;

/**
 * 템플릿 메인화면 작업 List 항목 VO(Sample 소스)
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.08.31  JJY            최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class MaaMainContentsVO implements Serializable {
	
	private String FYY;

	public String getFYY() {
		return FYY;
	}

	public void setFYY(String fYY) {
		FYY = fYY;
	}

	

}