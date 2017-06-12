<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<li><i class="icon-cog"></i>业务管理</li>
		<li>积分管理</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
			<form class='form-inline' action="">

				<div class='form-group'>
					<label>姓名：</label> <input class='form-control' type='text'
						id='query_name'>
				</div>

				<div class='form-group'>
					<label>手机号：</label> <input class='form-control' type='text'
						id='query_cellphone'>
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
	
	<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加积分</h4>
      </div>
      <div class="modal-body">
      	<form class='form-horizontal' action="">
      		<input name='userId' id='i_id' type="hidden">
      		<div class="form-group">
      			<label class='col-xs-2 control-label'>姓名:</label>
      			<div class="col-xs-10">
      				<p class="form-control-static" id='p_name'></p>
      			</div>
      		</div>
      		
      		<div class="form-group">
      			<label class='col-xs-2 control-label star'>积分:</label>
      			<div class="col-xs-10">
      				<input class="form-control" name='point'>
      			</div>
      		</div>
      		
      		<div class="form-group">
      			<label class='col-xs-2 control-label'>备注:</label>
      			<div class="col-xs-10">
      				<textarea rows="4" class="form-control" name='description'></textarea>
      			</div>
      		</div>
      		<div class="form-group">
      			<div class="col-xs-offset-2 col-xs-10">
      				<button  class="btn btn-primary save">保存</button>
      				  <button  class="btn btn-success" data-dismiss="modal">返回</button>
      			</div>
      		</div>
      	</form>
        <div>
        
        </div>
      </div>
      <div class="modal-footer">
        
        <!-- <button type="button" class="btn btn-primary save">保存</button>
        <button type="button" class="btn btn-success" data-dismiss="modal">返回</button> -->
      </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
	$(function() {
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid")
				.jqGrid(
						{
							url : "<c:url value='/point/list'/>",
							// we set the changes to be made at client side using predefined word clientArray
							editurl : 'clientArray',
							datatype : "json",
							jsonReader : {
								root : 'data',
								repeatitems : true,
							},
							cmTemplate : {
								align : 'center',
								sortable : false
							},
							colModel : [
									{
										label : 'ID',
										name : 'id',
										key : true,
										hidden : true,
										search : false,
									},

									{
										label : '用户姓名',
										name : 'name',
										search : false,
									}/* ,
									{
										label: '用户类型',
						                name: 'type',
						                formatter:'select', 
						                editoptions:{value:"1:居民;2:民警;3:群干;4:网格员;5:医生"},
						             
						            }*/,
									 {
										label : '状态',
						                name: 'status',
						                formatter:'select', 
						                editoptions:{value:"1:未认证;2:资料审核中;3:已认证;4:认证失败"},
						            },
									{
										label : '手机号',
										name : 'cellphone',
										search : false,

									},
									/* {
										label : '头像',
										name : 'img',
										formatter : function(cellvalue) {
											var imgSrc = cellvalue ? cellvalue
													: "images/header_img_default.jpg";
											return "<img src='"+imgSrc+"' style='width:80px;height:80px;'></img>"
										}

									},  */
									
									{
										label : '当前积分',
										name : 'points',
										search : false,
									}, {
										label : '操作',
										name : 'operation',
										editable : false,
										search : false,
										formatter : function(cellvalue, options, rowObject) {
											return "<div><button class='btn btn-primary' data-id ='"+rowObject.id+"' data-name='"+rowObject.name+"' data-toggle='modal' data-target='#myModal'>增加积分</button></div>";

										}


									} ],
							loadonce : true,
							viewrecords : true,
							shrinkToFit : true,
							height:$(window).height()-$('.panel-body').offset().top-80,
							autowidth : true,
							rownumbers : true,
							rownumWidth : 50,
							rowNum : 10,
							pager : "#jqGridPager"
						});

		
		var f = {
			groupOp : "AND",
			rules : []
		};

		var timer;
		$('#query_name').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "name";
			var op = "cn";

			if (timer) {
				clearTimeout(timer);
			}
			timer = setTimeout(function() {
				//timer = null;
				filter(f, grid, field, op, value);
			}, 0);

		});

		var timer1;
		$('#query_cellphone').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "cellphone";
			var op = "cn";

			if (timer1) {
				clearTimeout(timer1);
			}
			timer1 = setTimeout(function() {
				//timer = null;
				filter(f, grid, field, op, value);
			}, 0);

		});
		
		$('#myModal').on('show.bs.modal', function (event) {
			  var button = $(event.relatedTarget) // Button that triggered the modal
			  var id = button.data('id');
			  var name = button.data('name'); 
			  var modal = $(this)
			  modal.find('#i_id').val(id);
			  modal.find('#p_name').text(name);
			})
			
	/* 	$('.modal-footer .save').click(function(e){
			e.preventDefault();
			
			
			
		}); */
		
		$.validator.setDefaults({
			
			submitHandler:function(form){
				$.ajax({
					url:"<c:url value='/point/mgr'/>",
					type:'post',
					dataType:'json',
					data:$('.modal form').serialize(),
					success:function(data){
						alert('操作成功！');
						$('#myModal').modal('hide');
						var row = $('#jqGrid').getRowData(data.data.id);
						$('#jqGrid').setRowData(data.data.id,{points:parseInt(row.points)+data.data.point});
						$('.modal form')[0].reset();
					},
					error:function(){
						alert('系统出现异常，请稍后再试!')
					}
				});
				return false;
			}
		})
		$(".modal form").validate({
			rules:{
				point:{
					required:true,
					digits:true,
					range:[0,1000]
				},
			},
			messages:{
				point:{
					required:"增加的积分不能为空",
					digits:"必须是正整数",
					range: $.validator.format( "请输入 {0} 到 {1}之间的整数值" ),
				},
			},
			
			errorElement : "em",
			errorPlacement : function(error, element) {
				// Add the `help-block` class to the error element
				error.addClass("help-block");

				// Add `has-feedback` class to the parent div.form-group
				// in order to add icons to inputs
				element.parents(".form-group").addClass(
						"has-feedback");

				if (element.prop("type") === "checkbox") {
					error.insertAfter(element.parent("label"));
				} else {
					error.insertAfter(element);
				}

				// Add the span element, if doesn't exists, and apply the icon classes to it.
				if (!element.next("span")[0]) {
					$(
							"<span class='glyphicon glyphicon-remove form-control-feedback'></span>")
							.insertAfter(element);
				}
			},
			success : function(label, element) {
				// Add the span element, if doesn't exists, and apply the icon classes to it.
				if (!$(element).next("span")[0]) {
					$(
							"<span class='glyphicon glyphicon-ok form-control-feedback'></span>")
							.insertAfter($(element));
				}
			},
			highlight : function(element, errorClass,
					validClass) {
				$(element).parents(".form-group").addClass(
						"has-error").removeClass("has-success");
				$(element).next("span").addClass(
						"glyphicon-remove").removeClass(
						"glyphicon-ok");
			},
			unhighlight : function(element, errorClass,
					validClass) {
				$(element).parents(".form-group").addClass(
						"has-success").removeClass("has-error");
				$(element).next("span")
						.addClass("glyphicon-ok").removeClass(
								"glyphicon-remove");
			}
			
		});

});
</script>
<!-- END BODY -->

</html>