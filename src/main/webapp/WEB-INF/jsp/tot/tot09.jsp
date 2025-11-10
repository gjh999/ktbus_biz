<%--
  Class Name : Sample.jsp 
  Description : 샘플화면 - 관리용화면샘플(sample)
  Modification Information
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- ibsheet css -->
<link rel="stylesheet" href="../../css/default/main.css"/>
<!--  ibsheet 필수 js -->
<script src="../../js/ibsheet/ibleaders.js"></script>
<script src="../../js/ibchart/ibleaders.js"></script>
<script src="../../js/ibchart/ibchart.js"></script>
<script src="../../js/ibchart/ibchartinfo.js"></script>
<script src="../../js/ibsheet/ibsheet.js"></script>
<script src="../../js/ibsheet/locale/ko.js"></script>
<script src="../../js/mysuit-common.js"></script>

<!--  ibsheet 선택/추가 js -->
<script src="../../js/ibsheet/plugins/ibsheet-common.js"></script>
<script src="../../js/ibsheet/plugins/ibsheet-dialog.js"></script>
<script src="../../js/ibsheet/plugins/ibsheet-excel.js"></script>
<!--  외부 라이브러리 추가 -->
<script src="https://demo.ibsheet.com/ibsheet/v8/samples/customer-sample/assets/vendors/fontawesome.min.js"></script>
<link rel="stylesheet" href="https://www.ibsheet.com/v8/ibsheet/html/../assets/css/ibsheetExampleExtra.css"/>
<title>주요통계시스템 > 계약번호별 재갱신율 확인</title>
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
	          <c:import url="/sym/mms/EgovMenuLeft.do" />
	          <!--// Left menu -->
	          <div class="content_wrap">
	            <div id="contents" class="content">
	              <!-- Location -->
	              <br>
	              <h1 class="tit_1">계약번호별 재갱신율 확인</h1>
	              <br>
	              <!-- 검색조건 -->
					<div class="condition2">
					  <div class="srch_wrap">
					    <div class="group">
					      <span class="lb ml20">지부</span>
					      <input type="text" name="JIBU" id="JIBU" maxlength="10" style="width:70px;" class="f_date" value="서울" readonly />
					    </div>
					
					    <div class="group">
					      <span class="lb ml20">사업자번호</span>
					      <input type="text" name="SAUP" id="SAUP" maxlength="15" class="f_date" style="width:200px;" value="123-45-65711" readonly />
					    </div>
					
					    <div class="group">
					      <span class="lb ml20">조합명</span>
					      <input type="text" name="JOHAP" id="JOHAP" maxlength="15" class="f_date" style="width:250px;" value="제일고속관광" readonly />
					    </div>
					
					    <div class="group">
					      <span class="lb ml20">기간 조회</span>
					      <input type="text" name="FYY" id="FYY" class="f_date" maxlength="4" style="width:50px;"
					             oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/^(\d{4})/g, '$1');" />년
					      <input type="text" name="FMM" id="FMM1" class="f_date" style="width:50px;" maxlength="2"
					             oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/^(\d{4})/g, '$1');" />월 ~
					      <input type="text" name="TMM" id="TMM" class="f_date" style="width:50px;" maxlength="2"
					             oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/^(\d{4})/g, '$1');" />월
					    </div>
					  </div>
					
					  <div class="srch_btn">
					    <button class="item btn btn_blue_46 w_100" onclick="doAction('search')" type="button">조회</button>
					  </div>
					</div>

	              <!--// 검색조건 -->
	              <div style='height:calc(100% - 177px)'>
	                <div id='sheetDiv' style='width:100%;height:570px'></div>
	              </div>
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
<script language="javascript1.2"  type="text/javaScript"> 
<!--
	var ib = ib || {};
	ib = {
		//시트 초기화 구문
		'init': {
			//공통기능 설정 부분
			"Cfg": {
				"SuppressMessage": 0,
				InfoRowConfig: {
					Visible: 0
				},
			},
			//틀고정 좌측 컬럼 설정
			"LeftCols": [{
				"Header": "No",
				"Name": "SEQ",
				"Type": "Int",
				"Width": 40
			}],
			//중앙(메인) 컬럼 설정
			"Cols": [{
					"Header": "이름",
					"Name": "sName",
					"Type": "Text",
					"Color": "#AAAAAA"
				},
				{
					"Header": "급여",
					"Name": "sMoney",
					"Type": "Text",
					"MaxWidth": 150
				},
				{
					"Header": "전화번호",
					"Name": "sPhone",
					"Type": "Text",
					"Width": 150,
					"MaxWidth": 300
				},
				{
					"Header": "주민/사업자 번호",
					"Name": "sId",
					"Type": "Text"
				},
				{
					"Header": "우편번호",
					"Name": "sPostNo",
					"Type": "Text"
				},
				{
					"Header": "주소",
					"Name": "sAddr",
					"Type": "Text"
				},
				{
					"Header": "카드번호",
					"Name": "sCard",
					"Type": "Text"
				},
				{
					"Header": "사용자 임의 포맷",
					"Name": "sCustom",
					"Type": "Text",
					"RelWidth": 1
				}
			]
		},
		//시트 이벤트
		'event': {},
		//시트객체 생성
		'create': function() {
			var options = this.init;
			options.Events = this
				.event;
			IBSheet.create({
				id: 'sheet', // 생성할 시트의 id
				el: 'sheetDiv', // 시트를 생성할 Dom 객체 및 id
				options: options, // 생성될 시트의 속성
				data: this
					.data // 생성될 시트의 정적데이터
			});
			var createDate =
				function(count) {
					var sName = [
						'Google',
						'Apple',
						'삼성전자',
						'LG전자',
						'한화',
						'Microsoft',
						'현대',
						'현기차',
						'SK',
						'롯데'
					];
				}
		},
		//화면 기능
		'sampleBtn': function() {
			switch (arguments[0]
				.innerText) {
				case '메시지 띄우기':
					sheet
						.hideMessage(); // 기존에 화면에 다이얼로그가 존재하는 경우 다이얼로그를 닫습니다.
					var msgval1 =
						document
						.getElementById(
							'msgval1'
							).value;
					if (!msgval1) {
						alert(
							'메시지를 입력해주세요');
						return;
					}
					sheet
						.showMessage({
							message: msgval1,
							type: (document
								.getElementById(
									'block1'
									)
								.checked ?
								1 :
								0
								),
							importance: 4
						});
					break;
				case '메시지 끄기':
					sheet
						.hideMessage();
					break;
				case '메시지(Time) 띄우기':
					sheet
						.hideMessage(); // 기존에 화면에 다이얼로그가 존재하는 경우 다이얼로그를 닫습니다.
					var msgval =
						document
						.getElementById(
							'msgval'
							).value;
					var msgtime =
						parseInt(
							document
							.getElementById(
								'msgtime'
								)
							.value,
							10);
					if (!msgval) {
						alert(
							'메시지를 입력해주세요');
						return;
					}
					if (isNaN(
							msgtime
							)) {
						alert(
							'메시지 시간을 입력해주세요');
						return;
					}
					msgtime *= 1000;
					sheet
						.showMessageTime({
							message: msgval,
							time: msgtime,
							importance: 4
						});
					break;
					// no default
			}
		},
		//조회 데이터
	}
	ib.create();
//-->
</script>   
</body>
</html>