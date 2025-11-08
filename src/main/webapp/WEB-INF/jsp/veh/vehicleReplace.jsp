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
<style>
	
	.form-table {
	    width: 100%;
	    border-collapse: separate;
	    border-spacing: 0;
	    border: 2px solid #333;
	    margin: 20px 0;
	    border-radius: 15px;
	    overflow: hidden;
	}

	.form-table th, .form-table td {
	    border-right: 2px solid #333;
	    border-bottom: 2px solid #333;
	    padding: 0;
	    text-align: center;
	    vertical-align: middle;
	    height: 50px;
	}

	/* 맨 오른쪽 열의 오른쪽 테두리 제거 */
	.form-table th:last-child, 
	.form-table td:last-child {
	    border-right: none;
	}

	/* 맨 아래 행의 아래쪽 테두리 제거 */
	.form-table tr:last-child th,
	.form-table tr:last-child td {
	    border-bottom: none;
	}

	.form-table th {
	    background-color: #275cab;
	    font-weight: bold;
	    font-size: 17px;
	    color: #ffffff;
	}

	.form-table input[type="text"] {
	    width: 100%;
	    height: 100%;
	    padding: 0;
	    border: none;
	    text-align: center;
	    background: transparent;
	    outline: none;
	    box-sizing: border-box;
	    font-weight: bold;
	    font-size: 17px;
	}

	.readonly-field {
	    background-color: #f9f9f9 !important;
	}

	.button-container {
	    display: flex;
	    justify-content: flex-end;
	    margin-top: 10px;
	}
	
	/* 조회 버튼 스타일 - 테이블과 일치하도록 */
	.btn_table_style {
	    background-color: #275cab !important;
	    color: #ffffff !important;
	    border: 2px solid #333 !important;
	    border-radius: 15px !important;
	    font-weight: bold !important;
	    font-size: 20px !important;
	    height: 50px !important;
	    padding: 0 20px !important;
	    cursor: pointer;
	    transition: all 0.3s ease;
		width:120px;
	}

	.btn_table_style:hover {
	    background-color: #1e4a96 !important;
	    transform: translateY(-2px);
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	}

	.btn_table_style:active {
	    transform: translateY(0);
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	}
	.file-upload-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.file-upload-input {
		    display: none;
		}
		
		.file-upload-label {
		    background-color: #6c757d !important;
		    color: #ffffff !important;
		    border: 2px solid #333 !important;
		    border-radius: 15px !important;
		    font-weight: bold !important;
		    font-size: 20px !important;
		    height: 50px !important;
		    padding: 0 20px !important;
		    cursor: pointer;
		    transition: all 0.3s ease;
		    width: 120px;
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.file-upload-label:hover {
		    background-color: #5a6268 !important;
		    transform: translateY(-2px);
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		}
		
		.file-upload-label:active {
		    transform: translateY(0);
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		}
		
		.file-list {
		    margin-top: 10px;
		    padding: 10px;
		    background-color: #f8f9fa;
		    border-radius: 10px;
		    border: 2px solid #dee2e6;
		}
		
		.file-item {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 8px 12px;
		    margin: 5px 0;
		    background-color: white;
		    border-radius: 8px;
		    border: 1px solid #dee2e6;
		}
		
		.file-name {
		    font-size: 14px;
		    color: #333;
		    flex: 1;
		}
		
		.file-size {
		    font-size: 12px;
		    color: #6c757d;
		    margin-left: 10px;
		}
		
		.file-delete {
		    background-color: #dc3545;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    padding: 4px 10px;
		    cursor: pointer;
		    font-size: 12px;
		    margin-left: 10px;
		}
		
		.file-delete:hover {
		    background-color: #c82333;
		}
		
		.no-files {
		    text-align: center;
		    color: #6c757d;
		    font-size: 14px;
		    padding: 10px;
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
	          <!--// Left menu -->
			  <br>
				<div id="contents" class="content" style="width:100%; padding-left:25px;">
	              
	              <h1 class="tit_5">대폐차 신청</h1>
	             
				  <div class="condition2">
  <!--	                <span class="lb ml20">지부</span>-->
  	                <input type='hidden' name='JIBUNM' id='JIBUNM' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupNm}" readonly />
  					<input type='hidden' name='JIBU' id='JIBU' maxlength='10' style="width:70px;" class='f_date' value="${searchData.groupId}" readonly />
  <!--	                <span class="lb ml20">사업자번호</span>-->
  	                <input type='hidden' name='SAUP' id='SAUP' maxlength='15' class='f_date' style="width:200px;" value="${searchData.bizNo}" readonly />
  	                <span class="lb ml20">조합명</span>
  	                <input type='text' name='JOHAP' id='JOHAP' maxlength='15' class='f_text' style="width:150px; outline:none;" value="${searchData.companyName}" readonly />
  					<span class="lb ml20">조합원코드</span>
  					<input type='text' name='JOCODE' id='JOCODE' maxlength='6' class='f_text' style="width:85px;outline:none;" value="${searchData.johapcode}" readonly />
  	                <span class="lb ml20">해당년월</span>
  					<input type='hidden' name='FYM' id='FYM' class='f_date' maxlength="6" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" /> 
  					<input type='text' name='TYM' id='TYM' class='f_date' maxlength="6" style="width:150px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeydown="maxLengthCheck(this)" />
  					&nbsp;&nbsp;&nbsp; 
  					<input type='hidden' name='isAdminYn' id='isAdminYn'>
  	              </div>
				  
				  
				  
				  <form id="listFrm" name="listFrm" method="post">
				  <table class="form-table">
				    <tr>
				      <th style="width: 15%;">차량번호</th>
				      <td style="width: 15%;"><input type="text" name="MKCHNO" id="MKCHNO" maxlength='7' /></td>
				      <th style="width: 15%;">업체명</th>
				      <td style="width: 25%;"><input type="text" name="JOHAP" id="JOHAP" /></td>
				      <th style="width: 15%;">대표자</th>
				      <td style="width: 15%;"><input type="text" name="CEO" id="CEO" /></td>
					  <th style="width: 15%;">생년월일</th>
	  			      <td style="width: 15%;"><input type="text" name="BIRTH" id="BIRTH" /></td>
				    </tr>
				    <tr>
				      <th>관할구청</th>
				      <td><input type="text" name="WARD" id="WARD" /></td>
				      <th>소재지</th>
				      <td colspan="6"><input type="text" name="LOCATION" id="LOCATION" /></td>
				    </tr>
				    <tr>
				      <th>사업종류</th>
				      <td colspan="8"><input type="text" name="TYPE" id="TYPE" value="전세버스운송사업" readonly class="readonly-field" /></td>
				    </tr>
				    <tr>
				      <th>변경내용</th>
				      <td colspan="7"><input type="text" name="CHANGES" id="CHANGES" value="사업용 차량 (말소, 대차, 대체 택1) 등록" readonly class="readonly-field" /></td>
				    </tr>
				
				    <tr>
				      <th style="width: 10%;">구분</th>
				      <th style="width: 15%;">차량번호</th>
				      <th style="width: 12%;">차종</th>
				      <th style="width: 12%;">차명</th>
				      <th style="width: 10%;">년식</th>
				      <th style="width: 10%;">정원</th>
				      <th style="width: 16%;">차대번호</th>
				      <th style="width: 15%;">사유</th>
				    </tr>
				    <tr>
				      <th>변경전</th>
				      <td><input type="text" name="VNUMBER1" id="VNUMBER1" /></td>
				      <td><input type="text" name="CTYPE1" id="CTYPE1" /></td>
				      <td><input type="text" name="CARNAME1" id="CARNAME1" /></td>
				      <td><input type="text" name="MYEAR1" id="MYEAR1" /></td>
				      <td><input type="text" name="CAPACITY1" id="CAPACITY1" /></td>
				      <td><input type="text" name="VINUM1" id="VINUM1" /></td>
				      <td><input type="text" name="REASON1" id="REASON1" /></td>
				    </tr>
				    <tr>
				      <th>변경후</th>
				      <td><input type="text" name="VNUMBER2" id="VNUMBER2" /></td>
				      <td><input type="text" name="CTYPE2" id="CTYPE2" /></td>
				      <td><input type="text" name="CARNAME2" id="CARNAME2" /></td>
				      <td><input type="text" name="MYEAR2" id="MYEAR2" /></td>
				      <td><input type="text" name="CAPACITY2" id="CAPACITY2" /></td>
				      <td><input type="text" name="VINUM2" id="VINUM2" /></td>
				      <td><input type="text" name="REASON2" id="REASON2" /></td>
				    </tr>
				    <tr>
				      <th>사유</th>
				      <td colspan="7"><input type="text" name="REASON3" id="REASON3" /></td>
				    </tr>
				  </table>
				  <div class="file-list" id="fileListArea">
				  			      <div class="no-files" id="noFilesMsg">첨부된 파일이 없습니다.</div>
				  			      <div id="fileItems"></div>
				  			  </div>
				  			  
				  			  <div class="button-container">
				  			      <div class="file-upload-wrapper">
				  			          <input type="file" id="fileInput" name="attachFiles" class="file-upload-input" multiple accept=".pdf,.jpg,.jpeg,.png,.gif,.doc,.docx,.xls,.xlsx,.hwp">
				  			          <label for="fileInput" class="file-upload-label">파일첨부</label>
				  			      </div>
				  			      <button class='btn_table_style' onclick="doAction('search')" type="button">신청</button>
				  			  </div>
				  </form>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
<script language="javascript1.2"  type="text/javaScript"> 

	var SAUP = '${searchData.bizNo}'.replaceAll('-',''); // 로그인한 사업자 번호 
	var jname=$("#JOHAP").val();
	var selectedFiles = [];
	
	
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
				
				// 파일 선택 
					    $("#fileInput").on("change", function(e) {
					        handleFileSelect(e);
					    });
				});
				
				// 파일 선택 처리
					function handleFileSelect(e) {
					    var files = e.target.files;
					    
					    // 새로 선택된 파일을 배열에 추가
					    for (var i = 0; i < files.length; i++) {
					        var file = files[i];
					        
					        // 파일 크기 제한 체크 (예: 10MB)
					        if (file.size > 10 * 1024 * 1024) {
					            alert(file.name + "은(는) 10MB를 초과하여 첨부할 수 없습니다.");
					            continue;
					        }
					        
					        selectedFiles.push(file);
					    }
					    
					    // 파일 목록 화면에 표시
					    displayFileList();
					    
					    // input 초기화 (같은 파일 재선택 가능하도록)
					    e.target.value = "";
					}
					
					// 파일 목록 표시 함수
					function displayFileList() {
					    var fileItemsDiv = $("#fileItems");
					    var noFilesMsg = $("#noFilesMsg");
					    
					    fileItemsDiv.empty();
					    
					    if (selectedFiles.length === 0) {
					        noFilesMsg.show();
					    } else {
					        noFilesMsg.hide();
					        
					        selectedFiles.forEach(function(file, index) {
					            var fileSize = formatFileSize(file.size);
					            var fileItem = $("<div class='file-item'></div>");
					            
					            fileItem.append("<span class='file-name'>" + file.name + "</span>");
					            fileItem.append("<span class='file-size'>" + fileSize + "</span>");
					            
					            var deleteBtn = $("<button type='button' class='file-delete'>삭제</button>");
					            deleteBtn.on("click", function() {
					                removeFile(index);
					            });
					            
					            fileItem.append(deleteBtn);
					            fileItemsDiv.append(fileItem);
					        });
					    }
					}
					
					// 파일 삭제 함수
					function removeFile(index) {
					    selectedFiles.splice(index, 1);
					    displayFileList();
					}
					
					// 파일 크기 포맷 함수
					function formatFileSize(bytes) {
					    if (bytes === 0) return '0 Bytes';
					    
					    var k = 1024;
					    var sizes = ['Bytes', 'KB', 'MB', 'GB'];
					    var i = Math.floor(Math.log(bytes) / Math.log(k));
					    
					    return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
					}
					
					// 기존 doAction 함수에 파일 첨부 로직 추가
					// 신청 버튼 클릭 시 FormData를 사용하여 파일과 함께 전송
					function doActionWithFiles() {
					    if (selectedFiles.length === 0) {
					        alert("첨부할 파일을 선택해주세요.");
					        return;
					    }
					    
					    var formData = new FormData($("#listFrm")[0]);
					    
					    // 선택된 파일들을 FormData에 추가
					    selectedFiles.forEach(function(file) {
					        formData.append("attachFiles", file);
					    });
					    
					    // AJAX 전송 예시
					    /*
					    $.ajax({
					        url: '/your/upload/url',
					        type: 'POST',
					        data: formData,
					        processData: false,
					        contentType: false,
					        success: function(response) {
					            alert("신청이 완료되었습니다.");
					            selectedFiles = [];
					            displayFileList();
					        },
					        error: function(xhr, status, error) {
					            alert("신청 중 오류가 발생했습니다.");
					        }
					    });
					    */
					}
		
</script>   
    
</body>
</html>