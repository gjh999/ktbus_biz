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
	<link rel="stylesheet" href="<c:url value='/'/>css/jquery-ui.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/jquery-ui.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/mysuit-common.js"></script>
	
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
	
	
<title>주요통계시스템 > 계약번호별 만기 갱신안내 현황</title>
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
	          <!--// Left menu -->
<!--	          <div class="content_wrap">-->
	            <div id="contents" class="content" style="width:100%; padding-left:25px;">
	              <!-- Location -->
	              <br>
	              <h1 class="tit_5">만기갱신안내 <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>
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
	                  <span class="lb ml20">만기기간</span>
	                  <input type='text' name='FYM' id='FYM' class='f_date' maxlength="8" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" />~ 
					  <input type='text' name='TYM' id='TYM' class='f_date' maxlength="8" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" />
					   &nbsp;&nbsp;&nbsp; <button class='item btn btn_blue_46 w_100' onclick="doAction('search')" type="button">조회</button>
						
<!--						<button class='item btn btn_blue_46 w_100' onclick="doAction('action')" type="button">다운-->
					  </a>
					  <input type='hidden' name='isAdminYn' id='isAdminYn'>
	                </div>
                      <p style="text-align:right; font-weight:bold;">(단위: %)</p>	               
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
						fileName:'만기갱신안내'+'('+jname+')'+'.xlsx'
					})
				}
				
		$("#listFrm").keypress(function(e) {
		    if (e.keyCode == '13') {
		        doAction('search');
		    }
		});

		function maxLengthCheck(object) {
		    if (object.value.length > object.maxLength) {
		        object.value = object.value.slice(0, object.maxLength);
		    }
		}
		$(document).ready(function() {
			
			/*
			setTimeout(function() {
			   doAction('search');
			 }, 500);
			*/
			
		    var now = new Date();
		    var YY = now.getFullYear();
		    var MM = (now.getMonth() + 1).toString().padStart(2, '0');
		    var TMM = now.getMonth().toString().padStart(2, '0');
		    var DD = now.getDate().toString().padStart(2, '0');
		    var YeDay = YY + "" + MM + "" + DD;
		    var ToDay = YY + "" + TMM + "" + DD;
			var jname=$("#JOHAP").val();
				
				function excelDown(obj){
						sheet.exportData({
							merge:3,
							fileName:'만기갱신안내'+'('+jname+')'+'.xlsx'
						})
					}
			
			
		    //시작일
		    $("#FYM").val(ToDay).datepicker({
		        dateFormat: 'yymmdd',
				changeYear:true,
				changeMonth: true,
				minDate: '-30y',
				closeText:"CLOSE",
				prevText:"이전달",
				netxText:"다음달",
				currentText: "TODAY",
			    monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
				monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
				dayNames: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesShort: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesMin: ["SUN","MON","TUE","WED","THU","FRI","SAT"],

		        onClose: function(selectedDate) {
		            // 시작일(FYM) datepicker가 닫힐때
		            // 종료일(TYM)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
		            $("#TYM").datepicker("option", "minDate", selectedDate);
		        }
		    });
		    //종료일
		    $("#TYM").val(YeDay).datepicker({
				dateFormat: 'yymmdd',
				changeMonth: true,
				closeText:"CLOSE",
				prevText:"이전달",
				netxText:"다음달",
				currentText: "TODAY",
				monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
				monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
				dayNames: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesShort: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesMin: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
		        onClose: function(selectedDate) {
		            $("#FYM").datepicker("option", "maxDate", selectedDate);
		        }
		    });
			
			if(SAUP == "1148205353" || SAUP == "ORGNZT_0000000000000"){
				$("#isAdminYn").val("Y"); 
				$("#JOCODE").attr("readonly",false); 
			}else{
				$("#isAdminYn").val("N"); 
			}
		}); 
		<!--
		var ib = ib || {};
			ib = {
	    //시트 초기화 구문
	    'init': {
	        //공통기능 설정 부분
	        "Cfg": {
	            "SuppressMessage": 0,
	            "CanEdit": 3,
	            "DataMerge": 1,
	            HeaderMerge: 3,
	            InfoRowConfig: {
	                Visible: 0
	            },
	        },
			Def:{
				Row:{
					CanFormula:true,
					CalcOrder:"HBGUNSFormat,HBJUMSFormat"
					}
			},
	        //틀고정 좌측 컬럼 설정
	        "LeftCols": [
				{"Header": ["번호", "번호"],"Name": "SEQ","Type": "Int","Width": 50},
	            {"Header": ["계약번호", "계약번호"],"Name": "MKBUN","Type": "Text","Width": 110},
	            {"Header": ["차량번호", "차량번호"],"Name": "MKCHNO","Type": "Text","Width": 150}
	        ],
	        //중앙(메인) 컬럼 설정
	        "Cols": [
				{Header: ["만기일", "만기일"] ,Name: "MKTYMD1" ,Type: "Date" ,Format: "yyyy-MM-dd" ,RelWidth: 1,MinWidth:100},
	            {Header: ["전계약적용율", "전계약적용율"] ,Name: "MKSHTR" ,Type: "Float" ,MinWidth: 100,Format:"###.##"},
	            {Header: ["평가기간사고", "건수"] ,Name: "HBGUNS" ,Type: "Int" ,MinWidth: 50 ,Align: "center",FormatFormula:"HBGUNS?'#,### 건':' '"},
	            {Header: ["평가기간사고", "점수"] ,Name: "HBJUMS" ,Type: "Int" ,MinWidth: 50 ,Align: "center",FormatFormula:"HBJUMS?'#,### 점':' '"},
	            {Header: ["갱신계약적용율", "표준"] ,Name: "HBNHHR" ,Format:"###.##",Type: "Float" ,MinWidth: 80},
	            {Header: ["갱신계약적용율", "범위"] ,Name: "HBNHBR" ,Format:"###.##",Type: "Float" ,MinWidth: 80},
	            {Header: ["갱신계약적용율", "특별"] ,Name: "HBNHSR" ,Format:"###.##",Type: "Float" ,MinWidth: 80},
	            {Header: ["갱신계약적용율", "합계"] ,Name: "HBNHTR" ,Format:"###.##",Type: "Float" ,MinWidth: 80},
	            {Header: ["구분", "구분"] ,Name: "CHK1" ,Type: "Text" ,MinWidth: 80 ,RelWidth: 1 ,Align: "center"},
	            {Header: ["영수일자", "영수일자"] ,Name: "SPBYMD" ,Type: "Date" ,Format: "yyyy-MM-dd" ,MinWidth: 100 ,RelWidth: 1 ,Align: "center"},
	            {Header: ["관리지부", "관리지부"] ,Name: "MKJJCDN" ,Type: "Text" ,RelWidth: 1 ,MinWidth: 100}
			        ]
			    },
			    //시트 이벤트
			    'event': {},
			    //시트객체 생성
			    'create': function() {
			        var options = this.init;

			        options.Events = this.event;
			        IBSheet.create({
			            id: 'sheet', // 생성할 시트의 id
			            el: 'sheetDiv', // 시트를 생성할 Dom 객체 및 id
			            options: options, // 생성될 시트의 속성
			            data: this.data // 생성될 시트의 정적데이터
			        });
			        var createDate = function(count) {
			            var sName = [
			            ];
			        }
			    },
	    //화면 기능
	    'sampleBtn': function() {
	        switch (arguments[0].innerText) {
	            case '메시지 띄우기':
	                sheet.hideMessage(); // 기존에 화면에 다이얼로그가 존재하는 경우 다이얼로그를 닫습니다.
	                var msgval1 = document.getElementById('msgval1').value;

	                if (!msgval1) {
	                    alert('메시지를 입력해주세요');

	                    return;
	                }
	                sheet.showMessage({
	                    message: msgval1,
	                    type: (document.getElementById('block1').checked ? 1 : 0),
	                    importance: 4
	                });
	                break;
	            case '메시지 끄기':
	                sheet.hideMessage();
	                break;
	            case '메시지(Time) 띄우기':
	                sheet.hideMessage(); // 기존에 화면에 다이얼로그가 존재하는 경우 다이얼로그를 닫습니다.
	                var msgval = document.getElementById('msgval').value;
	                var msgtime = parseInt(document.getElementById('msgtime').value, 10);

	                if (!msgval) {
	                    alert('메시지를 입력해주세요');

	                    return;
	                }
	                if (isNaN(msgtime)) {
	                    alert('메시지 시간을 입력해주세요');

	                    return;
	                }
	                msgtime *= 1000;

	                sheet.showMessageTime({
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

		function doAction(str){			
		switch(str){
		case "search":
		//데이터 조회
		sheet.doSearch({url: "<c:url value='/mss/tot/tot05List.do'/>", param: $("#listFrm").serialize()});
		break;
		case "action":
		var gUrl = "http://192.168.2.20:8195/MYSUIT";
		var objFormData = new Object();
			objFormData.projectName = "Education";
			objFormData.formName    = "test_1";
		var objDataset = new Object();
		var dataset_0 = $("#listFrm").serialize();
			objDataset.dataset_0 = JSON.stringify(dataset_0); 
			objFormData.datasetList = objDataset;
		var objParam = new Object();
			objParam.YYMM = '202503';
			objFormData.paramList   = objParam;
			mysuitModule.gfn_reportCall(objFormData, gUrl + "/UView5/index.jsp"); // iframe으로 호출
		break;
		default: break;
				 }
		}
		ib.create();
	//-->
	</script>   
    
</body>
</html>