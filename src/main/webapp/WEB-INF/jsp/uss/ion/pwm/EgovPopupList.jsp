<%--
  Class Name : EgovPopupList.jsp
  Description : 팝업창관리 목록 페이지
  Modification Information

       수정일               수정자            수정내용
    ----------   --------   ---------------------------
    2009.09.16   장동한            최초 생성
    2018.08.23   이정은            공통컴포넌트 3.8 개선
    2019.01.07   이정은            체크박스 미선택 시 alert창 추가
    2019.12.10   신용호            KISA 보안약점 조치
    

    author   : 공통서비스 개발팀 장동한
    since    : 2009.09.16

    Copyright (C) 2009 by MOPAS  All right reserved.
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	
<title>내부서비스관리 > 부가기능 > 팝업관리</title><!-- 팝업창관리 목록 -->

<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************* */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/ion/pwm/listPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_PopupManage(){
	location.href = "<c:url value='/uss/ion/pwm/registPopup.do' />";
}
/* ********************************************************
 * 상세화면 처리 함수
 ******************************************************** */
function fn_egov_detail_PopupManage(popupId){
	var vFrom = document.listForm;
	vFrom.popupId.value = popupId;
	vFrom.action = "<c:url value='/uss/ion/pwm/detailPopup.do' />";
	vFrom.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_PopupManage(){
	var vFrom = document.listForm;
	
	vFrom.action = "<c:url value='/uss/ion/pwm/listPopup.do' />";
	vFrom.submit();

}
/* ********************************************************
* 체크 박스 선택 함수
******************************************************** */
function fn_egov_checkAll_PopupManage(){

	var FLength = document.getElementsByName("checkList").length;
	var checkAllValue = document.getElementById('checkAll').checked;

	//undefined
	if( FLength == 1){
		document.getElementById("checkList").checked = checkAllValue;
	}{
			for(var i=0; i < FLength; i++)
			{
				document.getElementsByName("checkList")[i].checked = checkAllValue;
			}
		}

}
/* ********************************************************
* 팝업창 미리보기
******************************************************** */
function fn_egov_view_PopupManage(popupId){

	var FLength = document.getElementsByName("checkList").length;
	var check = 0;
	
	if( FLength == 1){
		if(document.getElementById("checkList").checked == true){
			fn_egov_ajaxPopupInfo_PopupManage( document.getElementById("checkList").value );
			check ++;
		}
	}else{
		for(var i=0; i < FLength; i++)
		{
			if(document.getElementsByName("checkList")[i].checked == true){
				check ++;
				fn_egov_ajaxPopupInfo_PopupManage( document.getElementsByName("checkList")[i].value );
				}
		}
		}
	
	if(check == 0){
		alert("체크박스를 하나 이상 선택해 주세요.");
			}
	
	return;

}
/* ********************************************************
* 팝업창 정보 Ajax통신으로 정보 획득
******************************************************** */
function fn_egov_ajaxPopupInfo_PopupManage(popupIds){
	
	var ajaxUrl = "<c:url value='/uss/ion/pwm/ajaxPopupManageInfo.do' />";

	var param = {
			popupId: popupIds
	};

	$.ajax({
		url: ajaxUrl
		,type: 'post'
		,data: param
		,dataType: 'text'
		,success: function(data) {
			console.log(data);
	    	var returnValueArr = data.split("||");

    	   	fn_egov_popupOpen_PopupManage(popupIds,
       	    	returnValueArr[0],
       	    	returnValueArr[1],
       	    	returnValueArr[2],
       	    	returnValueArr[3],
       	    	returnValueArr[4],
       	    	returnValueArr[5]);
		} ,
		error: function(err) {
			alert("ERROR : "+err.statusText);
		}
	});

}

/* ********************************************************
* 팝업창  오픈
******************************************************** */
function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){
	
	var url = "<c:url value='/uss/ion/pwm/openPopupManage.do' />?";
	url = url + "fileUrl=" + fileUrl;
	url = url + "&stopVewAt=" + stopVewAt;
	url = url + "&popupId=" + popupId;
	var name = popupId;
	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

	<!--if (window.focus) {openWindows.focus()}-->
}

/* ********************************************************
* 팝업창  오픈 쿠키 정보 OPEN
******************************************************** */
function fnGetCookie(name) {
	  var prefix = name + "=";

	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  if (cookieStartIndex == -1) return null;
	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
}

$(document).ready(function(){
	console.log("searchCondition = " + $("#searchCondition").val());
	if(searchCondition == "" || searchCondition == null || searchCondition == "undefined"){
		$("#searchCondition option:eq(1)").prop("selected", true); //첫번째 option 선택
	}
});

</script>

</head>
<body>
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
                                        <li><a href="">부가기능</a></li>
                                        <li>팝업창관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">팝업창관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                
									<form name="listForm" action="<c:url value='/uss/ion/pwm/listPopup.do'/>" method="post">
									<!-- <span>가이드</span> -->
									<div class="search_box cond_wrap" title="이 레이아웃은 하단 정보를 대한 검색 정보로 구성되어 있습니다."><!-- 이 레이아웃은 하단 정보를 대한 검색 정보로 구성되어 있습니다. -->
										<div class="group">										
											<span class="lb mr10">검색조건 : </span>
											<label class="item f_select" for="searchCondition">
		                                        <select id="searchCondition" name="searchCondition">
													<option value='POPUP_SJ_NM' <c:if test="${searchCondition == 'POPUP_SJ_NM'}">selected</c:if>>팝업제목<!-- 팝업제목 -->
													<option value='FILE_URL' <c:if test="${searchCondition == 'FILE_URL'}">selected</c:if>>팝업창URL</option><!-- 팝업창URL -->
		    	                                </select>
		                                    </label>
										</div>
										<div class="group">										
											<span class="item f_search">
		                                        <input class="f_input w_500" title="검색값입력" id="searchKeyword" name="searchKeyword" type="text" value="${searchKeyword}" maxlength="35" onkeypress="press(event);">
		                                        <button class="btn" type="submit" onclick="fn_egov_search_PopupManage(); return false;">조회</button><!-- 조회 -->
		                                    </span>	                                    
										</div>
										<div class="group">
		                                    <a href="/uss/ion/pwm/registPopup.do" class="item btn btn_blue_46 w_100" onclick="">등록</a>		
										</div>
									</div>
								<input name="popupId" type="hidden" value="">
								<input name="pageIndex" type="hidden" value="<c:out value='${popupManageVO.pageIndex}'/>"/>
								</form>
								</div>
								<!--// 검색조건 -->
								
								<!-- 게시판 -->
								<div class="board_list">
									<table summary="팝업창관리에 대한 목록을 제공한다.">
                                        <caption>팝업창 관리</caption>
										<colgroup>
											<col style="width:35px" />
											<%-- <col style="width:30px" /> --%>
											<col style="width: auto;" />
											<%-- <col style="width:180px" /> --%>
											<col style="width: 350px;" />
											<col style="width:70px" />
											<col style="width:70px" />
										</colgroup>
										<thead>
											<tr>
											   <th scope="col">순번</th><!-- 순번 -->
											   <!-- <th scope="col"><input type="checkbox" name="checkAll" id="checkAll" class="check2" value="1" onClick="fn_egov_checkAll_PopupManage();"/></th> -->
											   <th scope="col">팝업제목</th><!-- 제목 -->
											   <th scope="col">게시기간</th><!-- 게시기간 -->
											   <!-- <th scope="col">파일</th>파일 -->
											   <th scope="col">미리보기</th><!-- 미리보기 -->
											   <th scope="col">게시상태</th><!-- 게시상태 -->
											</tr>
										</thead>
                                        <tbody>
											<%-- 데이터를 화면에 출력해준다 --%>
											<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
											<tr>
												<td><c:out value="${(popupManageVO.pageIndex-1) * popupManageVO.pageSize + status.count}"/></td>
												<%-- <td>
													<input type="checkbox" name="checkList" id="checkList" class="check2" value="${resultInfo.popupId}"/>
												</td> --%>
												<td>
													<a href="" onclick="fn_egov_detail_PopupManage('${resultInfo.popupId}'); return false;">${resultInfo.popupTitleNm}</a>
												</td>
												<td>
													<c:out value="${fn:substring(resultInfo.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceBgnde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceBgnde, 10, 12)}"/>M
													~
													<c:out value="${fn:substring(resultInfo.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(resultInfo.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(resultInfo.ntceEndde, 8, 10)}"/>H <c:out value="${fn:substring(resultInfo.ntceEndde, 10, 12)}"/>M
												</td>													
												<%-- <td>
													<c:out value="${resultInfo.fileUrl}"/>
												</td> --%>
												<td>
													<a href="" onclick="javascript:fn_egov_ajaxPopupInfo_PopupManage('${resultInfo.popupId}'); return false;" class="item btn btn_blue_15 w_50" title="새창 열림"><span>보기</span></a><!-- 미리보기 -->
												</td>													
												<td>
													<c:out value="${resultInfo.ntceAt}"/>
												</td>
											</tr>
											</c:forEach>
											
											<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
											<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="4">
													<spring:message code="common.nodata.msg" />
												</td>
											</tr>
											</c:if>
										</tbody>
                                    </table>
                                </div>
                                
                                <!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty popupManageVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- //페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
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
