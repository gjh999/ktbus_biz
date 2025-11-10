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
			
<title>주요통계시스템 > 운전자별 사고건수 현황</title>
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
        
<!--                        <div class="content_wrap">-->
                            <div id="contents" class="content" style="width:100%; padding-left:25px;">
								<br>
                                <h1 class="tit_5">운전자별 사고건수 <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>
								<form id ="listFrm" name="listFrm" method="post">
								<div class="condition2">
								  <div class="srch_wrap">
								    <input type="hidden" name="JIBU" id="JIBU" maxlength="10" style="width:70px;" class="f_date" value="${searchData.groupNm}" readonly />
								    <input type="hidden" name="SAUP" id="SAUP" maxlength="15" class="f_date" style="width:200px;" value="${searchData.bizNo}" readonly />
								    <input type="hidden" name="isAdminYn" id="isAdminYn" />
								
								    <div class="group">
								      <span class="lb ml20">조합명</span>
								      <input type="text" name="JOHAP" id="JOHAP" maxlength="15" class="f_text" style="width:150px; outline:none;" value="${searchData.companyName}" readonly />
								    </div>
								
								    <div class="group">
								      <span class="lb ml20">조합원코드</span>
								      <input type="text" name="JOCODE" id="JOCODE" maxlength="6" class="f_text" style="width:85px; outline:none;" value="${searchData.johapcode}" readonly />
								    </div>
								
								    <div class="group">
								      <span class="lb ml20">사고년도</span>
								      <input type="text" name="FYM" id="FYM" class="f_date" maxlength="4" style="width:100px;"
								             oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/^(\d{4})/g, '$1');" />
								    </div>
								  </div>
								
								  <div class="srch_btn">
								    <button class="item btn btn_blue_46 w_100" onclick="doAction('search')" type="button">조회</button>
								    &nbsp; ※ 지급액은 현시점까지 누계입니다.
								  </div>
								</div>

 								<p style="text-align:right; font-weight:bold;">(단위: 원)</p>
 								 <!--// 검색조건 -->
									 <div style='height:calc(100% - 177px)'>
									<div id='sheetDiv' style='width:100%;height:550px'></div>
									 </div>
								</form>
								                            <!--// 게시판 -->
<!--								                        </div>-->
								                    </div>
								                </div>
								            </div>
								        </div>
								    </div>

								    <!-- Footer -->
<!--								    <c:import url="/sym/mms/EgovFooter.do" />-->
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
						fileName:'운전자별 사고건수'+'('+jname+')'+'.xlsx'
					})
				}
				
		$("#listFrm").keypress(function (e) {
			if (e.keyCode == '13') {
			doAction('search');
		      }
		});
		
		$(document).ready(function(){
			
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
		    var YeDay = YY ;
		    var ToDay = YY + "" + TMM;
		    //시작일
		    $("#FYM").val(YeDay).datepicker({
				viewMonths: 2,
				showOtherMonths: false,
				dateFormat: "yy",
				changeYear:true,
				minDate: '-30y',
				closeText:"CLOSE",
				prevText:"이전달",
				netxText:"다음달",
				currentText: "TODAY",
<!--			    monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],-->
<!--				monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],-->
<!--				dayNames: ["SUN","MON","TUE","WED","THU","FRI","SAT"],-->
<!--				dayNamesShort: ["SUN","MON","TUE","WED","THU","FRI","SAT"],-->
<!--				dayNamesMin: ["SUN","MON","TUE","WED","THU","FRI","SAT"]-->
				});
				if(SAUP == "1148205353"){
					$("#isAdminYn").val("Y"); 
					$("#JOCODE").attr("readonly",false); 
				}else{
					$("#isAdminYn").val("N"); 
				}
		    });
			<!--
			var ib = ib||{};
			ib = {
			//시트 초기화 구문
			'init':{
			  //공통기능 설정 부분
			  "Cfg": {
				"SuppressMessage": 0,
				"DataMerge" : 1,
				"CanEdit":3,
				  InfoRowConfig: {
			   	Visible: 0
						}
			  },
			  Def:{
				Row:{
					CanFormula:true,
					CalcOrder:"C42OKKU9Format"
				}
			  },
			  //틀고정 좌측 컬럼 설정
			  "LeftCols": [
			   {"Header": "운전자명","Name": "C2DNAM","Type": "Text","Width": 70, CustomFormat: "#*#","Align":"Center","FormulaRow": {"Value": "건수"}},
			   {"Header": "운전자 생년월일","Name": "C2DJUNO","Type": "Text",  "Align":"Center","FormulaRow": {"Value": "Count"}}
			  ],
			  //중앙(메인) 컬럼 설정
			  "Cols": [
				 {"Header": "사고일시","Name": "C2SYMD","Type": "Date","Format": "yyyy-MM-dd HH:mm", MinWidth : 150, "Align":"center"},
				 {"Header": "접수일시","Name": "C2JYMD","Type": "Date","Format": "yyyy-MM-dd HH:mm", MinWidth : 150, "Align":"center"},
				 {"Header": "사고번호","Name": "C2BUN","Type": "Text", MinWidth : 110, "Align":"center"},
				 {"Header": "차량번호","Name": "C2SCHNO","Type": "Text", MinWidth : 170, "Align":"center"},
				 {"Header": "진행상태","Name": "C2STATNA","Type": "Text", MinWidth : 85, "Align":"center","FormulaRow": {"Value": "합계금액"}},
				 {"Header": "지급금액","Name": "C42OKKU9","Type": "Int",FormatFormula:"C42OKKU9?'#,###':' '", MinWidth : 350,"Align":"Right","FormulaRow": "Sum"},
				 {"Header": "사고원인","Name": "CP13NAME","Type": "Text", MinWidth : 350,RelWidth: 1, "Align":"Left"}
			  ]
			},
			//시트 이벤트
			'event' :{
			},
			//시트객체 생성
			'create':function () {
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
			'sampleBtn':function () {
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
																sheet.doSearch({url: "<c:url value='/mss/tot/tot04List.do'/>", param: $("#listFrm").serialize()});
																break;
															case "exceldown":
															sheet.down2Excel({
																fileName: "TreeSheet",
																sheetName: "TREE"
																			});
																			break;
																		default: break;
																	}
												
												}
												
								ib.create();

								//-->
								</script>   
    
</body>
</html>
