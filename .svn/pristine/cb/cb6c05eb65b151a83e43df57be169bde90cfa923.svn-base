<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统设置-监控设备管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
<%@ include file="../base/taglib.jsp"%>
<%@ include file="../base/importCss.jsp"%>
<!-- END PAGE LEVEL STYLES -->
<style type="text/css">
.help-block {
	color: red;
	float: left;
	position: relative;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
<%@ include file="../base/importJs.jsp"%>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>系统设置</li>
		<li>站点管理</li>
	</ul>
	<div class="panel panel-info">
		<div class="panel-heading">
      		站点类型：<select class="selectpicker entityType">
  				     	<option value="">请选择</option>
  				 		<option value="1">警察室</option>
						<option value="2">保安站</option>
						<option value="3">物业</option>
  					 </select>  &nbsp;&nbsp;
  			<button class="btn btn-primary query">查询</button>
  			<button class="btn btn-success pull-right addEntityBtn">新增站点</button>
		</div>
		<div class="panel-body">
			<table class="table table-bordered table-striped table-hover entity_table">
				<thead>
					<tr>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">序号</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">类型</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">站点名称</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 15%;">地址</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">电话</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 20%;">描述</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">新增日期</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">修改日期</th>
						<th class="text-center" style="background: #3499db; color: #ffffff; width: 15%;">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 设备对话框 -->
	<div class="modal fade modalArea" id="entityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="entityLabel"></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal entityform" role="form">
						<div class="form-group">
							<label class="col-sm-2 control-label">站点名称</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="name" name="name"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">站点类型</label>
							<div class="col-sm-6">
							<select class="form-control col-sm-6" id="type" name="type">
								<option value="1">警察室</option>
								<option value="2">保安站</option>
								<option value="3">物业</option>
							</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">电话</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="telephone" name="telephone"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">地址</label>
							<div class="col-sm-10"><input type="text" class="form-control col-sm-6" id="address" name="address"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">图片</label>
							<div class="col-sm-10">
							<img alt="" src="" width=200 height=100 id="communityImg" class="hidden">
							<input type="file" id="uploadImg" class="form-control" name="uploadImg"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="4" placeholder="描述不超过500位(汉字占2位)" id="description" name="description"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="entity_summit">提交</button>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
var operationType = 0;
var aData= null;
$(function() {
	$(".entity_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 10,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bFilter": false,
		"bDeferRender": true,
		"bAutoWidth" : true, //是否自适应宽度  
		ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/entityManage/entityList.do",
			dataType: "json",
			dataSrc: "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
			data:function(d){
				var p={};
				p.entityStatus = $('.entityStatus').val();
				p.entityType = $('.entityType').val();
				return p;
			}
	    } ,
	    "columnDefs": [ {
            "searchable": false,
            "orderable": false,
            "targets": 0
        } ],
	    "order": [[ 7, 'desc' ]],
	    showRowNumber:true,
	    columns: [//对应上面thead里面的序列
	              {  data: "xh", "sClass" : "text-center" },
	              { data: function (e) {
	            	  	var sContent = '';
	              		if(e.type=="1"){
	              			sContent = "警察室";
	              		}else if(e.type=="2"){
	              			sContent = "保安站";
	              		}else if(e.type=="3"){
	              			sContent = "物业";
	              		}else{
	              			sContent = "未知";
	              		}
	                    return sContent;
	            	  }, "sClass" : "text-center" },
	              { data: "name", "sClass" : "text-center" },
	              { data: "address", "sClass" : "text-center" },
	              { data: "telephone", "sClass" : "text-center" },
	              { data: "description", "sClass" : "text-center" },
	              { data: "createtime", "sClass" : "text-center" },
	              { data: "updatetime", "sClass" : "text-center" },
	              { data: function (e) {//这里给最后一列返回一个操作列表
	                    //e是得到的json数组中的一个item ，可以用于控制标签的属性。
	                    var sContent = '<button class="btn btn-primary modify">修改</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-primary" href="/ejwms/entityManage/entityMapManage/'+e.id+'">配置位置</a>&nbsp;&nbsp;&nbsp;<button class="btn btn-primary delete">删除</button>';
	                    return sContent;
	                }, "sClass" : "text-center"
	              }
	    ] ,
	    initComplete: function (setting, json) {
	        //初始化完成之后替换原先的搜索框。
	        //本来想把form标签放到hidden_filter 里面，因为事件绑定的缘故，还是拿出来。
	       // $(tablePrefix+"_filter").html("<form id='filter_form'>" + $("#hidden_filter").html() + "</form>");
	    },
	    language: {
	        lengthMenu: '<select class="form-control input-xsmall">' + '<option value="5">5</option>' + '<option value="10">10</option>' + '<option value="20">20</option>' + '<option value="30">30</option>' + '<option value="40">40</option>' + '<option value="50">50</option>' + '</select>条记录',//左上角的分页大小显示。
	        processing: "载入中",//处理页面数据的时候的显示
	        paginate: {//分页的样式文本内容。
	            previous: "上一页",
	            next: "下一页",
	            first: "第一页",
	            last: "最后一页"
	         },
	         zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
	         //下面三者构成了总体的左下角的内容。
	         info: "总共_PAGES_页，显示第_START_到第 _END_条 ",//左下角的信息显示，大写的词为关键字。
	         infoEmpty: "0条记录",//筛选为空时左下角的显示。
	         infoFiltered: ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
	    } 
	});   
/* 	$(".entity_table").DataTable().on( 'order.dt search.dt draw.dt', function () {
		 $(".entity_table").DataTable().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
		 	cell.innerHTML = i+1;} );} ).draw(); */
});

//查询
$(document).on('click','.query',function(){
	$(".entity_table").dataTable().fnReloadAjax();  //刷新datatables
});

//添加设备对话框
$(document).on('click','.addEntityBtn',function(){
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	operationType = 1;
	$('#communityImg').addClass("hidden");
	$('#type').selectpicker('refresh');
	$('#entityLabel').html("添加站点");
	$('#entityModal').modal('show');
});

//新增设备提交
$("#entity_summit").click(function () {
	var id = "";
	if(operationType != 1){
		id = aData.id;
	}
	if($(".entityform").valid()){
		var szFileName = $("#uploadImg").val();
		if(szFileName!=null&&szFileName!=""){
			szFileName = szFileName.replace(/(^\s*)|(\s*$)/g, "");
			var hzm = szFileName.substr(szFileName.length - 3).toLowerCase();
			if (hzm != "jpg"&&hzm!="png"&&hzm!="bmp"&&hzm!="jpeg") {
				alert("请上传jpg,png,bmp,jpeg格式的图片!");
				return false;
			}
		}
		$.ajaxFileUpload( {
			url : "/ejwms/entityManage/saveEntity.do",//请求的uri
			type:"POST",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				secureuri : false,//安全协议  
				dataType : 'text',  
				fileElementId:'uploadImg',
	      		data : {
	      			name:$('#name').val(),
	      			type:$('#type').val(),
	      			address:$('#address').val(),
	      			telephone:$('#telephone').val(),
	      			description:$('#description').val(),
	      			id:id},//传递到后台的参数				
	      		success : function(data) {
	      			$('.entityform')[0].reset();
	      			/* $(".entity_table").dataTable().fnReloadAjax(); */
	      			$(".entity_table").DataTable().ajax.reload(null,false);
					$('#entityModal').modal('hide');
					alert("操作成功!");
	      	},error: function () {
				alert('系统出现异常，请稍后再试!');
	        }}); 
	  	}
});

//修改设备
$(document).on('click','.modify',function(){//修改方案
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	operationType = 2;
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	$('#entityLabel').html("修改站点");
	$('#name').val(aData.name);
	$('#type').val(aData.type);
	$('#address').val(aData.address);
	$('#telephone').val(aData.telephone);
	$('#description').val(aData.description);
	$('#communityImg').attr("src",aData.img);
	$('#communityImg').removeClass("hidden");
	$('#type').selectpicker('refresh');
	$('#entityModal').modal('show');
});

/* //修改设备
$(document).on('click','.setLocation',function(){
	$('#mapModal').modal('show');
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	var map = new AMap.Map('mapContainer');
}); */

//删除设备
$(document).on('click','.delete',function(){
	if (confirm("你确定要删除该站点吗?"))  {  
		aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
		$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/entityManage/deleteEntity.do",//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				/* dataType : 'json',//后台返回前台的数据格式为json */
				success : function(data) {
					$(".entity_table").dataTable().fnReloadAjax();
					alert("删除成功");
		},error: function () {
				alert('系统出现异常，请稍后再试!'); 
        }}); 
	}
});

//设备对话框校验
$(function(){
    $(".entityform").validate({  
  	  errorElement: 'em', 
		  errorClass: 'help-block',
		  focusInvalid: false,   
        rules:{
      	  	name:{
                required:true,
                byteRangeLength:[0,100]
            },
            telephone:{
            	phonecheck:true
            },
            address:{
            	byteRangeLength:[0,500]
            },
            description:{
            	byteRangeLength:[0,500]
            }
        },
        messages:{
        	name:{
                required:"必填",
                byteRangeLength:"名称不超过100位(汉字占2位)"
            },
            telephone:{
            	phonecheck:"电话号码格式不正确"
            },
            address:{
            	byteRangeLength:"地址不超过500位(汉字占2位)"
            },
            description:{
            	byteRangeLength:"描述不超过500位(汉字占2位)"
            }           
        }       
    });
    jQuery.validator.addMethod("phonecheck", function(value, element) {      
	      return this.optional(element) || /0\d{2,3}\d{5,9}|0\d{2,3}-\d{5,9}/.test(value) || /^1[3|4|5|8][0-9]\d{8}$/.test(value);      
	  }, "联系电话格式不正确");
    jQuery.validator.addMethod("SerialCheck", function(value, element) {      
	      return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);      
	  }, "");
    // usernamecheck 用户名校验
     jQuery.validator.addMethod("usernamecheck", function(value, element) {      
	      return this.optional(element) || /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(value);      
	  }, "必须为字母、数字或下划线，不能以数字开头");
    //passwordcheck 密码校验
    jQuery.validator.addMethod("passwordcheck", function(value, element) {      
	      return this.optional(element) || /^(?![a-z]+$)(?![A-Z]+$)(?![0-9]+$)[0-9a-zA-Z\W]\S{6,18}$/.test(value);      
	  }, "密码应包含字母、数字、符号中的至少2种");
    //中文两个字节
    jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {      
    	var length = value.length;      
  	for(var i = 0; i < value.length; i++){      
      if(value.charCodeAt(i) > 127){      
      length++;      
      }      
    	}      
  	return this.optional(element) || ( length >= param[0] && length <= param[1] );      
		}, "不得多余16字");
});
</script>
</html>