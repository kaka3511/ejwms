<%@page import="java.util.ArrayList"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统设置-监控设备管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet"
	href="<c:url value='/plugins/font-awesome-master/css/font-awesome.min.css'/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value='/plugins/summernote-develop/dist/summernote.css'/>"
	type="text/css" />
<%@ include file="../../base/importJs.jsp"%>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<%
		String oper = (String) request.getAttribute("oper");
	%>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>内容管理</li>
		<li>通知发布</li>
	</ul>

	<div class="panel panel-info">
		<div class="panel-heading">发布通知</div>
		<div class="panel-body">
			<form class="form-horizontal ">

				<div class="form-group">
					<label class="col-sm-2 control-label">通知内容：</label>
					<div class="col-sm-6">
						<textarea rows="4" class='form-control' name='content' id='ta_content'></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">选择用户：</label>
					<div class="col-sm-6">
						<div style="margin-bottom: 10px;" id='btn_user_choose'>
							<label class='radio-inline'> 
								<input type="radio" data-target='#user_all' data-toggle="tab" name="r_user_choose" checked="checked" id='r_user_all' value='1'>所有用户
							</label>
							<label class='radio-inline'> 
								<input type="radio" data-target='#user_group' data-toggle="tab" name="r_user_choose" value='2'>分组用户
							</label>
							<label class='radio-inline'> 
								<input type="radio" data-target='#user_member' data-toggle="tab" name="r_user_choose" value='3'>特定用户
							</label>
						
						</div>
								

						<!-- Tab panes -->
				  		<div class="tab-content">
							<div class="tab-pane active fade in" id="user_all"></div>
							<div class="tab-pane fade" id="user_group">
	
								<label class='checkbox-inline'> <input type="checkbox" 
									name='notifyRole' value='2'>民警
								</label> <label class='checkbox-inline'> <input type="checkbox"
									name='notifyRole' value='3'>群干
								</label> <label class='checkbox-inline'> <input type="checkbox"
									name='notifyRole' value='4'>网格员
								</label> <label class='checkbox-inline'> <input type="checkbox"
									name='notifyRole' value='1'>普通居民
								</label>
							</div>
							<div class="tab-pane fade" id="user_member">
								<input type="text" id='i_members' class='form-control' >
								<button class='btn btn-primary' data-toggle='modal' data-target ='#myModal'>添加用户</button>
							</div>
						</div>
						

					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button class="btn btn-primary" id='btn_form_confirm'>发布</button>

						<button class="btn btn-success back"
							onclick="javascript:window.history.back(-1);return false;">返回</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"> 选择通知用户</h4>
      </div>
      <div class="modal-body">
        	<div class='center-block' style='width:800px;'>
	      		<div style='width:800px;margin-bottom: 10px;'>
	      			<form class='form-inline' action="">
		   						<div class='form-group'>
									    <label>姓名：</label>
									    <input class='form-control' type='text' id='query_keeper'>
		   						</div>
		   						
		   						<div class='form-group'>
									    <label>手机号：</label>
									    <input class='form-control' type='text' id='query_cellphone'>
		   						</div>
					   
		   					</form>
	      		</div>
	      			<table id="jqGrid"></table>
					<div id="jqGridPager"></div>
	      		
	      	</div>
      </div>
      <div class="modal-footer">
        
        <!-- <button type="button" class="btn btn-primary" id='btn_modal_confirm'>确定</button>
        <button type="button" class="btn btn-success" data-dismiss="modal">取消</button> -->
      </div>
    </div>
  </div>
</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
	$(function() {
		var oper = "<%=oper%>";
		
		$('form').submit(function(){
			return false;
		});
		
		
		$('#i_members').tagsinput({
			  tagClass: function(item) {
			    return 'label label-primary';
			  },
			  itemValue: 'id',
			  itemText: 'name',
			  freeInput:false,
			  onTagExists: function(item, $tag) {
				    
				  }
			});

		$('#i_members').on('itemRemoved', function(event) {

			if(event.options==undefined)
				$('#jqGrid').setSelection(event.item.id,false);
			}); 
		
		
		$('label input[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			  var target = e.target // newly activated tab
			  var relatedTarget = e.relatedTarget // previous active tab
			  
			  $(relatedTarget).prop('checked',false);
			  $(target).prop('checked',true);
		});
		
		$("#jqGrid").jqGrid({
	        url:"<c:url value='/notify/listUser'/>",
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
					label : '姓名',
	                name: 'name',
	            },
	            {
					label: '手机号',
	                name: 'cellphone',
	            },
	            {
					label: '角色',
	                name: 'type',
	                formatter:'select', 
	                editoptions:{value:"1:居民;2:民警;3:群干;4:网格员;5:医生"},
	            },
	            {
					label: '身份',
	                name: 'useridentity',
	                formatter:function(cellvalue,option,rowObject){
	                	var type = rowObject.type;
		                switch (type) {
						case 1:
							switch (cellvalue) {
							case 1:
								return '游客';
								break;
							case 2:
								return '访客';				
								break;
							case 3:
								return '业主';
								break;
							case 4:
								return '租客';
								break;
							default:
								return "";
							}
							break;
						case 2:
							switch (cellvalue) {
							case 1:
								return '警务室民警';
								break;
							case 2:
								return '派出所民警';				
								break;
							case 3:
								return '分局民警';
								break;
							default:
								return "";
							}					
							break;
						case 3:
							return '群干';
							break;
						case 4:
							return '网格员';
							break;
						case 5:
							return '医生';
							break;
						default:
							return "";
						}
	                }
	                
	            },
	            {
					label: '状态',
	                name: 'status',
	                formatter:'select', 
	                editoptions:{value:"1:未认证;2:资料审核中;3:已认证;4:认证失败"},
	            },
	            {
					label: '积分',
	                name: 'points',
	            
	            } 
	            	,
            	 {
					label: '注册时间',
	                name: 'createtime',
	            
	            } 
	        ],
	        onSelectRow:function(rowid, status, e){
	        	if(status){
	        		var row = $('#jqGrid').getRowData(rowid);
					 $('#i_members').tagsinput('add', row,{status:status});
	        	}else{
	        		var row = $('#jqGrid').getRowData(rowid);
					 $('#i_members').tagsinput('remove', row,{status:status});
	        	}
	        	
            },
            onSelectAll:function(rowids, status){
	        	if(status){
	        		$.each(rowids,function(i,id){
	        			var row = $('#jqGrid').getRowData(id);
						 $('#i_members').tagsinput('add', row,{status:status});
	        		});
	        		
	        	}else{
	        		$.each(rowids,function(i,id){
	        			var row = $('#jqGrid').getRowData(id);
						 $('#i_members').tagsinput('remove', row,{status:status});
	        		});
	        		
	        	}
	        	
            },
            gridComplete:function(){
            	var items = $('#i_members').tagsinput('items');
            	$.each(items,function(i,item){
            		$('#jqGrid').setSelection(item.id,false);
            	});
            	
            	
            },
            deselectAfterSort:false,
	         loadonce: true,
	 		viewrecords: true,
	         height: 400,
	         width:800,
	         //shrinkToFit:true,
	         autowidth:false,
	         multiselect:true,
	         rownumbers:true,
	         rownumWidth:50,
	         
	         rowNum: 10,
	         pager: "#jqGridPager",
	    });
		var f = { groupOp: "AND", rules: [] };
		var timer;
	     $('#query_keeper').keyup(function(){
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
	     $('#query_cellphone').keyup(function(){
	 		var self = this;
	 		var value = self.value;
	 		var grid = $('#jqGrid');
	      	var field = "cellphone";
	      	var op = "cn";
	      	
	 		if(timer1) { clearTimeout(timer1); }
	 		timer1 = setTimeout(function(){
	 			//timer = null;
	 			filter(f,grid,field,op,value);
	 		},0);
	      	
	      }); 
		
	     /*  $('#btn_modal_confirm').click(function(e) {
				e.preventDefault();

				var ids = $('#jqGrid').getGridParam('selarrrow');
				$.each(ids,function(i,v){
					 var row = $('#jqGrid').getRowData(v);
					 $('#i_members').tagsinput('add', row);
				});
				$('#myModal').modal('hide');
				
			}); */
	      
		$('#btn_form_confirm').click(function(e) {
			e.preventDefault();
			
			
			
			var userChoose  = $("#btn_user_choose input:checked").val();
			var roleSelected = [];
			var userSelected;
			
			switch (userChoose) {
			case '1':
				
				break;
			case '2':
				$.each($("#user_group input:checked"),function(i,v){
					roleSelected.push($(v).val());
				});		
				if(roleSelected.length==0){
					alert("请选择要发送的角色对象！");
					return ;
				}
				break;
			case '3':
				userSelected = $('#i_members').val();
				break;
			}
			
			$.ajax({
				type : "post",//不写此参数默认为get方式提交
				async : true, //设置为异步
				url : "/ejwms/notify/mgr",//请求的uri
				contentType:'application/json',
				data : JSON.stringify({
					oper:'add',
					content:$('#ta_content').val(),
					userChoose:userChoose,
					roleSelected:roleSelected,
					userSelected:userSelected
				}),
				processData : false,
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					if(data.code==0){
						alert("操作成功!");
						window.location.href = "/ejwms/notify/index";
					}else{
						alert('消息发送失败，请稍后再试!');
					}
					
				},
				error : function() {
					alert('系统出现异常，请稍后再试!');
				}
			});

		});
	});
</script>
</html>