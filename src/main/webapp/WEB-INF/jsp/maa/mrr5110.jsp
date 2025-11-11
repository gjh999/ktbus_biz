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
	              <h1 class="tit_5">분할납입 대상차량조회 
					<button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button>
					<button class='btn btn_excel' onclick="printDown(this)" type="button" style="float:right;">출력</a></button></h1>
				  </h1>
	              <!-- 검색조건 -->
				  <form id ="listFrm" name="listFrm" method="post">
				  <div class="condition2">
					  <div class="srch_wrap">
					    <input type="hidden" name="JIBUNM" id="JIBUNM" maxlength="10" style="width:70px;" class="f_date" value="${searchData.groupNm}" readonly />
					    <input type="hidden" name="JIBU" id="JIBU" maxlength="10" style="width:70px;" class="f_date" value="${searchData.groupId}" readonly />
					    <input type="hidden" name="SAUP" id="SAUP" maxlength="15" class="f_date" style="width:200px;" value="${searchData.bizNo}" readonly />
					    <input type="hidden" name="FYMD" id="FYMD" class="f_date" maxlength="8" style="width:150px;"
					           oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"
					           onkeydown="maxLengthCheck(this)" />
					    <input type="hidden" name="isAdminYn" id="isAdminYn" />
					
					    <div class="group">
					      <span class="lb ml20">조합명</span>
					      <input type="text" name="JOHAP" id="JOHAP" maxlength="15" class="f_text"
					             style="width:150px;outline:none;" value="${searchData.companyName}" readonly />
					    </div>
					
					    <div class="group">
					      <span class="lb ml20">조합원코드</span>
					      <input type="text" name="JOCODE" id="JOCODE" maxlength="6" class="f_text"
					             style="width:85px;outline:none;" value="${searchData.johapcode}" readonly />
					    </div>
					
					    <div class="group">
					      <span class="lb ml20">기준일자</span>
					      <input type="text" name="TYMD" id="TYMD" class="f_date" maxlength="8" style="width:150px;"
					             oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"
					             onkeydown="maxLengthCheck(this)" />
					    </div>
					  </div>
					
					  <div class="srch_btn">
					    <button class="item btn btn_blue_46 w_100" onclick="doAction('search')" type="button">조회</button>
					    <p class="srch_txt">※ 기준일로부터 60일 전까지만 조회가 가능합니다.</p>
					  </div>
					  <div>
					   <span class="lb ml20">조회구분&nbsp;&nbsp;&nbsp;: </span>
					  	<input type='radio' name='GUBN' id='GUBN' class='f_button' value="0" /><span class="lb ml10">전체(해지포함)</span>
						<input type='radio' name='GUBN' id='GUBN' class='f_button' value="1" /><span class="lb ml10">수납</span>
						<input type='radio' name='GUBN' id='GUBN' class='f_button' value="2" checked/><span class="lb ml10">미납</span>
						
						
						<input type='hidden' name='isAdminYn' id='isAdminYn'>
					  </div>
					</div>
	              <!-- 검색조건 -->
	              <div style='height:calc(100% - 177px)'>
	                <div id='sheetDiv' style='width:100%;height:550px'></div>
	              </div>
				  

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
				fileName:'분할납입 대상차량조회'+'('+jname+')'+'.xlsx'
			})
		}
		function printDown(obj){
			var fymd = $('#FYMD').val();
			var tymd = $('#TYMD').val();
			var gubn = $('input[name="GUBN"]:checked').val(); // 현재 선택된 라디오 버튼 값
			var jocode = $('#JOCODE').val();
			
			// 새로운 URL 형식으로 변경
			var printUrl = "https://biz.ktbus.com/MYSUIT/UView5/index.jsp?projectName=newmaa&formName=mrr5110&" + 
			               "FYMD=" + fymd + "&" + 
			               "TYMD=" + tymd + "&" + 
			               "JOCODE=" + jocode + "&" + 
			               "GUBN=" + gubn;
			
			window.open(printUrl, '_blank', 'width=800,height=600,scrollbars=yes,resizable=yes');
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
			    var MM = (now.getMonth()+1).toString().padStart(2, '0');
			    var DD = now.getDate().toString().padStart(2, '0');
			    
			    // 기준일자(종료일)를 오늘로 설정
			    var TYMD = YY + "" + MM + "" + DD;
			    
			    // 시작일자를 60일 전으로 설정 (간단하게)
			    var pastDate = new Date();
			    pastDate.setDate(pastDate.getDate() - 60);
			    var FYY = pastDate.getFullYear();
			    var FMM = (pastDate.getMonth()+1).toString().padStart(2, '0');
			    var FDD = pastDate.getDate().toString().padStart(2, '0');
			    var FYMD = FYY + "" + FMM + "" + FDD;
			    
			    $("#FYMD").val(FYMD);
			    $("#TYMD").val(TYMD);
			    
				$("#TYMD").on('input change', function() {
				       var tymdValue = $(this).val();
				       
				       // 8자리 숫자인지 확인 (YYYYMMDD 형식)
				       if (tymdValue.length === 8 && /^\d{8}$/.test(tymdValue)) {
				           try {
				               // TYMD를 Date 객체로 변환
				               var year = parseInt(tymdValue.substring(0, 4));
				               var month = parseInt(tymdValue.substring(4, 6)) - 1; // month는 0부터 시작
				               var day = parseInt(tymdValue.substring(6, 8));
				               
				               var tymdDate = new Date(year, month, day);
				               
				               // 유효한 날짜인지 확인
				               if (tymdDate.getFullYear() === year && 
				                   tymdDate.getMonth() === month && 
				                   tymdDate.getDate() === day) {
				                   
				                   // 60일 전 날짜 계산
				                   var fymdDate = new Date(tymdDate);
				                   fymdDate.setDate(fymdDate.getDate() - 60);
				                   
				                   // FYMD 형식으로 변환 (YYYYMMDD)
				                   var fymdFormatted = fymdDate.getFullYear() + 
				                                     (fymdDate.getMonth() + 1).toString().padStart(2, '0') + 
				                                     fymdDate.getDate().toString().padStart(2, '0');
				                   
				                   $("#FYMD").val(fymdFormatted);
				                   
				                   console.log('TYMD: ' + tymdValue + ' -> FYMD: ' + fymdFormatted);
				               }
				           } catch (e) {
				               console.log('날짜 변환 오류: ' + e.message);
				           }
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
						CalcOrder:"ILSUFormat,BUNKUMFormat,HKGKMFormat,SCNTFormat,C89G22Format,C89G23Format,C89G21Format,RPOKKMFormat,JKUMFormat,CKUMFormat,SONKUMFormat,SAGO_ULFormat"
					}
				},
			    //틀고정 좌측 컬럼 설정
			    "LeftCols": [
			   
			    ],
			    //중앙(메인) 컬럼 설정
				"Cols": [
						{"Header": "NO","Name": "SEQ","Type": "Int","Width": 60,"FormulaRow": {"Value": "합계"}},
						{"Header": "계약번호", "Name": "MBBUNH","Type": "Text",Align: "center","Format":"", MinWidth : 160,RelWidth: 1,"FormulaRow": {"Value": "건수"}},
					  	{"Header": "차량번호","Name": "MKCHNO","Type": "Text", Align: "center","Format":"",MinWidth : 180,RelWidth: 1,"FormulaRow": {"Value": "Count"}},
						{"Header": "회차","Name": "MBBCNT","Type": "Int",Align: "center",MinWidth : 70,RelWidth: 1},
						{"Header": "금액","Name": "BUNKUM","Type": "Int", FormatFormula:"BUNKUM?'#,### 원':' '", MinWidth : 110,RelWidth: 1,"FormulaRow": "Sum"},
					    {"Header": "납입일자","Name": "MBBNYMD","Type": "Date", MinWidth : 110,RelWidth: 1},
						{"Header": "최종납부일","Name": "LASTYMD","Type": "Date",Align: "center" ,MinWidth : 70,RelWidth: 1},
						{"Header": "실효예정일","Name": "ENDYMD","Type": "Date", MinWidth : 70,RelWidth: 1},
						{"Header": "계약상태","Name": "BIGO","Type": "Text",Align: "center", MinWidth : 70,RelWidth: 1}
					   /* {"Header": "경과일수","Name": "ILSU","Type": "Int",Align: "center" ,FormatFormula:"ILSU?'#### 일':' '", MinWidth : 130,RelWidth: 1},*/
						
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
					sheet.doSearch({url: "<c:url value='/mss/maa/mrr5110List.do'/>", param: $("#listFrm").serialize()});
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