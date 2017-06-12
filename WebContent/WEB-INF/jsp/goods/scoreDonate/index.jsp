<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>自助登记</title>
   	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">  
   	<%@ include file="../../base/taglib.jsp"%>
   	<%@ include file="../../base/importCss.jsp"%>
   	
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<%@ include file="../../base/importJs.jsp"%>
   	<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>商品管理
                  </li>
                  <li>积分捐赠</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
		   					<form class='form-inline' action="">
		   						 <!-- <div class='form-group'>
		   							<label>捐赠状态：</label>
								    <select class='form-control' id="query_status" >
			   							 <option value="-1" selected="selected">全部</option>
								    	<option value="1" >已捐赠</option>
								    	<option value="2" >已接收</option>
								    </select>
		   						</div>  -->
		   						<div class='form-group' >
									    <label>捐赠者：</label>
									    <input class='form-control' type='text' id='query_donate'>
		   						</div>
		   						<div class='form-group'>
									    <label>接收者：</label>
									    <input class='form-control' type='text' id='query_agent' >
		   						</div>
		   						
		   						
					   
		   					</form>
		   			
			</div>
			   	<div class="panel-body">
				   	<div >
					    <table id="jqGrid"></table>
					    <div id="jqGridPager"></div>
					</div>
			   	</div>

</div>
</body>
<script type="text/javascript">
$(function() {
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$("#jqGrid").jqGrid({
        url:"<c:url value='/scoreDonate/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        mtype: 'POST',
        datatype: "json",
        jsonReader : {
			root : 'data.rows',
            records: 'data.records',
            total: 'data.pages',
            repeatitems : false,
			
		},
        cmTemplate:{
        	align:'center',
        	sortable:false
        },
        colModel: [
            {
				label: 'ID',
                name: 'id',
				key: true,
				hidden:true,
				search:false,
            },
           
            /* {
				label : '活动',
                name: 'title',
                search:false,
            }, */
            {
				label : '捐赠人',
                name: 'donate',
                search:false,
            },
            {
				label: '捐赠时间',
                name: 'donatetime',
				formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                }
                
            },
            {
				label: '捐赠积分值',
                name: 'donatescore',
                search:false,
                
            },
            {
				label: '接收者',
                name: 'agent',
            
            },
            /* {
				label : '状态',
                name: 'status',
                formatter:'select', 
                editoptions:{value:"1:已捐赠;2:已接收;"},
            }, */
        ],
		loadonce: false,
		viewrecords: true,
        shrinkToFit :true,
        height:$(window).height()-$('.panel-body').offset().top-80,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
		        
	
	var f = { groupOp: "AND", rules: [] };
    
    var timer;
    $('#query_agent').keyup(function(){
		var self = this;
		var value = self.value;
		var grid = $('#jqGrid');
     	var field = "b.name";
     	var op = "cn";
     	
		if(timer) { clearTimeout(timer); }
		timer = setTimeout(function(){
			//timer = null;
			filter(f,grid,field,op,value);
		},0);
     	
		var query_agent = value;
		query_agent = escape(query_agent);
		setCookie("query_agent10", query_agent, 0.1);
     }); 
    
    var timer1;
    $('#query_donate').keyup(function(){
		var self = this;
		var value = self.value;
		var grid = $('#jqGrid');
     	var field = "c.name";
     	var op = "cn";
     	
		if(timer1) { clearTimeout(timer1); }
		timer1 = setTimeout(function(){
			//timer = null;
			filter(f,grid,field,op,value);
		},0);
		var query_donate = value;
		query_donate = escape(query_donate);
		setCookie("query_donate10", query_donate, 0.1);
     }); 
    
//再显示查询条件  
if(!(!!window.ActiveXObject || "ActiveXObject" in window))		
	{
			var query_agent = getCookie('query_agent10');
			var query_donate = getCookie('query_donate10');

			//cookie中文编码问题 
			query_agent = unescape(query_agent);
			query_donate = unescape(query_donate);

			if(query_agent != "" || query_agent!= null || query_agent!= undefined)
				$('#query_agent').val(query_agent);
			
			if(query_donate != "" || query_donate!= null || query_donate!= undefined)
				$('#query_donate').val(query_donate);
		}
	
    
    
    
});
</script>
<!-- END BODY -->

</html>