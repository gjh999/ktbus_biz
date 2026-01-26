<%--
  Class Name : EgovPartnerSelectUpdt.jsp
  Description : 일반회원상세조회, 수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.02  JJY          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.02
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
	
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 회원관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="partnerManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.partnerManageVO.action = "<c:url value='/uss/umt/mber/EgovPartnerManage.do'/>";
    document.partnerManageVO.submit();
}
function fnDeleteMber(checkedIds) {
    if(confirm('<spring:message code="common.delete.msg" />')) {
        document.partnerManageVO.checkedIdForDel.value=checkedIds;
        document.partnerManageVO.action = "<c:url value='/uss/umt/mber/EgovPartnerDelete.do'/>";
        document.partnerManageVO.submit(); 
    }
}
function fnPasswordMove(){
    document.partnerManageVO.action = "<c:url value='/uss/umt/mber/EgovPartnerPasswordUpdtView.do'/>";
    document.partnerManageVO.submit();
}
function fnUpdate(){
	document.partnerManageVO.action = "<c:url value='/uss/umt/mber/EgovPartnerSelectUpdt.do'/>";
    if(validateMberManageVO(document.partnerManageVO)){
        document.partnerManageVO.submit();
    }
}

function fn_egov_ZipSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 600
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(retVal){
	if (retVal) {
		document.getElementById("zip_view").value  = retVal.vZip;
		document.getElementById("adres").value  = retVal.sAddr;
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

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

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
                                        <li><a href="">사용자/조합원/조합</a></li>
                                        <li>조합원 등록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="partnerManageVO" name="partnerManageVO"  method="post" >
								
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
					            <input name="checkedIdForDel" type="hidden" />
					            <!-- 검색조건 유지 -->
					            <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
					            <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
					            <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
					            <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
					            <input type="hidden" name="loginType" value="partner"/>
					            <!-- 우편번호검색 -->
					            <%-- <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" /> --%>
					            <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
					            <input type="hidden" name="userTyForPassword" value="<c:out value='${partnerManageVO.userTy}'/>" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">조합원 상세조회(수정)</h2>

                                <div id="partnerBoard" class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberId">조합사아이디(partner)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="mberId" id="mberId" class="f_txt w_350" size="20" readonly="readonly" maxlength="20" />
                                                <form:errors path="mberId" cssClass="error" />
                                                <form:hidden path="uniqId" />
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
                                                    <input name="zip_view" id="zip_view" type="text" value="<c:out value='${partnerManageVOManageVO.zip}'/>" maxlength="8" readonly="readonly" />
                                                    <form:hidden path="zip" />
                                                    <button type="button" class="btn" onclick="execPostcode();">조회</button> 
                                                </span>
                                                <form:errors path="zip" />
                                                <br/>
                                                <br/>
                                                <form:input path="adres" id="address" title="기본주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="adres" />
                                                <input name="zip_view" id="zip_view" type="hidden" title="우편번호" value="<c:out value='${partnerManageVO.zip}'/>" maxlength="8" readonly="readonly" />
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
                                            	<label for="mberSttus">조합원<br>상태코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_350" for="mberSttus">
                                                    <form:select path="mberSttus" id="mberSttus" name="mberSttus">
					                                    <form:option value="" label="--선택하세요--"/>
					                                    <form:options items="${mberSttus_result}" itemValue="code" itemLabel="codeNm"/>
					                                </form:select>
					                                <form:errors path="mberSttus" cssClass="error"/>
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/uss/umt/mber/EgovPartnerManage.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnDeleteMber('<c:out value='${partnerManageVO.userTy}'/>:<c:out value='${partnerManageVO.uniqId}'/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                        <a href="<c:url value='/uss/umt/mber/EgovPartnerPasswordUpdtView.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnPasswordMove(); return false;"><spring:message code="button.passwordUpdate" /></a><!-- 암호변경 -->
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.partnerManageVO.reset();"><spring:message code="button.reset" /></a><!-- 취소 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/mber/EgovPartnerManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <form:hidden path="password" />
                                </form:form>
                                
                                <!--// 게시판 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>
    
</body>
</html>