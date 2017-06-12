<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="../base/taglib.jsp"%> 

<html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<meta charset="utf-8" />
	<title>阳光微警务 | 登录</title>
	<link rel="shortcut icon" type="image/x-icon" href="<c:url value='/images/icon.ico'/>" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<meta name="MobileOptimized" content="320">
	
	<%@ include file="../base/importCss.jsp"%>
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<%-- <link href="<c:url value='/css/pages/login.css'/>" rel="stylesheet" type="text/css"/> --%>
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<%@ include file="../base/importJs.jsp"%>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="<c:url value='/js/app.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/js/account.validate.js'/>" type="text/javascript"></script> 
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<!-- <link rel="shortcut icon" href="favicon.ico" /> -->
	
	<style type="text/css">
		.input-group .input-group-btn .btn{
			border-radius: 0px;
		}
	</style>
</head>

<!-- BEGIN BODY -->
<body style='padding-top: 0px!important;padding-left:0px!important;padding-right:0px!important;'>
<div class="topdiv">
	<div style='height:100px;'>
	
		<div  style='margin-left:45px;'>
				<img alt="" src="../images/home/login/jw_logo.png" style="float: left;margin-top:15px;margin-right:20px;">
		
				<div style=''>
				 <p style="font-family:Microsoft YaHei,simsun,Arial,sans-serif;color:#0a59de; font-size: 36px;margin-bottom: 0px;">阳光微警务管理后台</p>
				 <span style="color:#0a59de;font-size: 28px;">Sunshine E-police service  Management Platform</span>
			 	</div>
		</div>
		
	</div>
	 
</div>
<div class="login" >
		<div class='ctn_center' style='background-color:RGB(0,116,229); min-height: 500px;overflow: hidden;'>
			<div class='center-block' style='width:1200px;height:500px;background-image: url("../images/home/login/bg1.png");background-position: -350px -270px;background-repeat: no-repeat;'>
			
					<div style='float:right;position:relative;margin-top:75px;width:350px;background-color: white;padding: 5px 25px 35px 25px;border: 8px;border-style: solid;border-color: #e7e7e7;'>
						<form:form modelAttribute="contentModel" class="form login-form" method="POST" role="form">
								<h3 class="form-title" style='margin-bottom:20px;' >欢迎登录</h3>
								<div class="alert alert-error hide">
									<button class="close" data-dismiss="alert"></button>
									<span>请输入用户名和密码.</span>
								</div>
								<div class="form-group">
									<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
									<div class="input-group input-group-lg">
										<span class="input-group-btn">
									        <button class="btn btn-default" type="button" tabindex="-1">
												<img alt="" src="../images/home/login/account2.png">
											</button>
									      </span>
										<form:input  path="userAccount" class="form-control"  placeholder="请输入用户名"/><br/>
									</div>
									<form:errors path="userAccount" class="field-has-error"></form:errors>  
								</div>
								<div class="form-group">
									<div class="input-group input-group-lg">
										<span class="input-group-btn">
									        <button class="btn btn-default" type="button" tabindex="-1">
													<img alt="" src="../images/home/login/pwd2.png">
												
												</button>
									      </span>
										<form:password path="userPassword" class="form-control placeholder-no-fix"  placeholder="请输入密码"/><br/>  
									</div> 
									<form:errors path="userPassword" class="field-has-error"></form:errors> 
								</div>
<!-- 								<div class="form-group"> -->
<!-- 									<div class="input-group input-group-lg"> -->
<!-- 										<span class="input-group-btn"> -->
<!-- 									        <button class="btn btn-default" type="button"> -->
<!-- 												<img alt="" src="../images/home/login/pwdMgr2.png"> -->
<!-- 											</button> -->
<!-- 									      </span> -->
<%-- 										<form:password path="communityPassword" class="form-control placeholder-no-fix"  placeholder="请输入社区管理密码"/><br/>   --%>
<!-- 									</div>  -->
<%-- 									<form:errors path="communityPassword" class="field-has-error"></form:errors>  --%>
<!-- 								</div> -->
									<button type="submit" class="btn btn-primary btn-lg btn-block"  style='background-color:#0a59de;'>登录</button>   
							</form:form>
			
			</div>
					
		</div>
			
	</div>
		
				
</div>
<div class="center-block copyright" style="
    position: absolute;
    width: 100%;
    bottom: 0px;
">
	<div class='center-block' style="width:400px;margin-top:10px;">
		<img class='pull-left' src="../images/home/login/huaao_logo.png" style=" margin-right: 20px; ">
		<p style='color: #999999'>2016 &copy; Company. 华奥科技 版权所有.</p>
	</div>
	
				
 </div>
	<!-- END LOGIN -->
	<!-- BEGIN COPYRIGHT -->
	<!-- END COPYRIGHT -->
	 
	<script type="text/javascript">
$(function() {
			/* $("#userAccount").focus(); */
			App.init();
		  	AccountValidate.handleLogin();
		  	
		  	$('.input-group input').focus(function(){
		  		
		  		var oldSrc = $(this).siblings().children().children().attr('src');
		  		var newSrc = oldSrc.substring(0,oldSrc.length-5)+"1.png";
		  		$(this).siblings().children().children().attr('src',newSrc);
		  	});
		  	
		$('.input-group input').focusout(function(){
		  		
		  		var oldSrc = $(this).siblings().children().children().attr('src');
		  		var newSrc = oldSrc.substring(0,oldSrc.length-5)+"2.png";
		  		$(this).siblings().children().children().attr('src',newSrc);
		});
		
		function getViewPort() {
	        var e = window, a = 'inner';
	        if (!('innerWidth' in window)) {
	            a = 'client';
	            e = document.documentElement || document.body;
	        }
	        return {
	            width: e[a + 'Width'],
	            height: e[a + 'Height']
	        }
	    }
		var ctn = getViewPort().height - 100-50;
		$('.ctn_center').height(ctn);
		$('.ctn_center  .center-block').css('margin-top',ctn>500?(ctn-500)/2:0);
		$(window).resize(function(e){
			console.info(getViewPort());
			var ctn = getViewPort().height - 100-50;
			$('.ctn_center').height(ctn);
			$('.ctn_center .center-block').css('margin-top',ctn>500?(ctn-500)/2:0);
		});
}); 
		
		
	</script>
	<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>