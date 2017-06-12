<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<%@ include file="../../base/importJs.jsp"%>

</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>关联被监护人</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading" style="position:Relative; ">
			<div class='row'>
				<div class="col-xs-6">
						<form class='form-inline'>
							<div class="form-group">
								<label >类型：</label>
							    <select class='form-control' id="type_query" >
							   		 <option value="-1" >全部</option>
							    	<option value="0" >精神障碍患者</option>
							    	<option value="1" >残障人士</option>
							    </select>
							</div>
							
							<div class="form-group">
								<label>被监护人：</label>
							    <input class='form-control' type="text" id = 'pupil_query'>
							</div>
						</form>
					
					</div>
					<div class="col-xs-6" style="right: 0px;">
						<button class='btn btn-primary' id='btn_add_keeper'  style="position:Absolute; right: 17px;" >添加监护人</button>
					
					</div>
			</div>
					
				
		</div>
		<div class="panel-body">
			<div class='row' style='margin-left:0px;margin-right:0px;'>
			
					<div class="col-xs-6" style='padding-left: 0px;'>
					    <table id="jqGrid"></table>
					    <div id="jqGridPager"></div>
					</div>
					
					<div class="col-xs-6" style='padding-right: 0px;'>
					    <table id="jqGridDetails"></table>
					    <div id="jqGridPagerDetails"></div>
					</div>
			</div>
					
		</div>
	</div>
	
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">请选择监护人</h4>
	      </div>
	      <div class="modal-body">
	      	<div class='center-block' style='width:800px;'>
	      		<div style='width:800px;margin-bottom: 10px;'>
	      			<form class='form-inline' action="">
		   						<div class='form-group'>
									    <label>监护人姓名：</label>
									    <input class='form-control' type='text' id='query_keeper'>
		   						</div>
		   						
		   						<div class='form-group'>
									    <label>手机号：</label>
									    <input class='form-control' type='text' id='query_cellphone'>
		   						</div>
					   
		   					</form>
	      		</div>
	      			<table id="jqGridKeeper"></table>
					<div id="jqGridPagerKeeper"></div>
	      		
	      	</div>
	        
	      </div>
	      <!-- <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary">保存</button>
	      </div> -->
	    </div>
	  </div>
	</div>
	
</body>

<script type="text/javascript">
$(function() {
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		$("#jqGridDetails").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		$("#jqGridKeeper").setGridHeight($(window).height()-300);
	});
	$("#jqGrid").jqGrid({
        url:"<c:url value='/associateMgr/listPupil'/>",
		// we set the changes to be made at client side using predefined word clientArray
        editurl: 'clientArray',
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
				label : '被监护人',
                name: 'name',
            },
            {
				label : '性别',
                name: 'gender',
                formatter:function(cellvalue){
                	return cellvalue==0?'女':'男';
                }
            },
            {
				label : '年龄',
                name: 'age',
            },
            {
				label: '类型',
                name: 'type',
                formatter:'select', 
                editoptions:{value:"0:精神障碍患者;1:残障人士"},
            },
            /* {
				label: '头像',
                name: 'head_img',
                formatter:function(cellvalue, options, rowObject){
                	var img =  "<img style='width:80px;height:80px;' src='"+(rowObject.head_img?rowObject.head_img:'../images/header_img_default.jpg')+"'/>";
                	return img;
                	//return "<img src='images/header_img_default.jpg'/>";
                }
            
            }, */
            {
				label: '身份证号',
                name: 'idcard',
                width:200,
            
            },
            {
				label: '社区',
                name: 'community',
                editable: false,
            
            } 
        ], 
                  loadonce: true,
          		  viewrecords: true,
          		height:$(window).height()-$('.panel-body').offset().top-80,
                  shrinkToFit :true,
                  autowidth:true,
                  rownumbers:true,
                  rownumWidth:50,
                  rowNum: 10,
                  pager: "#jqGridPager",
                  onSelectRow:function(rowid, status, e){
                	  
                	  if(rowid != null) {
  						jQuery("#jqGridDetails").jqGrid('setGridParam',{url: "<c:url value='/associateMgr/listAssociatedKeeper/'/>"+rowid,datatype: 'json'}); // the last setting is for demo only
  						//jQuery("#jqGridDetails").jqGrid('setCaption', '关联的监护人');
  						jQuery("#jqGridDetails").trigger("reloadGrid");
  						}	
                  },
                  onSortCol : clearSelection,
  				onPaging : clearSelection,
  				gridComplete:clearSelection,
    });
	function clearSelection() {
		/* jQuery("#jqGridDetails").jqGrid('setGridParam',{url: "clientArray", datatype: 'local'}); // the last setting is for demo purpose only
		jQuery("#jqGridDetails").trigger("reloadGrid"); */
		
		jQuery("#jqGridDetails").clearGridData();
		
	}
	  var f = { groupOp: "AND", rules: [] };
     $('#type_query').change(function(){
    	var self = this;
 		var value = self.value;
     	var grid = $('#jqGrid');
     	var field = "type";
     	var op = value==-1?"ne":"eq";

     	filter(f,grid,field,op,value);
     	
     });
     
     var timer;
     $('#pupil_query').keyup(function(){
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
     /* function filter(grid,field,op,value){
    	 grid.jqGrid('setGridParam', { search: false });
      	var postData = grid.jqGrid('getGridParam', 'postData');
      	    //$.extend(postData, { filters: "{'groupOp':'AND','rules':[{'field':'id','op':'cn',…':'1'},{'field':'name','op':'cn','data':'test'}]}" });
      	     

      	    var have;
      	   $.each(f.rules,function(i,v){
      		   if(v.field==field){
      			   v.data = value;
      			   v.op = op;
      			   v.field = field;
      			   have = true;
      		   }
      	   })
      	     if(!have)f.rules.push({ field: field, op: op, data: value });
      	    
      	     $.extend(postData, { filters:JSON.stringify(f)});
      		grid.jqGrid('setGridParam', { search: true });
      	    grid.jqGrid().trigger('reloadGrid', [{ page: 1}]);
    	 
     } */
     $("#jqGridDetails").jqGrid({
         url:"clientArray",
 		// we set the changes to be made at client side using predefined word clientArray
         /* editurl: 'clientArray', */
         datatype: "local",
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
 				label : '监护人姓名',
                 name: 'name',
                 width:200,
             },
             {
 				label: '电话',
                 name: 'cellphone',
                 width:100,
             },
             {
 				label: '职位',
                 name: 'position',
                 width:100,
                 editable: false,
             
             } 
             ,
             
             
             {
 				label: '住址',
                 name: 'address',
                 width:100,
                 editable: false,
             
             }
             ,
             {
 				label: '操作',
                 name: 'operation',
                 width:100,
                 editable: false,
                 search:false,
                 formatter: function( cellvalue, options, rowObject ){
              		return "<div><button class='btn btn-primary del' data-rowid='"+rowObject.id+"'>删除</button></div>";
              	}
             
             } 
         ],
         gridComplete:function(){
        	 $('td .del').off('click',del);
         	$('td .del').on('click',del);
         }, 
          loadonce: true,
  		viewrecords: true,
          shrinkToFit :true,
          height:$(window).height()-$('.panel-body').offset().top-80,
          autowidth:true,
          rownumbers:true,
          rownumWidth:50,
          rowNum: 10,
          pager: "#jqGridPagerDetails",
          onSelectRow:function(rowid, status, e){
        	  
          }
     });
     function del(event){
			event.preventDefault();
			
			var grid = $("#jqGrid");
         var rowKey = grid.getGridParam("selrow");
         var row = grid.getRowData(rowKey);
         var pupilId =row.id;
         var keeperId =$(this).data('rowid'); 
         	
			$.ajax({
				url:"<c:url value='/associateMgr/del/'/>",
				dataType:'json',
				type:'post',
				data:{
					pupilId:pupilId,
					keeperId:keeperId,
				},
				success:function(data, textStatus, jqXHR){
					alert("删除成功！");
					$("#jqGridDetails").delRowData(keeperId);
				},
				error:function( jqXHR, textStatus, errorThrown){
					alert("删除失败,请稍后再试！");
				}
			});
			
			return false;
		}
 	$("#btn_add_keeper").click(function(){
 		
 		var grid = $("#jqGrid");
        var rowKey = grid.getGridParam("selrow");
        if(!rowKey){
        	alert("请先选中被监护人!");
        }else{
        	
        	var keeperIds = $("#jqGridDetails").getCol('id');
        	var strKeeper = "";
        	$.each(keeperIds,function(i,v){
        		
        		strKeeper+=v+',';
        	})
        	jQuery("#jqGridKeeper").jqGrid('setGridParam',{
        		url: "<c:url value='/associateMgr/listKeeper'/>",
        		datatype: 'json',
        		postData:{
        			keeperIds:strKeeper,
        		}
        		}); // the last setting is for demo only
			jQuery("#jqGridKeeper").trigger("reloadGrid");
				
				
        	$('#myModal').modal('show');
        }
 	});
 	
 	$("#jqGridKeeper").jqGrid({
        url:"clientArray",
		// we set the changes to be made at client side using predefined word clientArray
        /* editurl: 'clientArray', */
        datatype: "local",
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
				label : '监护人姓名',
                name: 'name',
            },
            {
				label: '电话',
                name: 'cellphone',
                width:100,
            },
            {
				label: '社区',
                name: 'community',
                editable: false,
            
            } 
            ,
            
            
            {
				label: '住址',
                name: 'address',
                editable: false,
            
            }
            ,
            {
				label: '操作',
                name: 'operation',
                editable: false,
                search:false,
                formatter:function( cellvalue, options, rowObject ){
            		return "<div><button class='btn btn-primary add' data-rowid='"+rowObject.id+"'>添加</button></div>";
            	}
            
            } 
        ],
        gridComplete:function(){
        	$('td .add').off('click',add);
        	$('td .add').on('click',add);
        }, 
         loadonce: true,
 		viewrecords: true,
         width:800,
         height:$(window).height()-300,
         //shrinkToFit:true,
         autowidth:false,
         rownumbers:true,
         rownumWidth:50,
         rowNum: 10,
         pager: "#jqGridPagerKeeper",
    });
 	function add(event){
		event.preventDefault();
		
		var grid = $("#jqGrid");
        var rowKey = grid.getGridParam("selrow");
        
        var row = grid.getRowData(rowKey);
        var pupilId =row.id;
		
		var grid = $("#jqGridKeeper");
		var keeperId =$(this).data('rowid'); 
       var row = grid.getRowData(keeperId);
       
       var rowKey = grid.getGridParam("selrow");
		$.ajax({
			url:"<c:url value='/associateMgr/add/'/>",
			dataType:'json',
			type:'post',
			data:{
				pupilId:pupilId,
				keeperId:keeperId,
			},
			success:function(data, textStatus, jqXHR){
				alert("添加成功！");
				$("#jqGridDetails").addRowData(keeperId,row,'last');
				$("#jqGridKeeper").delRowData(keeperId);
			},
			error:function( jqXHR, textStatus, errorThrown){
				alert("添加失败,请稍后再试！");
			}
		});
		return false;
	}
 	var f1 = { groupOp: "AND", rules: [] };
 	 var timer;
     $('#query_keeper').keyup(function(){
 		var self = this;
 		var value = self.value;
 		var grid = $('#jqGridKeeper');
      	var field = "name";
      	var op = "cn";
      	
 		if(timer) { clearTimeout(timer); }
 		timer = setTimeout(function(){
 			//timer = null;
 			filter(f1,grid,field,op,value);
 		},0);
      	
      }); 
     
     var timer1;
     $('#query_cellphone').keyup(function(){
 		var self = this;
 		var value = self.value;
 		var grid = $('#jqGridKeeper');
      	var field = "cellphone";
      	var op = "cn";
      	
 		if(timer1) { clearTimeout(timer1); }
 		timer1 = setTimeout(function(){
 			//timer = null;
 			filter(f1,grid,field,op,value);
 		},0);
      	
      }); 
    
});
</script>
</html>