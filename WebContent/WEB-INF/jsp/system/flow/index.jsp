<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>流程配置</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
	<%@ include file="../../base/taglib.jsp"%>
	<%@ include file="../../base/importCss.jsp"%>
	<!-- END PAGE LEVEL STYLES -->
	<style type="text/css">
	.help-block {
		color: red;
		float: left;
		position: relative;
	}
	.jstree-organize-icon {
	    background-image: url(../images/organize.png) !important;
	}
	</style>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
	<%@ include file="../../base/importJs.jsp"%>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.min.css'/>" />
	<script type="text/javascript" src="<c:url value='/js/jstree.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/page.js'/>"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
    <li>
	   <i class="icon-cog"></i>系统管理
    </li>
    <li>流程配置</li>
</ul>
<div class="panel panel-info" style="position: relative;">
   	<div class="panel-heading" style='overflow: hidden;height: 50px;'>
		流程配置
   	</div>
   	<div class="panel-body row" style="margin-top:14px;">
	   	<div class="col-md-12 col-md-6">
			<button class="btn btn-primary add addEntityBtn"  style="float:right; right: 30px; top: 12px;">添加</button>
	   		<table id="account_table" class="table table-bordered table-striped table-hover">
	            <thead>
	                <tr style="background: #F5F5F5;">
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">序号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">名称</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">操作</th>
	                </tr>
	            </thead>
	        </table>
        </div>
		<div class="col-md-12 col-md-6 pull-right">
			<button class="btn btn-primary add addEntityBtn2"  style="float:right; right: 30px; top: 12px;">添加</button>
			<table id="account_table2" class="table table-bordered table-striped table-hover">
	            <thead>
	                <tr style="background: #F5F5F5;">
	                    <th class="text-center" style="background: #3499db;color: #ffffff;" hidden="hidden"></th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">序号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">名称</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">操作</th>
	                </tr>
	            </thead>
	        </table>
		</div>
   	</div>
</div>

<!-- 添加流程 -->
<div class="modal fade" id="entityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
		<div class="modal-content">
			 <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"></h4>
			 </div>
			 <div class="modal-body">
				<form class="addtable addform flowform">
					<div class="form-group">
						<div class="input-group" style="width: 100%;">
							<label class="input-group-addon" style="width: 100px;">名称：</label>
							<select class="chooserole form-control" name="addFlowName" id="addFlowName"
							style="width: 100%;">
							</select>
						</div>
					</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" 
					   data-dismiss="modal" onclick="javascript:$('.addform').validate().resetForm();$('.addform')[0].reset();">关闭
					</button>
					<button type="button" class="btn btn-primary addchild" id="param_summit1">
															添加
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 添加节点 -->
<div class="modal fade" id="entityModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title"></h4>
		 </div>
         <div class="modal-body">
			<form class="addtable addform2 flowform">
				<div class="form-group" style="display:none;">
					<div class="input-group" style="width: 100%;">
						<label class="input-group-addon" style="width: 100px;"></label>
						<input class="_account form-control flow_id" id="node_id" name="node_id"
							style="width: 100%;" />
					</div>
				</div>
				<div class="form-group">
					<div class="input-group" style="width: 100%;">
						<label class="input-group-addon" style="width: 100px;">名称：</label>
						<select class="chooserole form-control status" id="node_name" name="node_name"
							style="width: 100%;"/>
						</select>
					</div>
				</div>
			</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" 
				   data-dismiss="modal" onclick="javascript:$('.addform2').validate().resetForm();$('.addform2')[0].reset();">关闭
				</button>
				<button type="button" class="btn btn-primary addchild" id="param_summit2">
														保存
				</button>
			</div>
        </div>
    </div>
    </div>
</div>

<!-- 人员 列表-->
<div class="modal fade" id="personModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			 <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"></h4>
			 </div>
		
			 <div class="modal-body">
				<table id="likeUserTables" class="table table-bordered table-striped table-hover like_table " style="border:solid 1px #D7D7D7; border-radius:5px 5px 0px 0px;" >
					<thead>
						<tr style="background: #F5F5F5;">
							<th class="text-center" style="background: #3499db;color: #ffffff; width: 8%;">序号</th>
							<th class="text-center" style="background: #3499db;color: #ffffff; width: 15%;">姓名</th>
							<th class="text-center" style="background: #3499db;color: #ffffff; ">职务</th>
							<th class="text-center" style="background: #3499db;color: #ffffff; width: 10%;">性别</th>
							<th class="text-center" style="background: #3499db;color: #ffffff; width: 25%;">所属区域</th>
							<th class="text-center" style="background: #3499db;color: #ffffff; width: 10%;">操作</th> 
						</tr>
					</thead>
				</table>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" 
					   data-dismiss="modal">关闭
					</button>
				</div>
			</div>
		</div>
    </div>
</div>
<!--人员添加-->
<div class="modal fade" id="addpersonModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			 <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"></h4>
			 </div>
			 <div class="modal-body">
				<form class="addtable addform3 flowform">
					<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">用户列表</label>
								<select class="chooserole form-control " name="user" id="user"
									style="width: 100%;">
								</select>
							</div>
						</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" 
					   data-dismiss="modal" onclick="javascript:$('.addform3').validate().resetForm();$('.addform3')[0].reset();$('#personModal').modal('show');">关闭
					</button>
				</div>
			</div>
		</div>
    </div>
</div>
</body>
<script type="text/javascript">
$(function() {
	//流程列表
	$("#account_table").dataTable(
		{
			serverSide : false, //分页，取数据等等的都放到服务端去
			processing : true, //载入数据的时候是否显示“载入中”
			pageLength : 10, //首次加载的数据条数
			ordering : false, //排序操作
			"bLengthChange" : false,
			"bPaginate" : true, //翻页功能
			"bFilter" : false,
			"bDeferRender" : true,
			destroy: true,
			ajax : {//类似jquery的ajax参数，基本都可以用。
				type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
				url : "/ejwms/flow/list.do",
				dataType : "json",
				dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
				data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
					var p = {};
					p.deptTypeNo = 0;
					p.type=0;
					return p;
				},
			},
			"aoColumnDefs" : [ {
				sDefaultContent : '',
				aTargets : [ '_all' ]
			} ],
			columns : [//对应上面thead里面的序列
			           {
							data : "index",
							"sClass" : "text-center"
						},
						{
							data : "name",
							"sClass" : "text-center"
						},
					{
						data : function(e) {//这里给最后一列返回一个操作列表
							//e是得到的json数组中的一个item ，可以用于控制标签的属性。
							 var sContent = '<button class="btn-primary delete" id="delBtn1">删除</button>';
							 /*  <button class="btn-primary modify">修改</button>&nbsp;&nbsp;&nbsp;*/
							return sContent; 
						},
						"sClass" : "text-center"
					} ],
			initComplete : function(setting, data) {
				/* if(data.total!=null){
					PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
				} */
	
			},
			language : {
				lengthMenu : '<select class="form-control input-xsmall">'
						+ '<option value="5">5</option>'
						+ '<option value="10">10</option>'
						+ '<option value="20">20</option>'
						+ '<option value="30">30</option>'
						+ '<option value="40">40</option>'
						+ '<option value="50">50</option>'
						+ '</select>条记录',//左上角的分页大小显示。
				processing : "载入中",//处理页面数据的时候的显示
				paginate : {//分页的样式文本内容。
					previous : "上一页",
					next : "下一页",
					first : "第一页",
					last : "最后一页"
				},
				search : "关键字查询",
				zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
				//下面三者构成了总体的左下角的内容。
				info : "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
				infoEmpty : "0条记录",//筛选为空时左下角的显示。
				infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
			}
		}
	);

	
	$(document).on('click','#account_table tbody tr',function(){//修改方案	
		var aData = $("#account_table").DataTable().row($(this)).data();
		console.log(aData.child);//传个id到后台
		$("#account_table2").dataTable(
			{
				serverSide : false, //分页，取数据等等的都放到服务端去
				processing : true, //载入数据的时候是否显示“载入中”
				pageLength : 10, //首次加载的数据条数
				ordering : false, //排序操作
				"bLengthChange" : false,
				"bPaginate" : true, //翻页功能
				"bFilter" : false,
				"bDeferRender" : true,
				destroy: true,
				ajax : {//类似jquery的ajax参数，基本都可以用。
					type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
					url : "/ejwms/flowNode/list.do?id="+aData.id,
					dataType : "json",
					dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
					data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
						var p = {};
						p.deptTypeNo = 0;
						p.type=0;
						return p;
					},
					callback: function(){  
				      	
				    }
				},
				"aoColumnDefs" : [ {
					sDefaultContent : '',
					aTargets : [ '_all' ]
				} ],
				columns : [//对应上面thead里面的序列
				        {
							data : "id",
							"sClass" : "hide"
						},
						{
							data : "index",
							"sClass" : "text-center"
						},
						{
							data : "name",
							"sClass" : "text-center"
						},
						{
							data : function(e) {//这里给最后一列返回一个操作列表
								//e是得到的json数组中的一个item ，可以用于控制标签的属性。
								 var sContent = '&nbsp;&nbsp;&nbsp;<button class="btn-primary delete" id="delBtn2" >删除</button>&nbsp;&nbsp;&nbsp;<button class="btn-primary person" >人员</button>';
								 /* <button class="btn-primary modify">修改</button>  */
								return sContent; 
							},
							"sClass" : "text-center"
						} ],
				initComplete : function(setting, data) {
					/* if(data.total!=null){
						PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
					} */
					
						$(document).on('click','#account_table2 .modify',function(){//修改方案	
							var form = $('.addform2');
							form[0].reset();
							form.validate().resetForm();
							aData = $("#account_table2").DataTable().row($(this).parents("tr")).data();
							form.find(".flow_id").val(aData.id).attr("disabled", "disabled");
							form.find(".name").val(aData.name);
							$('#entityModal2 .modal-title').html("流程节点修改");
							$('#entityModal2').modal('show');
						});
						
						//流程节点添加
						$(document).on('click','.addEntityBtn2',function(){
							var form = $('.addform2');
							
							$.ajax( {
								type:"post",//不写此参数默认为get方式提交
								async:false,   //设置为同步
								url : "/ejwms/flowNode/listNodeFromDic.do?id="+aData.id,
								//data :aData.id,//传递到后台的参数				
								cache : false,
								dataType : 'json',//后台返回前台的数据格式为json
								success : function(data) {
									var json = eval(data);
									var $select = $('#node_name');  
									$select.empty();
									$select.append('<option value="">--请选择--</option>'); 
									for(var i=0, len = json.data.length;i<len;i++){  
									/*  $select.append('<option id=u"'+json.data[i].id+'" value="'+json.data[i].id+'">'+json.data[i].name+'</option>');*/  
									  $select.append('<option value='+json.data[i].id+'>'+json.data[i].nodeName+'</option>'); 
									} 
								}
						});
							
							form[0].reset();
							form.find(".name").val("");
						//	$('#personModal').modal('hide');
							$('#entityModal2 .modal-title').html("流程节点添加");
							$('#entityModal2').modal('show');
						});
						
						$(document).on('click','#account_table2 .person',function() {
							aData = $("#account_table2").DataTable().row($(this).parents("tr")).data();//获取id
							$("#likeUserTables").dataTable(
								{
									serverSide : false, //分页，取数据等等的都放到服务端去
									processing : true, //载入数据的时候是否显示“载入中”
									pageLength : 8, //首次加载的数据条数
									ordering : false, //排序操作
									"bLengthChange" : false,
									"bPaginate" : true, //翻页功能
									"bFilter" : true,
									"bDeferRender" : true,
									destroy: true,
									ajax : {//类似jquery的ajax参数，基本都可以用。
										type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
										url : "/ejwms/flowNode/selectAllUser?id=" + aData.id,
										dataType : "json",
										dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
										data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
											var p = {};
											p.deptTypeNo = 0;
											p.type=0;
											return p;
										},
										callback: function(){  
									      	
									    }
									},
									"aoColumnDefs" : [ {
										sDefaultContent : '',
										aTargets : [ '_all' ]
									} ],
									columns : [//对应上面thead里面的序列
											{
												data : "index",
												"sClass" : "text-center"
											},
											{
												data : "name",
												"sClass" : "text-center"
											},
											{
												data : "position",
												"sClass" : "text-center"
											},
											{
												data : function(e) {
													var sContent;
													if(e.gender == 1) {
														 sContent="男";
													} else {
														 sContent="女";
													}
													return sContent;
												},
												"sClass" : "text-center"
											},
											{
												data : "deptName",
												"sClass" : "text-center"
											},
											
											{
												data : function(e) {//这里给最后一列返回一个操作列表
													//e是得到的json数组中的一个item ，可以用于控制标签的属性。
													console.log(e.status);
													var sContent;
													 if(e.status == '1') {
														 sContent= '<button class="btn-success" id="delUserBtn">解除</button>';
													 } else {														 
													 	 sContent = '<button class="btn-primary" id="relUserBtn">关联</button>';
													 }
													
													return sContent; 
												},
												"sClass" : "text-center"
											} ],
									initComplete : function(setting, data) {
										/* if(data.total!=null){
											PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
										} */
										
									},
									language : {
										lengthMenu : '<select class="form-control input-xsmall">'
												+ '<option value="5">5</option>'
												+ '<option value="10">10</option>'
												+ '<option value="20">20</option>'
												+ '<option value="30">30</option>'
												+ '<option value="40">40</option>'
												+ '<option value="50">50</option>'
												+ '</select>条记录',//左上角的分页大小显示。
										processing : "载入中",//处理页面数据的时候的显示
										paginate : {//分页的样式文本内容。
											previous : "上一页",
											next : "下一页",
											first : "第一页",
											last : "最后一页"
										},
										search : "关键字搜索      ",
										zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
										//下面三者构成了总体的左下角的内容。
										info : "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
										infoEmpty : "0条记录",//筛选为空时左下角的显示。
										infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
									}
								}
							);
							$('#personModal .modal-title').html("人员列表");
							$('#personModal').modal('show');
						});
				},
				language : {
					lengthMenu : '<select class="form-control input-xsmall">'
							+ '<option value="5">5</option>'
							+ '<option value="10">10</option>'
							+ '<option value="20">20</option>'
							+ '<option value="30">30</option>'
							+ '<option value="40">40</option>'
							+ '<option value="50">50</option>'
							+ '</select>条记录',//左上角的分页大小显示。
					processing : "载入中",//处理页面数据的时候的显示
					paginate : {//分页的样式文本内容。
						previous : "上一页",
						next : "下一页",
						first : "第一页",
						last : "最后一页"
					},
					search : "关键字查询      ",
					zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
					//下面三者构成了总体的左下角的内容。
					info : "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
					infoEmpty : "0条记录",//筛选为空时左下角的显示。
					infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
				}
			}
		);
	});
	
	//修改设备
	$(document).on('click','#account_table .modify',function(){//修改方案
		var form = $('.addform');
		form[0].reset();
		form.validate().resetForm();
		aData = $("#account_table").DataTable().row($(this).parents("tr")).data();
		form.find(".flow_id").val(aData.id).attr("disabled", "disabled");
		form.find(".name").val(aData.name);
		form.find(".status").val(aData.status);
		$('#entityModal .modal-title').html("流程配置");
		$('#entityModal').modal('show');
		return false;
	});
	
	//转至新增
	$(document).on('click','.addEntityBtn',function(){
		var form = $('.addform');
		
		$.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/flow/listFromDic.do",
			data :'',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				var json = eval(data);
				var $select = $('#addFlowName');  
				$select.empty();
				$select.append('<option value="">--请选择--</option>'); 
				for(var i=0, len = json.data.length;i<len;i++){  
				/*  $select.append('<option id=u"'+json.data[i].id+'" value="'+json.data[i].id+'">'+json.data[i].name+'</option>');*/  
				  $select.append('<option value='+json.data[i].id+'>'+json.data[i].name+'</option>'); 
				} 
			}
	});
		
		form[0].reset();
		form.find(".name").val("");
	//	$('#personModal').modal('hide');
		$('#entityModal .modal-title').html("流程添加");
		$('#entityModal').modal('show');
	});

	//新增提交（左）
	$("#param_summit1").click(function () {
		if($(".addform").valid()){
			$.ajaxFileUpload( {
				url : "/ejwms/flow/save.do",//请求的uri
				type:"POST",//不写此参数默认为get方式提交
					async:false,   //设置为同步
					secureuri : false,//安全协议  
					dataType : 'text',
					fileElementId:'uploadImg',
					data : {
						addFlowName:$('#addFlowName').val(),
						addFlowCode:$('#addFlowCode').val()
					},//传递到后台的参数				
					success : function(data) {
						if(data=='true'){
							$('.addform')[0].reset();
							BootstrapDialog.alert("添加成功");
							$("#account_table").dataTable().fnReloadAjax();
							$('#entityModal').modal('hide');
						} else if(data=='false') {
							$('.addform')[0].reset();
							BootstrapDialog.alert("该流程已添加，无需重复添加");
							$("#account_table").dataTable().fnReloadAjax();
							$('#entityModal').modal('hide');
						}
				},error: function () {
					BootstrapDialog.alert('系统出现异常，请稍后再试!');
				}}); 
			}
	});

	//新增提交（右）
	$("#param_summit2").click(function () {
		if($(".addform").valid()){
			$.ajaxFileUpload( {
				url : "/ejwms/flowNode/save.do", //请求的uri
				type:"POST",//不写此参数默认为get方式提交
					async:false,   //设置为同步
					secureuri : false,//安全协议  
					dataType : 'text',
					fileElementId:'uploadImg',
					data : {
						id:$('#node_name').val()
				/* 		index:$('#flow_node_index').val(),*/
						/* flowId:$('#flow_id').val() */
					},//传递到后台的参数				
					success : function(data) {
						if(data=='true'){
							$('.addform')[0].reset();
							BootstrapDialog.alert("操作成功!");
							$("#account_table2").dataTable().fnReloadAjax();
							$('#entityModal2').modal('hide');
						} else if(data=='false') {
							$('.addform2')[0].reset();
							BootstrapDialog.alert("该节点已添加，无需重复添加");
							$("#account_table2").dataTable().fnReloadAjax();
							$('#entityModal2').modal('hide');
						}
				},error: function () {
					BootstrapDialog.alert('系统出现异常，请稍后再试!');
				}}); 
			}
	});

	//删除（左）
	$(document).on('click','#delBtn1',function(){
		if (confirm("你确定要删除吗?"))  {  
			aData = $("#account_table").DataTable().row($(this).parents("tr")).data();
			$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/flow/delete.do?id=" + aData.id,//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					if(data){
						BootstrapDialog.alert("删除成功!");
						$('.addform')[0].reset();
						$("#account_table").dataTable().fnReloadAjax();
					}else{
						BootstrapDialog.alert('不能删除包含有子节点的流程');
					}
			},error: function () {
				BootstrapDialog.alert('系统出现异常，请稍后再试!');
			}}); 
		}
	});
	
	//删除(右)
	$(document).on('click','#delBtn2',function(){
		if (confirm("你确定要删除吗?"))  {  
			aData = $("#account_table2").DataTable().row($(this).parents("tr")).data();
			$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/flowNode/delete.do?id=" + aData.id,//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					if(data){
						BootstrapDialog.alert("删除成功!");
						$('.addform')[0].reset();
						$("#account_table2").dataTable().fnReloadAjax();
					}else{
						BootstrapDialog.alert('只能删除最后一个流程');
					}
			},error: function () {
				BootstrapDialog.alert('系统出现异常，请稍后再试!');
			}}); 
		}
	});
	
	//删除人员
	$(document).on('click','#delUserBtn',function(){
			aData = $("#likeUserTables").DataTable().row($(this).parents("tr")).data();
			$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/flowNode/deleteUser.do?id=" + aData.id,//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					if(data){
						$('#likeUserTables').DataTable().ajax.reload( null, false );
						/* $("#likeUserTables").dataTable().fnReloadAjax();  */
					}else{
						BootstrapDialog.alert('删除失败!');
					}
			},error: function () {
				BootstrapDialog.alert('系统出现异常，请稍后再试!');
			}}); 
	});
	
	//添加人员
	$(document).on('click','#relUserBtn',function(){
			aData = $("#likeUserTables").DataTable().row($(this).parents("tr")).data();
			$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/flowNode/saveUser.do?id=" + aData.id,//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
						if(data == false) {
							BootstrapDialog.alert('只能关联一个人员');				
						} else {
							$('#likeUserTables').DataTable().ajax.reload( null, false );												
						}
			},error: function () {
				BootstrapDialog.alert('只能关联一个人员');
			}}); 
	});
	

	//添加验证
	$(".addform").validate({  
		errorElement: 'em', 
		errorClass: 'help-block',
		focusInvalid: false,   
		rules:{
			"name":{
				required:true,
				maxlength:20
			}
		},
		messages:{
			"name":{
				required:"必填",
				maxlength:"不超过20位"
			}
		}       
  });
});
</script>


</html>