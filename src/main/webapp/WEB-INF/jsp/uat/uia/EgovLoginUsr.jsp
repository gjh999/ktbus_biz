<%--
  Class Name : EgovLoginUsr.jsp
  Description : 로그인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀  박지욱
    since    : 2009.03.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>로그인</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js?v=1"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
-->	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/component.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css">
	<script src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js?v=1"></script>
	<script src="${pageContext.request.contextPath}/js/ui.js"></script>
	
	<!-- 전자인증 모듈 설정 //-->
	<link rel="stylesheet" type="text/css" href="/web/CC_WSTD_home/unisignweb/rsrc/css/certcommon.css?v=1">
	<script type="text/javascript" src="/web/CC_WSTD_home/unisignweb/js/unisignwebclient.js?v=1"></script>
	<script type="text/javascript" src="/web/ccc-sample-wstd/UniSignWeb_Multi_Init_Nim.js?v=1"></script>
<script type="text/javascript">

function actionLogin() {
		
    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
        return false;
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
        return false;
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionSecurityLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}

function SignDataNVerifyVID() 
{
	alert("인증서 로그인");

	if (document.login_form.plainText.value == "")
	{
		alert("서명할 원문이 없습니다.");
		return;
	}
	
	if (document.login_form.ssn.value == "")
	{
		//alert("사업자등록번호 입력하여 주시기 바랍니다.");
		$("#j_username").attr("placeholder","필수 입력사항입니다.");
		document.login_form.ssn.focus();
		return;
	}
	
	var signedTextBox = "";
	
	unisign.SignDataNVerifyVID( document.login_form.plainText.value, null, document.login_form.ssn.value, 
		function(rv, signedText, certAttrs)
		{ 
			document.login_form.signedText.value = signedText;
			
			if ( null === document.login_form.signedText.value || '' === document.login_form.signedText.value || false === rv )
			{
				unisign.GetLastError(
					function(errCode, errMsg) 
					{ 
						alert('Error code : ' + errCode + '\n\nError Msg : ' + errMsg); 
					}
				);
			} else {
				//alert(certAttrs.subjectName);
				//alert('인증서의 신원확인 검증에 성공하였습니다.');
				Send();
			}
		} 
	);
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
    var message = document.loginForm.message.value;
    if (message != "") {
        alert(message);
    }
    getid(document.loginForm);
}

function goRegiUsr() {
    var userSe = document.loginForm.userSe.value;
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/user/EgovUserSignUpSelect.do'/>";
        document.loginForm.submit();
    }else{
        alert("일반회원 가입만 허용됩니다.");
    }
}

function updateLoginType(value) {
	// 'loginType'이라는 hidden input 값 변경
	document.querySelector("input[name='loginType']").value = value;
}
	

$(document).ready(function(){
	// 열기
	$("#certLoginBtn").click(function() {
	    $("#loginModal").fadeIn();
	});
	
	// 닫기 (X 버튼)
	$(".close").click(function() {
	    $("#loginModal").fadeOut();
	});
	
	// 인증서 로그인
	$("#modalLogin").click(function() {
		SignDataNVerifyVID();
	});
	
	// 배경 클릭 시 닫기
	$(document).mouseup(function(e) {
	  const modal = $(".modal-content");
	  if (!modal.is(e.target) && modal.has(e.target).length === 0) {
	      $("#loginModal").fadeOut();
	  }
	});
});


</script>
</head>
<body  onload="fnInit();">

	
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
        <c:import url="/sym/mms/EgovHeader.do" />
        <!--// Header -->

        <div class="container" style="padding-bottom: 60px;">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout_Login">

                        <!-- Location -->
                        <div class="location">
                            <ul>
                                <li><a class="home" href="">Home</a></li>
                                <li>사용자로그인</li>
                            </ul>
                        </div>
                        <!--// Location -->

                        <div class="P_LOGIN">
                            <h1>로그인</h1>
                            <p class="txt">전국전세버스운송사업조합연합회 업무시스템 로그인 페이지입니다.<br>
							               로그인을 하시면 업무시스템 서비스를 이용하실 수 있습니다.</p>
                            <div class="loginbox">
                                <form:form id="loginForm" name="loginForm" method="post">
                                    <fieldset>
										<legend>로그인</legend>
										<!-- 라디오 버튼 영역 -->
								        <div id="loginType" class="center-top">
											<!-- Radio Buttons -->
										    <input type='radio' name='userType' value='partner' checked onclick="updateLoginType(this.value)"/> 조합
										    <input type='radio' name='userType' value='member' checked onclick="updateLoginType(this.value)"/> 조합원
										    <input type='radio' name='userType' value='user' onclick="updateLoginType(this.value)" /> 사용자
								        </div>
			                            <dl>
			                                <dt><label for="memid">아이디</label></dt>
			                                <dd><input type="text" title="아이디를 입력하세요." id="id" name="id" maxlength="10"/></dd>
			                            </dl>

			                            <dl>
			                                <dt><label for="pwd">비밀번호</label></dt>
			                                <dd>
			                                    <input type="password" name="password" id="password" title="비밀번호" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }"/>
			                                    <label for="chk" class="f_chk">
			                                        <input type="checkbox" name="checkId" id="chk" title="ID 저장" onClick="javascript:saveid(document.loginForm);" />
			                                        <span>ID 저장</span>
			                                    </label>
			                                </dd>
			                            </dl>

			                            <div class="btn_a">
			                                <a href="#LINK" class="btn" onClick="actionLogin()">로그인</a>											
			                            </div>
			                            <div class="login_btn">
											<a href="#" class="point" onClick="goRegiUsr();">회원가입</a>
											<a href="#">비밀번호찾기</a>
										</div>
										<a href="#" class="line_btn" id="certLoginBtn">인증서 로그인 </a>
                                    </fieldset>
                                    <input type="hidden" name="message" value="<c:out value='${message}'/>" />
		                            <input type="hidden" name="userSe" value="GNR"/>
									<input type="hidden" name="loginType" value="member"/>
		                            <input name="j_username" type="hidden"/>
		                            </form:form>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 팝업 배경 -->
		<div id="loginModal" class="modal">
		  <div class="modal-content">
		    <span class="close">&times;</span>
		    <h3>인증서 로그인</h3>
		    <input type="text" title="사업자번호를 입력해 주세요" placeholder="사업자번호를 입력해 주세요" autofocus="" id="id2" name="id2" maxlength="10">
		    <div class="btn_a">
		    	<button class="btn" id="modalLogin">로그인</button>
		    </div>
		  </div>
		</div>

        <!-- Footer -->
        <c:import url="/sym/mms/EgovFooter.do" />
        <!--// Footer -->
    </div>
</body>
<style>
/* 라디오 버튼 그룹의 위치 설정 */
.center-top {
    position: absolute;
    top: 10%; /* 화면 상단에서 10% 떨어진 위치 */
    left: 50%; /* 화면의 중앙 정렬 */
    transform: translate(-50%, -50%); /* 중앙 정렬 */
    text-align: center; /* 텍스트 정렬 */
}

/* 추가적으로 디자인을 개선하고 싶을 경우 */
.center-top input[type='radio'] {
    margin: 0 10px; /* 버튼 간의 간격 */
}

.modal {
  display: none; 
  position: fixed;
  left: 0; top: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.5);
}

.modal-content {
  background: #fff;
  width: 443px;
  height: 200px;
  padding: 20px;
  margin: 15% auto;
  border-radius: 8px;
}

.modal-content > h3 {
text-align : center;
}

.modal-content > input {
width : 100%;
height : 50px;
margin-top : 10px;
margin-bottom : 10px;
}

.modal-content > button {
	width : 100%;
	height : 50px; 
}

.btn_a .btn {
    width: 100%;
    height: 50px;
    margin-right: 12px;
    border-radius: 8px;
    color: #fff;
    font-size: 18px;
    font-weight: 500;
    text-align: center;
    line-height: 50px;
    background: #169bd5;
}

.close {
  float: right;
  cursor: pointer;
  font-size: 20px;
}


</style>
</html>