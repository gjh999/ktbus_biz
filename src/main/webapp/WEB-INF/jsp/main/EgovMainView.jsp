<%--
  Class Name : EgovMainView.jsp 
  Description : 메인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			
			$("#noticeTitle").click(function(){
				$("#noticeList").removeClass("no_show");
				$("#bbsList").addClass("no_show");
				bbsId = "BBSMSTR_AAAAAAAAAAAA";
			});
			
			$("#bbsTitle").click(function(){
				$("#bbsList").removeClass("no_show");
				$("#noticeList").addClass("no_show");
				bbsId = "BBSMSTR_CCCCCCCCCCCC";
			});
			
			// 팝업 게시목록 조회
			fn_openPopupList();
			
		});
		
		var bbsId = "BBSMSTR_AAAAAAAAAAAA";
		
		function moreShow(){
			window.location.href = "/cop/bbs/selectBoardList.do?bbsId="+bbsId;
		}
		
		/* ********************************************************
		* 팝업 게시목록 정보 Ajax통신으로 정보 획득
		******************************************************** */
		function fn_openPopupList(){
			
			$.ajax({
					type:"POST",
				    url: "<c:url value='/uss/ion/pwm/listMainPopup.do' />",
					dataType:'json',
					timeout:(1000*30),
					success: function(data){
				        for(var i = 0 ; i < data.resultList.length ; i++) {
							var popupData = data.resultList[i];
							var popupCheck = fnGetCookie(popupData.popupId);
							console.log(popupCheck);
							if(!popupCheck){
			            		fn_egov_popupOpen_PopupManage(popupData.popupId, popupData.fileUrl, popupData.popupWidthSize, popupData.popupVrticlSize, popupData.popupWidthLc, popupData.popupVrticlLc, popupData.stopvewSetupAt);
							}
			            }
					} ,
					error: function(err) {
					}
				})

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

			if (window.focus) {openWindows.focus()}
		}

		/* ********************************************************
		* 팝업창  오픈 쿠키 정보 OPEN
		******************************************************** */
		function fnGetCookie(name) {
			  var prefix = "ktbus_biz_" + name + "=";

			  var cookieStartIndex = document.cookie.indexOf(prefix);
			  if (cookieStartIndex == -1) return null;
			  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
			  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


			  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
		}
	</script>
	
<title>표준프레임워크 경량환경 내부업무템플릿</title>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

<body>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
        <c:import url="/sym/mms/EgovHeader.do" />
        <!--// Header -->

        <div class="container main">
            <div class="P_MAIN">
                <div class="inner">
                    <p class="visual">
                        <span class="t_1">전국전세버스운송사업조합연합회</span>
                        <span class="t_2">내부업무 관리시스템</span>
                        <span class="t_3">신뢰와 사랑을 주신 전세버스운송사업자 및 종사자 여러분께 진심으로 감사드립니다.</span>
                    </p>
                </div>

                <div class="bot">
                    <div class="col">
                        <div class="left_col">
                            <div class="box">
                                <div class="head">
                                    <h2><span id="noticeTitle" style="cursor: pointer;">공지사항</span> / <span id="bbsTitle" style="cursor: pointer;">업무게시판</span></h2>
                                    <a href="javascript:moreShow()" class="more">더보기</a>
                                </div>
                                <ul class="list" id="noticeList">
                                	<c:forEach var="result" items="${notiList}" varStatus="status">
                                	<c:if test="${!(result.isExpired=='Y' || result.useAt == 'N')}">
                                    <li>
                                    	<c:if test="${result.replyLc!=0}">
                                    		<c:forEach begin="0" end="${result.replyLc}" step="1">
                                    			&nbsp;
                                    		</c:forEach>
                                    		<img src="<c:url value='/'/>images/ico_reply.png" alt="reply arrow">
                                    	</c:if>
                                        <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>">
                                        	<c:out value="${result.nttSj}" />
                                        </a>
                                        <span><c:out value="${result.frstRegisterPnttm}"/></span>
                                    </li>
                                    </c:if>
                                    </c:forEach>
                                </ul>
                                <ul class="list no_show" id="bbsList">
                                	<c:forEach var="result" items="${bbsList}" varStatus="status">
                                	<c:if test="${!(result.isExpired=='Y' || result.useAt == 'N')}">
                                    <li>
                                    	<c:if test="${result.replyLc!=0}">
                                    		<c:forEach begin="0" end="${result.replyLc}" step="1">
                                    			&nbsp;
                                    		</c:forEach>
                                    		<img src="<c:url value='/'/>images/ico_reply.png" alt="reply arrow">
                                    	</c:if>
                                        <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC'/>">
                                        	<c:out value="${result.nttSj}" />
                                        </a>
                                        <span><c:out value="${result.frstRegisterPnttm}"/></span>
                                    </li>
                                    </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="right_col">
                            <div class="box">
                                <div class="head">
                                    <h2>최신 교통뉴스 <span>정보</span></h2>
                                    <a href="http://www.gyotongn.com/" target="_blank" class="more">더보기</a>
                                </div>
                                <div class="list">
                                    <table>
                                        <colgroup>
                                            <col style="width: auto;">
                                        </colgroup>
                                        <c:forEach items="${rssList }" var="list" varStatus="i">
                                        <c:if test="${i.count < 11}">
                                        <tr>
                                            <td>
                                            	<a href="${list.link}" title="상세페이지로 이동" target="_blank">${list.title}</a>
                                            </td>
                                        </tr>
                                        </c:if>
                                        </c:forEach>
                                    </table>
                                </div>
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