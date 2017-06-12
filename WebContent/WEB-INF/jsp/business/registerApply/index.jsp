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
                     <i class="icon-cog"></i>业务管理
                  </li>
                  <li>自助登记</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
						<form class='form-inline'  autocomplete="off">
							<div class="form-group">
								<label >类型：</label>
							    <select class='form-control' id="type_query" value="${type_query}">
							   		 <option value="-1" >全部</option>
							    	<c:forEach items="${pupilTypeList }" var="item">
											<option value="${item.dictionary_code }">${item.dictionary_name }</option>
											
										</c:forEach>
							    </select>
							</div>
							
							<div class="form-group">
								<label >状态：</label>
							    <select class='form-control' id="status_query" value="${requestScope.status_query}">
							   		 <option value="-1" >全部</option>
							    	<option value="1" >网格员审核</option>
							    	<option value="2" >民警审核</option>
							    	<option value="4" >网格员驳回</option>
							    	<option value="5" >民警驳回</option>
							    	<option value="6" >群干委派</option>
							    	<option value="7" >群干驳回</option>
							    	<option value="8" >已结束</option>
							    </select>
							</div>
							
							<div class="form-group">
								<label >性别：</label>
							    <select class='form-control' id="gender_query" value="${requestScope.gender_query}">
							   		 <option value="-1" >全部</option>
							    	<option value="0" >女</option>
							    	<option value="1" >男</option>
							    </select>
							</div>
							<div class="form-group">
								<label>关键词：</label>
							    <input class='form-control' type="text" id = 'key_query' value="${requestScope.key_query}">
							</div>
							
							<div class='form-group'>
									<button id="btn_search" class="btn btn-success">搜索</button>
								</div>
							 <div class="form-group" style="margin-left:100px;" >
								<a class='btn btn-primary download' href=''/>下载</a> 
							</div> 
							
 								
						</form>
		   	
			</div>
			   	<div class="panel-body">
			   		<!-- <div class='container-fluid'>
			   			<div class="row">
			   				<div class='col-xs-12'>
			   					
			   				</div>
			   			</div>
			   		</div> -->
					    <table id="jqGrid"></table>
					    		<div id="jqGridPager"></div>
			   	</div>

</div>
</body>
<script type="text/javascript">
$(function() {
	var currentRegisterApplyPage = getOneSessionStorageValue("currentRegisterApplyPage");
 	$(".download").click(function(){
 		var keyword=$("#key_query").val();
 		var type_query=$("#type_query").val();
 		var status_query=$("#status_query").val();
 		var gender_query=$("#gender_query").val();
 		$(".download").attr("href","downloadExclefile?keyword="+keyword+"&type_query="+type_query+"&status_query="+status_query+"&gender_query="+gender_query);
 	});
 	
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});   
	$("#jqGrid").jqGrid({
        url:"<c:url value='/police/registerApply/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        datatype: "json",
        mtype: 'POST',
        page: currentRegisterApplyPage,
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
                name: 'apply_id',
				key: true,
				hidden:true,
				search:false,
            },
            {
				label: '申请人',
                name: 'cuser',
                
            },
            {
				label : '被监护人',
                name: 'name',
            },
            {
				label : '性别',
                name: 'gender',
                formatter:function(cellvalue){
                	return cellvalue==0?'女':'男';
                }
            },
            {
				label : '年龄',
                name: 'age',
            },
            {
				label: '类型',
                name: 'type',
                formatter:'select', 
                editoptions:{value:'<c:forEach items="${pupilTypeList }" var="item">${item.dictionary_code }:${item.dictionary_name };</c:forEach>'},
                
            },
           /*  {
				label: '头像',
                name: 'head_img',
                formatter:function(cellvalue, options, rowObject){
                	var img =  "<img style='width:80px;height:80px;' src='"+(rowObject.head_img?rowObject.head_img:'../images/header_img_default.jpg')+"'/>";
                	return img;
                	//return "<img src='images/header_img_default.jpg'/>";
                }
            
            }, */
            {
				label: '身份证号',
                name: 'idcard',
            
            },
            {
				label: '住址',
                name: 'addr',
                editable: false,
            
            } 
            ,
            {
				label : '状态',
                name: 'status',
                formatter:'select', 
                editoptions:{value:"0:已提交;6:群干委派;1:网格员审核;2:民警审核;3:关联关系;4:网格员驳回;5:民警驳回;7:群干驳回;8:已结束"},
            }
            ,
            {
				label: '申请时间',
                name: 'createtime',
				formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
            } 
            ,
            {
				label: '审核时间',
                name: 'audittime',
				formatter:function(cellvalue, options, rowObject){
                	if(rowObject.status==0||rowObject.status==6)return "";
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
            } ,
            {
				label: '操作',
                name: 'operation',
                editable: false,
                search:false,
                formatter:operFormat,
                unformat:operUnFormat
            
            }
        ],
		loadonce: false,
		viewrecords: true,
        autowidth:true,
        height:$(window).height()-$('.panel-body').offset().top-80,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
		        
	function operFormat( cellvalue, options, rowObject ){
		
		var status = rowObject.status;
		var userType = ${cuser.usertype};
		var userIdentity = ${cuser.userIdentity};
		var currentRegisterApplyPage = $(this).jqGrid('getGridParam','page');
		sessionStorage.setItem("currentRegisterApplyPage", currentRegisterApplyPage); 
		
		var auditTpl = "<div><a class='btn btn-primary edit'  href='<c:url value='/police/registerApply/view/?oper=show&id='/>"+rowObject.apply_id+"'>查看</a><a class='btn btn-primary edit'  href='<c:url value='/police/registerApply/view/?oper=edit&id='/>"+rowObject.apply_id+"'>审核</a></div>";
		var showTpl = "<div><a class='btn btn-primary edit'  href='<c:url value='/police/registerApply/view/?oper=show&id='/>"+rowObject.apply_id+"'>查看</a></div>";
		if(userType==2&&userIdentity==1&&status==2){
			//民警
			return auditTpl;
		}else if(userType==4&&status==1){
			//网格员
			return auditTpl;
		}else{
			return showTpl;
		}
		
	}
	
	function operUnFormat( cellvalue, options, cell){
		return "";
	}
	
	$("#btn_search").click(function(e){
		e.preventDefault();
		var grid = $('#jqGrid');
		
		var f = {
				groupOp : "AND",
				rules : [],
				groups:[{
					groupOp : "OR",
					rules : [],
				}]
			};
		f.rules.push({ field: "b.type", op: $('#type_query').val() == -1 ? "ne" : "eq", data: $('#type_query').val() });
		f.rules.push({ field: "a.status", op: $('#status_query').val() == -1 ? "ne" : "eq", data: $('#status_query').val() });
		f.rules.push({ field: "b.gender", op: $('#gender_query').val() == -1 ? "ne" : "eq", data: $('#gender_query').val() });
		
		f.groups[0].rules.push({ field: "name", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "cuser", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "idcard", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "addr", op: "cn", data: $('#key_query').val().trim() });
		/* f.groups[0].rules.push({ field: "b.age", op: "eq", data: $('#key_query').val().trim() }); */
		
		
		grid.jqGrid('setGridParam', { search: false });
	  	var postData = grid.jqGrid('getGridParam', 'postData');
		    
	     $.extend(postData, { filters:JSON.stringify(f)});
		grid.jqGrid('setGridParam', { search: true });
	    grid.jqGrid().trigger('reloadGrid', [{ page: 1}]);
		
	    
 	    var type_query = $('#type_query').val();
		var status_query = $('#status_query').val();
		var gender_query = $('#gender_query').val();
		var key_query = $('#key_query').val().trim();
		
		key_query = escape(key_query);
		
		setCookie("type_query1", type_query, 0.1);
		setCookie("status_query1", status_query, 0.1);
		setCookie("gender_query1", gender_query, 0.1);
		setCookie("key_query1", key_query, 0.1);
		
		
	});
	//再显示查询条件  
if(!(!!window.ActiveXObject || "ActiveXObject" in window))	
	{
			var type_query = getCookie('type_query1');
			var status_query = getCookie('status_query1');
			var gender_query = getCookie('gender_query1');
			var key_query = getCookie('key_query1');

			//cookie中文编码问题 
			key_query = unescape(key_query);
			
			if (type_query == "0" || type_query == "1" || type_query == "3"
					|| type_query == "4" || type_query == "5"
					|| type_query == "6")
				$('#type_query').val(type_query);
			else
				$('#type_query').val("-1");
			if (status_query == "1" || status_query == "2"
					|| status_query == "3" || status_query == "4"
					|| status_query == "5" || status_query == "6"
					|| status_query == "7" || status_query == "8")
				$('#status_query').val(status_query);
			else
				$('#status_query').val("-1");
			if (gender_query == "0" || gender_query == "1")
				$('#gender_query').val(gender_query);
			else
				$('#gender_query').val("-1");

			if(key_query != "" || key_query!= null || key_query!= undefined)
				$('#key_query').val(key_query);
		} 

	});
</script>
<!-- END BODY -->

</html>