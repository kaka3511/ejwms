<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>组织结构-人员类型</title>
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
 .jstree-group-icon {
    background-image: url(../images/group.png) !important;
}
.jstree-person-icon {
    background-image: url(../images/person.png) !important;
}
 .jstree-organize-icon {
    background-image: url(../images/organize.png) !important;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
<%@ include file="../base/importJs.jsp"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.min.css'/>" />
<script type="text/javascript" src="<c:url value='/js/jstree.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/page.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>组织架构</li>
		<li>用户管理</li>
	</ul>
	<div class="panel panel-info">
		<div class="panel-heading">
                            							<br/>
							人员管理列表
							<br/>
<!--         <button class="btn btn-success pull-right addEntityBtn">添加</button> -->
     	</div>

		<div class="panel-body">
			<div class="col-md-3" style="overflow: scroll; height: 600px;">
				<div id="tree_part"></div>
			</div>
			<div class="col-md-9">
				<table
					class="table table-bordered table-striped table-hover entity_table">
					<thead>
						<tr style="background: #F5F5F5;">
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">序号</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">姓名</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">手机号</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">职位</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">状态</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">积分</th>
							<th class="text-center"
								style="background: #3499db; color: #ffffff;">注册时间</th>
							 <th class="text-center" style="background: #3499db;color: #ffffff;">操作</th> 
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<!-- 积分变动列表 -->
	<div class="modal fade" id="entityModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 900px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="entityLabel"></h4>
				</div>
				<div class="modal-body">
					<table
						class="table table-bordered table-striped table-hover score_table">
						<thead>
							<tr style="background: #F5F5F5;">
								<th class="text-center"
									style="background: #3499db; color: #ffffff;width:10%">序号</th>
								<th class="text-center"
									style="background: #3499db; color: #ffffff;width:20%">操作时间</th>
								<th class="text-center"
									style="background: #3499db; color: #ffffff;width:10%">分数</th>
								<th class="text-center"
									style="background: #3499db; color: #ffffff;width:20%">积分类型</th>
								<th class="text-center"
									style="background: #3499db; color: #ffffff;width:40%">描述</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
<!-- END BODY -->
<script type="text/javascript">
var aData= null;
$(function() {
	
	$('#tree_part').jstree({
		'core' : {
			"themes" : { "stripes" : true },
			'data' : {
				"url" : "/ejwms/organization/communityAndTypeTree.do",
				"dataType" : "json",
				"data":function(node){
		            return {"id" : 0};
		        }
			}
		}
	}).on("select_node.jstree", function(e, data){
		query(data.node.id,data.node.original.code,data.node.original.role,data.node.original.communityid);
		
	}).on("loaded.jstree", function(){
		$('#tree_part').jstree("open_all");
	});
	
	
	$(".entity_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 12,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bPaginate": true, //翻页功能
		"bFilter": true,
		"bDeferRender": true,
		ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/organization/personnlList.do",
			dataType: "json",
			dataSrc: "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
			data:function(d){
				var p={};
				p.id='0';
				p.code='0';
				p.role='0';
				p.communityid='0';
				return p;
			}
	    } ,
	    "columnDefs": [ {
            "searchable": false,
            "orderable": false,
            "targets": 0
        } ],
	    columns: [//对应上面thead里面的序列
	              {  data: "xh" , "sClass" : "text-center"},
	              {data:"name","sClass":"text-center"},
	              { data: "cellphone", "sClass" : "text-center" },//字段名字和返回的json序列的key对应
	              {data:"position","sClass":"text-center"},
	              /* {data:function(e){
	            	  var statusName= '';
	            	  if(e.type =='1'){
	            		  statusName ="居民";
	            	  }else if(e.type =='2'){
	            		  statusName ="民警";
	            	  }else if(e.type =='3'){
	            		  statusName ="社区群干";
	            	  }else if(e.type =='4'){
	            		  statusName ="网格员";
	            	  }else{
	            		  statusName ="医生";
	            	  }
	            	  return statusName;
	              },"sClass":"text-center"},
	              {data:function(e){
	            	  var statusName= '';
	            	  if(e.type =='1'){
	            		  if(e.useridentity=='1'){
	            			  statusName ="游客";
	            		  }else if(e.useridentity=='2'){
	            			  statusName ="访客";
	            		  }else if(e.useridentity=='3'){
	            			  statusName ="业主";
	            		  }else{
	            			  statusName ="租客";
	            		  }
	            	  }else if(e.type =='2'){
	            		  if(e.useridentity=='1'||e.useridentity=='-1'){
	            			  statusName ="警务室民警";
	            		  }else if(e.useridentity=='2'){
	            			  statusName ="派出所民警";
	            		  }else{
	            			  statusName ="分局民警";
	            		  }
	            	  }else if(e.type =='3'){
	            		  statusName ="群干";
	            	  }else if(e.type =='4'){
	            		  statusName ="网格员";
	            	  }else{
	            		  statusName ="医生";
	            	  }
	            	  return statusName; 
	              },"sClass":"text-center"}, */
	              {data:function(e){
	            	  var statusName= '';
	            	  if(e.status =='1'){
	            		  statusName ="未认证";
	            	  }else if(e.status =='2'){
	            		  statusName ="资料审核中";
	            	  }else if(e.status =='3'){
	            		  statusName ="已认证";
	            	  }else{
	            		  statusName ="认证失败";
	            	  }
	            	  return statusName;
	              },"sClass":"text-center"
	              },
	              {data:function(e){
	            	  var sContent="";
	            	  if(e.points>0){
	            		  sContent='<a href="javascript:;" class="scoreClick" data-toggle="modal" data-target="#myModal" data-backdrop="false">'+e.points+'<a>' ;
	            	  }else{
	            		  sContent=e.points; 
	            	  }
	            	  
	            	  return sContent;
	              },"sClass":"text-center"},
	              {data:"updatetime","sClass":"text-center"},
 	              { data: function (e) {//这里给最后一列返回一个操作列表
 	                    //e是得到的json数组中的一个item ，可以用于控制标签的属性。
 	                    var sContent = '<button class="btn-primary deleteUser" >删除</button>&nbsp;&nbsp;&nbsp;';
 	                    return sContent;
 	                },"sClass":"text-center"
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
	         search: "关键字查询      ",
	         zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
	         //下面三者构成了总体的左下角的内容。
	         info: "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
	         infoEmpty: "0条记录",//筛选为空时左下角的显示。
	         infoFiltered: ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
	    } 
	});   
});

//查询
function query(id,code,role,communityid){
	$(".entity_table").dataTable().fnClearTable();
	  $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/organization/personnlList.do",//请求的uri
			data : {id:id,role:role,code:code,communityid:communityid}, //传递到后台的参数	
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				if(data.data.length){
					$(".entity_table").dataTable().fnAddData(data.data, true);
				}
			}
	}); 

};


//删除设备
$(document).on('click','.deleteUser',function(){
	if (confirm("你确定要删除该用户吗?"))  {  
		aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
		$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/organization/deleteUser.do",//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					$(".entity_table").dataTable().fnReloadAjax();
					var node = $('#tree_part').jstree().get_selected(true)[0];
					if(node)	query(node);
					alert("删除成功");
		},error: function () {
			alert('系统出现异常，请稍后再试!');
        }}); 
	}
});

//添加设备对话框
$(document).on('click','.addEntityBtn',function(){
	if($('#tree_part').jstree().get_selected(true).length == 0){
		  $('#myModal1').modal('hide');
		  alert("请选择一个社区");
		  return;
	  }
	  var node = $('#tree_part').jstree().get_selected(true)[0];
	 if(node.data == "root"){
		  $('#myModal1').modal('hide');
		  alert("请选择一个社区");
		  return;
	  }
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	$('#id').val("");
	$('#type').val("0");
	$('#entityLabel').html("添加");
	$('#entityModal').modal('show');
});

//新增设备提交
$("#entity_summit").click(function () {
	if($(".entityform").valid()){
		$.ajaxFileUpload( {
			url : "/ejwms/organization/saveUserType.do",//请求的uri
			type:"POST",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				secureuri : false,//安全协议  
				dataType : 'text',
	      		data : {
	      			name:$('#name').val(),
	      			code:$("#code").val(),
	      			id:$("#id").val(),
	      			communityid: communityid},//传递到后台的参数				
	      		success : function(data) {
	      			if(data=='true'){
	      				query(node);
		      			$('.entityform')[0].reset();
		      			$(".entity_table").dataTable().fnReloadAjax();
						$('#entityModal').modal('hide');
						alert("操作成功!");
		      			}else{
		      				alert("编码已存在！");
		      			}
	      			
	      	},error: function () {
				alert('系统出现异常，请稍后再试!');
	        }}); 
	  	}
});

//修改设备
$(document).on('click','.modify',function(){//修改方案	
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	$('#name').val(aData.name);
	$('#code').val(aData.code);
	$('#id').val(aData.id);
	$('#type').val("1");
	$('#entityModal').modal('show');
});


$(document).on("click","a[class='scoreClick']",function(){
	$(".score_table").dataTable().fnClearTable();
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	$.ajax( {
		type:"post",//不写此参数默认为get方式提交
		url: "/ejwms/organization/getUserScoreRecordList.do",
		async:false,   //设置为同步
		dataType: "json",
		data:{uid:aData.id},			
		cache : false,
		dataType : 'json',//后台返回前台的数据格式为json
		success : function(data) {
			if(data.data.length){
				$(".score_table").dataTable().fnAddData(data.data, true);
			}
			
		},error: function () {
			alert('获取数据异常!');
		}}); 
	$('#entityLabel').html("用户积分记录");
	$('#entityModal').modal('show');
})

$(".score_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 10,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bPaginate": true, //翻页功能
		"bFilter": true,
		"bDeferRender": true,
	/* 	 ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/organization/getUserScoreRecordList.do",
			async:false,   //设置为同步
			dataType: "json",
			data:{uid:aData.id}
	    } , */
	    "columnDefs": [ {
            "searchable": false,
            "orderable": false,
            "targets": 0
        } ],
	    columns: [//对应上面thead里面的序列
	              { data: "xh" , "sClass" : "text-center"},
	              {data:"createtime","sClass":"text-center"},
	              { data: "points", "sClass" : "text-center" },
	              {data:function(e){
	            	  var statusName= '';
	            	  if(e.type =='0'){
	            		  statusName ="每日签到";
	            	  }else if(e.type =='1'){
	            		  statusName ="健康测评";
	            	  }else if(e.type =='2'){
	            		  statusName ="游戏问题";
	            	  }else if(e.type =='3'){
	            		  statusName ="商品义卖";
	            	  }else if(e.type =='4'){
	            		  statusName ="活动积分捐赠";
	            	  }else if(e.type =='5'){
	            		  statusName ="随手拍";
	            	  }else if(e.type =='6'){
	            		  statusName ="一键报警";
	            	  }else if(e.type =='7'){
	            		  statusName ="活动签到";
	            	  }else if(e.type =='8'){
	            		  statusName ="商品兑换";
	            	  }else if(e.type =='9'){
	            		 statusName ="个人捐赠";
	            	  }else{
	            		  statusName ="民警奖励";
	            	  }
	            	  return statusName;
	              },"sClass":"text-center"},{data:"description","sClass":"text-center"}
	    ] ,
	    initComplete: function (setting, json) {
	       
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
	         search: "关键字查询      ",
	         zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
	         //下面三者构成了总体的左下角的内容。
	         info: "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
	         infoEmpty: "0条记录",//筛选为空时左下角的显示。
	         infoFiltered: ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
	    } 
	}); 
	
//添加验证
$(function(){
  $(".entityform").validate({  
	  errorElement: 'em', 
		  errorClass: 'help-block',
		  focusInvalid: false,   
		  rules:{
	            "name":{
	                required:true,
	                maxlength:100
	            },"code":{
	                required:true,
	                maxlength:30
	            }
	        },
	        messages:{
	        	"name":{
	                required:"必填",
	                maxlength:"不超过100位"
	            },"code":{
	                required:"必填",
	                maxlength:"不超过30位"
	            }
	        }       
  });
 
});
</script>
</html>