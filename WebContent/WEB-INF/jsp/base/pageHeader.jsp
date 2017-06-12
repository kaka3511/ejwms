<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- BEGIN HEADER -->   
<div class="header navbar navbar-fixed-top" style="background-color:RGB(2,130,205);position: relative;">
   <!-- BEGIN TOP NAVIGATION BAR -->
  <div class="header-inner">
     <!-- BEGIN LOGO -->  
     <div style="margin-top: 10px;margin-left: 20px;float: left;">
     <img src="<c:url value='/images/index/logo.png'/>" alt="logo"/>
     </div>
     <!-- <form class="search-form search-form-header" role="form" action="index.html" >
        <div class="input-icon right">
           <i class="icon-search"></i>
           <input type="text" class="form-control input-medium input-sm" name="query" placeholder="Search...">
        </div>
     </form> -->
     <!-- END LOGO -->
     <!-- BEGIN RESPONSIVE MENU TOGGLER --> 
     <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
     <img src="<c:url value='/images/menu-toggler.png'/>" alt=""/>
     </a>
     <label style="color:white;font-size:30px;font-family:Microsoft YaHei;margin-top:30px;padding-left: 20px;">阳光微警务管理后台</label>
     <!-- END RESPONSIVE MENU TOGGLER -->
     <!-- BEGIN TOP NAVIGATION MENU -->
   <%--   <ul class="nav navbar-nav pull-right" style="margin-top:20px;">
       <!--  <li class="devider">&nbsp;</li> -->
        <!-- BEGIN USER LOGIN DROPDOWN -->
        <li class="dropdown user">
           <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
           <img alt="" src="<c:url value='/images/avatar3_small.jpg'/>"/>&nbsp;
           <span class="username">${sessionScope.user.account}</span>&nbsp;-&nbsp;
           <span class="username">${sessionScope.user.name}</span>
           <i class="icon-angle-down"></i>
           </a>
           <ul class="dropdown-menu">
<!--               <li><a href="javascript:iframeHref('/patrol/accountManage/accountManage')"><i class="icon-user"></i>我的账户</a>
              </li> -->
              <li class="divider"></li>
              <li><a href="/ejwms/home/login"><i class="icon-off"></i>注销登录</a>
              </li>
           </ul>
        </li>
        <!-- END USER LOGIN DROPDOWN -->
     </ul> --%>
     
     <%@ include file="../base/styleSet.jsp"%> 
     
     
     <!-- END TOP NAVIGATION MENU -->
  </div>
  <!-- END TOP NAVIGATION BAR -->
</div>
<!-- END HEADER -->