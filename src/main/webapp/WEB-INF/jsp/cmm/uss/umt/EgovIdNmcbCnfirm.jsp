<%--
  Class Name : EgovIdNmcbCnfirm.jsp
  Description : 아이디중복확인
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY       최초 생성
     2011.08.31   JJY       경량환경 버전 생성
     2023.06.09   우시재 		NSR 보안조치 (아이디 중복 검사 크로스사이트 스크립트 방지)
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Nmcb ID중복확인</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<base target="_self">
<script type="text/javaScript">
function fnCheckId(){
	if(document.checkForm.checkId.value==""){
		alert("중복조회할 아이디를 입력하십시오.");
		document.checkForm.focus();
        return;
	}
	if(fnCheckNotKorean(document.checkForm.checkId.value)){
		document.checkForm.submit();
    }else{
    	alert("한글은 사용할 수 없습니다.");
        return;
    }
}
function fnReturnId(){
	var retVal = new Map();
    if (document.checkForm.usedCnt.value == 0){
    	alert("존재하지 않는 아이디입니다.");
        return;
    }else if (document.checkForm.usedCnt.value == 1){
        alert("이미 사용중인 아이디입니다.");
        return;
    }else if (document.checkForm.usedCnt.value == -1){
    	alert("먼저 중복확인을 실행하십시오");
        return;
    } else {
    	retVal.set("resultId", document.checkForm.resultId.value);
    	retVal.set("partnerNm", document.checkForm.partnerNm.value);
    	retVal.set("ceoNm", document.checkForm.ceoNm.value);
    	retVal.set("ceoMoblphonNo", document.checkForm.ceoMoblphonNo.value);
    	retVal.set("offmTelno", document.checkForm.offmTelno.value);
    	retVal.set("offmFaxno", document.checkForm.offmFaxno.value);
    	retVal.set("picNm", document.checkForm.picNm.value);
    	retVal.set("picMoblphonNo", document.checkForm.picMoblphonNo.value);
    	retVal.set("picDeptNm", document.checkForm.picDeptNm.value);
    	retVal.set("picEmailAdres", document.checkForm.picEmailAdres.value);
    	retVal.set("bizNo1", document.checkForm.bizNo1.value);
    	retVal.set("bizNo2", document.checkForm.bizNo2.value);
    	retVal.set("bizNo3", document.checkForm.bizNo3.value);
    	retVal.set("corpNo1", document.checkForm.corpNo1.value);
    	retVal.set("corpNo2", document.checkForm.corpNo2.value);
	    parent.showModalDialogCallback2(retVal);
    }
}
function fnClose(){
    var retVal="";
    parent.showModalDialogCallback(retVal);
    parent.fn_egov_modal_remove();
}
function fnCheckNotKorean(koreanStr){                  
    for(var i=0;i<koreanStr.length;i++){
        var koreanChar = koreanStr.charCodeAt(i);
        if( !( 0xAC00 <= koreanChar && koreanChar <= 0xD7A3 ) && !( 0x3131 <= koreanChar && koreanChar <= 0x318E ) ) { 
        }else{
            //hangul finding....
            return false;
        }
    }
    return true;
}
</script>

</head>
<body>

	<form name="checkForm" action ="<c:url value='/uss/umt/cmm/EgovIdNmcbCnfirm.do'/>">

    <!-- 아이디중복확인 팝업 -->
    <div class="popup POP_DUPID_CONF">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>Nmcb 아이디 조회하기</h1>
                <button type="button" class="close" onclick="fnClose(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <div class="box_1">
                    <label for="mid">조회할 아이디</label>
                    <input type="hidden" name="resultId" value="<c:out value="${checkId}"/>" />
                    <input type="hidden" name="usedCnt" value="<c:out value="${usedCnt}"/>" />
                    <input type="hidden" name="partnerNm" value="<c:out value="${resultVO.partnerNm}"/>" />
                    <input type="hidden" name="ceoNm" value="<c:out value="${resultVO.ceoNm}"/>" />
                    <input type="hidden" name="ceoMoblphonNo" value="<c:out value="${resultVO.ceoMoblphonNo}"/>" />
                    <input type="hidden" name="offmTelno" value="<c:out value="${resultVO.offmTelno}"/>" />
                    <input type="hidden" name="offmFaxno" value="<c:out value="${resultVO.offmFaxno}"/>" />
                    <input type="hidden" name="picNm" value="<c:out value="${resultVO.picNm}"/>" />
                    <input type="hidden" name="picMoblphonNo" value="<c:out value="${resultVO.picMoblphonNo}"/>" />
                    <input type="hidden" name="picDeptNm" value="<c:out value="${resultVO.picDeptNm}"/>" />
                    <input type="hidden" name="picEmailAdres" value="<c:out value="${resultVO.picEmailAdres}"/>" />
                    <input type="hidden" name="bizNo1" value="<c:out value="${resultVO.bizNo1}"/>" />
                    <input type="hidden" name="bizNo2" value="<c:out value="${resultVO.bizNo2}"/>" />
                    <input type="hidden" name="bizNo3" value="<c:out value="${resultVO.bizNo3}"/>" />
                    <input type="hidden" name="corpNo1" value="<c:out value="${resultVO.corpNo1}"/>" />
                    <input type="hidden" name="corpNo2" value="<c:out value="${resultVO.corpNo2}"/>" />
                    <input id="mid" class="f_txt2 ml15" type="text" name="checkId" title="선택여부" value="<c:out value="${checkId}"/>" maxlength="20" />
                </div>

                <p class="result">
                    <!-- 결과 : 중복확인을 실행하십시오. -->
                    결과 : 
                    <c:choose>
                    	<c:when test="${usedCnt eq -1}">
                    		&nbsp; 중복확인을 실행하십시오
                    	</c:when>
                    	<c:when test="${usedCnt eq 0}">
                    		<span><c:out value="${checkId}"/></span> 는 존재하지 않는 아이디입니다.
                    	</c:when>
                    	<c:when test="${usedCnt eq 1}">
                    		<span><c:out value="${resultVO.partnerNm}"/></span> 는 이미 가입한 아이디입니다.
                    	</c:when>
                    	<c:otherwise>
                    		<span><c:out value="${resultVO.partnerNm}"/></span> 는 가입 가능한 아이디입니다.
                    	</c:otherwise>
                    </c:choose>
                </p>

                <div class="btn_area al_c pt20">
                    <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fnCheckId(); return false;"><spring:message code="button.inquire" /></a><!-- 조회하기 -->
                    <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fnReturnId(); return false;"><spring:message code="button.use" /></a><!-- 사용하기 -->
                </div>
            </div>
        </div>
    </div>
    <!--// 아이디중복확인 팝업 -->
    
    </form>
    
</body>
</html>