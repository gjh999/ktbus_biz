<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<title>사용자 상세 및 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">

function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
    if(confirm("<spring:message code="common.delete.msg" />")){
        document.userManageVO.checkedIdForDel.value=checkedIds;
        document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
        document.userManageVO.submit(); 
    }
}
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
        document.userManageVO.submit();
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
    var frm = document.userManageVO;
    
    frm.subDn.value = dn;
}

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
<body>

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
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">내부시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>사용자등록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserSelectUpdt.do" name="userManageVO" method="post" >
								
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
								<input name="checkedIdForDel" type="hidden" />
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
								<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
								<input type="hidden" name="loginType" value="user"/>
								<!-- 우편번호검색 -->
								<%-- <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" /> --%>
								<!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
								<input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">업무사용자 상세조회(수정)</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="emplyrId" id="emplyrId" class="f_txt w_full" maxlength="20" readonly="readonly" />
                                                <form:errors path="emplyrId" />
                                                <form:hidden path="uniqId" />
                                            </td>
                                            <td class="lb">
                                                <label for="emplyrNm">이름</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="emplyrNm" id="emplyrNm" title="사용자이름" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="emplyrNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="homeadres">주소</label>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_300">
                                                	<input name="zip_view" id="zip_view" type="text" value="<c:out value='${userManageVO.zip}'/>" maxlength="8" readonly="readonly" />
                                                    <form:hidden path="zip" />
                                                    <button type="button" class="btn" onclick="execPostcode();">조회</button> 
                                                </span>
                                                <form:errors path="zip" />
                                                <br/>
                                                <br/>
                                                <form:input path="homeadres" id="address" title="기본주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="homeadres" />
                                                <%-- <input name="zip_view" id="zip_view" type="hidden" title="우편번호" value="<c:out value='${userManageVO.zip}'/>" maxlength="8" readonly="readonly" /> --%>
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
                                                <label for="offmTelno">사무실<br>전화번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="offmTelno" id="offmTelno" title="사무실전화번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="offmTelno" />
                                            </td>
                                            <td class="lb">
                                                <label for="fxnum">팩스번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="fxnum" id="fxnum" title="팩스번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="fxnum" />
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
                                                <label for="moblphonNo">휴대폰번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="moblphonNo" id="moblphonNo" title="핸드폰번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="moblphonNo" />
                                            </td>
                                            <td class="lb">
                                                <label for="emailAdres">이메일주소</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="emailAdres" id="emailAdres" title="이메일주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="emailAdres" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="groupId">그룹아이디<br>(해당지부)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="groupId">
                                                    <form:select path="groupId" id="groupId" name="groupId" title="그룹아이디">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="groupId" />
                                            </td>
                                            <td class="lb">
                                                <label for="orgnztNm">부서1</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="orgnztNm" id="orgnztNm" title="부서명" class="f_txt w_full" maxlength="30" />
                                                <form:input path="orgnztId" id="orgnztId" title="부서Id" maxlength="20" type="hidden" value="ORGNZT_0000000000000"/>
                                                <form:errors path="orgnztNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="orgnztDescNm">부서2</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="orgnztDescNm" id="orgnztDescNm" title="부서상세명" class="f_txt w_full" maxlength="30" />
                                                <form:errors path="orgnztDescNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="jbgdNm">직급</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="jbgdNm" id="jbgdNm" title="직급명" class="f_txt w_full" maxlength="30" />
                                                <form:errors path="jbgdNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                        	<td class="lb">
                                                <label for="jbpsNm">직위</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="jbpsNm" id="jbpsNm" title="직위명" class="f_txt w_full" maxlength="30" />
                                                <form:errors path="jbpsNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="emplyrSttusCode">사용자상태<br>코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="emplyrSttusCode">
                                                    <form:select path="emplyrSttusCode" id="emplyrSttusCode" name="emplyrSttusCode" title="사용자상태코드">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="emplyrSttusCode" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/uss/umt/user/EgovUserDelete.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnPasswordMove(); return false;"><spring:message code="button.passwordUpdate" /></a><!-- 비밀번호변경 -->
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.userManageVO.reset();"><spring:message code="button.reset" /></a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <form:hidden path="password" />
                                
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