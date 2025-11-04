<%--
  Class Name : EgovIncFooter.jsp
  Description : 화면하단 Footer(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="footer">
    <div class="inner">
        <h1><a href="#LINK"><img src="/images/copy_logo.png" alt="전국전세버스연합회"></a></h1>

        <div class="mid">
            <address>
                충청북도 청주시 흥덕구 오송읍 오송생명5로 303, 7층(국도푸르미르)
                <br/>
                T. 02-792-2916 | F. 02-794-2654
            </address>
            <p class="copy">Copyright © 전국전세버스운송사업조합연합회 All Rights Reserved.</p>
        </div>
		
        <div class="right_col banner_box">
            <%-- <a href="#LINK"><img src="<c:url value='/'/>images/banner01.png" alt="행정안전부"></a>
            <a href="#LINK"><img src="<c:url value='/'/>images/banner02.png" alt="NIA 한국지능정보사회진흥원"></a> --%>
            <ul id="web_banner2">
				<li><a href="https://nmcb.org/cooperative/user/main.do" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner01.jpg" alt="전국전세버스공제조합" /></a></li>
				<li><a href="http://www.moleg.go.kr" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner02.jpg" alt="법제처" /></a></li>
				<li><a href="http://www.molit.go.kr" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner03.jpg" alt="국토교통부" /></a></li>
				<li><a href="http://gwanbo.mois.go.kr" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner04.jpg" alt="관보" /></a></li>
				<li><a href="http://www.kotsa.or.kr" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner05.jpg" alt="교통안전공단" /></a></li>
				<li><a href="http://likms.assembly.go.kr" class="d_cell" target="_blank" title="새창열림"><img src="/images/main_banner06.jpg" alt="의안정보시스템" /></a></li>
			</ul>
        </div>
    </div>
</div>