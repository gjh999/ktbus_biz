<%--
  Class Name : EgovUserInsert.jsp
  Description : 사용자등록View JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<title>내부업무 사이트 > 내부서비스관리 > 사용자등록관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="partnerManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
function showModalDialogCallback2(retVal) {
    if(retVal) {
        document.partnerManageVO.entrprsMberId.value = retVal.get("resultId");
        document.partnerManageVO.id_view.value = retVal.get("resultId");
        
        document.partnerManageVO.partnerNm.value = retVal.get("partnerNm");
        document.partnerManageVO.partnerNm_view.value = retVal.get("partnerNm");
        
        document.partnerManageVO.bizNo1.value = retVal.get("bizNo1");
        document.partnerManageVO.bizNo1_view.value = retVal.get("bizNo1");
        document.partnerManageVO.bizNo2.value = retVal.get("bizNo2");
        document.partnerManageVO.bizNo2_view.value = retVal.get("bizNo2");
        document.partnerManageVO.bizNo3.value = retVal.get("bizNo3");
        document.partnerManageVO.bizNo3_view.value = retVal.get("bizNo3");
        
        document.partnerManageVO.corpNo1.value = retVal.get("corpNo1");
        document.partnerManageVO.corpNo1_view.value = retVal.get("corpNo1");
        document.partnerManageVO.corpNo2.value = retVal.get("corpNo2");
        document.partnerManageVO.corpNo2_view.value = retVal.get("corpNo2");
        
        document.partnerManageVO.ceoNm.value = retVal.get("ceoNm");
        //document.partnerManageVO.ceoNm_view.value = retVal.get("ceoNm");
        document.partnerManageVO.ceoMoblphonNo.value = retVal.get("ceoMoblphonNo");
        //document.partnerManageVO.ceoMoblphonNo_view.value = retVal.get("ceoMoblphonNo");
        
        document.partnerManageVO.offmTelno.value = retVal.get("offmTelno");
        //document.partnerManageVO.offmTelno_view.value = retVal.get("offmTelno");
        document.partnerManageVO.offmFaxno.value = retVal.get("offmFaxno");
        //document.partnerManageVO.offmFaxno_view.value = retVal.get("offmFaxno");
        
        document.partnerManageVO.picNm.value = retVal.get("picNm");
        //document.partnerManageVO.picNm_view.value = retVal.get("picNm");
        document.partnerManageVO.picMoblphonNo.value = retVal.get("picMoblphonNo");
        //document.partnerManageVO.picMoblphonNo_view.value = retVal.get("picMoblphonNo");
        document.partnerManageVO.picDeptNm.value = retVal.get("picDeptNm");
        //document.partnerManageVO.picDeptNm_view.value = retVal.get("picDeptNm");
        document.partnerManageVO.picEmailAdres.value = retVal.get("picEmailAdres");
        //document.partnerManageVO.picEmailAdres_view.value = retVal.get("picEmailAdres");
        
        fn_egov_modal_remove();
    }
}
<!--
function fnIdCheck(){
//     var retVal;
//     var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
//     var varParam = new Object();
//     varParam.checkId = document.partnerManageVO.emplyrId.value;
//     var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
//     retVal = window.showModalDialog(url, varParam, openParam);
//     if(retVal) {
//         document.partnerManageVO.emplyrId.value = retVal;
//         document.partnerManageVO.id_view.value = retVal;
//     }
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/EgovIdNmcbCnfirmView.do'/>?" + '" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 600,
        height: 450
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}
function showModalDialogCallback(retVal) {
    if(retVal) {
        document.partnerManageVO.emplyrId.value = retVal;
        document.partnerManageVO.id_view.value = retVal;
        
        fn_egov_modal_remove();
    }
}
function fnListPage(){
    document.partnerManageVO.action = "<c:url value='/uat/uia/egovLoginUsr.do'/>"; 
    document.partnerManageVO.submit();
}
function fnInsert(){
    if(validatePartnerManageVO(document.partnerManageVO)){
        if(document.partnerManageVO.password.value != document.partnerManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.partnerManageVO.submit();
    }
}
function fn_egov_inqire_cert() {
    var url = '/uat/uia/EgovGpkiRegist.do';
    var popupwidth = '500';
    var popupheight = '400';
    var title = '인증서';

    Top = (window.screen.height - popupheight) / 3;
    Left = (window.screen.width - popupwidth) / 2;
    if (Top < 0) Top = 0;
    if (Left < 0) Left = 0;
    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
    PopUpWindow = window.open(url, title, Future)
    PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
    var frm = document.partnerManageVO;
    
    frm.subDn.value = dn;
}

/*
if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
    alert('메인 화면이 변경되거나 없습니다');
    this.close();
} else {
    opener.fn_egov_dn_info_setting(dn);
    this.close();
}
*/

function fn_egov_ZipSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(retVal){
	
	if (retVal) {
		document.getElementById("zip_view").value  = retVal.sAddr;
	}
	
	fn_egov_modal_remove();
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}
//-->

function execPostcode() {
  // autoload=false로 로드했을 경우:
  if (window.daum && daum.postcode && daum.postcode.load) {
    daum.postcode.load(openPostcode);
  } else {
    openPostcode();
  }
}

function openPostcode() {
  new daum.Postcode({
    oncomplete: function (data) {
      // 도로명/지번 중 선택된 최종 주소
      const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
      document.getElementById('zip').value = data.zonecode; // 5자리 우편번호
      document.getElementById('zip_view').value = data.zonecode; // 5자리 우편번호
      document.getElementById('address').value = addr;
      document.getElementById('detailAddress').focus();
    }
  }).open();
}
</script>

</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
						<!--<c:import url="/sym/mms/EgovMenuLeft.do" />-->
						<!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">회원가입</a></li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="partnerManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovPartnerSignUp.do" name="partnerManageVO" method="post" >
								<!-- 우편번호검색 -->
								<input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />

                                <h1 class="tit_1">조합 회원가입</h1>

                                <div id="partnerBoard" class="board_view2" >
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="entrprsMberId">조합아이디(partner)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_300">
                                                    <input type="text" maxlength="20" disabled="disabled" id="id_view" name="id_view" readonly="readonly">
                                                    <form:input path="entrprsMberId" id="entrprsMberId" title="사용자아이디" maxlength="20" type="hidden" />
                                                    <button type="button" class="btn" onclick="fnIdCheck();">조회</button>
                                                </span>
                                                <span class="f_txt_inner ml10">(중복체크)</span>
                                                <form:errors path="entrprsMberId" />
                                            </td>
                                            <td class="lb">
                                                <label for="emplyrNm">조합명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input type="text" id="partnerNm_view" name="partnerNm_view" class="f_txt w_full" disabled="disabled"  readonly="readonly">
                                                <form:input path="partnerNm" id="partnerNm" title="조합명" maxlength="50" type="hidden" />
                                                <form:errors path="partnerNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                        	<td class="lb">
                                                <label for="bizNo">사업자번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<input type="text" id="bizNo1_view" name="bizNo1" class="f_txt w_70" disabled="disabled"  readonly="readonly">
                                            	<form:input path="bizNo1" id="bizNo1" title="bizNo1" maxlength="3" type="hidden" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input type="text" id="bizNo2_view" name="bizNo2" class="f_txt w_70" disabled="disabled"  readonly="readonly">
                                                <form:input path="bizNo2" id="bizNo2" title="bizNo2" maxlength="2" type="hidden" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input type="text" id="bizNo3_view" name="bizNo3" class="f_txt w_100" disabled="disabled"  readonly="readonly">
                                                <form:input path="bizNo3" id="bizNo3" title="bizNo3" maxlength="5" type="hidden" />
                                            </td>
                                            <td class="lb">
                                                <label for="areaNo">법인번호</label>
                                                <!-- <span class="req">필수</span> -->
                                            </td>
                                            <td>
                                            	<input type="text" id="corpNo1_view" name="corpNo1" class="f_txt w_150" disabled="disabled"  readonly="readonly">
                                            	<form:input path="corpNo1" id="corpNo1" title="corpNo1" maxlength="20" type="hidden" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input type="text" id="corpNo2_view" name="corpNo2" class="f_txt w_150" disabled="disabled"  readonly="readonly">
                                                <form:input path="corpNo2" id="corpNo2" title="corpNo2" maxlength="20" type="hidden" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="ceoNm">대표자명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<!-- <input type="text" id="ceoNm_view" name="ceoNm" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="ceoNm" id="ceoNm" title="대표자명" maxlength="15" type="hidden" /> --%>
                                                <form:input path="ceoNm" id="ceoNm" title="대표자명" maxlength="5" class="f_txt w_full" />
                                                <form:errors path="ceoNm" />
                                            </td>
                                            <td class="lb">
                                                <label for=ceoMoblphonNo>대표자 휴대폰번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<!-- <input type="text" id="ceoMoblphonNo_view" name="ceoMoblphonNo" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="ceoMoblphonNo" id="ceoMoblphonNo" title="대표자 휴대폰번호" maxlength="15" type="hidden" /> --%>
                                                <form:input path="ceoMoblphonNo" id="ceoMoblphonNo" title="대표자 휴대폰번호" maxlength="15" class="f_txt w_full" />
                                                <form:errors path="ceoMoblphonNo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="adres">주소</label>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_300">
                                                    <form:input path="" id="zip_view" title="주소" maxlength="100" readonly="true" />
                                                    <form:errors path="" />
                                                    <form:hidden path="zip" />
                                                    <button type="button" class="btn" onclick="execPostcode();">조회</button> 
                                                </span>
                                                <form:errors path="zip" />
                                                <br/>
                                                <br/>
                                                <form:input path="adres" id="address" title="기본주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="adres" />
                                                <input name="zip_view" id="zip_view" type="hidden" title="우편번호" value="<c:out value='${mberManageVO.zip}'/>" maxlength="8" readonly="readonly" />
                                            </td>
                                            <td class="lb">
                                                <label for="detailAdres">상세주소</label>
                                            </td>
                                            <td>
                                                <form:input path="detailAdres" id="detailAddress" title="상세주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="detailAdres" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="offmTelno">조합<br>전화번호</label>
                                            </td>
                                            <td>
                                            	<!-- <input type="text" id="offmTelno_view" name="offmTelno" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="offmTelno" id="offmTelno" title="사무실전화번호"  maxlength="15" type="hidden" /> --%>
                                                <form:input path="offmTelno" id="offmTelno" title="사무실전화번호"  maxlength="15" class="f_txt w_full" />
                                                <form:errors path="offmTelno" />
                                            </td>
                                            <td class="lb">
                                                <label for="fxnum">조합<br>팩스번호</label>
                                            </td>
                                            <td>
                                            	<!-- <input type="text" id="offmFaxno_view" name="offmFaxno" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="offmFaxno" id="offmFaxno" title="팩스번호"  maxlength="15" type="hidden" /> --%>
                                                <form:input path="offmFaxno" id="offmFaxno" title="팩스번호"  maxlength="15" class="f_txt w_full" />
                                                <form:errors path="offmFaxno" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="password">비밀번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:password path="password" id="password" title="비밀번호" class="f_txt w_full" maxlength="20" />
                                                <form:errors path="password" />
                                            </td>
                                            <td class="lb">
                                                <label for="password2">비밀번호확인</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="password2" id="password2" title="비밀번호확인" type="password" class="f_txt w_full" maxlength="20" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="passwordHint">비밀번호힌트</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="passwordHint">
                                                    <form:select path="passwordHint" id="passwordHint" name="passwordHint" title="비밀번호힌트">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="passwordHint" />
                                            </td>
                                            <td class="lb">
                                                <label for="passwordCnsr">비밀번호정답</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="passwordCnsr" id="passwordCnsr" title="비밀번호정답" class="f_txt w_full" maxlength="100" />
                                                <form:errors path="passwordCnsr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="picNm">담당자명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <!-- <input type="text" id="picNm_view" name="picNm" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="picNm" id="picNm" title="담당자명" maxlength="15" type="hidden" /> --%>
                                                <form:input path="picNm" id="picNm" title="담당자명" maxlength="5" class="f_txt w_full" />
                                                <form:errors path="picNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="picDeptNm">담당자부서</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <!-- <input type="text" id="picDeptNm_view" name="picDeptNm" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="picDeptNm" id="picDeptNm" title="담당자부서" maxlength="30" type="hidden" /> --%>
                                                <form:input path="picDeptNm" id="picDeptNm" title="담당자부서" maxlength="30" class="f_txt w_full" />
                                                <form:errors path="picDeptNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="picMoblphonNo">담당자 휴대폰번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<!-- <input type="text" id="picMoblphonNo_view" name="picMoblphonNo" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="picMoblphonNo" id="picMoblphonNo" title="담당자 휴대폰번호" maxlength="15" type="hidden" /> --%>
                                                <form:input path="picMoblphonNo" id="picMoblphonNo" title="담당자 휴대폰번호" maxlength="15" class="f_txt w_full" />
                                                <form:errors path="picMoblphonNo" />
                                            </td>
                                            <td class="lb">
                                                <label for="picEmailAdres">담당자 이메일주소</label>
                                            </td>
                                            <td>
                                                <!-- <input type="text" id="picEmailAdres_view" name="picEmailAdres" class="f_txt w_full" disabled="disabled"  readonly="readonly"> -->
                                                <%-- <form:input path="picEmailAdres" id="picEmailAdres" title="담당자이메일주소" maxlength="50" type="hidden" /> --%>
                                                <form:input path="picEmailAdres" id="picEmailAdres" title="담당자이메일주소" maxlength="50" class="f_txt w_full" />
                                                <form:errors path="picEmailAdres" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.partnerManageVO.reset();">초기화</a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnInsert(); return fallse;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;">취소</a><!-- 취소 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
						        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
						        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
						        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
						        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/><c:if test="${userSearchVO.pageIndex eq null}">1</c:if>"/>
						        <input type="hidden" name="loginType" value="partner"/>
						        
			                	</form:form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
    </div>
</body>
</html>