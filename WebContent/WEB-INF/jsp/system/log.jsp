<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>自助登记</title>
   	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">  
   	<%@ include file="../base/taglib.jsp"%>
   	<%@ include file="../base/importCss.jsp"%>
   	
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<%@ include file="../base/importJs.jsp"%>
   	<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>系统管理
                  </li>
                  <li>日志查询</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
		   		<div class="row">
		   			<div class='col-xs-12'>
		   					<form class='form-inline search_form' >
		   						<div class='form-group'>
									    <label>手机号：</label>
									    <input class='form-control' name="phone" type='text' id='query_phone'>
		   						</div>
		   						<div class='form-group'>
									    <label>姓名：</label>
									    <input class='form-control' name="name" type='text' id='query_name'>
		   						</div>
		   						<div class='form-group'>
									    <label>操作：</label>
									    <input class='form-control' name="name" type='text' id='query_action'>
		   						</div>
		   						<div class='form-group'>
									<label>操作时间：</label>
									<input class='form-control' name="starttime" type='text' id='query_starttime'>
								</div>
								
								<div class='form-group'>
									<label>至</label>
									<input class='form-control' name="endtime" type='text' id='query_endtime'>
								</div>
								<div class='form-group'>
									<button id="btn_search" class="btn btn-success">搜索</button>
								</div>
					   
		   					</form>
		   			
		   			</div>
		   			
		   		
		   		</div>
		   	
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
	$("#query_starttime").datepicker({
		language : 'zh-CN',
		format : "yyyy/m/d/",
		minView:2
	});
	$("#query_endtime").datepicker({
		language : 'zh-CN',
		format : "yyyy/m/d",
		minView:2
	});
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$("#jqGrid").jqGrid({
        url:"<c:url value='/log/list'/>",
        datatype: "json",
        jsonReader:{
        	root:'data.list',
        	total:'data.totalPage',
        	records:'data.records',
        	repeatitems: true,
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
            }
            ,
            {
				label: '操作手机号',
                name: 'create_phone',
            
            },
            {
				label: '操作姓名',
                name: 'create_name',
            
            }
            ,
            {
				label: '操作',
                name: 'title',
            
            }
            ,
            {
				label: '操作者IP',
                name: 'remote_addr',
            
            }
            ,
            {
				label: '浏览器',
                name: 'user_agent',
            
            }
            ,
            {
				label: '操作时间',
                name: 'create_date',
                formatter:function(cellvalue, options, rowObject){
                	
               	 var cell=0;
	                	if((cellvalue+"").length>10){
	                		cell=cellvalue/1000;
	                	}else{
	                		cell=cellvalue;
	                	}
            	return ToDate("Y/m/d H:i:s",cell);
               },
            
            }
        ],
       
		viewrecords: true,
		height:$(window).height()-$('.panel-body').offset().top-80,
        shrinkToFit :true,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 20,
        pager: "#jqGridPager"
    });
		        
	
	
	$("#btn_search").click(function(e){
		e.preventDefault();
		var grid = $('#jqGrid');
		
		
		var phone = $('#query_phone').val();
		
		var name = $('#query_name').val();
		var title = $('#query_action').val();
		var start =$('#query_starttime').val();
		if(start){
			try{
				start = new Date(start).getTime()/1000;
			}catch(e){
				start = 0;
			}
			
		}else{
			start = 0;
		}
		
		
		var end =$('#query_endtime').val();
		if(end){
			try{
				end = new Date(end).getTime()/1000;
			}catch(e){
				end = 9999999999999;
			}
			
		}else{
			end = 9999999999999;
		}
		
		if(start >= end){
			BootstrapDialog.alert("开始时间必须小于结束时间!");
			return;
		}
			
		$("#jqGrid").setGridParam({"postData":{
        	phone:$('#query_phone').val(),
        	name:$('#query_name').val(),
        	title:$('#query_action').val(),
        	starttime:$('#query_starttime').val(),
        	endtime:$('#query_endtime').val()
        }});
		$("#jqGrid").trigger("reloadGrid");
		/* $.ajax({
			url:"/ejwms/log/list",
			data:$(".search_form").serialize()+"&page=1&rows=20",
			dataType:"json",
			type:"post",
			success:function(resp){
				$("#jqGrid").clearGridData();
				$("#jqGrid").addRowData("id",resp.list);
			},
			error:function(){
				BootstrapDialog.alert("请求失败，请稍后重试！");
			}
		}); */
		
	});
	
	
    
    
    
});
</script>
<!-- END BODY -->

</html>