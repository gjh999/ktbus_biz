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
<%@ page import="egovframework.com.cmm.LoginVO" %>
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
<link rel="stylesheet" href="<c:url value='/'/>css/jquery-ui.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/jquery-ui.min.js"></script>
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
<!--  ibsheet 선택/추가 js -->
<script src="../../js/ibsheet/plugins/ibsheet-common.js"></script>
<script src="../../js/ibsheet/plugins/ibsheet-dialog.js"></script>
<script src="../../js/ibsheet/plugins/ibsheet-excel.js"></script>
<!--  외부 라이브러리 추가 -->
<script src="https://demo.ibsheet.com/ibsheet/v8/samples/customer-sample/assets/vendors/fontawesome.min.js"></script>
<link rel="stylesheet" href="https://www.ibsheet.com/v8/ibsheet/html/../assets/css/ibsheetExampleExtra.css"/>
<title>주요통계시스템 > 관할 지부별 손해율/사고발행율/수입분담금 현황</title>
<style>
input[type=number]:focus{
border: 3px solid #555;
}
</style>
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
	      <div class="sub_in" style="padding-left : 10px;">
	        <div class="layout">
	          <!-- Left menu -->
	          <c:import url="/sym/mms/EgovMenuLeft.do" />
	          <!--						<c:import url="/main/inc/EgovIncHeader.do"/>-->
	          <!--// Left menu -->
<!--	          <div class="content_wrap">-->
	            <div id="contents" class="content" style="width:100%; padding-left:25px;">
	              <br>
	              <h1 class="tit_5">자부담금대상  <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>
	              <form id="listFrm" name="listFrm" method="post">
	                <!-- 검색조건 -->
	                <div class="condition2">
<!--	              <span class="lb ml20">지부</span>-->
	                  	<input type='hidden' name='JIBU' id='JIBU' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupNm}" readonly />
<!--	              <span class="lb ml20">사업자번호</span>-->
	                  	<input type='hidden' name='SAUP' id='SAUP' maxlength='15' class='f_date' style="width:200px;" value="${searchData.bizNo}" readonly />
	                  <span class="lb ml20">조합명</span>
	                  	<input type='text' name='JOHAP' id='JOHAP' maxlength='15' class='f_text' style="width:150px; outline:none;" value="${searchData.companyName}" readonly />
	                  <span class="lb ml20">조합원코드</span>
	                  	<input type='text' name='JOCODE' id='JOCODE' maxlength='15' class='f_text' style="width:85px; outline:none;" value="${searchData.johapcode}" readonly />
	                  <span class="lb ml20">사고년월</span>
	                  	<input type='text' name='FYM' id='FYM' class='f_date' maxlength='6' style="width:120px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  /> 
					  &nbsp;&nbsp;&nbsp; 
					  <button class='item btn btn_blue_46 w_100' onclick="doAction('search')" type="button">조회</a></button>
					  &nbsp;※ 자차 과실율에 따라 자부담금 현황은 변경 될 수 있습니다.
					  <br>
	  					<span class="lb ml20">조회구분&nbsp;&nbsp;&nbsp;: </span>
	  					  	<input type='radio' name='GUBN2' id='GUBN2' class='f_button' value="1" /><span class="lb ml10">수납</span>
	  						<input type='radio' name='GUBN2' id='GUBN2' class='f_button' value="2" checked/><span class="lb ml10">미납(전체기간)</span>
					 
					  	<input type='hidden' name='isAdminYn' id='isAdminYn'>
	                </div>
                      <p style="text-align:right; font-weight:bold;">(단위: 원)</p>	
					  <!--// 검색조건 -->
	                <div style='height:calc(100% - 177px)'>
	                  <div id='sheetDiv' style='width:100%;height:550px'></div>
	                </div>
	              </form>
	              <!--// 게시판 -->
<!--	            </div>-->
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	  <!-- Footer -->
<!--	  <c:import url="/sym/mms/EgovFooter.do" />-->
	  <!--// Footer -->
	</div>
<script language="javascript1.2"  type="text/javaScript"> 
	
	var SAUP = '${searchData.bizNo}'.replaceAll('-',''); // 로그인한 사업자 번호
	var jname=$("#JOHAP").val();
		
		function excelDown(obj){
			if(sheet.getDataRows().length == 0){
							alert("다운로드할 데이터가 없습니다.");
							return;
						}
				sheet.exportData({
					merge:3,
					fileName:'자부담금대상'+'('+jname+')'+'.xlsx'
				})
			}
			
	$("#listFrm").keypress(function(e) {
		if (e.keyCode == '13') {
			doAction('search');
		}
	});
	$(document).ready(function() {
		
		/*
		setTimeout(function() {
		  doAction('search');
		  }, 500);
		*/
		
		var now = new Date();
		var YY = now.getFullYear();
		var MM = (now.getMonth() +
				1).toString()
			.padStart(2, '0');
		var TMM = now.getMonth()
			.toString().padStart(2,
				'0');
		var DD = now.getDate()
			.toString().padStart(2,
				'0');
		var YeDay = YY + "" + MM;
		var ToDay = YY + "" + TMM +
			"" + DD;
		$("#FYM").val(YeDay)
			.datepicker({
				dateFormat: 'yymm',
				changeYear: true,
				changeMonth: true,
				closeText: "CLOSE",
				prevText: "이전달",
				netxText: "다음달",
				minDate:new Date('2022-01-01'),
				currentText: "TODAY",
				monthNames: ["1월(JAN)",	"2월(FEB)",	"3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)","7월(JUL)",
					"8월(AUG)",
					"9월(SEP)",
					"10월(OCT)",
					"11월(NOV)",
					"12월(DEC)"
				],
				monthNamesShort: [
					"1월",
					"2월",
					"3월",
					"4월",
					"5월",
					"6월",
					"7월",
					"8월",
					"9월",
					"10월",
					"11월",
					"12월"
				],
				dayNames: [
					"SUN",
					"MON",
					"TUE",
					"WED",
					"THU",
					"FRI",
					"SAT"
				],
				dayNamesShort: [
					"SUN",
					"MON",
					"TUE",
					"WED",
					"THU",
					"FRI",
					"SAT"
				],
				dayNamesMin: [
					"SUN",
					"MON",
					"TUE",
					"WED",
					"THU",
					"FRI",
					"SAT"
				],
			});
			if(SAUP == "1148205353"){
							$("#isAdminYn").val("Y"); 
							$("#JOCODE").attr("readonly",false); 
						}else{
							$("#isAdminYn").val("N"); 
						}
			
	});
	var ib = ib || {};
	ib = {
		//시트 초기화 구문
		'init': {
			//공통기능 설정 부분
			"Cfg": {
				/*	SearchMode: 2,
				NoVScroll: 1,
				NoDataMessage: 3,
				NoDataMiddle: 1,*/
				"SuppressMessage": 0,
				"ClickPivotFilter": 1,
				"CanEdit": 3,
				"DataMerge": 1,
				HeaderMerge : 3,
				InfoRowConfig: {
					Visible: 0
				},
				"SelectionSummary": {
					"Mode": "DelRow",
					"Size": "High"
				},
			},
			Def:{
				Row:{
					CanFormula:true,
					CalcOrder:"JABKUMFormat,JAIKUM1Format,JAHKUMFormat"
				}
			},
			//틀고정 좌측 컬럼 설정
			"LeftCols": [
				{"Header": ["조합원명","조합원명"],"Name": "MKNAME",	"Type": "Text"},
				{"Header": ["차량번호","차량번호"],"Name": "MKCHNO",	"Type": "Text"},
				{"Header": ["계약번호","계약번호"],"Name": "MKBUNH",	"Type": "Text"}
			],
			//중앙(메인) 컬럼 설정
			"Cols": [
				{"Header": ["사고번호","사고번호"],"Name": "C2BUNH",	"Type": "Text","Align": "center",MinWidth: 91,RelWidth: 1,"FormulaRow": {"Value": "합계"}	},
				{"Header": ["운전자명","운전자명"],"Name": "C2DNAM","Type": "Text","Width": 70, CustomFormat: "#*#","Align":"Center"},
				{"Header": ["사고일자","사고일자"],"Name": "C2SYMD","Type": "Date",Format: "yyyy/MM/dd",	MinWidth: 90,RelWidth: 1,"Align": "center"},
				{"Header": ["접수일자","접수일자"],"Name": "C2JYMD","Type": "Date",Format: "yyyy/MM/dd",	"Align": "center",MinWidth: 90,	RelWidth: 1,"FormulaRow": "Count"},
				{"Header": ["발생금액","발생금액"],"Name": "JABKUM",	"Type": "Int",FormatFormula:"JABKUM?'#,###':' '",	"FormulaRow": "Sum",RelWidth: 1,MinWidth : 110},
				{"Header": ["수납상태","수납상태"],"Name": "JACHK","Type": "Text"},
				{"Header": ["수납금액","수납금액"],"Name": "JAIKUM1","Type": "Int",FormatFormula:"JAIKUM1?'#,###':' '","FormulaRow": "Sum",RelWidth: 1,MinWidth : 110},
				{"Header": ["입금일자","입금일자"],"Name": "JAIPYMD1","Type": "Date",MinWidth: 90,RelWidth: 1,Format: "yyyy/MM/dd"},
				{"Header": ["환급금액","환급금액"],"Name": "JAHKUM",	"Type": "Int",FormatFormula:"JAHKUM?'#,###':' '",	RelWidth: 1,MinWidth : 110},
				{"Header": ["환급일자","환급일자"],"Name": "JAHYMD",	"Type": "Date",MinWidth: 90,RelWidth: 1,Format: "yyyy/MM/dd"},
				{"Header": ["보상처리상태","보상처리상태"],"Name": "C22SATAT",	"Type": "Text"},
				{"Header": ["보상지부","보상지부"],"Name": "C22CDCODN","Type": "Text"}
			]
		},
		//시트 이벤트
		'event': {
			onReadCanEditDate: function(
				evtParam) {
				if (evtParam.col ===
					'DUE_DATE') {
					var row =
						evtParam
						.row;
					var toID =
						new Date(
							parseInt(
								row
								.ORDER_DATE,
								10)
						);
					var fromID =
						new Date(
							parseInt(
								row
								.DTDY31,
								10)
						);
					// 수주일과 검수일 사이만 선택 가능함.
					if (evtParam
						.date <
						toID ||
						evtParam
						.date >
						fromID) {
						return false;
					}
					return true;
				}
			},
			onBeforeExport: function(
				evtParam) {
				console.log(evtParam
					.eventName +
					' 발생');
			},
			onExportFinish: function(
				evtParam) {
				console.log(evtParam
					.eventName +
					' 발생');
			},
			onSearchFinish: function(
				evtParam) {
				for (var i = 1; i <=
					12; i++) {
					var col =
						"HIKKM" + i;
					evtParam.sheet
						.fitSize({
							col: col,
							norender: 1
						});
				}
				evtParam.sheet
					.rerender();
			}
		},
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
			window.Cal = null;
		},
		//화면 기능
		'data': []
	}

	function doAction(str) {
		switch (str) {
			case "search":
				//데이터 조회
				sheet.doSearch({
					url: "<c:url value='/mss/tot/tot06List.do'/>",
					param: $(
							"#listFrm"
						)
						.serialize()
				});
				break;
			case "exceldown":
				sheet.down2Excel({
					fileName: "TreeSheet",
					sheetName: "TREE"
				});
				break;
			default:
				break;
		}
	}
	ib.create();//-->
</script>   
</body>
</html>