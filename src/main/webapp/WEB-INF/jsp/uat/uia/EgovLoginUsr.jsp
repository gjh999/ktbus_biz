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
        document.loginForm.action="<c:url value='/uss/umt/user/EgovUserSignUpView.do'/>";
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
											<br/>											
    			                            <a href="#LINK" class="btn" onClick="goRegiUsr();">회원가입</a>
			                            </div>
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
</style>
</html>