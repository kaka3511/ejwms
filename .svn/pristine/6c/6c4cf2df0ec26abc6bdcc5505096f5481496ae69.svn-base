<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<%@ include file="../../base/importJs.jsp"%>
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>健康测评记录</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
					    <form class='form-inline' action="">
					    		<div class="form-group">
		   							<label>题目类型：</label>
								     <select id="question_query_type" class="form-control">
								   		 <option value="" >所有</option>
								    	<option value="1" >精神状态测评</option>
								    	<option value="2"  >危险度评测</option>
								    </select>
		   						</div> 
		   						
		   						<div class="form-group">
		   							<label>危险等级：</label>
								     <select id="query_rank" class="form-control">
								   		 <option value="" >所有</option>
								   		 <option value="0" >正常</option>
								    	<option value="1" >较危险</option>
								    	<option value="2"  >危险</option>
								    </select>
		   						</div> 
		   						<div class='form-group'>
									    <label>答题人：</label>
									    <input class='form-control' type='text' id='query_answer'>
		   						</div>
		   						
		   						<div class='form-group'>
									    <label>被监护人：</label>
									    <input class='form-control' type='text' id='query_pupil'>
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
        url:"<c:url value='/healthTestRecord/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        datatype: "json",
        jsonReader:{
        	root:'data',
        	repeatitems: false,
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
            }
            ,
            {
				label: '题目类型',
                name: 'type',
                width:100,
                formatter:'select', 
                editoptions:{value:"1:精神状态测评;2:危险度评测"},
            
            
            } 
            ,
            
            {
				label: '答题人',
                name: 'name',
            } 
			,
            
            {
				label: '被监护人',
                name: 'pupil',
            } 
            ,
            {
				label: '答题时间',
                name: 'time',
				formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
            } 
            ,
            {
				label: '危险等级',
                name: 'rank',
				formatter:function(cellvalue, options, rowObject){
					var template ="";
                	switch(cellvalue){
                		case 0:
                			template = "<p class='bg-success'>正常</p>";
                			break;
                		case 1:
                			template = "<p class='bg-warning'>较危险</p>";
                			break;
                		case 2:
                			template = "<p class='bg-danger'>危险</p>";
                			break;
                	
                	}
                	return template;
                }
            } 
            ,
            {
				label: '结果评定描述',
                name: 'description',
            } 
            ,
            {
				label: '评定人',
                name: 'assesser',
            } 
            /* ,
            {
				label: '评定时间',
                name: 'assesstime',
				formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
            }  */
        ], 
                  loadonce: true,
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
     
		$('#question_query_type').change(function(){
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "type";
			var op = "cn";
		
			filter(f,grid,field,op,value);
		     	
     }); 
		$('#query_rank').change(function(){
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "rank";
			var op = "cn";
		
			filter(f,grid,field,op,value);
		     	
     }); 
     
		var timer;
		$('#query_answer').keyup(function(){
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
		 	var field = "name";
		 	var op = "cn";
		 	
			if(timer) { clearTimeout(timer); }
			timer = setTimeout(function(){
				//timer = null;
				filter(f,grid,field,op,value);
			},0);
		 	
		 }); 
		 
		var timer1;
		$('#query_pupil').keyup(function(){
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
		 	var field = "pupil";
		 	var op = "cn";
		 	
			if(timer1) { clearTimeout(timer1); }
			timer1 = setTimeout(function(){
				//timer = null;
				filter(f,grid,field,op,value);
			},0);
		 	
		 }); 
    
});
</script>
</html>