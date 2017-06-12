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

<style type="text/css">
   		.ui-jqgrid .ui-jqgrid-bdiv{
   			overflow: hidden;
   		}
   		.table tbody tr.active:hover  td, .table tbody tr.active:hover  th{
   			background-color: #dff0d8 !important;
   		}
   		.ui-jqgrid-hbox .ui-jqgrid-labels{
		background-color:rgb(52, 153, 219);
		}
		.ui-jqgrid-hbox .ui-jqgrid-labels   .active{
		background-color:rgb(52, 153, 219);
		} 
   	</style>
   	<script>
		//$.jgrid.defaults.width = 780;
		$.jgrid.defaults.responsive = true;
		$.jgrid.defaults.styleUI = 'Bootstrap';
	</script>
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>评测试题</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
					    <!-- <label>题库类型：</label>
					    <select id="qbank_query_type" class="">
					   		 <option value="" >所有</option>
					    	<option value="1" >游戏问题</option>
					    	<option value="2"  >健康评测</option>
					    </select> -->
					  
					    <label>题目类型：</label>
					    <select id="question_query_type" class="">
					   		 <option value="" >所有</option>
					    	<option value="1" >防盗知识</option>
					    	<option value="2"  >防火知识</option>
					    	<option value="3"  >防骗知识</option>
					    	<option value="4"  >交通安全</option>
					    	<option value="5"  >禁毒知识</option>
					    </select>
				 <%-- <a class='btn btn-primary pull-right' id='btn_add' href="<c:url value='/healthTest/add'/>">添加题目</a> --%>

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
	$("#jqGrid").jqGrid({
        url:"<c:url value='/healthTest/list'/>",
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
				label : '问题标题',
                name: 'question',
                width:200,
            },
            {
				label: '题目类型',
                name: 'type',
                width:100,
                formatter:'select', 
                editoptions:{value:"1:防盗知识;2:防火知识;3:防骗知识;4:交通安全;5:禁毒知识"},
            
            
            } 
        ], 
                  loadonce: true,
          		viewrecords: true,
                  height: 600,
                  shrinkToFit :true,
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

     	grid.jqGrid('setGridParam', { search: false });
     	var postData = grid.jqGrid('getGridParam', 'postData');
     	    //$.extend(postData, { filters: "{'groupOp':'AND','rules':[{'field':'id','op':'cn',…':'1'},{'field':'name','op':'cn','data':'test'}]}" });

     	     var have;
       	   $.each(f.rules,function(i,v){
       		   if(v.field=='type'){
       			   v.data = value
       			   have = true;
       		   }
       	   })
       	     if(!have)f.rules.push({ field: "type", op: "cn", data: value });
     	    
     	     $.extend(postData, { filters:JSON.stringify(f)});
     		grid.jqGrid('setGridParam', { search: true });
     	    grid.jqGrid().trigger('reloadGrid', [{ page: 1}]);
     	
     }); 
    
});
</script>
</html>