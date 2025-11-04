<%--
  Class Name : EgovPopupRegist.jsp
  Description : 팝업창관리 등록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.09.16    장동한          최초 생성
     2018.08.29    이정은          공통컴포넌트 3.8 개선

    author   : 공통서비스 개발팀 장동한
    since    : 2009.09.16

    Copyright (C) 2009 by MOPAS  All right reserved.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html>
<html lang="ko">
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
	
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="popupManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<title>내부서비스관리 > 부가기능 > 팝업창 등록</title><!-- 팝업창관리 등록 -->
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_PopupManage(){

}

/* ********************************************************
 * 목록화면
 ******************************************************** */
function fn_egov_select_brdMstrList(){
    form = document.popupManageVO;
    form.action = "<c:url value='/uss/ion/pwm/listPopup.do'/>";
    form.submit();  
}

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_PopupManage(){
	var varFrom = document.popupManageVO;

	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/uss/ion/pwm/registPopup.do' />";
		
		if(!validatePopupManageVO(varFrom)){
			return;
		}else{


			var ntceBgnde = document.getElementById('ntceBgnde').value;
			var ntceEndde = document.getElementById('ntceEndde').value;

			var iChkBeginDe = Number( ntceBgnde.replaceAll("-","") );
			var iChkEndDe = Number( ntceEndde.replaceAll("-","") );

			if(iChkBeginDe > iChkEndDe || iChkEndDe < iChkBeginDe ){
				alert("게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다.");/* 게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다. */
				return;
			}

			varFrom.ntceBgnde.value = ntceBgnde.replaceAll('-','') + fn_egov_SelectBoxValue('ntceBgndeHH') +  fn_egov_SelectBoxValue('ntceBgndeMM');
			varFrom.ntceEndde.value = ntceEndde.replaceAll('-','') + fn_egov_SelectBoxValue('ntceEnddeHH') +  fn_egov_SelectBoxValue('ntceEnddeMM');

			varFrom.submit();
		}
	}
}

/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	return FValue;
}
/* ********************************************************
* SELECT BOX VALUE FUNCTION
******************************************************** */
function fn_egov_SelectBoxValue(sbName)
{
	var FValue = "";
	for(var i=0; i < document.getElementById(sbName).length; i++)
	{
		if(document.getElementById(sbName).options[i].selected == true){

			FValue=document.getElementById(sbName).options[i].value;
		}
	}

	return  FValue;
}
/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}
/* ********************************************************
 * 달력
 ******************************************************** */
function fn_egov_init_date(){
	
	$("#ntceBgnde").datepicker(  
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/bu_icon_carlendar.gif'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});


	$("#ntceEndde").datepicker( 
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/bu_icon_carlendar.gif'/>'  
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}
</script>
</head>
<body onLoad="fn_egov_init_PopupManage(); fn_egov_init_date();">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                                        <li>사용자부재관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->
								
								<form:form modelAttribute="popupManageVO" name="popupManageVO" action="${pageContext.request.contextPath}/uss/ion/pwm/registPopup.do" method="post" >
                                
                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">팝업창 등록</h2>
                                    
								<div class="board_view2">
									<!-- 등록폼 -->
									<table summary="팝업창 등록 양식입니다.">
										<colgroup>
											<col style="width:20%" />
											<col style="" />
										</colgroup>
										<tr>
											<td class="lb">
                                                <label for="popupTitleNm">팝업창명</label><!-- 팝업창명 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="popupTitleNm" class="f_txt w_full" title="팝업창명입력" path="popupTitleNm" maxlength="255"/>
                                                <form:errors path="popupTitleNm" cssClass="error"/>
                                            </td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="fileUrl">팝업창URL</label><!-- 팝업창URL -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="fileUrl" class="f_txt w_full" title="팝업창URL입력" path="fileUrl" maxlength="255"/>
                                                <form:errors path="fileUrl" cssClass="error"/>
                                            </td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="popupWlc">팝업창위치</label><!-- 팝업창위치 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <span class="f_txt_inner mr5 ml5">가로</span> <form:input id="popupWlc" class="f_txt w_100" title="팝업창위치입력" path="popupWlc" maxlength="10"/>
                                                <span class="f_txt_inner mr5 ml5">새로</span> <form:input id="popupHlc" class="f_txt w_100" title="팝업창위치입력" path="popupHlc" maxlength="10"/>
                                                <form:errors path="popupWlc" cssClass="error"/>
                                                <form:errors path="popupHlc" cssClass="error"/>
                                            </td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="popupWSize">팝업창사이즈</label><!-- 팝업창사이즈 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <span class="f_txt_inner mr5 ml5">넓이</span> <form:input id="popupWSize" class="f_txt w_100" title="팝업창사이즈입력" path="popupWSize" maxlength="10"/>
                                                <span class="f_txt_inner mr5 ml5">높이</span> <form:input id="popupHSize" class="f_txt w_100" title="팝업창사이즈입력" path="popupHSize" maxlength="10"/>
                                                <form:errors path="popupWSize" cssClass="error"/>
                                                <form:errors path="popupHSize" cssClass="error"/>
                                            </td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="ntceBgnde">게시기간</label><!-- 게시기간 -->
                                                <span class="req">필수</span>
                                            </td>
											<td>
												<form:input id="ntceBgnde" class="f_txt center w_130 mr5" title="게시기간입력" path="ntceBgnde" maxlength="10" readonly="true"/>
												<form:select path="ntceBgndeHH" class="f_txt w_30 mr5 m5">
													<form:options items="${ntceBgndeHH}" itemValue="code" itemLabel="codeNm"/>
												</form:select> <span class="f_txt_inner mr5 m5">시</span>
												<form:select path="ntceBgndeMM" class="f_txt w_30 mr5 m5">
													<form:options items="${ntceBgndeMM}" itemValue="code" itemLabel="codeNm"/>
												</form:select> <span class="f_txt_inner mr5 m5">분</span>
												&nbsp;~&nbsp;
												<form:input id="ntceEndde" class="f_txt center w_130 mr5" title="게시기간입력" path="ntceEndde" maxlength="10" readonly="true"/>
												<form:select path="ntceEnddeHH" class="f_txt w_30 mr2 m2">
													<form:options items="${ntceEnddeHH}" itemValue="code" itemLabel="codeNm"/>
												</form:select> <span class="f_txt_inner mr5 m5">시</span>
												<form:select path="ntceEnddeMM" class="f_txt w_30 mr5 m5">
													<form:options items="${ntceEnddeMM}" itemValue="code" itemLabel="codeNm"/>
												</form:select> <span class="f_txt_inner mr5 m5">분</span>
											</td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="stopVewAt">그만보기 설정여부</label><!-- 그만보기 설정여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:radiobutton path="stopVewAt" id="stopVewAt1" name="stopVewAt" value="Y" checked="checked" /><span class="f_txt_inner mr5 ml5">Y</span>
                                                <form:radiobutton path="stopVewAt" id="stopVewAt2" class="ml20" name="stopVewAt" value="N"  /><span class="f_txt_inner mr5 ml5">N</span>
                                            </td>
										</tr>
										<tr>
											<td class="lb">
                                                <label for="ntceAt">게시 상태</label><!-- >게시 상태 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:radiobutton path="ntceAt" id="ntceAt1" name="ntceAt" value="Y" checked="checked" /><span class="f_txt_inner mr5 ml5">Y</span>
                                                <form:radiobutton path="ntceAt" id="ntceAt2" class="ml20" name="ntceAt" value="N"  /><span class="f_txt_inner mr5 ml5">N</span>
                                            </td>
										</tr>
									</table>
									<br/>
									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_save_PopupManage(); return false;">저장</a><!-- 저장 -->
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_brdMstrList(); return false;">목록</a><!-- 목록 -->
	                                    </div>
	                                </div>
	                                <!-- // 목록/저장버튼 끝  -->
								</div>

								<%-- <form:hidden path="ntceBgnde" />
								<form:hidden path="ntceEndde" /> --%>
								<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
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
