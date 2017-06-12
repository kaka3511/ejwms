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
                  <li>被监护人管理</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
		   		<div class="row">
		   			<div class='col-xs-6'>
		   					<form class='form-inline' action="">
		   						<!-- <div class='form-group'>
		   							<label>状态：</label>
								    <select class='form-control' id="query_status" >
			   							 <option value="" selected="selected">全部</option>
								    	<option value="1" >已上架</option>
								    	<option value="2" >已下架</option>
								    </select>
		   						</div> -->
		   						<div class='form-group'>
									    <label>被监护人姓名：</label>
									    <input class='form-control' type='text' id='query_goods'>
		   						</div>
					   
		   					</form>
		   			
		   			</div>
		   			
		   			<div class='col-xs-6'>
		   				<a class='btn btn-primary pull-right' href="<c:url value='/pupil/publish'/>">添加被监护人</a>
		   			</div>
		   		
		   		</div>
		   	
			</div>
			   	<div class="panel-body">
				   	<div '>
					    <table id="jqGrid"></table>
					    <div id="jqGridPager"></div>
					</div>
			   	</div>

</div>
<div class="modal fade" id="imgModal" tabindex="-1" role="dialog" style='overflow: hidden;'>
		 <div class="modal-dialog modal-lg" >
		 </div>
		
	</div>
</body>
<script type="text/javascript">
$(function() {
	
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
	});
	$('.modal').on('mousewheel',function(e){
		var minHeight = 150;   // min height
         var tempStep = 10;    // evey step for scroll down or up
         zoom(e,$('.modal img'),minHeight,tempStep);
	});
	$('#imgModal .modal-dialog').click(function(){
		$('#imgModal ').modal('hide');
	});
	$('#imgModal').on('show.bs.modal', function (e) {
		var img =$("<img class='center-block' style='position:relative'/>");
		var src = $(e.relatedTarget).data('src');
		img.attr('src',src);
	  	  img.draggable({
	  		cursor:'move',
	  		scroll:false,
	  	  });
  		
	  	$('#imgModal .modal-dialog img').remove();
  		$('#imgModal .modal-dialog').append(img);
		
	})
	$("#jqGrid").jqGrid({
        url:"<c:url value='/pupil/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
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
				label: '姓名',
                name: 'name',
            
            },
			
            {
				label: '积分',
                name: 'score',
            },
            /* {
				label: '电话号码',
                name: 'cellphone',
            }, */
            {
				label: '身份证',
                name: 'idcard',
            },
            {
				label: '疾病类型',
                name: 'type',
                formatter:'select', 
                editoptions:{value:"0:精神障碍患者;1:残障人士"},
            },
            {
				label: '病史或情况说明',
                name: 'illness',
            },
            
            {
				label: '性别',
                name: 'gender',
                formatter:'select', 
                editoptions:{value:"0:女;1:男"},
            },
            {
				label: '年龄',
                name: 'age',
            },
            {
				label: '现住址',
                name: 'cuaddr',
            },
            {
				label: '户籍地址',
                name: 'addr',
            },
           /*  {
				label: '三证',
                name: 'nums',
            }, */
           
            
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
        gridComplete:function(){
        	$('td .del').off("click",del);
        	$('td .del').on("click",del);
        },
		loadonce: true,
		viewrecords: true,
		height:$(window).height()-$('.panel-body').offset().top-80,
        shrinkToFit :true,
        autowidth:true,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
		        
	function del(event){
		event.preventDefault();
		if(confirm("确定删除吗？")){
			var href = $(this).attr('href');
			$.ajax({
				url:href,
				dataType:'json',
				type:'get',
				success:function(data, textStatus, jqXHR){
					alert("删除成功！");
					$("#jqGrid").delRowData(data.data);
				},
				error:function( jqXHR, textStatus, errorThrown){
					alert("删除失败！");
				}
			});
		}
		
	}
	function operFormat( cellvalue, options, rowObject ){
       		return "<div><a class='btn btn-primary del' href='<c:url value='/pupil/del/'/>"+rowObject.id+"'>删除</a></div>";
		
	}
	
	function operUnFormat( cellvalue, options, cell){
		return "";
	}
	
	
	var f = { groupOp: "AND", rules: [] };
   /*  $('#query_status').change(function(){
   	var self = this;
		var value = self.value;
    	var grid = $('#jqGrid');
    	var field = "status";
    	var op = "eq";

    	filter(grid,field,op,value);
    	
    }); */
    
    var timer;
    $('#query_goods').keyup(function(){
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
	
    
    
    
});
</script>
<!-- END BODY -->

</html>