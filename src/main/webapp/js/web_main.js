////////////////////////////////////////////////////////////////
// 페이지 초기화 이벤트  
// (카멜로 변경) 2024.08.10 제니소프트
////////////////////////////////////////////////////////////////

//세션 처리를 위한 카운트
var s_tid;
var s_cnt = parseInt(600);//초기값(초단위)
function counter_init() {
	s_tid = setInterval("counter_run()", 1000);
}

function counter_reset() {
	
	if(!confirm("로그인 시간을 연장 하시겠습니까?")){
		return;
	}
	
	clearInterval(s_tid);
	s_cnt = parseInt(600);
	counter_init();
}

function counter_run() {
	$("#s_counter").html(time_format(s_cnt));
	s_cnt--;
	if(s_cnt < 0) {
		clearInterval(s_tid);
		self.location = "/j_spring_security_logout";
	}
}
function time_format(s) {
	var nHour=0;
	var nMin=0;
	var nSec=0;
	if(s>0) {
		nMin = parseInt(s/60);
		nSec = s%60;

		if(nMin>60) {
			nHour = parseInt(nMin/60);
			nMin = nMin%60;
		}
	} 
	if(nSec<10) nSec = "0"+nSec;
	if(nMin<10) nMin = "0"+nMin;

	return ""+nMin+":"+nSec+"&nbsp;&nbsp;[연장]";
}

// 메뉴, GNB(사용자 이동경로 네비게이션) 관련
$(document).ready(function(){
	$("#loginBtn").click(function(){
		

			

	});
	
});


////////////////////////////////////////////////////////////////
// 메뉴 생성
////////////////////////////////////////////////////////////////

//메뉴 조회
var g_topMenuList;
var menu_chk1 = 0;


function loadMenu(homepage){
 
	$.ajax ({
	    
	    type: "POST",
	    url: "/web/user/homepageMenuList.do",
	    dataType: 'json',
	    data: {
	    	homepage : homepage
	    },
	    async:false,
	    success:function(data){
	    	/*
		   	 - 조합원 : 계약조회, 보상처리조회, 자부담금 납입확인서발급
		   	 - 병원/정비공장 : 병원/정비공장용 공제금 지급내역 조회
		   	 - 직원은 전체 가능
		   	*/
		   	//01:조합원, 02:병원/정비공장
		   	if(s_account_type == "COMPANY" && s_user_gb == "01"){
		   		menu_chk1 = 1;
		   	}else if(s_account_type == "COMPANY" && s_user_gb == "02"){
		   		menu_chk1 = 2;
		   	}else if(s_account_type == "COMPANY" && jsNvl(s_user_gb) == ""){
		   		menu_chk1 = 1;
		   	}
		   	
	    	g_topMenuList = data.topMenuList;
	    	createTopMenu(g_topMenuList, menu_chk1);
	    	createMobileMenu(data.topMenuList, menu_chk1);
	    	createSitemapBox(data.topMenuList, menu_chk1);
	    	
	    }, 
		error : function(){
		    //Error시, 처리
		    alert("error");
		}
	
	});	
}

// 네비게이션 서브 메뉴 조회
function loadNaviMenu(submenuId){
    $.ajax
    ({
       type: "POST",
       url: "/web/user/naviSubmenuList.do",
       dataType: 'json',
       data: {
    	   submenuId : submenuId
       },
       success:function(data){
	    	/*
		   	 - 조합원 : 계약조회, 보상처리조회, 자부담금 납입확인서발급
		   	 - 병원/정비공장 : 병원/정비공장용 공제금 지급내역 조회
		   	 - 직원은 전체 가능
		   	*/
		   	//01:조합원, 02:병원/정비공장
		   	if(s_account_type == "COMPANY" && s_user_gb == "01"){
		   		menu_chk1 = 1;
		   	}else if(s_account_type == "COMPANY" && s_user_gb == "02"){
		   		menu_chk1 = 2;
		   	}
		   
    	   createNaviSubmenu(data.naviSubmenuList, menu_chk1, submenuId);
       }, error:function() {
		   alert("error");
	   }
    });
}

//Top 메뉴 생성
function createTopMenu(list, menu_chk1){

	var str = "", url = "",upMenuId = "", subCnt = 0, sizepos = "";
	var menu1,menu2,menu3,menu4;
	var sizepos = function(menu){
		return jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
	};
	
	var tag = 1;
	for(var i = 0; i < list.length;i++){
	    
		menu1 = list[i];
		
		if(menu1.menuLevel == 1){
			//GNB메뉴 사용여부
			if(menu1.gnbUseYn != 'Y') continue;
			
			str += '<li class="topmenu_'+tag+'" onmouseover="topmenuOpen('+tag+')" onmouseout="topmenuClose('+tag+')">';
			str += '  <a href="javascript:;" title="'+menu1.menuNm+'" id="atag'+tag+'" name="aTag">'+menu1.menuNm+'</a>';
			
			//2depth 메뉴 , class="on"
			if(menu1.subCnt > 0){	str += '<ul class="smenu'+tag+'">';	}
			
			for(var i2 = 0; i2 < list.length;i2++){
				menu2 = list[i2];
				
				if(menu1.menuId == menu2.upMenuId && menu2.menuLevel == 2){
				
					if(menu_chk1 == 2 && menu2.menuId == '82e629a871b240fd8750e4567f0f5340'){
						continue;
					}
					
					//직원만 가능(SMS보내기)
					if(s_account_type != "EMPLOYEE" && menu2.menuId == '125d372f1c454842bc6dcfff988c72d5'){
						continue;
					}

					str += "<li>";
					str += getMenuLink(menu2, '2', menu_chk1);
					
					/*
					if(menu2.subCnt > 0){	str += '<ul>';	}
					for(var i3 = 0; i3 < list.length;i3++){
						menu3 = list[i3];
						if(menu2.menuId == menu3.upMenuId && menu3.menuLevel == 3){
							str += "<li>";
							str += getMenuLink(menu3, '3');
							
							//4depth 메뉴 , class="on"
							if(menu3.subCnt > 0){	str += '<ul>';	}
							for(var i4 = 0; i4 < list.length;i4++){
								menu4 = list[i4];
								if(menu3.menuId == menu4.upMenuId && menu4.menuLevel == 4){
									str += "<li>";
									str += getMenuLink(menu4, '4');
									str += "</li>";
								}
							}
							if(menu3.subCnt > 0){	str += '</ul>';	}
							
							
							str += "</li>";
						}
					}
					//3depth 메뉴 , class="on"
					if(menu2.subCnt > 0){	str += '</ul>';	}
					*/
					
					str += "</li>";
					
				}
			}
			
			if(menu1.subCnt > 0){	str += '</ul>';	}
			
			str += '</li>';
			tag++;
	    }
	}	
	
	$("#TopMenu").html(str);
}


// 메뉴 닫기
function closeMenu(){
	
	$('.gnb nav div').hide();
	$('.gnb nav a').removeClass('on');
	$('html').css('overflow-x','auto');
}


// 모바일 메뉴 생성		
function createMobileMenu(list, menu_chk1){

	var str = "", url = "",upMenuId = "", subCnt = 0, sizepos = "";
	var menu1,menu2,menu3,menu4;
	var sizepos = function(menu){
		return jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
	};
	
	var tag = 1;
	for(var i = 0; i < list.length;i++){
	    
		menu1 = list[i];
		
		if(menu1.menuLevel == 1){
			
			//GNB메뉴 사용여부
			if(menu1.gnbUseYn != 'Y') continue;
			
			str += '<li>';
			str += '  <a href="javascript:;" title="'+menu1.menuNm+'">'+menu1.menuNm+'</a>';
			
			//2depth 메뉴 , class="on"
			if(menu1.subCnt > 0){	str += '<ul class="smenu">';	}
			
			for(var i2 = 0; i2 < list.length;i2++){
				menu2 = list[i2];
				if(menu1.menuId == menu2.upMenuId && menu2.menuLevel == 2){
					
	            	//직원, 조합원만 가능
					if(menu_chk1 == 2 && menu2.menuId == '82e629a871b240fd8750e4567f0f5340'){
						continue;
					}
					
					//직원만 가능(SMS보내기)
					if(s_account_type != "EMPLOYEE" && menu2.menuId == '125d372f1c454842bc6dcfff988c72d5'){
						continue;
					}

					str += "<li>";
					
					if(menu2.subCnt > 0){
						str += '  <a href="javascript:;" title="'+menu2.menuNm+'">'+menu2.menuNm+'</a>';
					}else{
						str += getMenuLink(menu2, '2', menu_chk1);
					}
					
					if(menu2.subCnt > 0){	str += '<ul class="ssmenu">';	}
					for(var i3 = 0; i3 < list.length;i3++){
						menu3 = list[i3];

						//직원, 조합원만 가능
						if(menu_chk1 == 2 && 
								(  menu3.menuId == '86166834b456448e951e123a55fc2e10' 
								//|| menu3.menuId == 'abc567786ddd46529d69d23f79200ba8' 
								|| menu3.menuId == '94344901d7604f1daf9a9e80148be668'
								)
						){
							continue;
						}
						
						//병원/정비공장만 가능
						if(menu_chk1 == 1 && (menu3.menuId == 'f9c9b05aea434d73bbdd9c34a0daaa6d')
						){
							continue;
						}
						
						//직원만 가능(진료비지불보증 조회)
						if(s_account_type != "EMPLOYEE" && menu3.menuId == 'abc567786ddd46529d69d23f79200ba8'){
							continue;
						}
						
						if(menu2.menuId == menu3.upMenuId && menu3.menuLevel == 3){
							str += "<li>";
							str += getMenuLink(menu3, '3', menu_chk1);
							
							//4depth 메뉴 , class="on"
							if(menu3.subCnt > 0){	str += '<ul class="sssmenu">';	}
							for(var i4 = 0; i4 < list.length;i4++){
								menu4 = list[i4];
								if(menu3.menuId == menu4.upMenuId && menu4.menuLevel == 4){
									str += "<li>";
									str += getMenuLink(menu4, '4', menu_chk1);
									str += "</li>";
								}
							}
							if(menu3.subCnt > 0){	str += '</ul>';	}
							
							
							str += "</li>";
						}
					}
					//3depth 메뉴 , class="on"
					if(menu2.subCnt > 0){	str += '</ul>';	}
					
					str += "</li>";
					
				}
			}
			
			if(menu1.subCnt > 0){	str += '</ul>';	}
			
			str += '</li>';
			tag++;
	    }
	}	
	
	$("#MobileTopMenu").html(str);
	
	$(".mobile_gnb").accordion({
		accordion:true
	});
	
}

//모바일 메뉴 생성		
function createSitemapBox(list, menu_chk1){

	if($("#sitemap_box").length > 0){
	}else{	return;	 }
	
	var str = "", url = "",upMenuId = "", subCnt = 0, sizepos = "";
	var menu1,menu2,menu3,menu4;
	var sizepos = function(menu){
		return jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
	};
	
	var tag = 1;
	for(var i = 0; i < list.length;i++){
	    
		menu1 = list[i];
		
		if(menu1.menuLevel == 1){
			str += '<li>';
			str += '  <h3>'+menu1.menuNm+'</h3>';
			
			
			//2depth 메뉴 , class="on"
			if(menu1.subCnt > 0){	str += '<ul class="smenu">';	}
			
			for(var i2 = 0; i2 < list.length;i2++){
				menu2 = list[i2];

            	//직원, 조합원만 가능
				if(menu_chk1 == 2 && menu2.menuId == '82e629a871b240fd8750e4567f0f5340'){
					continue;
				}
				
				if(menu1.menuId == menu2.upMenuId && menu2.menuLevel == 2){
					
					str += "<li>";
					str += getMenuLink(menu2, '2');
					
					if(menu2.subCnt > 0){	str += '<ul class="ssmenu">';	}
					for(var i3 = 0; i3 < list.length;i3++){
						menu3 = list[i3];

						//직원, 조합원만 가능
						if(menu_chk1 == 2 && 
								(  menu3.menuId == '86166834b456448e951e123a55fc2e10' 
								//|| menu3.menuId == 'abc567786ddd46529d69d23f79200ba8' 
								|| menu3.menuId == '94344901d7604f1daf9a9e80148be668'
								)
						){
							continue;
						}
						
						//병원/정비공장만 가능
						if(menu_chk1 == 1 && (menu3.menuId == 'f9c9b05aea434d73bbdd9c34a0daaa6d')
						){
							continue;
						}
						
						//직원만 가능(진료비지불보증 조회)
						if(s_account_type != "EMPLOYEE" && menu3.menuId == 'abc567786ddd46529d69d23f79200ba8'){
							continue;
						}
						
						if(menu2.menuId == menu3.upMenuId && menu3.menuLevel == 3){
							str += "<li>";
							str += getMenuLink(menu3, '3');
							
							//4depth 메뉴 , class="on"
							if(menu3.subCnt > 0){	str += '<ul class="sssmenu">';	}
							for(var i4 = 0; i4 < list.length;i4++){
								menu4 = list[i4];
								if(menu3.menuId == menu4.upMenuId && menu4.menuLevel == 4){
									str += "<li>";
									str += getMenuLink(menu4, '4');
									str += "</li>";
								}
							}
							if(menu3.subCnt > 0){	str += '</ul>';	}
							
							
							str += "</li>";
						}
					}
					//3depth 메뉴 , class="on"
					if(menu2.subCnt > 0){	str += '</ul>';	}
					
					str += "</li>";
					
				}
			}
			
			if(menu1.subCnt > 0){	str += '</ul>';	}
			
			str += '</li>';
			tag++;
	    }
	}
	
	$("#sitemap_box").html(str);
}


function getMenuLink(menu, depth, menu_chk1){
	var url 	= "";
	var str     = "";
	var sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
	
	if(menu.menuType == "F"){
		
		if(depth == '2' && jsNvl(menu_chk1) == 2 && menu.menuId == 'd53b14032d404d13a788382e987fe33f'){
			menu.ref_menu_url = '/web/accident/hospitalListPage.do';
			menu.ref_menu 	  = 'f9c9b05aea434d73bbdd9c34a0daaa6d';
		}
		
	    str += '      <a href="javascript:goSubMenu(\''+menu.ref_menu_url+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">'+menu.menuNm+'</a>';
	}
		
	else if(menu.menuType == "B"){
	    url += "/web/board/boardContentsListPage.do?board_id="+menu.board;
	    str += '      <a href="javascript:goSubMenu(\''+url+'\',\''+menu.menuId+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">'+menu.menuNm+'</a>';
	}
		
	else if(menu.menuType == "C"){
	    url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
	    str += '      <a href="javascript:goSubMenu(\''+url+'\',\''+menu.menuId+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">'+menu.menuNm+'</a>';
	}
		
	else{
	    url += menu.url;
	    str += '      <a href="javascript:goSubMenu(\''+url+'\',\''+menu.menuId+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">'+menu.menuNm+'</a>';
	}
	
	return str;
}

// 해당메뉴에 최하위 링크정보 가져오기
function goAuthFMenuInfo(lvl, menuId){
	
	var t_menu = null;
	var str = "", url = "",upMenuId = "", subCnt = 0, sizepos = "";
	var menu1, menu2, menu3, menu4;
	var list = g_topMenuList;
	if(lvl == '1'){
		
		for(var i = 0; i < list.length;i++){
			
			if(t_menu != null){ break; }
			
			menu1 = list[i];
			
			//1 level 체크
			if(menu1.menuId == menuId){
				
				if(menu1.subCnt > 0){
					
					for(var i2 = 0; i2 < list.length;i2++){
						
						if(t_menu != null){ break; }
						
						menu2 = list[i2];
						
						//2 level 체크
						if(menu1.menuId == menu2.upMenuId && menu2.menuLevel == 2){
							
							if(menu2.subCnt > 0){
								
								for(var i3 = 0; i3 < list.length;i3++){
									
									if(t_menu != null){ break; }
									
									menu3 = list[i3];
									
									//3 level 체크
									if(menu2.menuId == menu3.upMenuId && menu3.menuLevel == 3){
									
										if(menu3.subCnt > 0){
										
											for(var i4 = 0; i4 < list.length;i4++){
												
												if(t_menu != null){ break; }
												
												menu4 = list[i4];
												if(menu3.menuId == menu4.upMenuId && menu4.menuLevel == 4){
													t_menu = menu4;
													break;
												}
											}
											
										}else{
											t_menu = menu3;
											break;
										}
									
									}
									
								}
								
							}else{
								t_menu = menu2;
								break;
							}
							
						}
						
					}
					
				}else{
					t_menu = menu1;
					break;
				}
				
			}
			
		}
		
	}else if(lvl == '2'){
		
		for(var i2 = 0; i2 < list.length;i2++){
			
			if(t_menu != null){ break; }
			
			menu2 = list[i2];
			
			//2 level 체크
			if(menu2.menuId == menuId && menu2.menuLevel == 2){
				
				if(menu2.subCnt > 0){
					
					for(var i3 = 0; i3 < list.length;i3++){
						
						if(t_menu != null){ break; }
						
						menu3 = list[i3];
						
						//3 level 체크
						if(menu2.menuId == menu3.upMenuId && menu3.menuLevel == 3){
							
							if(menu3.subCnt > 0){
							
								for(var i4 = 0; i4 < list.length;i4++){
									
									if(t_menu != null){ break; }
									
									menu4 = list[i4];
									if(menu3.menuId == menu4.upMenuId && menu4.menuLevel == 4){
										t_menu = menu4;
										break;
									}
								}
								
							}else{
								t_menu = menu3;
								break;
							}
						
						}
						
					}
					
				}else{
					t_menu = menu2;
					break;
				}
				
			}
			
		}
		
	}

	return t_menu;
	
}

function goAuthMenuLink(lvl, upper_menuId){
	
	var menu = goAuthFMenuInfo(lvl, upper_menuId);
	
	if(menu == null){ 
		alert("접속가능한 메뉴가 없습니다."); 
	}
	
	var sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
	var url     = "";
	
	// Folder
	if(menu.menuType == "F"){
	    url = menu.ref_menu_url;
	    goSubMenu(url,menu.ref_menu,menu.target_set,sizepos);
	}

	// Board
	else if(menu.menuType == "B"){
	    url = "/web/board/boardContentsListPage.do?board_id="+menu.board;
	    goSubMenu(url,menu.menuId,menu.target_set,sizepos);
	}

	// Contents
	else if(menu.menuType == "C"){
	    url = "/web/intropage/intropageShow.do?page_id="+menu.contents;
	    goSubMenu(url,menu.menuId,menu.target_set,sizepos);
	}

	// Function or Link
	else{
	    url = menu.url;
	    goSubMenu(url,menu.menuId,menu.target_set,sizepos);
	}
	
}

// Top 메뉴로 이동
function goTopMenu(obj, url, topMenu, topMenuNm, subMenu, targetSet, sizepos){
    
	if(url == "undefined"){
	    alert("준비중입니다.");
	    return;
	}
	
	sizepos = sizepos.split("/");
	
	$.ajax ({
	    
	    type: "POST",
	    url: "/web/user/sessionMenu.do",
	    data:{
		topmenuId : topMenu,
		topmenuNm : topMenuNm,
		submenuId : subMenu
	    },
	    dataType: 'json',
	    success:function(data){
	    	goUrl(targetSet, url,  sizepos[0], sizepos[1], sizepos[2], sizepos[3]);
	    }
	});
}


//서브 메뉴로 이동
function goTopSubMenu(url, subMenu, targetSet, sizepos){

	if(url == "undefined"){
	    alert("준비중입니다.");
	    return;
	}
	
	sizepos = sizepos.split("/");
	
	$.ajax	({
	    
	    type: "POST",
	    url: "/web/user/sessionMenu.do",
	    data:{
		submenuId : subMenu
	    },
	    dataType: 'json',
	    success:function(data){					
	    	goUrl(targetSet, url, sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
	    }
	});
}

//서브 메뉴로 이동
function goSubMenu(url, subMenu, targetSet, sizepos){
 
 	//alert("goSubMenu");
 	location.href = "/userPageLink.do?menuNo="+subMenu;
 	/*
 	url = "123";
	if(url == "undefined"){
	    alert("준비중입니다.");
	    return;
	}
	
	sizepos = sizepos.split("/");
	
	alert("333");
	
	$.ajax	({
	    
	    type: "POST",
	    url: "/web/user/sessionMenu.do",
	    data:{
		submenuId : subMenu,
		menuNo : subMenu,
	    },
	    dataType: 'json',
	    success:function(data){		
			alert("success")
			console.log(data)			
	    	goUrl(targetSet, url, sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
	    },
	    error:function(){
			alert("error");
		}
	});
	*/
	
	
}

//서브 메뉴 보여주기
function showSubMenu(idx){
	$("#submenu_"+idx).show();
}


//서브 메뉴 숨기기
function hideSubMenu(idx){
	$("#submenu_"+idx).hide();
}

////////////////////////////////////////////////////////////////
// 네비게이션 서브 메뉴 생성
////////////////////////////////////////////////////////////////

// 네비게이션 서브 메뉴 생성
function createNaviSubmenu(list, menu_chk1, submenuId){

	var mstr = "";
	$("#NaviSubMenu").html("");
    
	var menu1,menu2,menu3,menu4;
	var onClass = '';
	
	for(var i=0; i < list.length;i++){
			//debugger;
			//2depth class="on"
            menu2 = list[i];
            
            if(menu2.menuLevel == 2){
                
            	//직원, 조합원만 가능
				if(menu_chk1 == 2 && menu2.menuId == '82e629a871b240fd8750e4567f0f5340'){
					continue;
				}

				//직원만 가능(SMS보내기)
				if(s_account_type != "EMPLOYEE" && menu2.menuId == '125d372f1c454842bc6dcfff988c72d5'){
					continue;
				}
				
            	onClass = '';
                if(submenuId == menu2.menuId){
                	onClass = 'class="on"';
                }
                
                mstr += '<li '+onClass+'>';
                
                if(menu2.menuType == "F"){
                	if(menu2.subCnt > 0){
                		mstr += '	<a href="javascript:;" title="'+menu2.menuNm+'">';
                	}else{
                		mstr += '	<a href="javascript:goPage(\''+menu2.ref_menu+'\',\'\',\'\');" title="'+menu2.menuNm+'">';
                	}
                }else{
                	if(menu2.subCnt > 0){
                		mstr += '	<a href="javascript:;" title="'+menu2.menuNm+'">';
                	}else{
                		mstr += '	<a href="javascript:goPage(\''+menu2.menuId+'\',\'\',\'\');" title="'+menu2.menuNm+'">';
                	}
                }
                
                mstr += '		'+menu2.menuNm+'';
                mstr += '	</a>';
                
                if(menu2.subCnt > 0){	mstr += '<ul class="lnb_smenu">';	    }
                
                //3depth class="on"
                for(var i2=0; i2 < list.length;i2++){
                	menu3 = list[i2];
                	if(menu2.menuId == menu3.upMenuId && menu3.lvl == 3){
                        
                		//직원, 조합원만 가능
        				if(menu_chk1 == 2 && 
        						(  menu3.menuId == '86166834b456448e951e123a55fc2e10' 
        						//|| menu3.menuId == 'abc567786ddd46529d69d23f79200ba8' 
        						|| menu3.menuId == '94344901d7604f1daf9a9e80148be668'
        						)
        				){
        					continue;
        				}
        				
        				//병원/정비공장만 가능
        				if(menu_chk1 == 1 && (menu3.menuId == 'f9c9b05aea434d73bbdd9c34a0daaa6d')
        				){
        					continue;
        				}
        				
						//직원만 가능(진료비지불보증 조회)
						if(s_account_type != "EMPLOYEE" && menu3.menuId == 'abc567786ddd46529d69d23f79200ba8'){
							continue;
						}
						
                        onClass = '';
                        if(web_g_upMenuId3 == menu3.menuId){
                        	onClass = 'class="on"';
                        }
                        
                		mstr += '<li '+onClass+'>';
                        
                        if(menu3.menuType == "F"){
                        	if(menu3.subCnt > 0){
                        		mstr += '	<a href="javascript:;" title="'+menu3.menuNm+'">';
                        	}else{
                        		mstr += '	<a href="javascript:goPage(\''+menu3.ref_menu+'\',\'\',\'\');" title="'+menu3.menuNm+'">';
                        	}
                        }else{
                        	if(menu3.subCnt > 0){
                        		mstr += '	<a href="javascript:;" title="'+menu3.menuNm+'">';
                        	}else{
                        		mstr += '	<a href="javascript:goPage(\''+menu3.menuId+'\',\'\',\'\');" title="'+menu3.menuNm+'">';
                        	}
                        }
                        
                        mstr += '		'+menu3.menuNm+'';
                        mstr += '	</a>';
                        
                        if(menu3.subCnt > 0){	mstr += '<ul class="lnb_ssmenu">';	    }
                        //4depth class="on"
                        for(var i3=0; i3 < list.length;i3++){
                        	menu4 = list[i3];
                        	if(menu3.menuId == menu4.upMenuId && menu4.lvl == 4){
                        		
                                onClass = '';
                                if(web_g_upMenuId4 == menu4.menuId){
                                	onClass = 'class="on"';
                                }
                                
                                mstr += '<li '+onClass+'>';
                                
                                if(menu4.menuType == "F"){
                                	mstr += '	<a href="javascript:goPage(\''+menu4.ref_menu+'\',\'\',\'\');" title="'+menu4.menuNm+'">';
                                }else{
                                	mstr += '	<a href="javascript:goPage(\''+menu4.menuId+'\',\'\',\'\');" title="'+menu4.menuNm+'">';
                                }
                                mstr += '		'+menu4.menuNm+'';
                                mstr += '	</a>';
                                mstr += '</li>';
                        	}
                        }
                        if(menu3.subCnt > 0){	mstr += '</ul>';	}
                        
                        mstr += '</li>';
                	}
                }
                
                if(menu2.subCnt > 0){	mstr += '</ul>';	}
                
                mstr += "</li>";
            }
            	

	}	
    
	$("#NaviSubMenu").html(mstr);
	
	$(".lnb_menu").accordion({
		accordion:true
	});
}

// 네비게이션 메뉴 보여주기
function showNaviSubmenu(){
    
	if($("#NaviSubMenu").css("display") == "none"){
	    $("#NaviSubMenu").show();
	} else {
	    $("#NaviSubMenu").hide();
	}
	
}

////////////////////////////////////////////////////////////////
// 탭 관련 
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// 게시판 관련 
////////////////////////////////////////////////////////////////

// 게시판 조회
function loadBoard(boardid, size, homepage){
        	
	$.ajax({
	    
	    type: "POST",
	    url: "/web/board/loadMainBoard.do",
	    data:{
			board_id : boardid,
			size 	 : size,
			homepage : homepage
	    },
	    dataType: 'json',
	    success:function(data){		
	    	makeBoard(data.list, boardid, data.notiList);
	    }
	});
}


// 게시판 화면 설정
function makeBoard(data, boardid, notiList){
	
	//alert("boardid = " + boardid);
	console.log(data);
    
	var html = "";
	if(data != null){

		// 공지사항
		/*
		if(boardid == 4) {
			if(jsNvl(notiList) != ""){
				var nCnt = 0;
				$.each(notiList,function(key,obj){
					
					if(nCnt == 0){
						html += '<li>';
						html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" class="reading" title="'+obj.title+'"><span>필독</span>'+obj.title+'</a>';
						html += '</li>';
					}
					
					nCnt++;
				});
			}
		}
		*/
		

		var cnt = 0;
    	$.each(data,function(key,obj){
    		
    		// 공지사항
    		if(boardid == 4) {
    			if(jsNvl(notiList) != "" && cnt >= 2){
    				return;
    			}
    			
    			html += '<li>';
    		    html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
    		    html += obj.title;
    		    html += '	</a>';
    		    //html += '	<span  class="time">'+obj.reg_date+'</span>';
    		    html += '</li>';
    		
    		//뉴스
    		}else if(boardid == 11) {

				html += '<li>';
				html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
				html += obj.title;
				html += '	<div class="date">'+obj.reg_date+'</div>';
				html += '</li>';
        	//주요알림
    		}else if(boardid == 12) {

				html += '<li>';
				html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
				html += obj.title;
				html += '	<div class="date">'+obj.reg_date+'</div>';
				html += '</li>';
        	//입법예고
    		}else if(boardid == 16) {
    			
				html += '<li>';
				html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
				html += obj.title;
				html += '	<div class="date">'+obj.reg_date+'</div>';
				html += '</li>';
    		}
    		
    		cnt++;
    	});
		
	} else{
	    html += '<li><a href="#"">등록된 내용이 없습니다.</a></li>';
	}
	
	
	
	$("#main_board_"+boardid).html(html);
}


//컨텐츠 상세화면 바로가기
function contentsViewMain(boardid, contentsid){
    
	var menuid = "";
	
	// 공지사항
	if(boardid == "4"){
	    menuid = "1b5a4c59380a4eafa39ebabf93574604";
	// 뉴스
	}else if(boardid == "11"){
		menuid = "19dc367064274a078ab6da6447043523";
	// 주요알림
	}else if(boardid == "12"){
		menuid = "b15fa49bb3fc4e0f9dd4738bc63b5230";
	// 입법예고
	}else if(boardid == "16"){
		menuid = "21bb4feebe624f8bb81f991222424e22";
	} 
	
	goPage(menuid, 'contents_id='+contentsid, '/web/board/boardContentsView.do');
}


// 페이지로 이동
function goPage(menuId, param, linkurl, openYn){
	
	//alert("goPage");
	//console.log("menuId = " + menuId);
	
	location.href = "/userPageLink.do?menuNo="+menuId;
	/*
	$.ajax ({
	    
	    type: "POST",
	    url: "/web/user/sessionPage.do",
	    data:{
		menuId : menuId
	    },		           
	    dataType: 'json',
	    success:function(data){
								  
			url = "";
			if(linkurl == undefined || linkurl == "") {
				 
			    // Folder
			    if(data.menu.menuType == "F"){
			    	url += data.menu.ref_menu_url;
			    } 
				
			    // 게시판
			    else if(data.menu.menuType == "B"){
			    	url += "/web/board/boardContentsListPage.do?board_id="+data.menu.board;
			    }
			
			    // 컨텐츠
			    else if(data.menu.menuType == "C"){
			    	url += "/web/intropage/intropageShow.do?page_id="+data.menu.contents;
			    }
			    
			    // Function, Link
			    else{
			    	url += data.menu.url;
			    }
						
			} else {
			    url += linkurl;
			}

			if(param != "") url += ( url.indexOf("?") > -1 ? "&" : "?" ) + param;

			goUrl(data.menu.target_set, url, data.menu.width,data.menu.height, data.menu.left, data.menu.top, openYn);
		
	    }
	});
	*/
}


// URL로 이동
function goUrl(target, url, width, height, xPos, yPos, openYn){

	if(url == "undefined" || url == "" || url == "준비중 입니다."){
	    alert("준비중입니다.");
	    return;
	}
	
	alert("goUrl");
	
	console.log("target = " + target);
	console.log("url = " + url);
	console.log("openYn = " + openYn);
	
	//새창으로 열기일 경우
	if(jsNvl(openYn) == "N"){
		target = "2";
	}

	if(target == "1"){
	    document.location.href = url;
	}else if(target == "2"){
	    window.open(url);
	}else if(target == "3"){
	    openPosPopUp(url, "Popup", width, height, xPos, yPos);
	}
	
}




////////////////////////////////////////////////////////////////
// 배너 관련 
////////////////////////////////////////////////////////////////

// 배너 조회
function loadBanner(region, homepage){
    
	$.ajax({
	    
	    type: "POST",
	    url: "/web/banner/loadMainBanner.do",
	    data:{
	    	region   : region,
	    	homepage : homepage
	    },
	    dataType: 'json',
	    success:function(data){
	    	makeBanner(region, data.bannerlist);
	    }
	});
}


//배너 화면 설정
function makeBanner(region, data){

	var html 	= "";
	var target 	=  "";
	var cnt 	= 0;
	var go 		= "";

	if(data != null){
    
	    html = "";
        
	    jQuery.each(data,function(key,obj){
        
			cnt++;
	            
			if(obj.target == 2){
			    target = "_blank";
			} else {
			    target =  "_self";
			}
	           
			//메인배너
			if(region == 1){
	            
			    //go = "javascript:goPage('"+obj.url+"', '', '')";
				go = isEmpty(obj.url , "javascript:;");
				
			    html += '<li>';
			    html += '	<a href="'+go+'" title="'+obj.titl_nm+'" target="'+target+'" >';
			    html += '		<img src="/contents/banner/'+obj.image_nm+'" alt="'+obj.titl_alt+'" title="'+obj.titl_alt+'" />';
			    html += '	</a>';
			    html += '</li>';
	           
			//바로가기
			}else if(region == 2){
		            
				    //go = "javascript:goPage('"+obj.url+"', '', '')";
					go = isEmpty(obj.url , "javascript:;");
					
				    html += '<li>';
				    html += '	<a href="'+go+'" class="d_cell" title="'+obj.titl_nm+'" target="'+target+'" >';
				    html += '		<img src="/contents/banner/'+obj.image_nm+'" alt="'+obj.titl_alt+'" title="'+obj.titl_alt+'" />';
				    html += '	</a>';
				    html += '</li>';
		           
			}
        
	    });
    
	} else {
	    html += '<li><a href="javascript:;">&nbsp;</a></li>';
	}
    
	$("#web_banner"+region).html(html);
	$("#mobile_banner"+region).html(html);
	
	//공제조합,연합회 메인배너
	if(region == 1 || region == 2){	
	
		$(".main_img > .main_slide").slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			speed: 400,
			autoplay: true,
			autoplaySpeed:4000,
			arrows: false,
			dots:true
		});
		
		$(".slick-pause").click(function(){
			if ($(".main_img").hasClass("pause") == false){
				$(".main_img > .main_slide").slick('slickPause');
				$(".main_img").addClass("pause");
			}else{
				$(".main_img > .main_slide").slick('slickPlay');
				$(".main_img").removeClass("pause");
			}
		});
	
	}
	
}

////////////////////////////////////////////////////////////////
//팝업 공지 관련 
////////////////////////////////////////////////////////////////

//팝업 공지 조회
function loadPopupNoti(homepage){

	$.ajax({
	    type: "POST",
	    url: "/web/popnoti/popnotiList.do",
	    dataType: 'json',
	    data: {
	    	homepage : homepage
	    },	    
	    success:function(data){
	    	makePopupNoti(data.list);
	    }
	});

}


//팝업 공지 생성
function makePopupNoti(data){

	var html = "";
	var cnt = 0;
	
	if(data != ""){
	    
	    $.each(data,function(key,obj){
		
		if (getCookie(obj.noti_id) != "done"){
			
			var c_height = parseInt(obj.height) - 180;
			
		    html = "";
			html += '<div class="popup main" id="layerPop_'+cnt+'" style="left: '+obj.left+'px; top: '+obj.top+'px; width: '+obj.width+'px; height: '+obj.height+'px;">';
			html += '	<div class="popup_title"><h3>'+obj.title+'</h3></div>';
			html += '	<div class="popup_inner">';
			html += '		<div class="contents" style="height: '+c_height+'px;"><input type="hidden" name="noti_id" value="'+obj.noti_id+'"/>';
			html += '			'+obj.contents;
			html += '		</div>';
			if(obj.file_id != undefined){
				html += '		<dl class="file">';
				html += '			<dt>첨부파일 :</dt>';
				html += '			<dd>';
				html += '				<a href="/commonfile/fileidDownLoad.do?file_id='+obj.file_id+'" target="_blank" title="다운받기">'+obj.file_nm+'</a>';
				html += '			</dd>';
				html += '		</dl>';
				}
			html += '	</div>';
			html += '	<div class="bottom">';
			html += '		<div class="pop_check">';
			html += '			<input type="checkbox" id="close" name="chk" value="Y" onclick="showWeekNot(\''+obj.noti_id+'\',\''+cnt+'\');"/>';
			html += '			<label for="close"><span>오늘은 이제 그만</span></label>';
			html += '		</div>';
			html += '		<button type="button" onClick="closeNoti('+cnt+')">닫기</button>';
			html += '	</div>';
			html += '</div>';
			
		    $("body").append(html);
		    
		    cnt++;
		}
    
	    });
    
	}
}


//공지 닫기
function closeNoti(num){
    $('#layerPop_'+num).hide();
}

//주간 공지 보여주기
function showWeekNot(id, num){
    setCookie(id , "done" , 7);
    closeNoti(num);
}


////////////////////////////////////////////////////////////////
//배너 관련 
////////////////////////////////////////////////////////////////

//배너 조회
function loadOrgan(){

	$.ajax({
	
		type: "POST",
		url: "/web/organ/loadMainOrganList.do",
		data:{
		},
		dataType: 'json',
		success:function(data){
			makeOrgan(data.list);
		}
	});
}


//배너 화면 설정
function makeOrgan(data){

	var html = "", html_1 = "", html_2 = "", html_3 = "", html_4 = "";
	
	if(data != null){
		
    	$.each(data,function(key,obj){	
    		
    		html = "";
			html += '<li>';
			html += '	<a href="javascript:goOrganHomepage(\''+obj.organ_gb+'\',\''+obj.organ_homepage+'\')" title="'+obj.organ_nm+'">';
			html += '		<span>'+obj.organ_nm+'</span>';
			html += '	</a>';
			html += '</li>';
			
			if(obj.organ_gb == 1) html_1 += html;
			else if(obj.organ_gb == 2) html_2 += html;
			else if(obj.organ_gb == 3) html_3 += html;
			else if(obj.organ_gb == 4) html_4 += html;
	
		});
	
	}
	
	$("#main_footer_sub_menu_1").html(html_1);
	$("#main_footer_sub_menu_2").html(html_2);
	$("#main_footer_sub_menu_3").html(html_3);
	$("#main_footer_sub_menu_4").html(html_4);

}

//해당 기관 목록 보여주기
function goOrganHomepage ( organ_gb, url ){	
	window.open(url);
    $('#footer_sub_menu_'+organ_gb).toggle();
}

// 해당 기관 목록 보여주기
function showOrganList( organ_gb ){	
    $('#footer_sub_menu_'+organ_gb).toggle();
}



// 관련기관 상세 바로가기
function goOrganList( organ_gb ){
	goPage( '12036f4b80644b32b6c6da5b0ad5e292' , 'organ_gb=' + organ_gb , '' );	
}




////////////////////////////////////////////////////////////////
// 행사일정 관련 
////////////////////////////////////////////////////////////////

// 행사일정 조회
function loadSchedule(size){

    $.ajax({
    
    type: "POST",
    	url: "/web/support/loadMainScheduleList.do",
    	data:{
    	    size : size
    	},
    	dataType: 'json',
    	success:function(data){    
    	    makeSchedule(data.list);    	    
    	}
    });
}


// 행사일정 화면 설정
function makeSchedule(data){
    
	var html = "";
	var cnt = 0;
	if(data != null){
		jQuery.each(data,function(key,obj){
			html += '<li>';
			html += '	<a href="javascript:scheduleView( \'' + obj.evt_sn + '\' , \'' + obj.evt_strt_dt.substring( 0 , 7 ) + '\' );" title="해당페이지로 이동">';
			html += '		' + obj.evt_ttle;
			html += '	</a>';
			if(obj.evt_strt_dt == obj.evt_end_dt){
				html += '	<span class="date">'+ obj.evt_strt_dt + '</span>';				
			} else {
				html += '	<span class="date">'+ obj.evt_strt_dt + ' ~ ' + obj.evt_end_dt + '</span>';
			}
			html += '</li>';
		});
	} else {
		html += '<p>등록된 내용이 없습니다.</p>';
	}
	
	$("#main_schedule").html(html);
}


// 행사일정 상세 바로가기
function scheduleView( evt_sn , evt_yymm ){
	goPage( '7643ca0399b549d9b38c96ce01324aef' , 'evt_sn=' + evt_sn + '&evt_yymm=' + evt_yymm , '' );	
}



////////////////////////////////////////////////////////////////
// FAQ 관련 
////////////////////////////////////////////////////////////////

// FAQ 조회
function loadFaq(size){
    
	$.ajax({
		type: "POST",
	   url: "/web/board/loadMainFaq.do",
	   data:{
			size : size
	   },
	   dataType: 'json',
		success:function(data){
			makeFaq(data.list);
		}
	});
}

// FAQ 화면 설정
function makeFaq(data){
    
	var html = "";
	var cnt = 0;
	if(data != null){
		jQuery.each(data,function(key,obj){
			cnt++;
			html += '<li>';
			html += '	<span class="num">'+cnt+'</span>';
			html += '	<a href="javascript:faqView(\''+obj.faq_id+'\')"" class="notice_contents_list_txt" title="해당페이지로 이동">';
			html += '		<span>'+obj.title+'</span>';
			html += '	</a>';
			html += '</li>';
		});
	} else {
		html += '<p>등록된 내용이 없습니다.</p>';
	}
	
	$("#main_faq").html(html);
}

// FAQ 상세 바로가기
function faqView(faqid){
	goPage('b935fd907c2d4be287bc23139c6cd4fc', 'faq_id='+faqid, '');
}

////////////////////////////////////////////////////////////////
// 기타
////////////////////////////////////////////////////////////////

// 현재 포커스 알아오기
function menuBlur(){
	$(".sub_menu").css("display","none");
	$(".nav_bg").css("display","none");
}

// 웹툰 이동
function fn_webtoon_go(val){
	var windowHeight=document.all?document.body.clientHeight:window.sub_menuHeight;
	var height = windowHeight - 90;
	window.open("/info/webtoon_view.php?no=" +val, "webtoon_01", "width=720,height="+height+",scrollbars=1,top=90");
}

// layerPopup
function layerPopup(id){
	
	if($("#" + id).attr("class").indexOf("hide") >= 0){
		if(id == 'mnav'){
			$("#" + id).attr("class","mnav_area show");
		}else{
			$("#" + id).attr("class","show");
		}
		$("#" + id).show();
		
	}else{
		if(id == 'mnav'){
			$("#" + id).attr("class","mnav_area hide");
		}else{
			$("#" + id).attr("class","hide");
		}
		$("#" + id).hide();
	}
}

//메일보내기 팝업
function mailSendPop(){
	
	var param = "";
	openWinC("/popup/web/member/mailSendPop.do", 'mailSendPop', param, 1024, 650,"scrollbars=yes,resizable=no");
	
}