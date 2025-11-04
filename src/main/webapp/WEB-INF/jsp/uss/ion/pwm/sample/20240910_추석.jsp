<%--
  Class Name : EgovPopupSample.jsp
  Description : 팝업창관리 팝업샘플
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.10.09    장동한          최초 생성
     2018.09.18    이정은          공통컴포넌트 3.8 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.10.09

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<!--<link type="text/css" rel="stylesheet" href="/css/yonhap/default.css">
<link type="text/css" rel="stylesheet" href="/css/yonhap/reset.css">
<link type="text/css" rel="stylesheet" href="/css/yonhap/font.css">
<link type="text/css" rel="stylesheet" href="/css/yonhap/contents.css">
<link type="text/css" rel="stylesheet" href="/css/yonhap/table.css">
<link type="text/css" rel="stylesheet" href="/css/yonhap/slick.css">
<link type="text/css" rel="stylesheet" href="/css/common.css">-->
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<!--<script type="text/javascript" src="/js/script.js"></script>
<script type="text/javascript" src="/js/accordion.js"></script>-->
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/yonhap/common_ui.js"></script>
<title>팝업 샘플</title><!-- 팝업 샘플페이지 -->
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 쿠키설정
 ******************************************************** */
function fnSetCookiePopup( name, value, expiredays ) {
	  var todayDate = new Date();
	  todayDate.setDate( todayDate.getDate() + expiredays );
	  document.cookie = "ktbus_biz_" + name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {
	fnSetCookiePopup( "${popupId}", "done" , 365);
	window.close();
}

/* ********************************************************
* 닫기버튼 클릭시
******************************************************** */
function fnClose() {
	window.close();
}
</script>
<style>
	/*메인팝입*/
	.popup.main {transform: translateX(0);} 
	.popup.main .popup_inner {padding: 20px;} 
	.popup.main .bottom {width: 100%; height: 50px; border-top: 1px solid #ccc;}
	.popup.main .bottom .pop_check {float: left;}
	.popup.main .bottom .pop_check input[type=checkbox] {display: none;}
	.popup.main .bottom .pop_check input[type=checkbox] + label {display: inline-block; cursor: pointer; position: relative; font-size: 13px; padding-left: 25px; line-height: 16px; margin: 17px 0 0 15px;}
	.popup.main .bottom .pop_check input[type=checkbox] + label:before {content: ""; position: absolute; left: 0; top: -1px; width: 16px; height: 16px; background: #fff; border: 1px solid #ccc;}
	.popup.main .bottom .pop_check input[type=checkbox]:checked + label:before {background: url('/images/yonhap/icon_check.png') center center no-repeat #fff;}
	.popup.main .bottom button {float: right; margin: 10px 15px 0 0; width: 70px; height: 30px; color: #fff; font-size: 13px; background: #717171;}
	
	/*팝업*/
	.popup.board {margin-top: -290px; width: 670px; height: 580px;}
	.popup.password {margin-top: -120px; width: 400px; height: 240px;}
	.popup.type2 {margin-top: -160px; width: 500px; height: 320px;}
	.popup .popup_title {position: relative; padding: 10px 10px 10px 30px; background: url('/images/yonhap/bg_popup.png') 0 0 #246cba;}
	.popup .popup_title .close {position: absolute; right: 20px; top: 30px; width: 22px; height: 22px; background: url('/images/yonhap/icon_close2.png') center center no-repeat;}
	.popup .popup_title h3 {color: #fff; font-size: 22px;}
</style>
</head>
<body>
<div id="contents">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<div class="popup main" id="layerPop_1">
	    <div class="popup_title">
	        <h3>추석맞이 인사말</h3>
	    </div>
	    <div class="popup_inner">
	        <div class="contents"><input type="hidden" name="noti_id" value="c1463a77cb3f4d1f92cd32bfdc269572">
	            <p>
					<br style="clear:both;">
					<img src="/contents/commoneditor/20240905144452d7e26d2f-6298-4beb-94d1-8e92e412d796.png" title="2024.09.02_1.png">
					<br style="clear:both;">
					<img src="/contents/commoneditor/20240905144452731b5af1-19cb-449e-b0a3-5b95d9b180c0.png" title="2024.09.02_1.png">
				</p>
	        </div>
	    </div>
	    <div class="bottom">
			<c:if test="${stopVewAt eq 'Y'}">
	        <div class="pop_check">
				<input type="checkbox" id="close" name="chk" value="Y" onclick="fnPopupCheck();"> 
				<label for="close"><span>오늘은 이제 그만</span></label> 
			</div>
			</c:if> 
			<button type="button" onclick="fnClose()">닫기</button>
	    </div>
	</div>

</body>
</html>
