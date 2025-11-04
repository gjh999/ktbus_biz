/* 전역 변수 */
var ua = navigator.userAgent;
var windowWidth = $(window).width();
var windowHeight = $(window).height();

$(document).ready(function(){
	$( ".topmenu .sitemap" ).click(function(){
		if($(".topmenu .sitemap").hasClass("on") === true) {
			$( this ).removeClass( "on" );
			$( ".sitemap_box" ).slideUp( 200 );
			$( ".sitemap_back" ).slideUp( 0 );
		} else {
			$( this ).addClass( "on" );
			$( ".sitemap_box" ).slideDown( 200 );
			$( ".sitemap_back" ).slideDown( 0 );
		}
	});
});
$(document).ready(function(){
	$( ".top_right .search_m" ).click(function(){
		if($(".top_right .search_m").hasClass("on") === true) {
			$( this ).removeClass( "on" );
			$( ".search_box" ).slideUp( 200 );
		} else {
			$( this ).addClass( "on" );
			$( ".search_box" ).slideDown( 200 );
		}
	});
});
/* useagent check */
function userAgentChk(){
	if(ua.match(/iPhone|iPod|LG|Android|SAMSUNG|Samsung/i) != null){
		if (windowWidth > 720){
			$("body").addClass("device").addClass("tablet");
			switch(window.orientation){ 
				case -90:
				$("body").addClass("tablet_landscape");
				$("body").addClass("pc").removeClass("tablet");
				break;
				case 90:
				$("body").addClass("tablet_landscape");
				$("body").addClass("pc").removeClass("tablet");
				break;
				case 0:
				$("body").addClass("tablet_portrait");
				$("body").removeClass("pc").removeClass("normal").addClass("tablet");
				break;
				case 180:
				$("body").addClass("tablet_portrait");
				$("body").removeClass("pc").removeClass("normal").addClass("tablet");
				break;
			 }
		}else{
			$("body").addClass("mobile").addClass("device");
			switch(window.orientation){  
				case -90:
				$("body").addClass("mobile_landscape")
				break;
				case 90:
				$("body").addClass("mobile_landscape");
				break;
				case 0:
				$("body").addClass("mobile_portrait");
				break;
				case 180:
				$("body").addClass("mobile_portrait");
				break;
			 }
		}
	}else if (ua.match(/iPad|GallaxyTab/i) != null){
		$("body").addClass("device").addClass("tablet");
		switch(window.orientation){ 
			case -90:
			$("body").addClass("tablet_landscape");
			$("body").addClass("pc").removeClass("tablet");
			break;
			case 90:
			$("body").addClass("tablet_landscape");
			$("body").addClass("pc").removeClass("tablet");
			break;
			case 0:
			$("body").addClass("tablet_portrait");
			$("body").removeClass("pc").removeClass("normal").addClass("tablet");
			break;
			case 180:
			$("body").addClass("tablet_portrait");
			$("body").removeClass("pc").removeClass("normal").addClass("tablet");
			break;
		 }
	}else{
		bodyClassChange();

		$(window).resize(function(){
			windowWidth = $(window).width();
			windowHeight = $(window).height();
			bodyClassChange();
		}).resize();

		if(ua.indexOf("MSIE 8.0") > -1 || ua.indexOf("Trident/4.0") > -1){ //IE8 이하일 경우
			$("body").addClass("pc").addClass("pc_ie8");
			if(ua.indexOf("Windows NT 6.2") > -1){
			}else if (ua.indexOf("Windows NT 6.1") > -1){			
				$("body").addClass("pc").addClass("pc_ie8").addClass("w7"); //window7, IE8
			}else if (ua.indexOf("Windows NT 5.1") > -1){
				$("body").addClass("pc").addClass("pc_ie8").addClass("xp"); //windowXP, IE8
			}
		}else if(ua.indexOf("MSIE 7.0") > -1 || ua.indexOf("MSIE 6.0") > -1){
			$("body").addClass("pc").addClass("pc_ie8");
		}else if(ua.indexOf("Trident") > -1){
			$("body").addClass("pc").addClass("ie");
		}else{ //IE9 PC 
			if (ua.indexOf("Chrome") > -1){
				$("body").addClass("pc").addClass("chrome");
			}else if(ua.indexOf("Mac") > -1){
				$("body").addClass("mac");
			}else{
				$("body").addClass("pc");
			}
		}
	}
}
userAgentChk();

function bodyClassChange(){
	if (windowWidth > 1200){
		$("body").removeClass("mobile_portrait").removeClass("mobile").removeClass("tablet").removeClass("smallbrowser").addClass("normal");
		$(".midarea").css("min-height", (windowHeight-$(".toparea").height()-$(".bottomarea").height())+"px");
		$(".btn-mobilesearch").hide();
		$(".topmenu").css("left","0");
	}else if (windowWidth <= 1200 && windowWidth > 1018){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("mobile").removeClass("tablet").addClass("smallbrowser");
		$(".midarea").css("min-height", (windowHeight-$(".toparea").height()-$(".bottomarea").height())+"px");
		$(".btn-mobilesearch").hide();
		$(".topmenu").css("left","0");
	}else if (windowWidth <= 1017 && windowWidth > 768){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("mobile").removeClass("smallbrowser").addClass("tablet");
	}else if (windowWidth <= 768){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("mobile").removeClass("smallbrowser").addClass("tablet");
	}
}

function firstLoad(){
	setTimeout(function(){
		$("#wrap").animate({opacity:1}, 100);
	}, 100);
}
firstLoad();


function topmenuOpen(Idx){
	if ($("body").hasClass("normal")){
		$(".gnb > ul > li.topmenu_"+Idx+"").removeClass("on");
		$(".gnb > ul > li.topmenu_"+Idx+" ul").stop().slideDown();
		$(".gnb").addClass("menuOpen");
	}else if ($("body").hasClass("smallbrowser")){
		$(".gnb > ul > li.topmenu_"+Idx+"").addClass("on");
		$(".gnb > ul > li.topmenu_"+Idx+" ul").stop().slideDown();
		$(".gnb").addClass("menuOpen");
	}else{
		return false;
	}
}

function topmenuClose(Idx){
	if (Idx){		
		if ($("body").hasClass("normal") || $("body").hasClass("smallbrowser")){
			$(".gnb > ul > li.topmenu_"+Idx+"").removeClass("on");
			$(".gnb > ul > li.topmenu_"+Idx+" ul").stop().slideUp();
			$(".gnb").removeClass("menuOpen");
		}else{
			return false;
		}
	}else{
		$(".toparea .bg-topmenu-on").remove();
		$(".gnb > ul > li ul").stop().slideUP();
		$(".gnb").removeClass("menuOpen");
	}
}

$(".topmenu_1 a").keyup(function(){
	$(".smenu1").show();
	$(".smenu2").hide();
	$(".smenu3").hide();
	$(".smenu4").hide();
	return false; //중요
});
$(".topmenu_2 a").keyup(function(){
	$(".smenu1").hide();
	$(".smenu2").show();
	$(".smenu3").hide();
	$(".smenu4").hide();
	return false; //중요
});
$(".topmenu_3 a").keyup(function(){
	$(".smenu1").hide();
	$(".smenu2").hide();
	$(".smenu3").show();
	$(".smenu4").hide();
	return false; //중요
});
$(".topmenu_4 a").keyup(function(){
	$(".smenu1").hide();
	$(".smenu2").hide();
	$(".smenu3").hide();
	$(".smenu4").show();
	return false; //중요
});
if ($("body").hasClass("mobile") || $("body").hasClass("tablet")){
	if ($(".toparea").hasClass("mobileOpen") == false){
		$(".toparea .mobile-category > div").css("left", -(windowWidth+100)+"px").css("height",$(window).height()+"px");
	}
}

$(window).resize(function(){	
	windowWidth = $(window).width();
	windowHeight = $(window).height();		
	if ($("body").hasClass("mobile") || $("body").hasClass("tablet")){
		if ($(".toparea").hasClass("mobileOpen") == false){
			$(".toparea .mobile-category > div").css("left", -(windowWidth+100)+"px").css("height",$(window).height()+"px");
		}
	}
}).resize();


/* 모바일 왼쪽 메뉴 열림  */
function mobileMenuToggle(type){
	if (type == "open"){
		$(".toparea").addClass("mobileOpen");
		$(".toparea .mobile-category").css("width", $(window).width()+"px").css("height", $(window).height()+"px");
		if ($("body").hasClass("mobile")){
			$(".toparea .mobile-category > div.mobild_menu > ul").css("min-height", $(window).height()-($(".mobile-category h2").height()+$(".mobile-category dl").height()+$(".mobile-category .email-reject").height()+40)+"px");
		}else if ($("body").hasClass("tablet")){
			$(".toparea .mobile-category > div.mobild_menu > ul").css("min-height", $(window).height()-($(".mobile-category h2").height()+$(".mobile-category dl").height()+100)+"px");
		}
		$(".btn-category-holder").hide();
		$(".toparea .mobile-category > div.mobild_menu").animate({left:"0"}, 500, function(){
			if ($("body").hasClass("device")){
				$("body").css("overflow-y", "hidden");
			}
		});
		$(".toparea").append("<div class='transparents-layer'></div>");
	}else{
		$(".toparea .mobile-category > div.mobild_menu").animate({left:-(windowWidth+100)+"px"}, 500, function(){
			if ($("body").hasClass("device")){
				$("body").css("overflow-y", "visible");
			}
			if ($("body").hasClass("mobile")){
				$(".toparea .mobile-category").css("width", "38px").css("height", "38px");
			}else if ($("body").hasClass("tablet")){
				$(".toparea .mobile-category").css("width", "32px").css("height", "24px");
			}
			$(".toparea").removeClass("mobileOpen");
			$(".toparea .mobile-category > div.mobild_menu > ul").css("min-height", "auto");
			$(".toparea .transparents-layer").remove();
			$(".btn-category-holder").show();
		});	
	}
}

/* 모바일 왼쪽 메뉴 슬라이드 토글 함수  */
function slideToggle(Idx){
	if ($(".mobile-category > div > ul >li.topmenu_"+Idx+"").hasClass("slideOpen") == false){
		$(".mobile-category > div > ul >li.topmenu_"+Idx+" > ul").slideDown("slow");
		$(".mobile-category > div > ul >li.topmenu_"+Idx+"").addClass("slideOpen");
	}else{
		$(".mobile-category > div > ul >li.topmenu_"+Idx+" > ul").slideUp("slow");
		$(".mobile-category > div > ul >li.topmenu_"+Idx+"").removeClass("slideOpen");
	}
}


/*모바일메뉴*/
$( ".mobile_gnb li a" ).click(function(){
	if($(".mobile_gnb li").hasClass("active")) {
		$( this ).addClass( "active" );
	} else{
		$( this ).removeClass( "active" );
	}
});
function skipNavi(skipName){
	if (skipName == "#gnb"){
		$("#gnb li.topmenu_1 > a").focus();
		topmenuOpen(1);
	}else if (skipName == "#maincontents"){
		$("#maincontents .section1 .type1 a").focus();
	}else if (skipName == "#sub_contents"){
		$("#sub_contents .contentsarea h2").focus();
	}else if (skipName == "#sidearea"){
		$("#lnb_box li:first-child a").focus();
	}
}

$(".iradio").click(function(){
	if ($(this).hasClass("on") == false){
		$(this).parent().parent().find(".iradio").removeClass("on");
		$(this).parent().parent().find(".iradio input").prop("checked", false);
		$(this).addClass("on");
		$(this).find("input").prop("checked", true);
	}
});

function floatingTop (){
	$(window).scroll(function () {
		var winTop = $(this).scrollTop();
		var headerTop = $("#header").height();
		
		if (winTop > headerTop) {
			$(".floating_top").fadeIn(300,"easeOutCubic");
		}
	});	
}

/*상단 검색*/
$(document).ready(function() {
	gnb (); //gnb 
	js_search (); //js_search 
});

//js_fixed
function js_fixed (){
	var fixed_obj = $("#header");
		fixed_obj.sc = fixed_obj.find(".totalsearch");
	
}
//js_search 
function js_search (){
	var search_obj = $(".totalsearch");
		search_obj.box = search_obj.find("div");
		search_obj.box.input = search_obj.box.find(">input");
		search_obj.btn = search_obj.find(">.total_search"); 
	var	move = "";	
	 	
	//default
	js_search_def (search_obj);
	$(window).resize(function(){
		//js_search_def (search_obj);
	});
	
	//click
	search_obj.btn.click(function(){
		if(search_obj.box.is(":animated")) return false;
		if(!$(this).hasClass("active")){
			js_search_move (search_obj,"open");	
		} else {
			js_search_move (search_obj,"close");
		}	
		return false;	
	});	
	
	//mouseleave
	//search_obj.mouseleave(function(){
	$("#header").mouseleave(function(){		
		if($(".mob_btn").is(":hidden")){
			if(search_obj.btn.hasClass("active")){
				js_search_move (search_obj,"close");		
			}
		}
	});
}
function js_search_move (search_obj,move){
	if(move == "open"){
		search_obj.btn.addClass("active").find(">span").text("검색닫기");
		if($(".mob_btn").is(":hidden")){
			//$("#nav").fadeOut(100);
			search_obj.box.stop().animate({"width":306+"px"},500,"easeInOutExpo",function(){
				search_obj.box.input.fadeIn(300);
			});		
		} else {
			search_obj.box.fadeIn(300);		
		}	
	} else if(move == "close") {
		search_obj.btn.removeClass("active").find(">span").text("검색열기");	
		if($(".mob_btn").is(":hidden")){
			search_obj.box.input.fadeOut(0);
			search_obj.box.stop().animate({"width":33+"px"},500,"easeInOutExpo",function(){
				//$("#nav").fadeIn(100);	
			});	
		} else {
			search_obj.box.fadeOut(300);	
		}
	}	
}
function js_search_def (search_obj){
	search_obj.btn.removeClass("active").find(">span").text("검색열기");
	if(!$(".mob_btn").is(":hidden")){
		search_obj.box.hide();
	} else {
		search_obj.box.show();	
	}	
}	

//gnb
function gnb (){
	var res = "";
}	
