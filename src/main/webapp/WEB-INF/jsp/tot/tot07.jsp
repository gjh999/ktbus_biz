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
	              <h1 class="tit_5"> 환급금 이체내역 조회  <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>
	              <form id="listFrm" name="listFrm" method="post">
	                <!-- 검색조건 -->
	                <div class="condition2">
<!--	                  <span class="lb ml20">지부</span>-->
	                  <input type='hidden' name='JIBU' id='JIBU' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupNm}" readonly />
<!--	                  <span class="lb ml20">사업자번호</span>-->
	                  <input type='hidden' name='SAUP' id='SAUP' maxlength='15' class='f_date' style="width:200px;" value="${searchData.bizNo}" readonly />
	                  <span class="lb ml20">조합명</span>
	                  <input type='text' name='JOHAP' id='JOHAP' maxlength='15' class='f_text' style="width:150px; outline:none;" value="${searchData.companyName}" readonly />
	                  <span class="lb ml20">조합원코드</span>
	                  <input type='text' name='JOCODE' id='JOCODE' maxlength='6' class='f_text' style="width:85px; outline:none;" value="${searchData.johapcode}" readonly />
	                  <span class="lb ml20">이체년월</span>
	                  <input type='text'  name='FYM' id='FYM' class='f_date' maxlength='6' style="width:120px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" />
	                  <input type='hidden' name='TYM' id='TYM' class='f_date' maxlength='8' style="width:120px;" />
					   &nbsp;&nbsp;&nbsp; 
					  <button class='item btn btn_blue_46 w_100' onclick="doAction('search')" type="button">조회</button>
					  
					  <input type='hidden' name='isAdminYn' id='isAdminYn'>
				  </div>
				  <p style="text-align:right; font-weight:bold;">(단위: 원)</p>	
	                <div style='height:calc(100% - 177px)'>
	                  <div id='sheetDiv' style='width:100%;height:550px'>
	                  </div>
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
<!--	  // Footer -->
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
					fileName:'환급금 이체내역 조회'+'('+jname+')'+'.xlsx'
				})
			}
	
	function maxLengthCheck(Object) {
		if (Object.value.length > object
			.maxLength) {
			object.value = object.value
				.slice(0, object.maxLength);
		}
	}
	$("#listFrm").keypress(function(e) {
		if (e.keyCode == '13') {
			doAction('search');
		}
	});
	
	$(document).ready(function() {
		
		setTimeout(function() {
		  doAction('search');
		  }, 500);	
		
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
		var ToDay = YY + "" + TMM;
		var TYM11 = "202401";
		$("#FYM").val(YeDay)
			.datepicker({
				dateFormat: 'yymm',
				changeYear: true,
				changeMonth: true,
				minDate: '-30y',
				closeText: "CLOSE",
				prevText: "이전달",
				netxText: "다음달",
				currentText: "TODAY",
				monthNames: [
					"1월(JAN)",
					"2월(FEB)",
					"3월(MAR)",
					"4월(APR)",
					"5월(MAY)",
					"6월(JUN)",
					"7월(JUL)",
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
		$("#TYM").val(TYM11);
		
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
					CalcOrder:"MVKMFormat"
				}
				
			},
			//틀고정 좌측 컬럼 설정
			"LeftCols": [
				{"Header": "이체날짜",	"Name": "YMD","Type": "Text","Width": 150,"Align": "Center","FormulaRow": {"Value": "합계"}},
				{"Header": "이체종류",	"Name": "ACCDNA","Type": "Text","Align": "left","FormulaRow": {"Value": "Count"}},
				{"Header": "은행코드",	"Name": "BKCD","Type": "Text","Align": "Center"}
						],
			//중앙(메인) 컬럼 설정
			"Cols": [
				{"Header": "은행명","Name": "BKCDNA","Type": "Text",Width : 100},
				{"Header": "계좌번호",	"Name": "ACNO","Type": "Text",Width : 200,RelWidth: 1},
				{"Header": "예금주명","Name": "CMNA","Type": "Text",Width : 200,RelWidth: 1},
				{"Header": "송금금액",	"Name": "MVKM","Type": "Int",FormatFormula:"MVKM?'#,###':' '","FormulaRow": "Sum",MinWidth: 120},
				{"Header": "송금인명",	"Name": "COMNA","Type": "Text",Width : 200,RelWidth: 1}
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
					url: "<c:url value='/mss/tot/tot07List.do'/>",
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
	ib.create();
//-->
</script>   
</body>
</html>