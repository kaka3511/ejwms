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
                     <i class="icon-cog"></i>商品管理
                  </li>
                  <li>爱心义卖</li>
               </ul>
<div class="panel panel-info">
		
		   	<div class="panel-heading">
		   					<form class='form-inline' action="">
		   						 <div class='form-group'>
		   							<label>认证状态：</label>
								    <select class='form-control' id="query_status" >
			   							 <option value="-1" selected="selected">全部</option>
								    	<option value="1" >审核中</option>
								    	<option value="2" >已通过</option>
								    	<option value="3" >未通过</option>
								    </select>
		   						</div> 
		   						
		   						<div class='form-group'>
									    <label>商品发布者：</label>
									    <input class='form-control' type='text' id='query_publisher' >
		   						</div>
		   						
		   						<div class='form-group' >
									    <label>商品标题：</label>
									    <input class='form-control' type='text' id='query_title'>
		   						</div>
					   
		   					</form>
		   			
		   			
		   		
		   	
			</div>
			   	<div class="panel-body">
				   	<div>
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
	var currentGoodsSalePage = getOneSessionStorageValue("currentGoodsSalePage");
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
        url:"<c:url value='/goodsSale/list'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
        datatype: "json",
        mtype: 'POST',
        page: currentGoodsSalePage,
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
                name: 'id',
				key: true,
				hidden:true,
				search:false,
            },
            {
				label: '商品发布者',
                name: 'name',
            
            },
            {
				label : '商品标题',
                name: 'title',
                search:false,
            },
            {
				label : '商品数量',
                name: 'number',
            },
           {
				label : '封面图片',
                name: 'images',
                formatter:function(cellvalue, options, rowObject){
                	var images = rowObject.images;
                	var img;
                	if(images){
                		var imgArr = images.split(',');
                		img = imgArr[0];
                	}
                	
                	var imgTmplate =  "<ul class='dowebok'><li><img class='img-rounded' style='width:34px;height:34px;cursor:pointer;' src='"+(img?img:'../images/idcard_default_290_186.png')+"'/></li></ul>";
                    
                	return imgTmplate;
                }
            },
            {
				label: '价格',
                name: 'score',
                search:false,
                
            },
            {
				label : '状态',
                name: 'status',
                formatter:'select', 
                editoptions:{value:"1:审核中;2:已通过;3:未通过"},
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
        pager: "#jqGridPager",
        gridComplete: function(){
        	$('.dowebok').viewer();
        }
    }); 
	function operFormat( cellvalue, options, rowObject ){
		var currentGoodsSalePage = $(this).jqGrid('getGridParam','page');
		sessionStorage.setItem("currentGoodsSalePage", currentGoodsSalePage);
		if(rowObject.status==1){
			return "<div><a class='btn btn-primary edit'  href='<c:url value='/goodsSale/view/?oper=edit&id='/>"+rowObject.id+"'>审核</a></div>";
		}
		
		return "";
	}
	
	function operUnFormat( cellvalue, options, cell){
		return "";
	}
	
	
	var f = { groupOp: "AND", rules: [] };
     $('#query_status').change(function(){
   	var self = this;
		var value = self.value;
    	var grid = $('#jqGrid');
    	var field = "a.status";
    	var op = value==-1?"ne":"eq";

    	filter(f,grid,field,op,value);
    	
    	var query_status = value;
		
		setCookie("query_status7", query_status, 0.1);
    	
    }); 
    
    var timer;
    $('#query_publisher').keyup(function(){
		var self = this;
		var value = self.value;
		var grid = $('#jqGrid');
     	var field = "b.name";
     	var op = "cn";
     	
		if(timer) { clearTimeout(timer); }
		timer = setTimeout(function(){
			//timer = null;
			filter(f,grid,field,op,value);
		},0);
		
		var query_publisher = value;
		
		query_publisher = escape(query_publisher);
		setCookie("query_publisher7", query_publisher, 0.1);

     	
     }); 
    
    var timer1;
    $('#query_title').keyup(function(){
		var self = this;
		var value = self.value;
		var grid = $('#jqGrid');
     	var field = "a.name";
     	var op = "cn";
     	
		if(timer1) { clearTimeout(timer1); }
		timer1 = setTimeout(function(){
			//timer = null;
			filter(f,grid,field,op,value);
		},0);
		var query_title = value;
		
		query_title = escape(query_title);
		setCookie("query_title7", query_title, 0.1);

		
     }); 
	//再显示查询条件  
if(!(!!window.ActiveXObject || "ActiveXObject" in window))		
	{
			var query_status = getCookie('query_status7');
			var query_publisher = getCookie('query_publisher7');
			var query_title = getCookie('query_title7');

			//cookie中文编码问题 
			query_publisher = unescape(query_publisher);
			query_title = unescape(query_title);
			
			if (query_status == "0" || query_status == "1" || query_status == "3")
				$('#query_status').val(query_status);
			else
				$('#query_status').val("-1");

			if(query_publisher != "" || query_publisher!= null || query_publisher!= undefined)
				$('#query_publisher').val(query_publisher);
			
			if(query_title != "" || query_title!= null || query_title!= undefined)
				$('#query_title').val(query_title);
		}
    
    
    
});
</script>
<!-- END BODY -->

</html>