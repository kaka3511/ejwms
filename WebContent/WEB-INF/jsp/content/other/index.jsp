<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.huaao.model.home.UserInfo"%>
<%@page import="com.huaao.web.home.AuthHelper"%>
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
<%
   
   UserInfo cuser = AuthHelper.getSessionUserAuth(request);
   int uid=cuser.getId();
%>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>内容管理
                  </li>
                  <li>内容发布</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
					    
					  <form class='form-inline' action="">
							  <div class="form-group">
									<label>信息类型：</label>
								    <select class='form-control' id="query_type" >
			   							 <option value="-1" selected="selected">全部</option>
<!-- 								    	<option value="1" >办事指南</option> -->
								    	<option value="4"  >健康计划</option>
								    	<option value="5"  >健康生活</option>
								    	<option value="6"  >健康贴士</option>
								    </select>
								</div>
		   						<div class='form-group'>
									    <label>标题：</label>
									    <input class='form-control' type='text' id='query_title'>
		   						</div>
		   						
		   						<div class='form-group  pull-right'>
									    <a class='btn btn-primary' href="<c:url value='/content/other/add'/>">发布信息</a>
		   						</div>
					   
		   			</form>
					  
			</div>
			   	<div class="panel-body">
				   	<div >
					    <table id="jqGrid"></table>
					    <div id="jqGridPager"></div>
					</div>
					 <!-- <div id="mysearch"></div>
					<button class='btn btn-primary' id='btn_search'>搜索</button>
					<button class='btn btn-primary' id='trigger'>点击</button>   -->
			   	</div>

</div>
</body>
<script type="text/javascript">
$(function() {
	var currentContentOtherPage = getOneSessionStorageValue("currentContentOtherPage");
	var uid="<%=uid%>";
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$("#jqGrid").jqGrid({
        url:"<c:url value='/content/health'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        datatype: "json",
        mtype: 'POST',
        page: currentContentOtherPage,
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
            {
				label: '类型',
                name: 'type',
                width:100,
                formatter:'select', 
                editoptions:{value:"1:办事指南;2:康复活动;3:慈善活动;4:健康计划;5:健康生活;6:健康贴士"},
                stype:'text', 
                searchoptions:{
                	//value:"1:办事指南;2:康复活动;3:慈善活动;4:健康计划;5:健康生活;6:健康贴士"
                },
            
            },
           {
			label: '状态',
            name: 'status',
            width:100,
            formatter:'select', 
            editoptions:{value:"2:待审核;3:审核不通过;4:已通过"},
            stype:'text', 
            searchoptions:{
            	//value:"1:办事指南;2:康复活动;3:慈善活动;4:健康计划;5:健康生活;6:健康贴士"
            }
         },
            {
				label : '标题',
                name: 'title',
                width:200,
            },
            {
				label: '摘要',
                name: 'summary',
                width:400,
                search:false,
                searchoptions:{
                	sopt:['cn'],
                }
            },
           
            {
				label: '修改时间',
                name: 'updatetime',
                width:100,
                search:false,
 				formatter:function(cellvalue, options, rowObject){
 					var cell=0;
                	if(cellvalue>10000000000){
                		cell=cellvalue/1000;
                	}else{
                		cell=cellvalue;
                	}
                	return ToDate("Y-m-d H:i:s",cell);
                }
            },
           
            
            {
				label: '操作',
                name: 'operation',
                editable: false,
                search:false,
                formatter:operFormat,
                unformat:operUnFormat,
                width:120,
            
            }
        ],
        gridComplete : function() {
			$('td .del').off('click',del);
			$('td .del').on('click',del);
		},
		loadonce: false,
		viewrecords: true,
		height:$(window).height()-$('.panel-body').offset().top-80,
        shrinkToFit :true,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
	function del(event) {
		event.preventDefault();
		if(confirm("确认删除该条记录吗？")){
			var href = $(this).attr('href');
			$.ajax({
				url : href,
				dataType : 'json',
				type : 'get',
				success : function(data, textStatus, jqXHR) {
					alert("删除成功！");
					$("#jqGrid").delRowData(data.data);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("删除失败,请稍后再试！");
				}
			});
		};
		
	}
	
	
	function operFormat( cellvalue, options, rowObject ){
		var currentContentOtherPage = $(this).jqGrid('getGridParam','page');
		sessionStorage.setItem("currentContentOtherPage", currentContentOtherPage); 
		if(rowObject.type==6&&(rowObject.status==4||rowObject.cuser==uid)){
			return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/other/edit/'/>"+rowObject.id+"'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"+rowObject.id+"'>删除</a></div>";
		}else{
			if(rowObject.type==6){
				return "<div><a class='btn btn-primary del' href='<c:url value='/content/del/'/>"+rowObject.id+"'>删除</a></div>";
			}else{
				if(rowObject.type==2){
		       		return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/other/edit/'/>"+rowObject.id+"'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"+rowObject.id+"'>删除</a><a class='btn btn-primary ' href='<c:url value='/content/downloadQRCode/'/>"+rowObject.id+"'>下载二维码</a></div>";
		       	}else{
		       		return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/other/edit/'/>"+rowObject.id+"'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"+rowObject.id+"'>删除</a></div>";
		       	}
			}
		}
	}
	
	function operUnFormat( cellvalue, options, cell){
		return "";
	}
	
	var f = { groupOp: "AND", rules: [] };
	$('#query_type').change(function(){
    	var self = this;
 		var value = self.value;
     	var grid = $('#jqGrid');
     	var field = "type";
     	var op = value==-1?"ne":"eq";

     	filter(f,grid,field,op,value);
     	
     	var type_query = value;		
		setCookie("type_query3", type_query, 0.1);
     });	
	var timer;
    $('#query_title').keyup(function(){
		var self = this;
		var value = self.value;
		var grid = $('#jqGrid');
     	var field = "title";
     	var op = "cn";
     	
		if(timer) { clearTimeout(timer); }
		timer = setTimeout(function(){
			//timer = null;
			filter(f,grid,field,op,value);
		},0);
     	
		var query_title = value;
		
		query_title = escape(query_title);
		setCookie("query_title2", query_title, 0.1);
		
     }); 
	
//再显示查询条件  
	
	{
			var type_query = getCookie('type_query3');
			var query_title = getCookie('query_title2');

			//cookie中文编码问题 
			query_title = unescape(key_query);
			
			if (type_query == "4" || type_query == "5"
					|| type_query == "6")
				$('#type_query').val(type_query);
			else
				$('#type_query').val("-1");


			if(query_title != "" || query_title!= null || query_title!= undefined)
				$('#query_type').val(query_title);
		}
	
});
</script>
<!-- END BODY -->

</html>