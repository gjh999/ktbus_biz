package egovframework.let.mss.tot.service;

import java.io.Serializable;

/**
 *  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.11   이삼섭          최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class TotResultsVO implements Serializable {
   
	private String FYY;
	private String HKCBSD;
	private String HKCBSQ;

	public String getFYY() {
		return FYY;
	}

	public void setFYY(String fYY) {
		FYY = fYY;
	}

	public String getHKCBSD() {
		return HKCBSD;
	}

	public void setHKCBSD(String hKCBSD) {
		HKCBSD = hKCBSD;
	}

	public String getHKCBSQ() {
		return HKCBSQ;
	}

	public void setHKCBSQ(String hKCBSQ) {
		HKCBSQ = hKCBSQ;
	}
	
	
}
