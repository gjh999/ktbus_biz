<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/js/jqueryui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jqueryui.css">

<script type="text/javaScript" language="javascript">

function fn_egov_modal_create(){
	
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/EgovPageLink.do'/>?" + "linkIndex=" + 3 +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1250,
        height: 950
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

</script>

<!-- Header -->
<div class="header">
    <div class="inner">
        <div class="left_col">
            <h1 class="logo"><a href="<c:url value='/'/>cmm/main/mainPage.do"><img src="${pageContext.request.contextPath}/images/logo4.png" alt="전국전세버스운송사업조합연합회"></a></h1>
				
            <%-- <a class="go" href="#LINK" onclick="fn_egov_modal_create(); return false;"><img src="${pageContext.request.contextPath}/images/ico_question.png" alt="메뉴구성 설명"></a> --%>
        </div>
<!--		<h2 class="logo"><a><img src="<c:url value='/'/>images/logo3.png" alt="전국전세버스운송사업조합연합회">전국전세버스운송사업조합연합회공제조합</img></a></h2>-->
		<%
			LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
			if(loginVO == null){
		%>
			<div class="top_menu">
	            <span class="t"><span>로그인정보 없음</span> &nbsp</span>
	            <span class="d">로그인후 사용하십시오</span>
	            <a href="<c:url value='/uat/uia/egovLoginUsr.do'/>" class="btn btn_blue_15 w_90">로그인</a>
	        </div>
		<% } else { %>
			<c:set var="loginName" value="<%= loginVO.getName()%>"/>
	        <div class="top_menu">
	            <span class="t"><span onclick="alert('개인정보 확인 등의 링크 제공'); return false;" style="cursor: pointer;"><c:out value="${loginName}" /> 님</span> 환영합니다. </span>
	            <!--<span class="d">2021-06-30 12:45 입니다.</span>-->
	            <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="btn btn_blue_15 w_90">로그아웃</a>
	        </div>
        <% } %>

        <!-- gnb -->
        <div class="gnb">
            <ul>
                <c:forEach var="result" items="${list_headmenu}" varStatus="status">
                	<li>
                		<a href="#" data-menu-no='<c:out value="${result.menuNo}"/>' class='dept_01 <c:if test="${result.menuOrdr >= 5}">manager</c:if>'><c:out value="${result.menuNm}"/></a>
                		<!--  onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"  -->
                		<div class="subMenu">
                			<!-- <button class="subClose"></button> -->
                			
                			
                			<!-- 
                			<h3>서브 타이틀1</h3>
                			<ul>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                			</ul>
                			<h3>서브 타이틀2</h3>
                			<ul>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                				<li>
                					<a href="#">샘플 텍스트</a>
                				</li>
                			</ul>
                			 -->
                		</div>
                	</li>
                </c:forEach>
                <c:if test="${fn:length(list_headmenu) == 0 }">
                	<!-- <li>등록된 메뉴가 없습니다.</li> -->
                </c:if>
            </ul>
        </div>
        <!-- gnb -->

		<!-- util menu -->
		<%
			if(loginVO == null){
		%>
			<div class="util_menu">
	            <ul>
	                <li></li>
	            </ul>
	        </div>
		<% } else { %>
			<div class="util_menu">
	            <ul>
	                <li><a href="" class="allmenu" title="전체메뉴">전체메뉴</a></li>
	            </ul>
	        </div>
        <% } %>
        <!--// util menu -->
        
    </div>
</div>
<!--// Header -->

<!-- 전체메뉴 팝업 -->
<div class="all_menu" id="">
    <div>
        <div class="inner">
        	<c:forEach var="upperMenu" items="${list_headmenu}" varStatus="status">
	       		<c:choose>
					<c:when test="${upperMenu.menuNo == '5000000' or upperMenu.menuNo == '6000000'}">
					<div class="admin">
					</c:when>
					<c:otherwise>
					<div>
					</c:otherwise>
				</c:choose>
                	<h2>${upperMenu.menuNm}</h2>
	                <ul>
	                	<c:forEach var="subMenu" items="${list_menulist}" varStatus="status">
	                	<c:if test="${upperMenu.menuNo == subMenu.upperMenuId}">
	                		<c:if test="${subMenu.chkUrl == '/'}">
	                		<h3>${subMenu.menuNm}</h3>
	                		<ul>
	                			<c:forEach var="subMenu2" items="${list_menulist}" varStatus="status">
	                			<c:if test="${subMenu.menuNo == subMenu2.upperMenuId}">
	                			<li><a href="${subMenu2.chkUrl}">${subMenu2.menuNm}</a></li>
	                			</c:if>
	                			</c:forEach>
	                		</ul>	
	                		</c:if>
	                		<c:if test="${subMenu.chkUrl != '/'}">
	                		<li><a href="${subMenu.chkUrl}">${subMenu.menuNm}</a></li>	
	                		</c:if>
	                    </c:if>
	                    </c:forEach>
	                </ul>
            	</div>
            </c:forEach>
            <!-- <div>
                <h2>알림정보</h2>
                <ul>
                    <li><a href="/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항</a></li>
                    <li><a href="/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC">업무게시판</a></li>
                </ul>
            </div>

            <div>
                <h2>직급체계관리</h2>
                <ul>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=200000">입퇴사정보 관리</a></li>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=200000">직급정보 관리</a></li>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=200000">직위정보 관리</a></li>
                </ul>
            </div>

            <div>
                <h2>진급관리</h2>
                <ul>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=300000">업무평가점수 관리</a></li>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=300000">상벌정보 관리</a></li>
                </ul>
            </div>

            <div>
                <h2>근태관리</h2>
                <ul>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=400000">출퇴근정보 관리</a></li>
                    <li><a href="/EgovPageLink.do?linkIndex=0&baseMenuNo=400000">휴무정보 관리</a></li>
                </ul>
            </div>

            <div class="admin">
                <h2>내무서비스관리</h2>
                <h3>내부업무게시판관리</h3>
                <ul>
                    <li><a href="/cop/bbs/SelectBBSMasterInfs.do">게시판생성관리</a></li>
                    <li><a href="/cop/com/selectBBSUseInfs.do">게시판사용관리</a></li>
                    <li><a href="/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항관리</a></li>
                    <li><a href="/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC">업무게시판관리</a></li>
                </ul>
                
                <h3>사용현황관리</h3>
                <ul>
                    <li><a href="/sym/log/clg/SelectLoginLogList.do">접속로그관리</a></li>
                    <li><a href="/sts/cst/selectConectStats.do">접속통계관리</a></li>
                    <li><a href="/uat/uap/selectLoginPolicyList.do">로그인정책관리</a></li>
                </ul>
            </div>

            <div class="admin">
                <h2>내부시스템관리</h2>
                <h3>사용자관리</h3>
                <ul>
                    <li><a href="/uss/umt/user/EgovUserManage.do">사용자등록관리</a></li>
                    <li><a href="/uss/ion/uas/selectUserAbsnceListView.do">사용자부재관리</a></li>
                </ul>

                <h3>사용자권한관리</h3>
                <ul>
                    <li><a href="/sec/ram/EgovAuthorList.do">권한관리</a></li>
                    <li><a href="/sec/gmt/EgovGroupList.do">사용자그룹관리</a></li>
                    <li><a href="/sec/rgm/EgovAuthorGroupListView.do">사용자별권한관리</a></li>
                    <li><a href="/sec/rmt/EgovRoleList.do">롤관리</a></li>
                </ul>

                <h3>메뉴관리</h3>
                <ul>
                    <li><a href="/sym/prm/EgovProgramListManageSelect.do">프로그램목록관리</a></li>
                    <li><a href="/sym/mnu/mcm/EgovMenuCreatManageSelect.do">메뉴생성관리</a></li>
                    <li><a href="/sym/mnu/mpm/EgovMenuManageSelect.do">메뉴목록관리</a></li>
                </ul>

                <h3>코드관리</h3>
                <ul>
                    <li><a href="/sym/ccm/ccc/EgovCcmCmmnClCodeList.do">분류코드관리</a></li>
                    <li><a href="/sym/ccm/cca/EgovCcmCmmnCodeList.do">공통코드관리</a></li>
                    <li><a href="/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do">상세코드관리</a></li>
                    <li><a href="/sym/ccm/zip/EgovCcmZipList.do">우편번호관리</a></li>
                </ul>
            </div> -->
        </div>
    </div>
</div>
<!--// 전체메뉴 팝업 -->

<!-- Topmenu start -->
<script type="text/javascript">

function getLastLink(baseMenuNo){
	var tNode = new Array;
    for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
        tNode[i] = document.menuListForm.tmp_menuNm[i].value;
        var nValue = tNode[i].split("|");
        //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
        if (nValue[1]==baseMenuNo) {
            if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                //링크정보가 있으면 링크정보를 리턴한다.
                return nValue[5];
            }else{
                //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                return getLastLink(nValue[0]);
            }
        }
    }
}
function goMenuPage(baseMenuNo){
	document.getElementById("baseMenuNo").value=baseMenuNo;
	
	//document.getElementById("link").value=getLastLink(baseMenuNo);
    //document.menuListForm.chkURL.value=url;
    document.menuListForm.action = "<c:url value='/'/>"+getLastLink(baseMenuNo).substring(1);
    document.menuListForm.submit();
}
function actionLogout()
{
    document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
    document.selectOne.submit();
    //document.location.href = "<c:url value='/j_spring_security_logout'/>";
}

</script>
<script>
$(document).ready(function() {
  function isMobile() {
    return window.innerWidth <= 1024;
  }

  $('.all_menu .inner > div h2').on('click', function() {
    if (!isMobile()) return;

    var $section = $(this).closest('div');
    var $subMenu = $section.find('h3, h3 + ul');

    if ($section.hasClass('open')) {
      $section.removeClass('open');
      $(this).removeClass('active');
      $subMenu.stop(true, true).slideUp(250);
    } 
    else {
      $('.all_menu .inner > div.open')
        .removeClass('open')
        .find('h3, h3 + ul')
        .stop(true, true)
        .slideUp(250);
      $('.all_menu .inner > div h2.active').removeClass('active');

      $section.addClass('open');
      $(this).addClass('active');
      $subMenu.stop(true, true).slideDown(250);
    }
  });

  $(window).on('resize', function() {
    if (!isMobile()) {
      $('.all_menu .inner > div.open')
        .removeClass('open')
        .find('h3, h3 + ul')
        .removeAttr('style');
      $('.all_menu .inner > div h2.active').removeClass('active');
      $('.all_menu .inner > div h3, .all_menu .inner > div h3 + ul').css('display', 'block');
    }
  });
});
</script>
<script>
$(document).ready(function() {
  const $gnb = $('.gnb');

  // 1dept 클릭 시 open 토글
  $gnb.on('click', '.dept_01', function(e) {
    e.preventDefault();
    const $link = $(this);
    const isOpen = $link.hasClass('open');

    // 모든 메뉴 닫기
    $gnb.find('.dept_01.open').removeClass('open');

    // 클릭한 메뉴가 닫혀 있으면 열기
    if (!isOpen) {
      $link.addClass('open');
      showSubMenu($link);
    }
  });

  // 1dept 마우스오버 시 open 추가 (자동 닫힘 없음)
  $gnb.on('mouseenter', '.dept_01', function() {
    const $link = $(this);
    // 다른 메뉴 닫기
    $gnb.find('.dept_01.open').not($link).removeClass('open');
    $link.addClass('open');
    showSubMenu($link);
  });

  // 닫기 버튼 클릭 시 닫기
  $gnb.on('click', '.subClose', function(e) {
    e.stopPropagation();
    $(this).closest('li').find('.dept_01.open').removeClass('open');
  });

  // GNB 영역 외 클릭 시 닫기
  $(document).on('click', function(e) {
    if ($(e.target).closest('.gnb').length === 0) {
      $gnb.find('.dept_01.open').removeClass('open');
    }
  });
  
  // list_menulist 추출	
  const list_menulist = [
      <c:forEach var="menu" items="${list_menulist}">
        {
          menuNo: "${menu.menuNo}",
          upperMenuId: "${menu.upperMenuId}",
          chkUrl: "${menu.chkUrl}",
          menuNm: "${menu.menuNm}"
        }<c:if test="${!fn:contains(menu.menuNo, fn:length(list_menulist))}">,</c:if>
      </c:forEach>
    ];
  
  //subMenu 보이기
  function showSubMenu($link) {

    // Clear previous submenu
    $link.next('.submenu').remove();
    
    // Create new submenu HTML
    let submenuHtml = '<div class="submenu">';
    
    // Get the menuNo of the clicked link
    const targetMenuNo = $link.data('menu-no');
    
    console.log(list_menulist);
    
    const filteredSubMenus = list_menulist.filter(subMenu => subMenu.upperMenuId == targetMenuNo);
    
    console.log(filteredSubMenus);
    
    // Add filtered submenus to HTML
    filteredSubMenus.forEach(subMenu => {
	  if (subMenu.chkUrl === '/') {
	    submenuHtml += '<h3>' + subMenu.menuNm + '</h3>';
	    submenuHtml += '<ul>';
		  
		  // Check for sub-menu items
		  const subSubMenus = list_menulist.filter(subMenu2 => subMenu.menuNo == subMenu2.upperMenuId);
		  subSubMenus.forEach(subMenu2 => {
		    submenuHtml += '<li><a href="' + subMenu2.chkUrl + '">' + subMenu2.menuNm + '</a></li>';
		  });
		submenuHtml += '</ul>';
		  
	  } else{
		  submenuHtml += '<ul>';
		  submenuHtml += '<li><a href="' + subMenu.chkUrl + '">' + subMenu.menuNm + '</a></li>';
		  submenuHtml += '</ul>';
	  }
	});
    
    submenuHtml += '</div>';
    
    // Append submenu after the clicked link
    $link.after(submenuHtml);
  }
});
</script>



<!-- // Topmenu end -->

<!-- Menu list -->
<form name="menuListForm" action="" method="post">
	<input type="hidden" id="testData" value="꽥" />
    <input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
    <input type="hidden" id="link" name="link" value="" />
    <div style="width:0px; height:0px;">
    <c:forEach var="result" items="${list_menulist}" varStatus="status" >
        <input type="hidden" name="tmp_menuNm" value="<c:out value='${result.menuNo}'/>|<c:out value='${result.upperMenuId}'/>|<c:out value='${result.menuNm}'/>|<c:out value='${result.relateImagePath}'/>|<c:out value='${result.relateImageNm}'/>|<c:out value='${result.chkUrl}'/>|" />
    </c:forEach>
    </div>
</form>