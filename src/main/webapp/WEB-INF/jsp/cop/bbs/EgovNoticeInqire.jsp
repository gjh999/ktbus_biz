<%--
  Class Name : EgovNoticeInqire.jsp
  Description : 게시물 조회 화면
  Modification Information
 
      수정일      수정자              수정내용
     ----------  --------    ---------------------------
     2009.03.23   이삼섭        최초 생성
     2009.06.26   한성곤        2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31   JJY       	경량환경 버전 생성
     2013.05.23   이기하       	상세보기 오류수정
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.23
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
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
	
	<!-- SmartEditor2 라이브러리  -->
	<script type="text/javascript" src="<c:url value='/dist/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>
	
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
	<script type="text/javascript">
		var oEditors = [];
		
		smartEditor = function(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "nttCn",  //textarea ID 입력
				sSkinURI: "/dist/smarteditor2/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
				fCreator: "createSEditor2",
				htParams : {
                    // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                    bUseToolbar : false,             
                    // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                    bUseVerticalResizer : false,     
                    // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                    bUseModeChanger : false,
                },
				// 읽기전용 만들기
				fOnAppLoad : function(){ 
					//console.log(oEditors);
					var inputHeight = $(".se2_inputarea").clientHeight;
					alert("사이즈 확인 " + inputHeight);
					var editor = oEditors.getById["nttCn"];
					editor.exec("DISABLE_WYSIWYG");
					editor.exec("DISABLE_ALL_UI");
					editor.exec("MSG_EDITING_AREA_RESIZE_STARTED", []);
					editor.exec("RESIZE_EDITING_AREA", [0,500]);
					//editor.exec("ON_RESIZE_HEIGHT");
					editor.exec("MSG_EDITING_AREA_RESIZE_ENDED", []);
					
					editor.exec("SE_FIT_IFRAME", []);
		        }
			})
		};
		
		$(document).ready(function(){
			//smartEditor();
			$("#nttCn").html($("#nttCn_H").val());
		});
		
		
	</script>
	
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function onloading() {
        if ("<c:out value='${msg}'/>" != "") {
            alert("<c:out value='${msg}'/>");
        }
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_delete_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }
        
        if (confirm('<spring:message code="common.delete.msg" />')) {
            document.frm.action = "<c:url value='/cop/bbs${prefix}/deleteBoardArticle.do'/>";
            document.frm.submit();
        }   
    }
    
    function fn_egov_moveUpdt_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }

        document.frm.action = "<c:url value='/cop/bbs${prefix}/forUpdateBoardArticle.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_addReply() {
        document.frm.action = "<c:url value='/cop/bbs${prefix}/addReplyBoardArticle.do'/>";
        document.frm.submit();
    }
</script>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useComment == 'true'}">
<c:import url="/cop/bbs/selectCommentList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/bbs/selectSatisfactionList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
    function fn_egov_addScrap() {
        document.frm.action = "<c:url value='/cop/bbs/addScrap.do'/>";
        document.frm.submit();          
    }
</script>
</c:if>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<title>내부업무 사이트 > 알림정보 > <c:out value='${result.bbsNm}'/></title>

</head>
<body onload="onloading();">
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
                        <c:import url="/sym/mms/EgovMenuLeft.do" />
                        <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">알림정보</a></li>
                                        <li><c:out value='${result.bbsNm}'/></li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="frm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>">
								
			                    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			                    <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
			                    <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			                    <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
			                    <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
			                    <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
			                    <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
			                    <input type="hidden" id="nttCn_H" name="nttCn_H" value="<c:out value="${result.nttCn}" escapeXml="false" />" >

                                <h1 class="tit_1">알림정보</h1>

                                <h2 class="tit_2"><c:out value='${result.bbsNm}'/></h2>

                                <!-- 게시판 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${result.nttSj}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>작성자</dt>
                                                <dd>
                                                	<c:choose>
                                                		<c:when test="${anonymous == 'true'}">
                                                			******
                                                		</c:when>
                                                		<c:when test="${result.ntcrNm == ''}">
                                                			<c:out value="${result.frstRegisterNm}" />
                                                		</c:when>
                                                		<c:otherwise>
                                                			<c:out value="${result.ntcrNm}" />
                                                		</c:otherwise>
                                                	</c:choose>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dt>작성일</dt>
                                                <dd><c:out value="${result.frstRegisterPnttm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>조회수</dt>
                                                <dd><c:out value="${result.inqireCo}" /></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="board_article">
										<div id="nttCn" name="nttCn" class="textarea" cols="30" rows="10" readonly="readonly" title="글내용"></div>
                                    </div>
									<%-- <div class="jsx-2303464893 editor ">
										<div class="fr-box fr-basic fr-top" role="application">
											<div class="fr-wrapper show-placeholder" dir="auto">
												<textarea name="nttCn" id="nttCn" style="width: 100%; overfolw-y:auto;" readonly><c:out value="${result.nttCn}" escapeXml="false" /></textarea>
											</div>
										</div>
									</div> --%>
									<br>

									<c:if test="${not empty result.atchFileId}">
										<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
		                                    <div class="board_attach">
		                                        <dl>
		                                            <dt>첨부이미지</dt>
		                                            <dd>
		                                                <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
		                                                	<c:param name="atchFileId" value="${egovc:encryptSession(result.atchFileId, pageContext.session.id)}" />
		                                                </c:import>
		                                            </dd>
		                                        </dl>
		                                    </div>
		                                </c:if>
		                                <div class="board_attach">
	                                        <dl>
	                                            <dt>첨부파일</dt>
	                                            <dd>
	                                                <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
				                                    </c:import>
	                                            </dd>
	                                        </dl>
	                                    </div>
	                                </c:if>
	                                
                                    <c:if test="${anonymous == 'true'}">
                                    	<div class="board_attach">
	                                    	<dl>
                                                <dt><label for="password"><spring:message code="cop.password" /></label></dt>
                                                <dd><input name="password" title="암호" type="password" size="20" value="" maxlength="20" ></dd>
                                            </dl>
                                           </div>
                                    </c:if>

									
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                        	<c:if test="${result.frstRegisterId == sessionUniqId}">
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_moveUpdt_notice(); return false;">수정</a>
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_delete_notice(); return false;">삭제</a>
                                            </c:if>
                                            <c:if test="${result.replyPosblAt == 'Y'}">
                                            	<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_addReply(); return false;">답글작성</a>
                                            </c:if>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList('1'); return false;">목록</a>
                                        </div>
                                    </div>
                                    
                                </div>
                                
                                </form>
                                
                                <!-- 게시판 상세보기 -->
                              
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