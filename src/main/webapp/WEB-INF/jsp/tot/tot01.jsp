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
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<!-- ibsheet css -->
<link rel="stylesheet" href="../../css/default/main.css"/>
<!--  ibsheet 필수 js -->
<script src="../../js/ibsheet/ibleaders.js?version=20250422"></script>
<script src="../../js/ibchart/ibleaders.js?version=20250422"></script>
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
	              <h1 class="tit_5">경과분담금 및 손해금액 현황 <button class='btn btn_excel' onclick="excelDown()" type="button" style="float:right;">엑셀다운로드</a></button></h1>  
	              <form id="listFrm" name="listFrm" method="post">
	                <!-- 검색조건 -->
	                <div class="condition2">
<!--	                  <span class="lb ml20">지부</span>-->
	                  		<input type='hidden' name='JIBUNM' id='JIBUNM' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupNm}" readonly />
	                  		<input type='hidden' name='JIBU' id='JIBU' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupId}" readonly />
<!--	                  <span class="lb ml20">사업자번호</span>-->
	                  		<input type='hidden' name='SAUP' id='SAUP' maxlength='15' class='f_date' style="width:200px;" value="${searchData.bizNo}" readonly />
	                  <!--<input type='hidden' name='JOCODE' id='JOCODE' maxlength='15' class='f_date' style="width:200px;" value="${searchData.johapcode}" readonly />-->
	                  <span class="lb ml20">조합명 : </span>
	                 	 <input type='text' name='JOHAP' id='JOHAP' maxlength='15' class='f_text' style="width:150px; outline:none;" value="${searchData.companyName}"  readonly />
					  <span class="lb ml20">조합원코드 :</span>
<!--					 	<input type='text' name='JOCODE' id='JOCODE' maxlength='6' class='f_text' style="width:85px; outline:none;" value="${searchData.johapcode}" readonly/>-->
					 	<input type='text' name='JOCODE' id='JOCODE' maxlength='6' class='f_text' style="width:85px; outline:none;" value="${searchData.johapcode}" readonly/>
					  <span class="lb ml20" >당해년도</span>
	                  	<input type='text' name='FYY' id='FYY' class='f_date' maxlength='4' style="width:80px;" /*onmouseover="style='cursor:pointer'"*/ oninput="maxLengthCheck(this); " />년 
					  
						
						&nbsp;&nbsp;&nbsp; 
					  <button class='item btn btn_blue_46 w_100' onclick="doAction('search')" type="button">조회</a></button>
					 
					  
					   <input type='hidden' name='isAdminYn' id='isAdminYn'>
					</div>
					
					<p style="text-align:right; font-weight:bold;">(단위: 원, %)</p>
	                <!--// 검색조건 -->
	                <div style='height:calc(100% - 177px)'>
	                  <div id='sheetDiv' style='width:100%;height:420px'></div>
	                </div>
					<br>
<!--					1.합산손해율①은 순손해율②과 해당년도 사업비③를 합한 공제조합 경영실적을 판단하는 기준입니다.<br>-->
					1.합산손해율은 기준율 100% 초과시 적자, 100% 미만시 흑자를 의미합니다.<br>
					2.보상비(공제금)를 제외한 사업비는 인건비, 행정경비, 임차료, 사고예방비, 법정부담경비등이 포함되어 있습니다.<br>
					3.경과분담금 : 공제계약자로 부터 받은 분담금 중 공제기간이 경과한 분담금으로 분담금으로 공제사고비용 및 운용에 사용되는 금액<br>
					&nbsp;&nbsp;
					(예시:1년분 분담금을 납부시 6개월이 경과했을 경우 1/2의 분담금이 경과분담금임)<br>
					4.손해금액 = 공제금(보상비) - 전기이월 지급준비금 + 차기이월 지급준비금<br>
					&nbsp;&nbsp;(공제금 청구포기사고 및 자기과실이 전혀 없는 사고는 공제금 및 지급준비금에 미포함)<br>
					5.손해율 : 손해액/경과분담금 * 100
<!--					4.예시) 2023년도 합산손해율(사업비포함) : 2023년도 순손해율(190%) + 3년 평균 사업비(21.2%) = 합산손해율(211.2%) -->
<!--					<input type='text' name='BIGO' id='BIGO' size='100' style="width:1200px; outline:none; border:none; font-size:16px" step="0.01"  readonly/>-->
<!--					예시) 2023년도 합산손해율(사업비포함) : 2023년도 순손해율(190%) + 사업비(21.2%) = 합산손해율(211.2%) -->
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
	var now = new Date();
	var YY = now.getFullYear();
	var SAUP = '${searchData.bizNo}'.replaceAll('-',''); // 로그인한 사업자 번호 
	var jname=$("#JOHAP").val();
	var kum11=0,kum12=0,kum21=0,kum22=0,kum31=0,kum32=0,kum41=0,kum42=0,kumt1=0,kumt2=0;
	var son1t=0,son2t=0,son3t=0,son4t=0,son5t = 0;
	var ym="",json1 = 0, json2 = 0, json3 = 0;//년도, 사업비, 순손해율, 합산손해율
	var ts =[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]] ;
	var js =[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]] ;
	var ca =[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]] ;
	
	function excelDown(obj){
		if(sheet.getDataRows().length == 0){
						alert("다운로드할 데이터가 없습니다.");
						return;
					}
		sheet.exportData({
			merge:3,
			fileName:'경과분담금 및 손해금액 현황'+'('+jname+')'+'.xlsx'
		})
	}
	function maxLengthCheck(Object) {
		if (Object.value.length > object
			.maxLength) {
			object.value = object.value
				.slice(0, object
					.maxLength);
		}
	}
	$("#listFrm").keypress(function(e) {
		
		if (e.keyCode == '13') {
			doAction('search');
		}
		
	});
	$(document).ready(function() {
			    $("#FYY").val(YY).datepicker({
					dateFormat: 'yy',
					minViewMode: 'years',
					closeText:"CLOSE",
					minDate : "-10Y",
					
			    });
				setTimeout(function() {
				   doAction('search');
				 }, 500);	
			
			
		//사업자번호 체크 후 조합원 코드 readonly 수정
		if(SAUP == "1148205353" || SAUP == "ORGNZT_0000000000000"){
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
				/*	
				
				NoDataMessage: 3,
				NoDataMiddle: 1,*/
				SearchMode: 0
				,"SuppressMessage": 0
				,"ClickPivotFilter": 1
				,"DataMerge": 3
				,"CanEdit": 3
				,"HeaderMerge": 3
				,InfoRowConfig: {Visible:0}
				,FocusedRow: "AR1"		  // 데이터 첫번째 행에 포커스 처리
/*				,FocusedCol: "TITLE"   */   // 포커스된 행의 "seq" 열에 포커스 처리
				,"SelectionSummary": {
					 "Mode": "DelRow"
					,"Size": "50"
						},
				Export:{
					"Url":"../jsp/tot/tot01.jsp"
					
				},
					},
					Def:{
						Row:{
							CanFormula:true,
							CalcOrder:"JSON1Format,JSON2Format,SON1Format,SON2Format,TextColor,HIKKM0Format,HIKKM0TextColor,HIKKM1Format,HIKKM1TextColor,HIKKM2Format,HIKKM2TextColor,HIKKM3Format,HIKKM3TextColor,HIKKM4Format,HIKKM4TextColor,HIKKM5Format,HIKKM5TextColor,HIKKM6Format,HIKKM6TextColor,HIKKM7Format,HIKKM7TextColor,HIKKM8Format,HIKKM8TextColor,HIKKM9Format,HIKKM9TextColor,HIKKM10Format,HIKKM10TextColor,HIKKM11Format,HIKKM11TextColor,HIKKM12Format,HIKKM12TextColor,TITLETextColor,SSONFormat",
							/*	TextColorFormula:function(fr){
								if(fr.Row["TITLE"]=="손해금액"){
									return "#FF0000"
								}
								else if(fr.Row["TITLE"]=="총 손해금액"){
									return "#FF0000"
								}
							}*/
						}
					},
				/*	Cols:{
						TextColorFormula:function(fr){
							if(fr.Col["HIKKM3"]>0){
								return "#FF0000"
							}
						}
						
					},*/
			//틀고정 좌측 컬럼 설정
			"LeftCols": [
				{"Header": ["년도","년도"],"Name": "HKMYER","Type": "Text" ,"Width": 75,"Align": "center","Format":""},
	    		{"Header": ["공제조합(전체)","합산손해율\n(① + ②)"],"Name": "SON1","Type": "Float" ,FormatFormula:function(fr){if(fr.Value){return '###.## \\%'}else{return ' '}},"Color":"#87CEFA", "Width":110 ,"Align": "right"},
    			{"Header": ["공제조합(전체)","순손해율①\n(사업비제외)"],"Name": "SON2","Type": "Float" ,FormatFormula:function(fr){if(fr.Value){return '###.## \\%'}else{return ' '}},"Width": 110,"Align": "right"},
    			{"Header": [{Value:"사업비②",Color:"#FFC939",TextColor:"#000000"},{Value:"사업비②",Color:"#FFC939",TextColor:"#000000"}],"Name": "SSON","Type": "Int",FormatFormula:function(fr){if(fr.Value){return '###.## \\%'}else{return ' '}},"Width": 110,"Color":"#FFC939","Align": "right"},
				{"Header": [jname,"합산손해율\n(② + ③)"],"Name": "JSON1","Type": "Float" ,FormatFormula:function(fr){if(fr.Value){return '###.## \\%'}else{return ' '}},"Color":"#87CEFA","Width": 110,"Align": "right"},
				{"Header": [jname,"순손해율③\n(사업비제외)"],"Name": "JSON2","Type": "Float" ,FormatFormula:function(fr){if(fr.Value){return '###.## \\%'}else{return ' '}},"Width": 110,"Align": "right"},
				{"Header": ["항목","손해금액\n(사업비제외)"],"Name": "TITLE","Type": "Text","Format":"", "Width": 130,"Align": "center","TextColorFormula": TOTTextColur}
			],
			//중앙(메인) 컬럼 설정
			"Cols": [
				{"Header": ["합계","합계"],"Name": "HIKKM0","Type": "Int",Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 120, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}	
			   ,{"Header": ["1월","1월"] ,"Name": "HIKKM1" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["2월","2월"] ,"Name": "HIKKM2" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}
			   ,{"Header": ["3월","3월"] ,"Name": "HIKKM3" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}
			   ,{"Header": ["4월","4월"] ,"Name": "HIKKM4" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["5월","5월"] ,"Name": "HIKKM5" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ",  MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["6월","6월"] ,"Name": "HIKKM6" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ",  MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["7월","7월"] ,"Name": "HIKKM7" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ",  MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["8월","8월"] ,"Name": "HIKKM8" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,####</span>;  ",  MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["9월","9월"] ,"Name": "HIKKM9" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ",  MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur }
			   ,{"Header": ["10월","10월"] ,"Name": "HIKKM10" ,"Type": "Int" ,Format: "#,####;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}
			   ,{"Header": ["11월","11월"] ,"Name": "HIKKM11" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}
			   ,{"Header": ["12월","12월"] ,"Name": "HIKKM12" ,"Type": "Int" ,Format: "#,###;<span style='color:#2196F3;font-weight:normal;'>#,###</span>;  ", MinWidth : 110, RelWidth: 1, CanEmpty:1,"TextColorFormula": TOTTextColur}
			]
		},
		//시트 이벤트
		'event': {
			onSearchFinish: function(evtParam) {
				for (var i = 1; i <= 14; i++) {
					var col ="HIKKM" + i;
					evtParam.sheet.fitSize({
							col: col
							,norender: 1
						});
				}
				// 모든 값이 음수일 경우 절대값으로 변환하는 예시
				evtParam.sheet
					.rerender();
			},
			onBeforeDataLoad:function(evtParam){
				     var i=0;
				          // 조회 결과 데이터
				          var DATA = evtParam.data;
						  // 조회된 데이터 일부를 수정한다.
				          for(var i = 0; i < DATA.length; i++){
				              var row = DATA[i];
				              // AttrYn 컬럼에 값이 Y 인 경우 ConfirmFinish 컬럼에 "결정완료"를 설정하고
				              // 해당 행의 Edit를 막는다. (수정된 데이터에 대한 별도 리턴은 필요 없음[CallByReference])
							 /* alert(row["SORT1"]);*/
							 //var ym=0,json1 = 0, json2 = 0;
							 if(row["SON1"] == 0) {       // SON1 컬럼이 0일 경우 Color와 Format을 없앤다.
							     row["SON1Color"]="#FFFFFF";
							     row["SON1Format"]=" ";
							  }
							  if(row["SORT1"] == 3) {
								kum11 = row["HIKKM0"];kumt1 = kumt1+row["HIKKM0"];
						      }
							  if(row["SORT1"] == 4) {
								 kum12 = row["HIKKM0"];kumt2 = kumt2+row["HIKKM0"];
							  }
							  if(row["SORT1"] == 5) {
								kum21 = row["HIKKM0"];kumt1 = kumt1+row["HIKKM0"];
							  }
							  if(row["SORT1"] == 6) {
								 kum22 = row["HIKKM0"];kumt2 = kumt2+row["HIKKM0"];
							  }
							  if(row["SORT1"] == 7) {
								kum31 = row["HIKKM0"];kumt1 = kumt1+row["HIKKM0"];
							  }
							  if(row["SORT1"] == 8) {
								kum32 = row["HIKKM0"];kumt2 = kumt2+row["HIKKM0"];
								sont1=row["SON1"];
							  }
							  if(row["SORT1"] == 9) {
								kum41 = row["HIKKM0"];kumt1 = kumt1+row["HIKKM0"];
								json1=row["JSON1"];//사업비
								ym=row["HKMYER"];
							  }
							  if(row["SORT1"] == 10) {
								kum42 = row["HIKKM0"];kumt2 = kumt2+row["HIKKM0"];
							  }
				              if( i == 0 ) {
								// 당해년도 납입분담금
				                ts[0][0] =row["HIKKM0"];
					            ts[0][1] =row["HIKKM1"];
					            ts[0][2] =row["HIKKM2"];
					            ts[0][3] =row["HIKKM3"];
					            ts[0][4] =row["HIKKM4"];
					            ts[0][5] =row["HIKKM5"];
					            ts[0][6] =row["HIKKM6"];
					            ts[0][7] =row["HIKKM7"];
					            ts[0][8] =row["HIKKM8"];
					            ts[0][9] =row["HIKKM9"];
				                ts[0][10]=row["HIKKM10"];
					            ts[0][11]=row["HIKKM11"];
					            ts[0][12]=row["HIKKM12"];
				              } else if ( i == 1 ) {
								//당해년도 손해금액
				                js[0][0] =row["HIKKM0"];
					            js[0][1] =row["HIKKM1"];
					            js[0][2] =row["HIKKM2"];
					            js[0][3] =row["HIKKM3"];
					            js[0][4] =row["HIKKM4"];
					            js[0][5] =row["HIKKM5"];
					            js[0][6] =row["HIKKM6"];
					            js[0][7] =row["HIKKM7"];
					            js[0][8] =row["HIKKM8"];
					            js[0][9] =row["HIKKM9"];
					            js[0][10]=row["HIKKM10"];
					            js[0][11]=row["HIKKM11"];
					            js[0][12]=row["HIKKM12"];
				             } else if( i == 2 ) {
								//1년전 납입분담금
				                ts[1][0] =row["HIKKM0"];
					            ts[1][1] =row["HIKKM1"];
					            ts[1][2] =row["HIKKM2"];
					            ts[1][3] =row["HIKKM3"];
					            ts[1][4] =row["HIKKM4"];
					            ts[1][5] =row["HIKKM5"];
					            ts[1][6] =row["HIKKM6"];
					            ts[1][7] =row["HIKKM7"];
					            ts[1][8] =row["HIKKM8"];
					            ts[1][9] =row["HIKKM9"];
					            ts[1][10]=row["HIKKM10"];
					            ts[1][11]=row["HIKKM11"];
					            ts[1][12]=row["HIKKM12"];
				              } else if ( i == 3 ) {
								//1년전 손해금액
				                js[1][0] =row["HIKKM0"];
					            js[1][1] =row["HIKKM1"];
					            js[1][2] =row["HIKKM2"];
					            js[1][3] =row["HIKKM3"];
					            js[1][4] =row["HIKKM4"];
					            js[1][5] =row["HIKKM5"];
					            js[1][6] =row["HIKKM6"];
					            js[1][7] =row["HIKKM7"];
					            js[1][8] =row["HIKKM8"];
					            js[1][9] =row["HIKKM9"];
					            js[1][10]=row["HIKKM10"];
					            js[1][11]=row["HIKKM11"];
					            js[1][12]=row["HIKKM12"];
		          			  } else if ( i == 4 ) {
								//2년전 납입분담금
				                ts[2][0] =row["HIKKM0"];
					            ts[2][1] =row["HIKKM1"];
					            ts[2][2] =row["HIKKM2"];
					            ts[2][3] =row["HIKKM3"];
					            ts[2][4] =row["HIKKM4"];
					            ts[2][5] =row["HIKKM5"];
					            ts[2][6] =row["HIKKM6"];
					            ts[2][7] =row["HIKKM7"];
					            ts[2][8] =row["HIKKM8"];
					            ts[2][9] =row["HIKKM9"];
					            ts[2][10]=row["HIKKM10"];
					            ts[2][11]=row["HIKKM11"];
					            ts[2][12]=row["HIKKM12"];
							  } else if ( i == 5 ) {
								//2년전 손해금액
   				                js[2][0] =row["HIKKM0"];
   					            js[2][1] =row["HIKKM1"];
   					            js[2][2] =row["HIKKM2"];
   					            js[2][3] =row["HIKKM3"];
   					            js[2][4] =row["HIKKM4"];
   					            js[2][5] =row["HIKKM5"];
   					            js[2][6] =row["HIKKM6"];
   					            js[2][7] =row["HIKKM7"];
   					            js[2][8] =row["HIKKM8"];
   					            js[2][9] =row["HIKKM9"];
   					            js[2][10]=row["HIKKM10"];
   					            js[2][11]=row["HIKKM11"];
   					            js[2][12]=row["HIKKM12"];
							  } else if ( i == 6 ) {
								//3년전 납입분담금
   				                ts[3][0] =row["HIKKM0"];
   					            ts[3][1] =row["HIKKM1"];
   					            ts[3][2] =row["HIKKM2"];
   					            ts[3][3] =row["HIKKM3"];
   					            ts[3][4] =row["HIKKM4"];
   					            ts[3][5] =row["HIKKM5"];
   					            ts[3][6] =row["HIKKM6"];
   					            ts[3][7] =row["HIKKM7"];
   					            ts[3][8] =row["HIKKM8"];
   					            ts[3][9] =row["HIKKM9"];
   					            ts[3][10]=row["HIKKM10"];
   					            ts[3][11]=row["HIKKM11"];
   					            ts[3][12]=row["HIKKM12"];
	   				          } else if ( i == 7 ) {
								//3년전 손해금액
				                js[3][0] =row["HIKKM0"];
					            js[3][1] =row["HIKKM1"];
					            js[3][2] =row["HIKKM2"];
					            js[3][3] =row["HIKKM3"];
					            js[3][4] =row["HIKKM4"];
					            js[3][5] =row["HIKKM5"];
					            js[3][6] =row["HIKKM6"];
					            js[3][7] =row["HIKKM7"];
					            js[3][8] =row["HIKKM8"];
					            js[3][9] =row["HIKKM9"];
					            js[3][10]=row["HIKKM10"];
					            js[3][11]=row["HIKKM11"];
					            js[3][12]=row["HIKKM12"];
							  }
				       }
				      for(var j = 0; j < 13; j++){
						if(ts[3][j]==0 && ts[2][j] == 0 && ts[1][j] == 0  && ts[0][j] == 0 ){
						  ca[0][j]=0;
						} else {
					 	  if(ts[3][j]==0 && ts[2][j] == 0 && ts[1][j] == 0  && ts[0][j] == 0){
							ca[0][j]=  0;
						  }else{
							  ca[0][j]=((ts[3][j]+ts[2][j]+ts[1][j]+ts[0][j])).toFixed(2);
						  
							  if(isNaN(ca[0][j])){
							     ca[0][j] = 0;
							  }
						  }	
						}
						if(js[3][j]==0 && js[2][j] == 0 && js[1][j] == 0 && js[0][j] == 0){
						  ca[1][j]=0;
						} else {
							 if(js[3][j]==0 && js[2][j] == 0 && js[1][j] == 0 && js[0][j] == 0){
							   ca[1][j]=0;
							}else{
							    ca[1][j]=((js[3][j]+js[2][j]+js[1][j]+js[0][j])).toFixed(2);
								
								 if(isNaN(ca[1][j])){
									ca[1][j] = 0;
								 }

							}	
					      }
				    }
					son1t = (kum12/kum11)*100;
					son2t = (kum22/kum21)*100;
					son3t = (kum32/kum31)*100;
					son4t = (kum42/kum41)*100;
					son5t = (kumt2/kumt1)*100;
					
					for(var i = 0; i < DATA.length; i++){
						 var row = DATA[i];
						 //*****************************
						 //2025.05.20 이사장님 및 본부팀장 회의 결과
						 //손해금액의 경우 1월부터 12월 마이너스인 금액은 글자색 파란색으로 변경하고 (-)기호 생략
						 if(row["SORT1"] == 4 || row["SORT1"] == 6 || row["SORT1"] == 8 || row["SORT1"] == 10) {
						 	//if(row["HIKKM3"]<0)row["HIKKM3"]=row["HIKKM3"]*-1;												
						 }
						 //*****************************
						 if(row["SORT1"] == 3 ) {
							 row["JSON2"]=son1t;  
							 if(row["JSON1"]!=0){
								row["JSON1"]=son1t+row["JSON1"];
							}
						 }
						 if(row["SORT1"] == 4 ){
							row["JSON2"]=son1t; 
							if(row["JSON1"]!=0){
								row["JSON1"]=son1t+row["JSON1"];
							}
						}
						 if(row["SORT1"] == 5 && row["JSON1"]!=0) {
							  row["JSON2"]=son2t; row["JSON1"]=son2t+row["JSON1"];
						}
						 if(row["SORT1"] == 6 && row["JSON1"]!=0) {row["JSON2"]=son2t; row["JSON1"]=son2t+row["JSON1"];}
						 if(row["SORT1"] == 7 && row["JSON1"]!=0) {row["JSON2"]=son3t; row["JSON1"]=son3t+row["JSON1"];}
						 if(row["SORT1"] == 8 && row["JSON1"]!=0) {row["JSON2"]=son3t; row["JSON1"]=son3t+row["JSON1"];}
						 if(row["SORT1"] == 9 && row["JSON1"]!=0) {
							row["JSON2"]=son4t; row["JSON1"]=son4t+row["JSON1"];
							json2 = son4t;//순손해율
							json3 = row["JSON1"];//합산손해율
						}
						 if(row["SORT1"] == 10 && row["JSON1"]!=0){row["JSON2"]=son4t; row["JSON1"]=son4t+row["JSON1"];}
					}
					console.log(ca[1][3]);
				      },
					  onDataLoad:function(evtParam){
						// init 안에 Color:"red" -> 배경
						// init 안에 TextColor:"red" -> 폰트 색상
					  			sheet.addRow({"init":{"HKMYER":"소계","SON1":"소계","SON2":"소계","SSON":"소계","JSON1":"소계","JSON2":"소계","TITLE":"총 경과분담금", "HIKKM0":ca[0][0],CanFocus:0}});
					  			sheet.addRow({"init":{"HKMYER":"소계","SON1":"소계","SON2":"소계","SSON":"소계","JSON1":"소계","JSON2":"소계","TITLE":"총 손해금액", "HIKKM0":ca[1][0],CanFocus:0,TextColor:"red"}});
								sheet.setAutoMerge(5);
									if(json3>100){
										var bigo ="4.예시)"+jname+"의 "+ym+"도 합산손해율("+json3.toFixed(2)+"%) 초과입니다."; 
									} else if(json3<100){
										var bigo ="4.예시)"+jname+"의 "+ym+"도 합산손해율("+json3.toFixed(2)+"%)는 기준율(100%) 미만입니다."; 
									} else {
										var bigo ="4.예시)"+jname+"의 "+ym+"도 합산손해율("+json3.toFixed(2)+"%)는 기준율(100%)에 부합합니다."; 
									}
									$('#BIGO').val(bigo);
							},
						},
		//시트객체 생성
		'create': function() {
			var options = this
				.init;
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
		'data': [
		]
	}
	function TOTTextColur(fr){
	    if (fr.Value > 0 && fr.Row["TITLE"]=="손해금액") {
	        return '#FF0000';
	    } else if(fr.Value < 0 && fr.Row["TITLE"]=="손해금액") {
	        return '#0D35FC';
	    } else if(fr.Row["TITLE"]=="손해금액")
			return '#FF0000';
	}
	function textColorFormula(fr) {
	  const v = fr.Sheet.getValue(fr.Row, fr.Col);

	  if(v.indexOf("-")>-1) return "#0d35fc";
	  else if(parseInt(v.replace(/[^\d]/g,""))===0) return ""; 

	  return "#fc0820";
	}
	
	function doAction(str) {
		if( YY <= (Number(document.getElementById('FYY').value) + 5) ){
			switch (str) {
				case "search":
					//데이터 조회
					sheet.doSearch({
						url: "<c:url value='/mss/tot/tot01List.do'/>",
						param: $("#listFrm").serialize()
					});
					break;
				default:
					break;
			}
		} else{
			alert( YY+"년 기준 5년 이전 자료는 조회 할수 없습니다.");
		}
	}
	ib.create();
//-->
</script>   
</body>
</html>