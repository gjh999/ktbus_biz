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

<title>주요통계시스템 > 조합원별 손해율/사고발행율/수입분담금 현황</title>
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
	              <br>
	              <h1 class="tit_5">관할지부 대비 사고발생율 <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>
	              <!-- 검색조건 -->
				  <form id ="listFrm" name="listFrm" method="post">
	              <div class="condition2">
		              <div class="srch_wrap">
	<!--	                <span class="lb ml20">지부</span>-->
		                <input type='hidden' name='JIBUNM' id='JIBUNM' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupNm}" readonly />
						<input type='hidden' name='JIBU' id='JIBU' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupId}" readonly />
	<!--	                <span class="lb ml20">사업자번호</span>-->
		                <input type='hidden' name='SAUP' id='SAUP' maxlength='15' class='f_date' style="width:200px;" value="${searchData.bizNo}" readonly />
		              	<div class="group"> 
		              	<span class="lb ml20">조합명</span>
		                <input type='text' name='JOHAP' id='JOHAP' maxlength='15' class='f_text' style="width:150px; outline:none;" value="${searchData.companyName}" readonly />
		                </div>
		              	<div class="group">
		              	<span class="lb ml20">조합원코드</span>
						<input type='text' name='JOCODE' id='JOCODE' maxlength='6' class='f_text' style="width:85px;outline:none;" value="${searchData.johapcode}" readonly />
						</div>
		              	<div class="group">
		              	  <span class="lb ml20">해당년월</span>
						<input type='hidden' name='FYM' id='FYM' class='f_date' maxlength="6" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" /> 
						<input type='text' name='TYM' id='TYM' class='f_date' maxlength="6" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" />
						</div>
		              </div>
		              <div class="srch_btn">
			              <button class='item btn btn_blue_46 w_100' onclick="doAction('search')" type="button">조회</a></button>
							&nbsp; ※ 마감된 달까지만 조회됩니다. (매 년도 12월 마감기준)
												<input type='hidden' name='isAdminYn' id='isAdminYn'>
		              </div>
	              </div>
				  <p style="text-align:right; font-weight:bold;">(단위: 원, %)</p>
	              <!-- 검색조건 -->
	              <div style='height:calc(100% - 177px)'>
	                <div id='sheetDiv' style='width:100%;height:550px'></div>
	              </div>
				  <font color=""> ※ 사고율(%) = 사고건수 / 해당월총일수 * 365 / 유효대수 * 100  </font> &nbsp;&nbsp;,&nbsp;&nbsp;
				  <font color=""> ※ 손해율(%) = 손해액 / 경과분담금 * 100  </font>
				  <br>
				  <font color="">※ 경과분담금 : 공제계약자로 부터 받은 분담금 중 공제기간이 경과한 분담금으로 공제사고비용 및 운용에 사용되는 금액<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  (예시:1년분 분담금을 납부시 6개월이 경과했을 경우 1/2의 분담금이 경과분담금임)</font><br> 
				  <font color="">※ 손해금액 : 해당년도의 손해금액(지급공제금) + 차기미결추산-전월미결추산(조회시점 미마감 시 해당월은 미반영)</font><br>
				  <font color="">※ 전월미결추산 : 해당년도-1년의 종료월의 미결추산</font><br>
				  <font color="">※ 차기미결추산 : 해당년도의 종료월의 미결추산</font>

				  </form>
<!--	            </div>-->
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
<!--	  <c:import url="/sym/mms/EgovFooter.do" />-->
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
				fileName:'관할지부 대비 사고발생율'+'('+jname+')'+'.xlsx'
			})
		}
	
	$("#listFrm").keypress(function (e) {
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
		    var MM = now.getMonth().toString().padStart(2, '0');
		    var TMM =now.getMonth().toString().padStart(2, '0');
		    var DD = now.getDate().toString().padStart(2, '0');
		    //종료일
			var YeDay = YY + "" + MM;
			//시작일
		    var ToDay = YY + "" + TMM;
			var TYM11 = "202501";
			
		    //시작일
			$("#FYM").val(TYM11)
		    //종료일
		    $("#TYM").val(YeDay).datepicker({
				dateFormat: 'yymm',
				changeMonth: true,
				closeText:"CLOSE",
				prevText:"이전달",
				netxText:"다음달",
				monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
				monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
				dayNames: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesShort: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
				dayNamesMin: ["SUN","MON","TUE","WED","THU","FRI","SAT"],
		        onClose: function(selectedDate) {
		            $("#FYM").datepicker("option", "maxDate", selectedDate);
		        }
		    });
			if(SAUP == "1148205353" || SAUP == "admin"){
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
				  SearchMode: 0,
				  HeaderMerge : 3,
			  	 "DataMerge" : 1,
				 "CanEdit":3,
				  InfoRowConfig: {
							Visible: 0
						}
			    },
				Def:{
					Row:{
						CanFormula:true,
						CalcOrder:"MTADA1Format,MTDKMFormat,HKGKMFormat,SCNTFormat,C89G22Format,C89G23Format,C89G21Format,RPOKKMFormat,JKUMFormat,CKUMFormat,SONKUMFormat,SAGO_ULFormat"
					}
				},
			    //틀고정 좌측 컬럼 설정
			    "LeftCols": [
			      {"Header": ["조합원명","조합원명"],"Name": "CBCODN","Type": "Text","Width": 150, "Align":"Center","Format":""},
			  	{"Header":  ["담보","담보"],"Name": "DAMN","Type": "Text","Format":""},
			  	{"Header": ["차종","차종"], "Name": "MTJONGN","Type": "Text","Format":""},
				{"Header": ["유효대수","유효대수"],"Name": "MTADA1","Type": "Int",FormatFormula:"MTADA1?'#,### 대':' '"},
			    ],
			    //중앙(메인) 컬럼 설정
				"Cols": [
					    {"Header": ["분담금","납입분담금"],"Name": "MTDKM","Type": "Int",FormatFormula:"MTDKM?'#,###':' '", MinWidth : 130, RelWidth: 1},
					    {"Header": ["분담금","경과분담금"],"Name": "HKGKM","Type": "Int",FormatFormula:"HKGKM?'#,###':' '", MinWidth : 130, RelWidth: 1},
						{"Header": ["사고현황","사고건수"],"Name": "SCNT","Type": "Int",FormatFormula:"SCNT?'#,### 건':' '", MinWidth : 110, RelWidth: 1},
						{"Header": ["사고현황","사망"],"Name": "C89G22","Type": "Int",FormatFormula:"C89G22?'#,### 명':' '", MinWidth : 110, RelWidth: 1},
						{"Header": ["사고현황","부상(대물)"],"Name": "C89G23","Type": "Int",FormatFormula:"C89G23?'#,### 명':' '", MinWidth : 110, RelWidth: 1},
						{"Header": ["사고현황","인원계"],"Name": "C89G21","Type": "Int",FormatFormula:"C89G21?'#,### 명':' '", MinWidth : 110, RelWidth: 1},
						{"Header": ["손해현황","사고발생율(%)"],"Name": "SAGO_UL","Type": "Float",Format: "###.##", MinWidth : 110, RelWidth: 1},
						{"Header": ["손해현황","결정금액"],"Name": "RPOKKM","Type": "Int",FormatFormula:"RPOKKM?'#,###':' '", MinWidth : 130, RelWidth: 1},
						{"Header": ["손해현황","전기미결추산"],"Name": "JKUM","Type": "Int",FormatFormula:"JKUM?'#,###':' '", MinWidth : 130, RelWidth: 1},
						{"Header": ["손해현황","차기미결추산"],"Name": "CKUM","Type": "Int",FormatFormula:"CKUM?'#,###':' '", MinWidth : 130, RelWidth: 1},
						{"Header": ["손해현황","손해금액"],"Name": "SONKUM","Type": "Int",FormatFormula:"SONKUM?'#,###':' '", MinWidth : 130, RelWidth: 1},
						{"Header": ["손해현황","손해율(%)"],"Name": "SON_UL","Type": "Float",Format: "###.##", MinWidth : 110, RelWidth: 1}
					  ]
			},
			//시트 이벤트
			'event':{

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
				var createDate = IBSheet.dateToString(new Date('f_date'),"yyyy-MM-dd");
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
			'data' : [
			]}
								
		function doAction(str){			
			switch(str){
				case "search":
				    var tym = $('#TYM').val();
					$('#FYM').val(tym);
					//데이터 조회
					sheet.doSearch({url: "<c:url value='/mss/tot/tot02List.do'/>", param: $("#listFrm").serialize()});
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