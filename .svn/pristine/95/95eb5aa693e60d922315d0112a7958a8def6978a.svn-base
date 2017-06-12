<%@page import="java.util.ArrayList"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统设置-监控设备管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet"
	href="<c:url value='/plugins/font-awesome-master/css/font-awesome.min.css'/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value='/plugins/summernote-develop/dist/summernote.css'/>"
	type="text/css" />
<%@ include file="../../base/importJs.jsp"%>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<%
		String oper = (String)request.getAttribute("oper");
		String operName = "";
		String operAction = "";
		Integer id = null;
		String qbType = "健康测评";
		String qTitle = "";
		Integer type = 1;
		String typeName = "";

		int optionIndex = 0;

		String[] prefixArr = new String[]{"A.", "B.", "C.", "D.", "E.", "F."};
		String[] optionArr = new String[6];

		SqlRowSet question = null;
		if(oper.equals("edit")||oper.equals("show")){
			if(oper.equals("edit")){
				operName = "修改";
				operAction  = "保存";
			}
			else operName = "查看";
			question = (SqlRowSet) request.getAttribute("question");
			
			question.next();

			id = question.getInt("id");
			qTitle = StringUtils.isEmpty(question.getString("question")) ? "" : question.getString("question");
			type = question.getInt("type");
			typeName = type==1 ? "精神状态测评" : "危险度评测";

			optionArr = new String[]{question.getString("option0"), question.getString("option1"),
					question.getString("option2"), question.getString("option3"), question.getString("option4"),
					question.getString("option5")};

		}else{
			operName = "添加";
			operAction  = "添加";
		}
		
	%>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>题库管理</li>
		<li><%=operName %>题目</li>
	</ul>

	<div class="panel panel-info">
		<div class="panel-heading"><%=operName %>题目</div>
		<div class="panel-body">
			<form class="form-horizontal ">
				<input type="hidden" name="oper" value="<%=oper%>">
				<c:if test='<%=oper.equals("edit") %>'>
					<input type="hidden" name="id" id="id"
					value="<%=question.getInt("id")%>">
				</c:if>
				
				<ul class="page-breadcrumb breadcrumb">
					<div class="form-group">
						<label class="col-sm-2 control-label">题库类型：</label>
						<div class="col-sm-10">
						<input type="hidden" name="qbType" value='2'>
							<p class='form-control-static'><%=qbType%></p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">题目内容：</label>
						<div class="col-sm-6">
							<textarea rows="4" class="form-control" name='question' id='ta_question'><%=qTitle%></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">题目类型:</label>
						<div class="col-sm-6">
							<select class="form-control " id="type"
								name="type">
								<option value="1">精神状态测评</option>
								<option value="2">危险度评测</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">备选答案:</label>
						<div class="col-sm-6">
							<div id="ctn_options">
								<c:forEach items='<%=optionArr%>' var="item">
								<c:if test='${item!=null&&item ne ""}'>

											<div class="input-group" style="margin-bottom: 10px;">
												<span class="input-group-addon"><%=prefixArr[optionIndex]%></span>
												<input class='form-control' name='option<%=optionIndex++%>'
													value="${fn:substring(item,2,fn:length(item)) }" />
												<div class="input-group-btn">
													<button class='btn btn-danger' title="删除">&times;</button>
												</div>

											</div>

								</c:if>
							</c:forEach>
							</div>
							
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button class='btn btn-primary' id='btn_add_option'>添加选项</button>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<c:if test='<%= !oper.equals("show")%>'>
								<button class="btn btn-primary save" id='btn_form_confirm'><%=operAction %></button>
							</c:if>
							
							<button class="btn btn-success back"
								onclick="javascript:window.history.back(-1);return false;">返回</button>
						</div>
					</div>
			</form>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
	$(function() {
		var oper = "<%=oper%>";
		var prefixArr = ["A.", "B.", "C.", "D.", "E.", "F."];
		var optionCount = $('#ctn_options .input-group').length;
		if(oper=="edit"||oper=="show"){
			$('form select').val(<%=type%>);
			$('form select').change();
		}
		
		$("#btn_add_option").click(function(e){
			e.preventDefault();
			if(optionCount==6){
				alert('最多可添加6个备选答案！');
				return;
			}
			var optionTemplate = $("<div><div class='input-group' style='margin-bottom: 10px;'> <span class='input-group-addon'>"+prefixArr[optionCount]+"</span> <input class='form-control option' name='option"+optionCount+"' /><div class='input-group-btn'><button class='btn btn-danger' title='删除'>&times;</button></div></div></div>");
			optionTemplate.find('button').click(function(e){
				e.preventDefault();
				del_option(this);
			});
			$("#ctn_options").append(optionTemplate);
			
			var rules = "{\"required\":true,\"messages\":{\"required\":\"备选答案不能为空\"}}";
			optionTemplate.find('input').rules('add',JSON.parse(rules));
			optionCount++;
			
		});
		

		$("#ctn_options button").click(function(e){
			e.preventDefault();
			del_option(this);
			
		});
		function del_option(_this){
			$(_this).parent().parent().parent().remove();
			optionCount--;
			
			$.each($('#ctn_options .input-group'),function(i,v){
				$(v).children('span').text(prefixArr[i]);
				$(v).children('input').attr('name','option'+i);
			});
		}
		
		$("form").validate({
			submitHandler:function(form){
				if($('#ctn_options .input-group').length==0){
					alert("请添加备选答案");
					return ;
				}
				/* if($('#ctn_option_answer input:checked').length==0){
					alert("请选择答案");
					return ;
				} */
				$.ajax({
					type : "post",//不写此参数默认为get方式提交
					async : true, //设置为异步
					url : "/ejwms/question/mgr",//请求的uri
					data :$('form').serialize(),
					processData:false,
					cache : false,
					dataType : 'json',//后台返回前台的数据格式为json
					success : function(data) {
						alert("操作成功!");
						window.location.href = "/ejwms/question/healthTestPaper";
					},
					error : function() {
						alert('系统出现异常，请稍后再试!');
					}
				}); 
				return false;
			},
			rules:{
				question:{
					required:true,
				},
				option0:{
					required:true,
				},
			},
			messages:{
				question:{
					required:"题目不能为空",
				},
				option0:{
					required:"备选答案不能为空",
				},
			},
			
			errorElement : "em",
			errorPlacement : function(error, element) {
				// Add the `help-block` class to the error element
				error.addClass("help-block");

				// Add `has-feedback` class to the parent div.form-group
				// in order to add icons to inputs
				$(element).parents(".form-group").addClass(
						"has-feedback");

				if ($(element).prop("type") === "checkbox") {
					error.insertAfter($(element).parent("label"));
				} else if($(element).hasClass('option')){
					error.insertAfter($(element).parent());
				}else {
					error.insertAfter(element);
				}

				// Add the span element, if doesn't exists, and apply the icon classes to it.
				if (!element.next("span")[0]&&!$(element).hasClass('option')) {
					$(
							"<span class='glyphicon glyphicon-remove form-control-feedback'></span>")
							.insertAfter(element);
				}
			},
			success : function(label, element) {
				// Add the span element, if doesn't exists, and apply the icon classes to it.
				if (!$(element).next("span")[0]&&!$(element).hasClass('option')) {
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
				if($(element).hasClass('option')){
					$(element).parent().next('em').remove();
				}
				$(element).parents(".form-group").addClass(
						"has-success").removeClass("has-error");
				$(element).next("span")
						.addClass("glyphicon-ok").removeClass(
								"glyphicon-remove");
			}
			
		});
	});
</script>
</html>