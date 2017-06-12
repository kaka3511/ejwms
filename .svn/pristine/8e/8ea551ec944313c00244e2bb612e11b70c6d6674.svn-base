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
		<li>人员类型</li>
	</ul>
	<div class="panel panel-info" style="position: relative;">
	 
		<div class="panel-heading" style='overflow: hidden;'>
			<span>人员类型</span>
        <button class="btn btn-primary add addEntityBtn"  style="float:right; right: 30px; top: 12px;">添加</button>
     	</div>

		<div class="panel-body">
		<div class="col-md-3" style="overflow: scroll; height: 500px;"><div id="tree_part"></div></div>
		<div class="col-md-9">
			<table class="table table-bordered table-striped table-hover entity_table">
				<thead>
				 <tr style="background: #F5F5F5;">
                    <th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">序号</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">名称</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">类型编码</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">身份编码</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">描述</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 15%;">操作</th>
                </tr>
				</thead>
			</table>
			</div>
		</div>
	</div>
	<!-- 添加 -->
<div class="modal fade" id="entityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="entityLabel"></h4>
		 </div>
         <div class="modal-body">
					<form class="addtable addform">
						<input  type="hidden" name="id" id="id" />
						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">名称：</label>
								<input class="_account form-control" name="name" id="name"
									style="width: 100%;" />
							</div>
						</div>
						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">类型编码：</label><input
									class="_name form-control" name="code" id="code"
									style="width: 100%;" />
							</div>
						</div>
						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">身份编码：</label><input
									class="form-control"  name="role"
									id="role" style="width: 100%;" />
							</div>
						</div>
						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">所属组织：</label>
								<select class="chooserole form-control " name="dept" id="dept"
									style="width: 100%;">
								</select>
							</div>
						</div>

						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">状态：</label>
								<select class="chooserole form-control " name="status" id="status"
									style="width: 100%;">
									<option value="1">可用</option>
									<option value="0">不可用</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group" style="width: 75%;">
								<label class="input-group-addon" style="width: 100px;">描述</label>
								<div>
									<textarea class="form-control" rows="4"
										placeholder="内容不超过200位(汉字占2位)" id="description" name="description"
										style="width: 100%;"></textarea>
								</div>
							</div>
						</div>

					</form>
				</div>
        
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal" onclick="javascript:$('.addform').validate().resetForm();$('.addform')[0].reset();">关闭
            </button>
            <button type="button" class="btn btn-primary addchild" id="param_summit" >
                                                    添加
            </button>
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
				"url" : "/ejwms/organization/communityTree.do",
				"dataType" : "json",
				"data":function(node){
		            return {"id" : node.id};
		        }
			}
		}
	}).on("select_node.jstree", function(e, data){
		query(data.node.id);
		
	}).on("loaded.jstree", function(){
		$('#tree_part').jstree("open_all");
	});
	
	
	$(".entity_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 8,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bPaginate": true, //翻页功能
		"bFilter": true,
		"bDeferRender": true,
		ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/organization/queryUserType.do?deptid=0",
			dataType: "json",
			dataSrc: "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
			data:function(d){
				var p={};
				return p;
			}
	    } ,
	    "aoColumnDefs": [
	                     {
	                          sDefaultContent: '',
	                          aTargets: [ '_all' ]
	                     }
	                 ],
	    columns: [//对应上面thead里面的序列
	              {  data: "xh", "sClass" : "text-center" },
	              { data: "name", "sClass" : "text-center" },
	              {  data: "code", "sClass" : "text-center" },
	              { data: "role", "sClass" : "text-center" },
	              { data: "description", "sClass" : "text-center" },
	              { data: function (e) {//这里给最后一列返回一个操作列表
	                    //e是得到的json数组中的一个item ，可以用于控制标签的属性。
	                  var sContent = '<button class="btn btn-primary modify" data-toggle="modal" data-target="#myModal" data-backdrop="false">修改</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-primary delete" >删除</button>&nbsp;&nbsp;&nbsp;';
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
function query(nodeid){
	$(".entity_table").dataTable().fnClearTable();
	 $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url :"/ejwms/organization/queryUserType.do?deptid="+nodeid,//请求的uri
			data :'',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				if(data.data.length){
					$(".entity_table").dataTable().fnAddData(data.data, true);
				}
			}
	});
	
};


$(document).on('click','.addEntityBtn',function(){
	 $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/organization/getCommunityList.do",
			data :'',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				var json = eval(data);
				var $select = $('#dept');  
				$select.empty();
				 $select.append('<option value="">--请选择--</option>'); 
				for(var i=0, len = json.data.length;i<len;i++){  
				  $select.append('<option value="'+json.data[i].id+'">'+json.data[i].name+'</option>');  
				} 
				$('#entityLabel').html("人员类型添加");
				$('#entityModal').modal('show');
				$('.addform')[0].reset();
				var node = $('#tree_part').jstree().get_selected(true)[0];
				$('#id').val(0);
				if(node){
					$('#dept').val(node.id);
				}
			}
	});
});

//新增设备提交
$("#param_summit").click(function () {
	if($(".addform").valid()){
		$.ajaxFileUpload( {
			url : "/ejwms/organization/saveUserType.do",//请求的uri
			type:"POST",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				secureuri : false,//安全协议  
				dataType : 'text',
	      		data : {
	      			id:$('#id').val(),
	      			name:$("#name").val(),
	      			code:$("#code").val(),
	      			role:$('#role').val(),
	      			status:$("#status").val(),
	      			description:$("#description").val(),
	      			dept:$("#dept").val()
	      			},//传递到后台的参数				
	      		success : function(data) {
	      			if(data=='true'){
			      			$('.addform')[0].reset();
			      			//$(".entity_table").dataTable().fnReloadAjax();
							$('#entityModal').modal('hide');
						    alert("操作成功!");
						    var node = $('#tree_part').jstree().get_selected(true)[0];
							if(node){
								query(node.id);
							}else{
								$(".entity_table").dataTable().fnReloadAjax();
							}
		      			}else{
		      				alert("同一套类型编码/身份编码/所属组织在数据库中已存在！");
		      			}
	      			
	      	},error: function () {
				alert('系统出现异常，请稍后再试!');
	        }}); 
	  	}
});

//修改设备
$(document).on('click','.modify',function(){//修改方案	
	 $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/organization/getCommunityList.do",
			data :'',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				var json = eval(data);
				var $select = $('#dept');  
				$select.empty();
				 $select.append('<option value="">--请选择--</option>'); 
				for(var i=0, len = json.data.length;i<len;i++){  
				  $select.append('<option value="'+json.data[i].id+'">'+json.data[i].name+'</option>');  
				} 
				
			}
	});
	
	$('#entityLabel').html("人员类型修改");
	$('.addform')[0].reset();
	$('.addform').validate().resetForm();
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	$('#name').val(aData.name);
	$('#code').val(aData.code);
	$('#id').val(aData.id);
	$('#role').val(aData.role);
	$('#description').val(aData.description);
	$('#status').val(1);
	$('#dept').val(aData.dept);
	$('#entityModal').modal('show');
	
});


//删除设备
$(document).on('click','.delete',function(){
	if (confirm("你确定要删除吗?"))  {  
		aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
		$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/organization/deleteUserType.do",//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					    alert("删除成功!");
					    var node = $('#tree_part').jstree().get_selected(true)[0];
						if(node){
							query(node.id);
						}else{
							$(".entity_table").dataTable().fnReloadAjax();
						}
		},error: function () {
			alert('系统出现异常，请稍后再试!');
        }}); 
	}
});

//添加验证
$(function(){
  $(".addform").validate({  
	  errorElement: 'em', 
		  errorClass: 'help-block',
		  focusInvalid: false,   
		  rules:{
	            "name":{
	                required:true,
	                maxlength:20
	            },
	            "code":{
	                required:true,
	                SerialCheck:true,
	                maxlength:10
	            },
	            "role":{
	                required:true,
	                SerialCheck:true,
	                maxlength:10
	            },"dept":{
	                required:true
	            }
	        },
	        messages:{
	        	"name":{
	                required:"必填",
	                maxlength:"不超过20位"
	            },"code":{
	                required:"必填"
	            },
	            "role":{
	                required:"必填"
	            },"dept":{
	                required:"必填"
	            }
	        }       
  });
  jQuery.validator.addMethod("SerialCheck", function(value, element) {      
      return this.optional(element) || /^[0-9]+$/.test(value);      
  }, "只能输入数字");
});
</script>
</html>