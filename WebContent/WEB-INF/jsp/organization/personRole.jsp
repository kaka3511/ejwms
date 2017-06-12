<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>组织结构</title>
   	<%@ include file="../base/taglib.jsp"%>
   	<%@ include file="../base/importCss.jsp"%>
   	
   	<!-- BEGIN PAGE LEVEL STYLES -->
   	<link rel="stylesheet" href="<c:url value='/plugins/bootstrap-datatables/dataTables.bootstrap.css'/>" type="text/css"/>
   	<!-- END PAGE LEVEL STYLES -->
   <style type="text/css">
   .help-block{
     color:red;
     float: left;
     position: relative;
    }
   </style>
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<%@ include file="../base/importJs.jsp"%>
   	<link rel="stylesheet" type="text/css" href="<c:url value='/dist/themes/default/style.min.css'/>" />
   	<script type="text/javascript" src="<c:url value='/dist/jstree.min.js'/>"></script>
   	<script type="text/javascript" src="<c:url value='/js/page.js'/>"></script>
   	<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>组织架构
                  </li>
                  <li>人员类型管理</li>
               </ul>
<div class="panel panel-info">

   	<div class="panel-heading">
                            人员类型管理列表
   	</div>
   	<div class="panel-body">
   		<div class="col-md-3" style="overflow: scroll; height: 500px;"><div id="tree_part"></div></div>
	   	<div class="col-md-9">
	   		姓名：<input type="text" class="query_param" > &nbsp;&nbsp;
   			账户：<input type="text" class="query_param" > &nbsp;&nbsp;
   			<button class="btn btn-primary query">查询</button>
	  	    <button class="btn btn-primary add" style="float: right;margin-right: 5px;"
              data-toggle="modal" data-target="#myModal1" data-backdrop="false">添加</button><br/><br/>
	   		 <table id="account_table" class="table table-bordered table-striped table-hover">
	            <thead>
	                <tr style="background: #F5F5F5;">
	                  	<th class="text-center" style="background: #3499db;color: #ffffff; width: 5%;">编号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 10%;">姓名</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 10%;">账户</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 18%;">地址</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 5%;">角色</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 8%;">状态</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 12%;">身份证号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 5%;">积分</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 12%;">修改时间</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff; width: 12%;">操作</th>
	                </tr>
	            </thead>
	        </table>
	        <nav id="page">
	        	<div style="display:inline-block; position:relative; top:-20px" class="description">description</div>
			  <ul class="pagination">
				<li>
				  <a href="#" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				  </a>
				</li>
				<li>
				  <a href="#" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				  </a>
				</li>
			  </ul>
			</nav>
        </div>
   	</div>
</div>
<!-- 修改弹出框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">修改</h4>
         </div>
         
         <form class="modal-body editform" role="form">
           <div class="form-group">
           	<div class="input-group"><label class="input-group-addon">姓名：</label><input class="_account service_select form-control" name="name" id="name1"  style="width: 50%;"/></div>
            </div>
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">账号：</label><input class="_name service_select form-control" name="cellphone" id="cellphone1" style="width: 50%;"/></div>
            </div>
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">密码：</label><input class="_password service_select form-control" type="password" name="passwd" id="passwd1" style="width: 50%;"/></div>
            </div>
           
            <div class="form-group">
           	 <div class="input-group"><label class="input-group-addon">状态：</label>
           	 <select type="text" class="chooserole service_select form-control" name="status" id="status1" style="width: 50%;">
           	    <option value="1">未认证</option>
          	    <option value="2">资料审核中</option>
          	    <option value="3">已认证</option>
           	 </select>
           	 </div>
            </div>
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">类型：</label>
          	<select class="chooserole service_select form-control " name="type" id="type1" style="width: 50%;">
          	    <option value="1">居民</option>
          	    <option value="2">民警</option>
          	    <option value="3">保安</option>
          		<option value="5">群干</option>
  				<option value="6">网格员</option>
  				<option value="7">志愿者</option>
  				<option value="11">城管</option>
				<option value="12">物业</option>
				<option value="13">学校</option>
				<option value="14">居委会</option>
				<option value="15">质监</option>
				<option value="16">消防</option>
          	</select>
          	</div>
            </div>
            <div class="form-group">
           	 <div class="input-group"><label class="input-group-addon">上传头像：</label><input type="file" class="chooserole service_select form-control" name="img" id="img1" style="width: 50%;"/></div>
           	<div class="input-group" style="margin-top:10px;">
           	<label class="input-group-addon" >头像：</label>
					<div class="col-sm-9">
						<img alt="" src="" width=200 height=100 id="txImg">
					</div>
					</div>
            </div>
             <div class="form-group">            
           	 <div class="input-group"><label class="input-group-addon">住址：</label><input class="_account service_select form-control" name="address" id="address1" style="width: 50%;"/></div>
            </div>
            
         </form>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal" onclick="javascript:$('.editform').validate().resetForm();$('.editform')[0].reset();">关闭
            </button>
            <button type="button" class="btn btn-primary save">
                                                    提交
            </button>
         </div>
      </div>
      </div>
</div>
<!-- 添加 -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            
            <h4 class="modal-title" id="myModalLabel">
                                                   添加
            </h4>
         </div>
         <div class="modal-body">
         <form class="addtable addform"  enctype="multipart/form-data">
         <input type="hidden" name="method" value="upload"/>  
         	<div class="form-group">
           	<div class="input-group"><label class="input-group-addon">姓名：</label><input class="_account form-control" name="name" id="name"  style="width: 50%;"/></div>
            </div>
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">账号：</label><input class="_name form-control" name="cellphone" id="cellphone" style="width: 50%;"/></div>
            </div>
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">密码：</label><input class="_password form-control" type="password" name="password" id="password" style="width: 50%;"/></div>
            </div>
            <div class="form-group">
         	 <div class="input-group"><label class="input-group-addon">确认密码：</label><input class="_passwords form-control" type="password" name="repassword" id ="repassword" style="width: 50%;"/></div>
            </div>
            
            <div class="form-group">
          	<div class="input-group"><label class="input-group-addon">类型：</label>
          	<select  class="chooserole form-control " name="type" id="type" style="width: 50%;">
          	    <option value="1">居民</option>
          	    <option value="2">民警</option>
          	    <option value="3">保安</option>
          		<option value="5">群干</option>
  				<option value="6">网格员</option>
  				<option value="7">志愿者</option>
  				<option value="11">城管</option>
				<option value="12">物业</option>
				<option value="13">学校</option>
				<option value="14">居委会</option>
				<option value="15">质监</option>
				<option value="16">消防</option>
          	</select>
          	</div>
            </div>
            
             <div class="form-group">
           	 <div class="input-group"><label class="input-group-addon">上传头像：</label>
           	 <input type="file" class="chooserole form-control" style="width: 50%;" name="img" id="img" />
           	  <img name="pic" id="pic" alt="" src=""> 
           </div>
            </div>
             <div class="form-group">            
           	 <div class="input-group"><label class="input-group-addon">住址：</label><input class="_account form-control" name="address" id="address" style="width: 50%;"/></div>
            </div>
            <div class="form-group">            
           	 <div class="input-group"><label class="input-group-addon">身份证号码：</label><input class="_account form-control" name="idcard" id="idcard" style="width: 50%;"/></div>
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
<script type="text/javascript">
var bData;
var lx=1;//1是增加 2是修改
var password="";
$(function() {
	
	$('#tree_part').jstree({
		'core' : {
			'data' : {
				"url" : "/ejwms/organization/personRoleTree.do",
				"dataType" : "json" 
			}
		}
	}).bind("select_node.jstree", function(e, data){
		query(data.node);
	}).bind("loaded.jstree",function(){
		$.jstree.reference('#tree_part').select_node('0');
		$.jstree.reference('#tree_part').open_node('0');
	});
    $("#account_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 10,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bFilter": false,
		"bDeferRender": true,
		ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/organization/queryPeople.do",
			dataType: "json",
			dataSrc: "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
			data: function (d) {//d 是原始的发送给服务器的数据，默认很长。
				var p={};
				p.status = $('#status_q').val();
				p.cellphone = $('#cellphone_q').val();
				p.page=0;
				return p;
	        },
	    } ,
	    "aoColumnDefs": [
          {
               sDefaultContent: '',
               aTargets: [ '_all' ]
          }
      ],
	    columns: [//对应上面thead里面的序列
	              {  data: "id" , "sClass" : "text-center"},
	              {data:"name","sClass":"text-center"},
	              { data: "cellphone", "sClass" : "text-center" },//字段名字和返回的json序列的key对应
	              {data:"address","sClass":"text-center"},
	              {data:function(e){
	            	  var typeName= '';
	            	  if(e.type =='1'){
	            		  typeName ="居民";
	            	  }else if(e.type =='2'){
	            		  typeName ="民警";
	            	  }else if(e.type =='3'){
	            		  typeName ="保安";
	            	  }else if(e.type =='11'){
	            		  typeName ="城管";
	            	  }else if(e.type =='12'){
	            		  typeName ="物业";
	            	  }else if(e.type =='13'){
	            		  typeName ="学校";
	            	  }else if(e.type =='14'){
	            		  typeName ="居委会";
	            	  }else if(e.type =='15'){
	            		  typeName ="质监";
	            	  }else if(e.type =='16'){
	            		  typeName ="消防";
	            	  }
	            	  return typeName;
	              },"sClass":"text-center"
	              },
	              {data:function(e){
	            	  var statusName= '';
	            	  if(e.status =='1'){
	            		  statusName ="未认证";
	            	  }else if(e.status =='2'){
	            		  statusName ="资料审核中";
	            	  }else if(e.status =='3'){
	            		  statusName ="已认证";
	            	  }
	            	  return statusName;
	              },"sClass":"text-center"
	              },
	              {data:"idcard","sClass":"text-center"},
	              {data:"points","sClass":"text-center"},
	              {data:"updatetime","sClass":"text-center"},
	              { data: function (e) {//这里给最后一列返回一个操作列表
	                    //e是得到的json数组中的一个item ，可以用于控制标签的属性。
	                    var sContent = '<button class="btn btn-primary modify" data-toggle="modal" data-target="#myModal" data-backdrop="false">修改</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-primary delete" >删除</button>&nbsp;&nbsp;&nbsp;';
	                   // sContent+='&nbsp;&nbsp;&nbsp;<button class="btn-primary ondetail" data-toggle="modal" data-target="#myModal2" data-backdrop="false">详情</button>';
	                    return sContent;
	                },"sClass":"text-center"
	              } 
	    ] ,
	    initComplete: function (setting, data) {
	    	if(data.total!=null){
				PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
			}
	    },
	    language: {
	        lengthMenu: '<select class="form-control input-xsmall">' + '<option value="5">5</option>' + '<option value="10">10</option>' + '<option value="20">20</option>' + '<option value="30">30</option>' + '<option value="40">40</option>' + '<option value="50">50</option>' + '</select>条记录',//左上角的分页大小显示。
	        processing: "",//处理页面数据的时候的显示
	        paginate: {//分页的样式文本内容。
	            previous: "上一页",
	            next: "下一页",
	            first: "第一页",
	            last: "最后一页"
	         },
	         zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
	         //下面三者构成了总体的左下角的内容。
	         info: "总共_PAGES_页，显示第_START_到第 _END_条",//左下角的信息显示，大写的词为关键字。
	         infoEmpty: "0条记录",//筛选为空时左下角的显示。
	         infoFiltered: ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
	    } 
	}); 
});

$('#account_table').on('xhr.dt', function() {
	$("#account_table_info").remove();
	$("#account_table_paginate").remove();
});
function pageEvent(page){
	$("#account_table").dataTable().fnClearTable();
	var node = $('#tree_part').jstree().get_selected(true)[0];
	var keys = node.id.split("|");
	var url_data;
	if(keys.length != 2){
		url_data = {communityid: keys[0], type: "0"};
	}else{
		url_data = {communityid: keys[0], type: keys[1]};
	}
	url_data.name = $(".query_param").eq(0).val();
	url_data.phone = $(".query_param").eq(1).val();
	url_data.page = page;
	 $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/organization/queryPeople.do",//请求的uri
			data : url_data, //传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				if(data.data.length)
				$("#account_table").dataTable().fnAddData(data.data, true);
			}
	});
}


$(".query").click(function(){
	if($('#tree_part').jstree().get_selected(true).length == 0){
		  alert("请选择一个人员类型");
		  return;
	 }
	var params = {name: $(".query_param").eq(0).val(), phone: $(".query_param").eq(1).val()}
	query($('#tree_part').jstree().get_selected(true)[0], params);
});

//查询
function query(node, params){
	$("#account_table").dataTable().fnClearTable();
	var keys = node.id.split("|");
	var url_data;
	if(keys.length != 2){
		url_data = {communityid: keys[0], type: "0"};
	}else{
		url_data = {communityid: keys[0], type: keys[1]};
	}
	if(params){
		url_data.name = params.name;
		url_data.phone = params.phone;
	}
	 $.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/organization/queryPeople.do?page=0",//请求的uri
			data : url_data,//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				if(data.total!=null){
					if(data.total!=0)
						$("#account_table").dataTable().fnAddData(data.data, true);
					PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
				}
			}
	});
	
};


//删除
$(document).on('click','.delete',function(){
	if(confirm("确定要删除吗?")) {
		 bData = $("#account_table").DataTable().row($(this).parents("tr")).data();
		 $.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/police/delete.do",//请求的uri
				data : {id:bData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
				//	$("#account_table").dataTable().fnReloadAjax();//刷新表格
					var node = $('#tree_part').jstree().get_selected(true)[0];
					if(node)	query(node);
					alert("删除成功!");
				}
				});
	}
}); 
 //添加
  $(document).on('click','.add',function(){
	  if($('#tree_part').jstree().get_selected(true).length == 0){
		  $('#myModal1').modal('hide');
		  alert("请选择一个社区或人员类型");
		  return;
	  }
	  
	 $('#myModalLabel').html("添加");
	 $('.addform')[0].reset();
	 $('.addform').validate().resetForm();
	 $("#name").removeClass('help-block');
	 lx=1;
	 $("#name").val();
	 $('.form-control').prop('disabled',false);
	 $('#myModal1').modal('show');//显示弹出框
 });  
	

	//添加提交
 $(document).on('click','#param_summit',function(){	 
	 var node = $('#tree_part').jstree().get_selected(true)[0];
	 if(node.data == "root"){
		  $('#myModal1').modal('hide');
		  alert("请选择一个社区或人员类型");
		  return;
	  }
	 var communityid = node.id.split("|")[0];
	 
    	  if($('.addform').valid()){
    		  $.ajaxFileUpload( {
    			type:"POST",//不写此参数默认为get方式提交
    			async:false,   //设置为同步
    			secureuri : false,//安全协议  
    			dataType : 'text',  
    			fileElementId:'img',//需要上传的文件域的ID，即<input type="file">的ID。
  				url : "/ejwms/police/add.do",//请求的uri
  				data : {
  				 name:$('#name').val(),
  				 password:$('#password').val(),
  				 cellphone:$('#cellphone').val(),
  				 address:$('#address').val(),
  				 img:$('#img').val(),
  				 idcard:$('#idcard').val(),
  				 type:$('#type').val(),
  				 status:$('#status').val(),
  				 communityid: communityid
  				 },//传递到后台的参数				
  				cache : false,
  				error : function() {  
  		        	alert('系统出现异常，请稍后再试!');
  		        }, 
  				success : function(data) {
  				//	$("#account_table").dataTable().fnReloadAjax();  //刷新datatables
  					query(node);
  					$(".addform")[0].reset();
					$("#myModal1").modal('hide');
  						alert("添加成功!");
  				}});
    		  
    	  }
	  }); 

	//修改操作提交
 $(document).on('click','.save',function(){
	 var node = $('#tree_part').jstree().get_selected(true)[0];
	 if(node.data == "root"){
		  $('#myModal').modal('hide');
		  alert("请选择一个社区或人员类型");
		  return;
	  }
	 var communityid = node.id.split("|")[0];
	 
	 var szFileName = $("#img1").val();
		if(szFileName!=null&&szFileName!=""){
			szFileName = szFileName.replace(/(^\s*)|(\s*$)/g, "");
			var hzm = szFileName.substr(szFileName.length - 3).toLowerCase();
			if (hzm != "jpg"&&hzm!="png"&&hzm!="bmp"&&hzm!="jpeg") {
				alert("请上传jpg,png,bmp,jpeg格式的图片!");
				return false;
			}
		}
	 var id="";
	 if(lx==2){
		 id=bData.id;
	 }
	 var passwd="";
	 if(password!=$('#passwd1').val()){  //修改密码
		 passwd = $('#passwd1').val();
	 }
	  if($('.editform').valid()){
		  $.ajaxFileUpload( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/police/update.do",//请求的uri
				secureuri : false,//安全协议  
		 	    fileElementId:'img1',//id
		 	    dataType : 'text',
				data : {
					 id:bData.id,
				     name:$('#name1').val(),
				     passwd:passwd,
	  				 cellphone:$('#cellphone1').val(),
	  				 address:$('#address1').val(),
	  				 img:$('#img1').val(),
	  				 idcard:$('#idcard1').val(),
	  				 type:$('#type1').val(),
	  				 status:$('#status1').val(),
	  				 communityid: communityid
				},//传递到后台的参数				
				cache : false,
				error : function() {  
		        	alert('系统出现异常，请稍后再试!');
		        }, 
				success : function(data) {
				//		$("#account_table").dataTable().fnReloadAjax();  //刷新datatables
						query(node);
						$(".editform")[0].reset();
						$('#myModal').modal('hide');
						alert("修改成功!");
				}
				});
		  
	  }
		 
	 });
//修改
 $(document).on('click','.modify',function(){
	 if($('#tree_part').jstree().get_selected(true).length == 0){
		 $('#myModal').modal('hide');
		  alert("请选择一个社区或人员类型");
		  return;
	  }
	 
	  $('#myModalLabel').html("修改");
	 $('.editform').validate().resetForm();
	 $('#name1').removeClass('help-block');
	 lx=2;
	 bData = $("#account_table").DataTable().row($(this).parents("tr")).data();
 		 $.ajax({
 			 type:"post",//不写此参数默认为get方式提交
 		     async:false,//设置为同步
 		     url:"/ejwms/police/found.do",
 		     data:{id:bData.id},//传递到后台的参数
 		     cache:false,
 		     dataType:'json',//后台返回前台的数据格式为json
 		     success:function(data){
 			$('#name1').val(data.name);
 	 		 $('#cellphone1').val(data.cellphone);
 			 $('#passwd1').val(data.passwd);
 			password = data.passwd;
 			 $('#status1').val(data.status);
 			 $('#type1').val(data.type);
 			$('#txImg').attr("src",data.img);
 			 $('#idcard1').val(data.idcard);
 			 $('#address1').val(data.address);
 		     }
 		     });
 		  $('#myModal').modal('show');
 });


 jQuery.validator.addMethod("phone", function(value, element) {   
	    var tel = /^1[3-8]\d{9}$/;
	    return this.optional(element) || (tel.test(value));
	}, "请输入正确的账号");
     // usernamecheck 用户名校验
     jQuery.validator.addMethod("usernamecheck", function(value, element) {      
	      return this.optional(element) || /^[a-zA-Z0-9_][a-zA-Z0-9_]*$/.test(value);      
	  }, "必须为字母、数字或下划线，不能以数字开头");
    //passwordcheck 密码校验
    jQuery.validator.addMethod("passwordcheck", function(value, element) {      
	      return this.optional(element) || /^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@#$%^&]))[\dA-Za-z!@#$%^&]+$/.test(value);      
	  }, "密码应包含字母、数字、符号中的至少2种");
    //idcardcheck 身份证校验
    jQuery.validator.addMethod("eidcardcheck", function(value, element) {      
	      return this.optional(element) || /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);      
	  }, "身份证格式不正确");
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


//修改子账户表单验证
	$(function(){
	      $(".editform").validate({  
	    	  errorElement: 'em', 
			  errorClass: 'help-block',
			  focusInvalid: false,   
	         rules:{
	       	  name:{
	                 required:true,
	             },
	             cellphone:{
	                 required:true,
	                 rangelength:[6,20]
	             },
	             password:{
	                 required:true,
	                 rangelength:[6,20],
	                 passwordcheck:true
	             },
	             repassword:{
	           	  equalTo:"#password"
	             },
	             points:{
	            	 digits:true,
	               	byteRangeLength:[0,9]
	             },
	         },
	         messages:{
	       	  name:{
	                 required:"必填",
	             },
	             cellphone:{
	                 required:"必填",
	                 rangelength:"账户不能少于6位或大于20"
	             },
	             password:{
	                 required:"必填",
	                 rangelength:"密码为6~20位",
	                 passwordcheck:"应包含字母、数字、符号中的至少2种"
	             },
	             repassword:{
	           	  equalTo:"两次输入不一致"
	             },
	             points:{
	             	  digits:"必须输入整数",
	             	byteRangeLength:"不超过9位"
	               }    
	         
	                                      
	         }      
	      });
 });  
</script>
<!-- END BODY -->

</html>