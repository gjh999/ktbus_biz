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
<validator:javascript formName="mberManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">

<!--
function fnIdCheck(){
//     var retVal;
//     var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
//     var varParam = new Object();
//     varParam.checkId = document.mberManageVO.mberId.value;
//     var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
//     retVal = window.showModalDialog(url, varParam, openParam);
//     if(retVal) {
//         document.mberManageVO.mberId.value = retVal;
//         document.mberManageVO.id_view.value = retVal;
//     }

    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/EgovIdDplctCnfirmView.do'/>?" + '" width="100%" height="100%"></iframe>')
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
        document.mberManageVO.mberId.value = retVal;
        document.mberManageVO.id_view.value = retVal;
        
        fn_egov_modal_remove();
    }
}
function fnListPage(){
    document.mberManageVO.action = "<c:url value='/uat/uia/egovLoginUsr.do'/>"; 
    document.mberManageVO.submit();
}
function fnInsert(){
    if(validateMberManageVO(document.mberManageVO)){
        if(document.mberManageVO.password.value != document.mberManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.mberManageVO.submit();
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
    var frm = document.mberManageVO;
    
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

								<form:form modelAttribute="mberManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovMberSignUp.do" name="mberManageVO" method="post" >
								<!-- 우편번호검색 -->
								<%-- <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" /> --%>

                                <h1 class="tit_1">조합원 회원가입</h1>
                                
                                <div id="memberBoard" class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberId">조합원아이디(member)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_300">
                                                    <input type="text" maxlength="20" disabled="disabled" id="id_view" name="id_view" readonly="readonly">
                                                    <form:input path="mberId" id="mberId" title="일반회원아이디" maxlength="20" type="hidden" />
                                                    <button type="button" class="btn" onclick="fnIdCheck();">조회</button>
                                                </span>
                                                <span class="f_txt_inner ml10">(중복체크)</span>
                                                <form:errors path="mberId" />
                                            </td>
                                            <td class="lb">
                                                <label for="mberNm">조합원이름</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="mberNm" id="mberNm" title="사용자이름" type="text" class="f_txt w_full" value="" maxlength="60" />
                                                <form:errors path="mberNm" />
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
                                                <label for="partnerNm">조합명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="partnerNm" id="partnerNm" title="조합명" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="partnerNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="bizNo">사업자번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="bizNo1" id="bizNo1" title="bizNo1" class="f_txt w_70" maxlength="3" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="bizNo2" title="bizNo2" id="bizNo2" class="f_txt w_70" maxlength="2" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="bizNo3" title="bizNo3" id="bizNo3" class="f_txt w_100" maxlength="5" />
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
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="offmTelno" id="offmTelno" title="사무실전화번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="offmTelno" />
                                            </td>
                                            <td class="lb">
                                                <label for="moblphonNo">휴대폰번호(조합원)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="moblphonNo" id="moblphonNo" title="핸드폰번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="moblphonNo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberEmailAdres">이메일주소(조합원)</label>
                                            </td>
                                            <td>
                                                <form:input path="mberEmailAdres" id="mberEmailAdres" title="이메일주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="mberEmailAdres" />
                                            </td>
                                            <td class="lb">
                                                <label for=""></label>
                                            </td>
                                            <td>
                                                <!-- 
                                                <form:input path="moblphonNo" id="moblphonNo" title="핸드폰번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="moblphonNo" />
                                                 -->
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.mberManageVO.reset();">초기화</a><!-- 초기화 -->
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

<style>
  #postcode-layer {display:none; position:fixed; z-index:9999; left:50%; top:50%;
    width:360px; height:480px; transform:translate(-50%, -50%); border:1px solid #ccc; background:#fff;}
  #btnCloseLayer {position:absolute; right:8px; top:8px;}
</style>

<div id="postcode-layer">
  <button id="btnCloseLayer" onclick="closePostcodeLayer()">닫기</button>
</div>
<button type="button" onclick="openPostcodeLayer()">주소 찾기</button>

</html>