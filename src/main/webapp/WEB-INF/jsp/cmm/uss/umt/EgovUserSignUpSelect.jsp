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

<title>내부업무 사이트 > 내부서비스관리 > 사용자등록관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnIdCheck(){
//     var retVal;
//     var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
//     var varParam = new Object();
//     varParam.checkId = document.userManageVO.emplyrId.value;
//     var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
//     retVal = window.showModalDialog(url, varParam, openParam);
//     if(retVal) {
//         document.userManageVO.emplyrId.value = retVal;
//         document.userManageVO.id_view.value = retVal;
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
        document.userManageVO.emplyrId.value = retVal;
        document.userManageVO.id_view.value = retVal;
        
        fn_egov_modal_remove();
    }
}
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uat/uia/egovLoginUsr.do'/>"; 
    document.userManageVO.submit();
}
function fnInsert(){
    if(validateUserManageVO(document.userManageVO)){
        if(document.userManageVO.password.value != document.userManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
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

function updateLoginType(value, text) {
	// 'loginType'이라는 hidden input 값 변경
	document.querySelector("input[name='loginType']").value = value;
	
	$("#loginTypeNm").text(text + " 가입");
	
	if(value == "partner"){
		$("#partnerBoard").show();
		$("#memberBoard").hide();
		$("#userBoard").hide();	
	} else if(value == "member"){
		$("#partnerBoard").hide();
		$("#memberBoard").show();
		$("#userBoard").hide();
	} else if(value == "user"){
		$("#partnerBoard").hide();
		$("#memberBoard").hide();
		$("#userBoard").show();
	}
}


function userJoin2(type){

	var f = document.userManageVO;
	// 회원유형 값 세팅
    //f.user_gb.value = type;
	
 	// 유형별 action 분기
    if (type === "01") {
        f.action = "<c:url value='/uss/umt/user/EgovUserSignUpMember.do'/>";
    } else if (type === "02") {
        //if (!confirm("범용공인인증서 입니까?\r\n은행(은행 및 국가기관만 사용가능)\r\n공인인증서는 사용 불가합니다.")) {
            //return;
        //}
        f.action = "<c:url value='/uss/umt/user/EgovUserSignUpPartner.do'/>";
    } else if (type === "03") {
        f.action = "<c:url value='/uss/umt/user/EgovUserSignUpUser.do'/>";
    }

    f.submit();
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

								<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserSignUp.do" name="userManageVO" method="post" >
								<!-- 우편번호검색 -->
								<input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />

                                <h1 class="tit_1">회원가입</h1>

                                <!--내용 시작-->
								<div class="membership_box">
									<div class="box_type mb30">
										<h3><span class="color_b">전세버스공제조합 홈페이지</span>에 오신 것을 환영합니다.</h3>
										<p>전세버스공제조합 등록된 조합원(사업자)만 회원가입 가능합니다.</p>
									</div>
									<h4 class="line">회원유형</h4>
									<ul class="join_box">
										<li>
											<img src="/images/cooperative/icon_join01.png" alt="" />
											<p>조합원</p>
											<button type="button" onclick="userJoin2('01')" class="btn btn_blue_46 w_150" title="회원가입">회원가입</button>
										</li>
										<li>
											<img src="/images/cooperative/icon_join02.png" alt="" />
											<p>병원/정비공장</p>
											<button type="button" onclick="userJoin2('02')" class="btn btn_blue_46 w_150" title="회원가입">회원가입</button>
										</li>
										<li>
											<img src="/images/cooperative/icon_join03.png" alt="" />
											<p>임직원 및 관리자</p>
											<button type="button" onclick="userJoin2('03')" class="btn btn_blue_46 w_150" title="회원가입">회원가입</button>
										</li>
									</ul>
								</div>
								<!--내용 끝-->
                                
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
/*멤버쉽*/
.membership_box {text-align: center;}
.membership_box h3 {font-size: 20px;}
.membership_box h4 {padding-bottom: 10px; color: #000; text-align: left;}
.membership_box h4.line {border-bottom: 1px solid #c3c3c3;}
.membership_box fieldset {display: block;}
.membership_box fieldset.login {margin: 50px auto 30px; width: 460px;}
.membership_box fieldset.login .radio_box {margin-bottom: 10px; text-align: left;}
.membership_box fieldset.login .inpbox {margin-bottom: 15px; width: 100%; height: 50px;}
.membership_box fieldset.login .inpbox input.txt {padding: 0 20px; color: #333; font-size: 15px; font-weight: 600; border: 1px solid #dadada;}
.membership_box fieldset.login .inpbox input.txt:focus {border: 1px solid #2a88d1;}
.membership_box fieldset > button {margin-top: 15px; width: 100%; height: 50px; font-weight: 600; font-size: 20px;}
.membership_box .bottom_list {text-align: center;}
.membership_box .bottom_list li {display: inline-block;}
.membership_box .bottom_list li a {font-size: 15px;}
.membership_box .bottom_list li span {margin: 0 20px; font-size: 15px;}
.membership_box .id_search {margin: 0 auto; width: 400px;}
.membership_box .id_search p {margin-bottom: 50px; word-break: keep-all;}
.membership_box .id_search .box {margin: 0 0 50px;}
.membership_box .id_search ul.box {padding: 0 15px;}
.membership_box .id_search ul.box li {overflow: hidden; padding: 5px 20px;}
.membership_box .id_search ul.box li label {float: left; width: 100px; color: #444; font-size: 14px; font-weight: 600; text-align: left;}
.membership_box .id_search ul.box li .inpbox {overflow: hidden; float: left; width: calc(100% - 100px); height: 28px;}
.membership_box .id_search ul.box li .inpbox input.txt {float: left; padding: 0 10px; margin-left: 10px; border: 1px solid #d2d2d2;}
.membership_box .id_search ul.box li .inpbox input.txt.name {width: calc(100% - 10px);}
.membership_box .id_search ul.box li .inpbox input.txt.num1 {width: 55px;}
.membership_box .id_search ul.box li .inpbox input.txt.num2 {width: calc(100% - 180px);}
.membership_box .id_search ul.box li .inpbox input.txt.num3 {width: 95px}
.membership_box .id_search div.box {padding: 40px 10px; color: #444; font-size: 15px; font-weight: 600; background: #fafafa;}
.membership_box .id_search .tab_box .tab_list > li > a .d_cell {height: 40px;}
.membership_box div.id_search > button {width: 100%; height: 50px; font-weight: 600; font-size: 20px;}
.membership_box div.id_search.type2 > button {margin: 0 3px; width: calc(50% - 9px);}
/*회원가입 step*/
.member_step {overflow: hidden; margin-bottom: 40px; border: 1px solid #d7d7d7;}
.member_step li {position: relative; float: left; padding-left: 50px; width: 25%; height: 60px; font-size: 18px; line-height: 60px; text-align: center; background-repeat: no-repeat; background-position: left 30% center;}
.member_step > li.step1 {z-index: 16; background-image: url('/images/cooperative/icon_step01.png');}
.member_step > li.step1.on {background-image: url('/images/cooperative/icon_step01_on.png');}
.member_step > li.step1:before {content: ""; position: absolute; right: -9px; bottom: 0; width: 0; height: 0; border-left: 10px solid #fff; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.step2 {z-index: 15; background-image: url('/images/cooperative/icon_step02.png');}
.member_step > li.step2.on {background-image: url('/images/cooperative/icon_step02_on.png');}
.member_step > li.step2:after {content: ""; position: absolute; left: 0; bottom: 0; width: 0; height: 0; border-left: 10px solid #d7d7d7; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.step2:before {content: ""; position: absolute; right: -10px; bottom: 0; width: 0; height: 0; border-left: 10px solid #fff; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.step3 {z-index: 14; background-image: url('/images/cooperative/icon_step03.png');}
.member_step > li.step3.on {background-image: url('/images/cooperative/icon_step03_on.png');}
.member_step > li.step3:after {content: ""; position: absolute; left: 1px; bottom: 0; width: 0; height: 0; border-left: 10px solid #d7d7d7; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.step3:before {content: ""; position: absolute; right: -10px; bottom: 0; width: 0; height: 0; border-left: 10px solid #fff; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.step4 {z-index: 13; background-image: url('/images/cooperative/icon_step04.png');}
.member_step > li.step4.on {background-image: url('/images/cooperative/icon_step04_on.png');}
.member_step > li.step4:after {content: ""; position: absolute; left: 1px; bottom: 0; width: 0; height: 0; border-left: 10px solid #d7d7d7; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
.member_step > li.on {color: #fff; font-weight: 600; background-color: #7bb1f0; border: 0;}
.member_step > li.on:before {content: ""; position: absolute; right: -10px; bottom: 0; width: 0; height: 0; border-left: 10px solid #7bb1f0; border-top: 30px solid transparent; border-bottom: 30px solid transparent;}
/*회원가입*/
.join_box {margin-top: 40px;}
.join_box li {overflow: hidden; display: inline-block; width: 280px; margin-bottom: 50px}
.join_box li p {margin: 10px 0 30px; font-size: 18px; font-weight: 600;}
.membership_box .btn {width: 150px;}
.agreement_box .contents {padding: 20px; height: 220px; overflow-y: auto; border: 1px solid #e4e4e4; text-align: left;}
.agreement_box .contents.type2 {height: 330px;}
.agreement_box .contents h5 {margin-bottom: 5px; color: #444; font-size: 14px;}
.agreement_box .contents h6 {margin-bottom: 5px; color: #666; font-size: 14px;}
.agreement_box .contents p {margin: 0 0 15px; font-size: 14px; line-height: 18px;}
.agreement_box .contents ul {margin-bottom: 15px;}
.agreement_box .contents ul li {margin-bottom: 5px; font-size: 14px; line-height: 18px;}
.agreement_box .contents ul li:last-child {margin-bottom: 0px;}
.agreement_box .check {margin: 10px 0 30px; text-align: right;}
.agreement_box .check .tbl_top {display: inline-block;}
.agreement_box .check .tbl_top li {float: left; text-align: left;}
.agreement_box .check .tbl_top li .iradio {background:url('/images/cooperative/icon_radio2_off.png') no-repeat 0 2px; cursor: pointer;}
.agreement_box .check .tbl_top li .iradio.on {background:url('/images/cooperative/icon_radio2_on.png') no-repeat 0 2px;}
.agreement_box .check .tbl_top .iradio label {font-size: 14px;}
.membership_box .step4_list {display: inline-block; margin-top: 20px;}
.membership_box .step4_list li {position: relative; padding-left: 10px; color: #333; font-weight: 600; text-align: left;}
.membership_box .step4_list li:after {content: ''; position: absolute; left: 0; top: 10px; width: 3px; height: 3px; background: #2f76c2;}

.box_type {
    padding: 20px;
    background: #fafafa;
    word-break: keep-all;
    text-indent: 0;
}

.mb30 {
    margin-bottom: 30px !important;
}

.color_b {color: #2474de !important;}
.color_bl {color: #000;}
.color_r {color: #f00000;}
.color_o {color: #ec4a03;}
.color_g {color: #01c587;}

.bg_blue {color: #fff; background: #2281e7;}
.bg_orange {color: #fff; background: #e97401;}
.bg_gray {color: #fff; background: #717171;}
</style>
</html>