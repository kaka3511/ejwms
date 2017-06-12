<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--引进c  和 from 标签  -->
<%@ include file="../base/taglib.jsp"%>

<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>阳光微警务管理后台</title>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta content="width=device-width, initial-scale=1.0" name="viewport" />
   <meta content="" name="description" />
   <meta content="" name="author" />
   <meta name="MobileOptimized" content="320">
   <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/images/icon.ico'/>" />
   <%@ include file="../base/importCss.jsp"%>
   <!-- BEGIN PAGE LEVEL PLUGIN STYLES --> 
   <link href="<c:url value='/plugins/fullcalendar/fullcalendar/fullcalendar.css'/>" rel="stylesheet" type="text/css"/>
   <!-- END PAGE LEVEL PLUGIN STYLES -->
   <style>
		.sub-menu > li > .selected{
			background: #229BF3 !important;
			color: #fff;
		}
	</style>
   
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed main" style='padding-right:0px!important;' > 
   <%@ include file="../base/pageHeader.jsp"%>
   <!-- <div class="clearfix"></div> -->
   <!-- BEGIN CONTAINER -->
   <div class="page-container">
   
      <%@ include file="../system/menuManage.jsp"%>
      
      <!-- BEGIN PAGE -->
      <div class="page-content" style="background: #fafafa;"> 
	            	<iframe style="background-color: #fafafa;" marginheight="0" marginWidth="0" id="contentFrame"  frameBorder="0" src="/ejwms/home/welcome" width="100%" style='padding:20px;'></iframe>
      </div>
      <!-- END PAGE -->
   </div>
   <!-- END CONTAINER -->
   <!-- BEGIN FOOTER -->
    <%@ include file="../base/pageFooter.jsp"%>
   <!-- END FOOTER -->
   
   <%@ include file="../base/importJs.jsp"%>
   <!-- BEGIN PAGE LEVEL PLUGINS -->
   <script src="<c:url value='/plugins/gritter/js/jquery.gritter.js'/>" type="text/javascript"></script>
   <!-- IMPORTANT! fullcalendar depends on jquery-ui-1.10.3.custom.min.js for drag & drop support -->
   <script src="<c:url value='/plugins/fullcalendar/fullcalendar/fullcalendar.min.js'/>" type="text/javascript"></script>
   <script src="<c:url value='/plugins/jquery.sparkline.min.js'/>" type="text/javascript"></script>  
   <!-- END PAGE LEVEL PLUGINS -->
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
   <script src="<c:url value='/js/app.js'/>" type="text/javascript"></script>
   <script src="<c:url value='/js/index.js'/>" type="text/javascript"></script>  
   <!-- END PAGE LEVEL SCRIPTS -->  

   <script type="text/javascript">
      jQuery(document).ready(function() {  
         App.init(); // initlayout and core plugins
         /* Index.init();
         Index.initCalendar(); // init index page's custom scripts
         Index.initPeityElements();
         Index.initKnowElements();
         Index.initDashboardDaterange(); */
         //window.setInterval("reinitIframe()", 20);
         $(window).resize(function(){
        	 windowResize();
         });
         windowResize();
      }); 
      /* IFRAME自适应*/
      function windowResize(){
         /*  var iframe = document.getElementById("contentFrame");
          try{
              var bHeight = iframe.contentWindow.document.body.scrollHeight+30;
              var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
              //alert(bHeight+"==="+dHeight);
              var height = Math.min(bHeight, dHeight);
              if(height<400){
            	  height = 400;
              }
              iframe.height =  height;
              //iframe.height =  bHeight;
              }catch (ex){} */
              $('.page-content').css('cssText',"min-height:0px!important;");
              $('#contentFrame').height($(window).height()-130);
              $('.page-sidebar').css('cssText',"height:"+($(window).height()-110)+"px!important;overflow-y:auto!important");
      }
      
      function iframeHref(url){
    	  sessionStorage.clear();
    	  clearCookie();
    	  $('#contentFrame').attr("src",url);
      }
      
      $(function(){
			$(".sub-menu li a").click(function(){
				$(".sub-menu li a").removeClass("selected");
				$(this).toggleClass("selected");
			})
		})
   </script>
   <!-- END JAVASCRIPTS -->
</body>
</html>