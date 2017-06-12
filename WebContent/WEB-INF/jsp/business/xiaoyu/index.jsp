<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>视频会议</title>
   	<%@ include file="../../base/taglib.jsp"%>
   	<%@ include file="../../base/importCss.jsp"%>

   <style type="text/css">
   .help-block{
     color:red;
     float: left;
     position: relative;
    }
   .jstree-organize-icon {
    background-image: url(../images/organize.png) !important;
}
#Content-Left{
   width: 350px;
   margin: 5px 5px 5px 20px;/*设置元素跟其他元素的距离为20像素*/
   float:left;/*设置浮动，实现多列效果，div+Css布局中很重要的*/
   
}
#Content-Main{
    width: 890px;
    margin: 0px 5px 5px 5px;/*设置元素跟其他元素的距离为20像素*/
    float:left;/*设置浮动，实现多列效果，div+Css布局中很重要的*/
}
 .display{
   display:block;
 }
   </style>
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<%@ include file="../../base/importJs.jsp"%>
   	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
   	<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>视频会议
                  </li>
                  <li>视频会议管理</li>
               </ul>
<div class="panel panel-info" style="position: relative;">

   	 	<div class="panel-heading" style='overflow: hidden;'>
							视频会议列表
      <button class="btn btn-primary addWindows" onclick="openshowRoleTable('addRole')"  style="float:right; right: 15px; top: 12px;">添加</button>
   	</div>
   	<div class="panel-body">
   			<div >
				<table id="jqGrid"></table>
			    <div id="jqGridPager"></div>
		    </div>
   	</div>
</div>


<div class="modal hide" id="addRole">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick="colesshowRoleTable('addRole')" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加会议房间</h4>
            </div>
            <div class="modal-body">
               <form class="form-horizontal addroleform" role="form">
					<!-- 	<div class="form-group">
						    <input type="hidden"  id="type" name="type">
							<label class="col-sm-2 control-label">角色编码</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="addCode" name="addCode"></div>
						</div>
					 -->
					 	<div class="form-group">
							<label class="col-sm-2 control-label">项目名称</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="projectName" name="adddesc"></div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 control-label">房间名称</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="addName" name="addName"></div>
						</div>
						
						
											
					</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="colesshowRoleTable('addRole')" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveaddRole()">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
<script type="text/javascript">
$(function() {
	
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$("#jqGrid").jqGrid({
        url:"list.action",
        datatype: "json",
        jsonReader:{
        	root:'data',
        	repeatitems: true,
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
				label: '项目名称',
                name: 'projectName',
            },
            {
				label: '会议名称',
                name: 'name',
            },
            {
				label : '密码',
                name: 'password',
            },
            {
				label : '会议编号',
                name: 'roomid',
            },
            {
				label: '网络地址',
                name: 'url',
            },
            {
				label: '申请时间',
                name: 'createtime',
                search:false,
                formatter:function(cellvalue, options, rowObject){
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
                
            },
            {
				label: '过期时间',
                name: 'endtime',
                search:false,
                formatter:function(cellvalue, options, rowObject){
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
                
            },
            {
				label: '是否有效',
                name: 'isDead',
                search:false
            }
            //,
           // {
		   //   label: '操作',
           //   name: 'operation',
           //   editable: false,
           //   search:false 
           //}
        ],
		viewrecords: true,
		height:$(window).height()-$('.panel-body').offset().top-80,
        shrinkToFit :true,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
	
	
});


function saveaddRole(){
	 if($(".addroleform").valid()){
			$.ajax({
				type : "post",//不写此参数默认为get方式提交
				async : false, //设置为同步
				url : "/ejwms/meetingroomxy/create.do",
				data :  {
	      			roomName:$("#addName").val(),
	      			projectName:$("#projectName").val()
      			},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					$('#jqGrid').jqGrid('clearGridData');
					$('#jqGrid').jqGrid().trigger('reloadGrid');
					colesshowRoleTable('addRole');
					$('#addroleform')[0].reset();
				}
			});
	 }else{
		 
		 }
}


function colesshowRoleTable(showtablseid){
 	$("#"+showtablseid).removeClass("show");
 	$("#"+showtablseid).addClass("hide");
 }
function openshowRoleTable(showtablseid){
 	$("#"+showtablseid).addClass("show");
 	$("#"+showtablseid).removeClass("hide");
 } 


</script>
<!-- END BODY -->

</html>