<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>组织结构</title>
   	<%@ include file="../base/taglib.jsp"%>
   	<%@ include file="../base/importCss.jsp"%>

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
                  <li>
                     <i class="icon-cog"></i>组织架构
                  </li>
                  <li>地区管理</li>
               </ul>
<div class="panel panel-info" style="position: relative;">

   	 	<div class="panel-heading" style='overflow: hidden;'>
							地区层级列表
   	</div>
   	<div class="panel-body">
   		<div class="col-md-3" style="overflow: scroll; height: 500px;">
				<div id="tree_part"></div>
   		
   		
   		</div>
	   	<div class="col-md-9">
	   		 <table id="account_table" class="table table-bordered table-striped table-hover">
	            <thead>
	                <tr style="background: #F5F5F5;">
	                  <th class="text-center" style="background: #3499db;color: #ffffff;">序号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;width:30%;">地区名称</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;width:30%;">地区编码</th>
	                     <th class="text-center" style="background: #3499db;color: #ffffff;width:30%;">状态</th>
	                </tr>
	            </thead>
	        </table>
        </div>
   	</div>
</div>
</body>
<script type="text/javascript">
var bData,json;
var polygon;
$(function() {
	 
 	$('#tree_part').jstree({
		'core' : {
			"themes" : { "stripes" : true },
			'data' : {
				"url" : "/ejwms/organization/regionTree.do",
				"dataType" : "json",
				"async": true, 
				"data":function(node){
					 return {"id" : 0};
		        }
			}
		}
	}).on("select_node.jstree", function(e, data){
		query(data.node.id);
	}).on("open_node.jstree", function(e, data) {
		
		}).on("loaded.jstree", function() {
// 					$('#tree_part').jstree("open_all");
		});

     
		//我的门店table列表
		$("#account_table")
				.dataTable(
						{
							serverSide : false, //分页，取数据等等的都放到服务端去
							processing : true, //载入数据的时候是否显示“载入中”
							pageLength : 10, //首次加载的数据条数
							ordering : false, //排序操作
							"bLengthChange" : false,
							"bPaginate" : true, //翻页功能
							"bFilter" : true,
							"bDeferRender" : true,
							ajax : {//类似jquery的ajax参数，基本都可以用。
								type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
								url : "/ejwms/organization/queryRegion.do",
								dataType : "json",
								dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
								data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
									var p = {};
									p.kid = 0;
									return p;
								},
							},
							"aoColumnDefs" : [ {
								sDefaultContent : '',
								aTargets : [ '_all' ]
							} ],
							columns : [//对应上面thead里面的序列
									{
										data : "xh",
										"sClass" : "text-center"
									},
									{
										data : "name",
										"sClass" : "text-center"
									},
									{
										data : "code",
										"sClass" : "text-center"
									},
									{
										data : function(e) {
											var sContent ="";
											if(e.status==1){
												sContent="可用"
											}else{
												sContent="不可用"
											}
											return sContent;
										},
										"sClass" : "text-center"
									}],
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
								search : "关键字查询      ",
								zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
								//下面三者构成了总体的左下角的内容。
								info : "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
								infoEmpty : "0条记录",//筛选为空时左下角的显示。
								infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
							}
						});
	});

	//查询
	function query(nodeid) {
		$("#account_table").dataTable().fnClearTable();
		$.ajax({
			type : "post",//不写此参数默认为get方式提交
			async : false, //设置为同步
			url : "/ejwms/organization/queryRegion.do?kid=" + nodeid,//请求的uri
			data : '',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				$("#account_table").dataTable().fnAddData(data.data, true);
			}
		});

	};


</script>
<!-- END BODY -->

</html>