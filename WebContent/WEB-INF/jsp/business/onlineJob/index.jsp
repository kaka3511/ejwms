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
                  <li>网上办事</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
		   					<form class='form-inline' action="">
		   						<div class='form-group'>
		   							<label>审核状态：</label>
								    <select class='form-control' id="status_query" value="${status_query }">
			   							 <option value="-1" selected="selected">全部</option>
			   							 <option value="1" >社区群干复核</option>
								    	<option value="2" >社区民警审核</option>
								    	<option value="7" >派出所审核</option>
								    	<option value="8" >分局审核</option>
								    </select>
		   						</div> 
		   						<div class="form-group">
									<label >类型：</label>
								    <select class='form-control' id="type_query" value="${type_query }">
								   		 <option value="-1" >全部</option>
								    	<c:forEach items="${pupilTypeList }" var="item">
											<option value="${item.dictionary_code }">${item.dictionary_name }</option>
											
										</c:forEach>
								    </select>
								</div>
							<div class="form-group">
								<label>关键词：</label>
							    <input class='form-control' type="text" id = 'key_query' value="${key_query }">
							</div>
							
							<div class='form-group'>
									<button id="btn_search" class="btn btn-success">搜索</button>
								</div>
					   			<a class='btn btn-primary edit' href='downloadWordfileFTL' style="position: absolute; right: 1%;"/>模版下载</a>
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
	var currentOnlineJobPage = getOneSessionStorageValue("currentOnlineJobPage");
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$("#jqGrid").jqGrid({
        url:"<c:url value='/onlineJob/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        datatype: "json",
        mtype: 'POST',
        page: currentOnlineJobPage,
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
				label: '类型',
                name: 'type',
                formatter:'select', 
                editoptions:{value:'<c:forEach items="${pupilTypeList }" var="item">${item.dictionary_code }:${item.dictionary_name };</c:forEach>'},
            },
            {
				label : '社区',
                name: 'pupil_community',
            },
            {
				label: '病情描述',
                name: 'description',
            },
            {
				label : '状态',
                name: 'audit_status',
                formatter:'select', 
                editoptions:{value:"0:已提交;1:社区复核;2:社区民警审核;11:入院;4:社区驳回;5:社区民警驳回;6:出院;7:派出所审核;8:分局审核;9:派出所驳回;10:分局驳回;3:确认收治"},
            },
            {
				label: '申请时间',
                name: 'createtime',
                width:120,
                search:false,
                formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
                
            },
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
		height:$(window).height()-$('.panel-body').offset().top-80,
        shrinkToFit :true,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
		        
	function operFormat( cellvalue, options, rowObject ){
		var userType = ${cuser.usertype};
		var userIdentity = ${cuser.userIdentity};
		var currentOnlineJobPage = $(this).jqGrid('getGridParam','page');
		sessionStorage.setItem("currentOnlineJobPage", currentOnlineJobPage); 
		
		//var auditTpl = "<div><a class='btn btn-primary edit'  href='<c:url value='/onlineJob/view/?oper=show&id='/>"+rowObject.apply_id+"'>查看</a><a class='btn btn-primary edit'  href='<c:url value='/onlineJob/view/?oper=edit&id='/>"+rowObject.apply_id+"'>审核</a><a class='btn btn-primary edit' target='view_window'  href='<c:url value='/onlineJob/downloadWordfile/?id='/>"+rowObject.apply_id+"'>下载Word</a></div>";
		var auditTpl = "<div><a class='btn btn-primary edit'  href='<c:url value='/onlineJob/view/?oper=edit&id='/>"+rowObject.apply_id+"'>审核</a><a class='btn btn-primary edit' target='view_window'  href='<c:url value='/onlineJob/downloadWordfile/?id='/>"+rowObject.apply_id+"'>下载</a></div>";
		var showTpl = "<div><a class='btn btn-primary edit'  href='<c:url value='/onlineJob/view/?oper=show&id='/>"+rowObject.apply_id+"'>查看</a><a class='btn btn-primary edit' target='view_window'  href='<c:url value='/onlineJob/downloadWordfile/?id='/>"+rowObject.apply_id+"'>下载</a></div>";
		
		if(userType==3){
			//群干、
			if(rowObject.audit_status==1){
				return auditTpl;
			} else{
				return showTpl;
			}
		}else if(userType==5){
			//医生
			if(rowObject.audit_status==11||rowObject.audit_status==3){
				return auditTpl;
			} else{
				return showTpl;
			}
			
		}else if(userType == 2){
			//民警
			if(userIdentity==1&&rowObject.audit_status==2){
				return auditTpl;
			}else if(userIdentity==2&&rowObject.audit_status==7){
				return auditTpl;
			}else if(userIdentity==3&&rowObject.audit_status==8){
				return auditTpl;
			}else{
				return showTpl;
			}
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
		f.rules.push({ field: "type", op: $('#type_query').val() == -1 ? "ne" : "eq", data: $('#type_query').val() });
		f.rules.push({ field: "a.status", op: $('#status_query').val() == -1 ? "ne" : "eq", data: $('#status_query').val() });
		
		f.groups[0].rules.push({ field: "b.name", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "cuser", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "c.name", op: "cn", data: $('#key_query').val().trim() });
		f.groups[0].rules.push({ field: "a.description", op: "cn", data: $('#key_query').val().trim() });
		
		
		grid.jqGrid('setGridParam', { search: false });
	  	var postData = grid.jqGrid('getGridParam', 'postData');
		    
	     $.extend(postData, { filters:JSON.stringify(f)});
		grid.jqGrid('setGridParam', { search: true });
	    grid.jqGrid().trigger('reloadGrid', [{ page: 1}]);
		
	    if(!(!!window.ActiveXObject || "ActiveXObject" in window))	{
	    	
	    var type_query = $('#type_query').val();
		var status_query = $('#status_query').val();
		var key_query = $('#key_query').val().trim();
		
		key_query = escape(key_query);
		
		setCookie("type_query2", type_query, 0.1);
		setCookie("status_query2", status_query, 0.1);
		setCookie("key_query2", key_query, 0.1);
	    }
	    
	    
		
	});
	
//再显示查询条件  
if(!(!!window.ActiveXObject || "ActiveXObject" in window))	
	{
			var type_query = getCookie('type_query2');
			var status_query = getCookie('status_query2');
			var key_query = getCookie('key_query2');

			//cookie中文编码问题 
			key_query = unescape(key_query);
			
			if (type_query == "0" || type_query == "1" || type_query == "3"
					|| type_query == "4" || type_query == "5"
					|| type_query == "6")
				$('#type_query').val(type_query);
			else
				$('#type_query').val("-1");
			if (status_query == "1" || status_query == "2"
					|| status_query == "7" || status_query == "8")
				$('#status_query').val(status_query);
			else
				$('#status_query').val("-1");

			if(key_query != "" || key_query!= null || key_query!= undefined)
				$('#key_query').val(key_query);
		}

    
    
    
});
</script>
<!-- END BODY -->

</html>