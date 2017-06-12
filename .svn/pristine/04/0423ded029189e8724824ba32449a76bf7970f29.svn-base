<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>警情信息-警情信息</title>
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>

<style type="text/css">
.help-block {
	color: red;
	float: left;
	position: relative;
}
#audit_form button{
margin-left: 40px;
}
.imgs img{
	width:300px;
	height:150px;
	cursor: pointer;
}
.audit_flow div{
display: inline-block;
vertical-align: top;
text-align: center;
}

           .modal-body {
                height: 600px;
                overflow: auto;
            }
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<%@ include file="../../base/importJs.jsp"%>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<%
			String oper = (String)request.getAttribute("oper");
			String operAction = oper.equals("show")?"查看":"审核";
			SqlRowSet pupil = (SqlRowSet)request.getAttribute("pupilForAudit");
			pupil.next();
			String head = pupil.getString("head_img");
			int type = pupil.getInt("type");
			%>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>自助登记</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
			<div style='overflow: hidden'>
				<label >基本信息</label>
					<button class='btn btn-primary pull-right' id='btn_show_history' style='margin-left:10px;'>查看修改历史</button>
				<button class='btn btn-primary pull-right' id='btn_info_update'>修改</button>
			</div>
		</div>
		<div class="panel-body">
			<input class=' hidden' type='file' id='f_header_img'>
			<input class=' hidden' type='file' id='f_idcard_img1'>
			<input class=' hidden' type='file' id='f_idcard_img2'>
			<input class=' hidden' type='file' id='f_idcard_img3'>
			<form class="form-horizontal " id='form_info'  action='police/updateInfo'>
				<input type="hidden" value='<%=pupil.getInt("id")%>' name='id'>
				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>头像：</label>
					<div class="col-xs-8">
						<img class='img-circle'  style="width:80px;height:80px;" src='<%=StringUtils.isEmpty(pupil.getString("head_img"))?"images/header_default_96_96.png":pupil.getString("head_img")%>'>
							<input type="hidden" name='head_img' id='head_img' value='<%=StringUtils.isEmpty(pupil.getString("head_img"))?"":pupil.getString("head_img")%>'>
							<button class='btn btn-primary hidden btn_choose_img editable'   id='btn_header_img'>请选择照片</button>
					</div>
				</div>
				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>姓名：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%= StringUtils.isEmpty(pupil.getString("name"))?"":pupil.getString("name")%></p>
							<input class='form-control hidden editable' name='name' value='<%= StringUtils.isEmpty(pupil.getString("name"))?"":pupil.getString("name")%>'>
					</div>
				</div>
				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>性别：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%= pupil.getInt("gender")==0?"女":"男"%></p>
						<select class="form-control hidden editable" name="gender">
							<option value="0">女</option>
							<option value="1">男</option>
						</select>
					</div>
				</div>

				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>年龄：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%= StringUtils.isEmpty(pupil.getString("age"))?"":pupil.getString("age")%></p>
						<input class='form-control hidden editable' name='age' value='<%= StringUtils.isEmpty(pupil.getString("age"))?"":pupil.getString("age")%>'>
					</div>
				</div>

				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>身份证：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%= StringUtils.isEmpty(pupil.getString("idcard"))?"":pupil.getString("idcard")%></p>
						<input class='form-control hidden editable' name='idcard' value='<%= StringUtils.isEmpty(pupil.getString("idcard"))?"":pupil.getString("idcard")%>'>
					</div>
				</div>

				<div class='form-group col-xs-4'>
					<label class='col-xs-4 control-label'>住址：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%= StringUtils.isEmpty(pupil.getString("addr"))?"":pupil.getString("addr")%></p>
						<%-- <sys:areaSelectTag limit="false" url="organization/queryRegionByPid.do" name="addr" value='<%= StringUtils.isEmpty(pupil.getString("addr"))?"":pupil.getString("addr")%>'></sys:areaSelectTag> --%>
						<input class='form-control hidden editable' name='addr' value='<%= StringUtils.isEmpty(pupil.getString("addr"))?"":pupil.getString("addr")%>'>
					</div>
				</div>

				<div class='form-group col-xs-4 ' >
					<label class='col-xs-4 control-label'>类型：</label>
					<div class="col-xs-8">

						<p class="form-control-static">
							<c:set value="<%=type %>" var="typeSel"></c:set>
							<c:forEach items="${pupilTypeList }" var="item">
								<c:if test='${item.dictionary_code==typeSel }'>
									${item.dictionary_name }
								</c:if>
							</c:forEach>
						</p>
						
						<select class="form-control hidden editable" name="type">
							<c:forEach items="${pupilTypeList }" var="item">
								<c:choose>
									<c:when test='${item.dictionary_code==typeSel }'>
										<option value="${item.dictionary_code }" selected>${item.dictionary_name }</option>
									</c:when>
									<c:otherwise>
										<option value="${item.dictionary_code }">${item.dictionary_name }</option>
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
						</select>
					</div>
				</div>

				<div class='form-group col-xs-4 ' >
					<label class='col-xs-4 control-label'>病史（或情况说明）：</label>
					<div class="col-xs-8">

						<p class="form-control-static"><%= StringUtils.isEmpty(pupil.getString("illness"))?"":pupil.getString("illness")%></p>
						<textarea class='form-control hidden editable' name='illness' ><%= StringUtils.isEmpty(pupil.getString("illness"))?"":pupil.getString("illness")%></textarea>
					</div>
				</div>
				
					<div style='clear: both;'>
					<div class='col-sm-4'>
						<div class='col-sm-offset-4 col-sm-8 hidden' id='info_control' style="padding: 0px;">
							<button class='btn btn-primary  ' id='btn_info_confirm'>确定</button>
							<button class='btn btn-default ' id='btn_info_cancel'>取消</button>
						</div>
					</div>
					
				</div>
			</form>

			
		</div>
		<div class="panel-heading">
			<div style='overflow: hidden'>
				<label >三证照片</label>
				<button class='btn btn-primary pull-right  ' id='btn_img_update' >修改</button> 
			</div>
		</div>
		<%
		String nums = pupil.getString("nums");
			String imgs = pupil.getString("imgs");
			
			
		String[] finalNums = new String[]{"","",""};
		String[] finalImgs = new String[]{"","",""};
		
		if(!StringUtils.isEmpty(nums)&&!StringUtils.isEmpty(imgs)){
			
			String[] numArr = nums.split(",");
			String[] imgArr = imgs.split(",");
			for(int i=0;i<imgArr.length;i++){
				
				String num = numArr[i];
				finalNums[i] = num.equals("")?"":num;
				
				String img = imgArr[i];
				finalImgs[i] = img.equals("")?"":img;
						
			}
		}
		List flowList = (List)request.getAttribute("auditFlow");
		int size = flowList.size();
		Map applyer = new HashMap();
		try {
			applyer= (Map)flowList.get(0);
		} catch (Exception e) {
			// TODO: handle exception
		}
		Map audit1 = new HashMap();
		try {
			audit1= (Map)flowList.get(1);
		} catch (Exception e) {
			// TODO: handle exception
		}
		Map audit2 = new HashMap();
		try {
			audit2= (Map)flowList.get(2);
		} catch (Exception e) {
			// TODO: handle exception
		}
		Map audit3 = new HashMap();
		try {
			audit3= (Map)flowList.get(3);
		} catch (Exception e) {
			// TODO: handle exception
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		String date = applyer.get("auditdate")==null?"":format.format(new Date((Long)applyer.get("auditdate")*1000));
		String date1 = audit1.get("auditdate")==null?"":format.format(new Date((Long)audit1.get("auditdate")*1000));
		String date2 = audit2.get("auditdate")==null?"":format.format(new Date((Long)audit2.get("auditdate")*1000));
		String date3 = audit3.get("auditdate")==null?"":format.format(new Date((Long)audit3.get("auditdate")*1000));
		
		
		
		%>
		<div class="panel-body imgs">
			<ul class="dowebok clear">
				<li class='pull-left' style='margin-right: 40px;'>
					<h4>医保证（证号：<span class='number'><%=finalNums[0] %></span><input class='hidden editable' name="number1" value="<%=finalNums[0] %>">）</h4>
					
					<img class='img-rounded'   src='<%=StringUtils.isEmpty(finalImgs[0])?"images/idcard_default_290_186.png":finalImgs[0]%>'>
					<input type="hidden" name='idcard_img1' id='i_idcard_img1' value='<%=finalImgs[0]%>'>
					<button class='btn btn-primary hidden btn_choose_img'   id='btn_idcard_img1'>请选择照片</button>
				</li >
				<li class='pull-left' style='margin-right: 40px;' >
					<h4>低保证（证号：<span class='number'><%=finalNums[1] %></span><input class='hidden editable' name="number2" value="<%=finalNums[1] %>">）</h4>
					<img class='img-rounded'  src="<%=StringUtils.isEmpty(finalImgs[1])?"images/idcard_default_290_186.png":finalImgs[1]%>">
					<input type="hidden" name='idcard_img2' id='i_idcard_img2' value='<%=finalImgs[1]%>'>
					<button class='btn btn-primary hidden btn_choose_img'   id='btn_idcard_img2'>请选择照片</button>
				</li>
				<li class='pull-left' style='margin-right: 40px;'>
					<h4>残疾证（证号：<span class='number'><%=finalNums[2] %></span><input class='hidden editable' name="number3" value="<%=finalNums[2] %>">）</h4>
					<img class='img-rounded'  src="<%=StringUtils.isEmpty(finalImgs[2])?"images/idcard_default_290_186.png":finalImgs[2]%>">
					<input type="hidden" name='idcard_img1' id='i_idcard_img3' value='<%=finalImgs[2]%>'>
					<button class='btn btn-primary hidden btn_choose_img'   id='btn_idcard_img3'>请选择照片</button>
				</li>
			</ul>	
				<div class='hidden' id='img_control' style='margin-top: 10px;margin-left: 10px;margin-bottom: 10px;'>
						<a class='btn btn-primary ' id='btn_img_confirm'>确定</a>
						<a class='btn btn-default ' id='btn_img_cancel'>取消</a>
				</div>
				
		</div>
		<div class="panel-heading">
			审核流程
		</div>
		<div class='panle-body'>
			<div class="container-fluid">
				<div class='row  audit_flow'>
							<div style=''>
								<button class='btn btn-<%=applyer.get("status")!=null?(((Integer)applyer.get("status"))==0?"success":"danger"):"warning" %> status' data-remark='<%=applyer.get("status")==null?"":"已提交" %>' data-name='<%=applyer.get("audit")==null?"":applyer.get("audit") %>' data-position='<%=applyer.get("position")==null?"":applyer.get("position") %>'>申请人：<%=applyer.get("audit")==null?"":applyer.get("audit") %>-<%=applyer.get("position")==null?"":applyer.get("position") %></button>
								<img src='images/online_job_arrow.png'>
								<p id = 'flow_time_1'> <%=date%></p>
							</div>
							<div >
								<button class='btn btn-<%=audit1.get("status")!=null?(((Integer)audit1.get("status"))==6?"success":"danger"):"warning" %> status' data-remark='<%=audit1.get("remark")!=null?audit1.get("remark"):"暂无信息！" %>' data-name='<%=audit1.get("audit")==null?"":audit1.get("audit") %>' data-position='<%=audit1.get("position")==null?"":audit1.get("position") %>'>群干委派：<%=audit1.get("audit")==null?"":audit1.get("audit") %>-<%=audit1.get("position")==null?"":audit1.get("position") %></button>
								<img src='images/online_job_arrow.png'>
								<p id = 'flow_time_2'> <%=date1%></p>
							</div>
							<div >
								<button class='btn btn-<%=audit2.get("status")!=null?(((Integer)audit2.get("status"))==1?"success":"danger"):"warning" %> status' data-remark='<%=audit2.get("remark")!=null?audit2.get("remark"):"暂无信息！" %>' data-name='<%=audit2.get("audit")==null?"":audit2.get("audit") %>' data-position='<%=audit2.get("position")==null?"":audit2.get("position") %>'>网格员审核：<%=audit2.get("audit")==null?"":audit2.get("audit") %>-<%=audit2.get("position")==null?"":audit2.get("position") %></button>
								<img src='images/online_job_arrow.png'>
								<p id = 'flow_time_3'> <%=date2 %></p>
							</div>
							<div >
								<button class='btn btn-<%=audit3.get("status")!=null?(((Integer)audit3.get("status"))==2?"success":"danger"):"warning" %> status' data-remark='<%=audit3.get("remark")!=null?audit3.get("remark"):"暂无信息！" %>' data-name='<%=audit3.get("audit")==null?"":audit3.get("audit") %>' data-position='<%=audit3.get("position")==null?"":audit3.get("position") %>'>民警审核：<%=audit3.get("audit")==null?"":audit3.get("audit") %>-<%=audit3.get("position")==null?"":audit3.get("position") %></button>
								<p id = 'flow_time_4'> <%=date3 %></p>
							</div>
							
							
							
						</div>
			</div>
						
		</div>
		<c:if test='<%=oper.equals("edit") %>'>
		
		
			<div class="panel-heading">
				审核意见：
			</div>
			<div class="panel-body">
				<textarea class="form-control" rows="4" placeholder="不能超过200个字符" id="reject_reason" name="reject_reason"></textarea><br>
			</div>
		</c:if>
		
		<div>
		
		  <div  style="width:400px;padding-bottom: 10px;margin-top:20px;" class='audit_form'>
		  	<c:if test='<%=oper.equals("edit") %>'>
			  <input type="hidden" name="applyId" value="${applyId }">
			    <button  class ='btn btn-success'  id="accept" >通过</button>
			    <button  class='btn btn-danger  '    id="reject"   data-toggle="modal" data-target="#myModal">拒绝</button>
			    </c:if>
			     <button class='btn btn-success '    id="return"  onclick="javascript:window.history.go(-1);return false;">返回</button>
		  </div>
	  </div>
	  <div class="modal fade" id="imgModal" tabindex="-1" role="dialog" style='overflow: hidden;'>
		 <div class="modal-dialog modal-lg" >
		 </div>
		
	</div>
	
	
	<ul class="list-group hidden tooltip_tpl" style="text-align: left;">
	  <li class="list-group-item"><span style='font-weight: bold;'>姓名：</span><span class="name"> </span></li>
	  <li class="list-group-item"><span style='font-weight: bold;'>职位：</span><span class="position"></span></li>
	  <li class="list-group-item"><p style='font-weight: bold;' >审批意见：</p><p class=" remark" ></p></li>
	</ul>
</body>
<script type="text/javascript">
	$(function() {$('.dowebok').viewer();
		$("#btn_show_history").click(function(){
			$.getJSON("/ejwms/police/listUpdateHistory/<%=pupil.getInt("id")%>",function(resp){
				var content = "";
				$.each(resp.data,function(index,item){
					content+="<p style='border-bottom-width: 1px;border-bottom-style: solid; border-bottom-color: lightgray;padding-bottom: 5px;'>"+item.content+"</p>";
				});
				BootstrapDialog.alert(content);
			})
		});
		$(".audit_flow button").popover({
			"html":true,
			"placement":"top",
			"delay":0,
			"animation":false,
			"trigger":"hover",
			"content":function(){
				var name = $(this).data("name");
				var position = $(this).data("position");
				var remark = $(this).data("remark");
				var tpl = $(".tooltip_tpl").clone(true).toggleClass("hidden");
				tpl.find(".name").text(name);
				tpl.find(".position").text(position);
				tpl.find(".remark").text(remark);
				return tpl[0].outerHTML;
			}
		}
		); 
		$(".audit_flow button").click(function(e){
			e.preventDefault();
		});
		
		
		
		var oper = "<%=oper%>";
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
		
		var applyId = ${applyId};
		$("#reject").click(function(){
			var reject = true;
			var reason = $("#reject_reason").val();
			var len = reason.trim().length;
			if(len<200&&len>0){
				updateStatus(applyId,reject,reason);
			}else if(len>=200){
				alert("审核意见字符数过长！");
			}else if(len==0){
				alert("请输入详细的审核意见！");
			}
			
		}); 
		
		$("#accept").click(function(){
			var reject = false;
			var reason = $("#reject_reason").val();
			var len = reason.trim().length;
			if(len<200&&len>0){
				updateStatus(applyId,reject,reason);
			}else if(len>=200){
				alert("审核意见字符数过长！");
			}else if(len==0){
				alert("请输入详细的审核意见！");
			}

		})
		function updateStatus(applyId,reject,reason){
			$.ajax( {
	      		type:"post",//不写此参数默认为get方式提交
	      		async:true,   //设置为异步
	      		url : "<c:url value='/police/police/registerApply/audit/update'/>",//请求的uri
	      		data : {
	      			applyId:applyId,
	      			reject:reject,
	      			reason:reason
	      			},//传递到后台的参数				
	      		cache : false,
	      		dataType : 'json',//后台返回前台的数据格式为json
	      		success : function(data) {
					alert("操作成功!");
					window.history.back(-1);
		      	},
		      	error: function () {
					alert('系统出现异常，请稍后再试!');
		        }
	      	}); 
		}
		
		$("#btn_info_update").click(function(e){
			$(".form-group .editable ").toggleClass("hidden");
			$(".form-group .form-control-static ").toggleClass("hidden");
			
			$("#info_control").toggleClass("hidden");
			$(this).toggleClass("hidden"); 
		});
		
		$("#btn_info_cancel").click(function(e){
			e.preventDefault();
			/* $(".form-group input,.input-group,.form-group select,.form-group button").toggleClass("hidden"); */
			$(".form-group .editable ").toggleClass("hidden");
			$(".form-group .form-control-static ").toggleClass("hidden");
			
			$("#info_control").toggleClass("hidden");
			$("#btn_info_update").toggleClass("hidden");
		});
		
		$("#btn_img_update").click(function(e){
			$(".imgs .number").toggleClass("hidden");
			$(".imgs .editable").toggleClass("hidden");
			$(".imgs button").toggleClass("hidden");
			
			$("#img_control").toggleClass("hidden");
			
			$(this).toggleClass("hidden");
		});
		
		
		
		$("#btn_img_cancel").click(function(e){
			e.preventDefault();
			$(".imgs .number").toggleClass("hidden");
			$(".imgs .editable").toggleClass("hidden");
			$(".imgs button").toggleClass("hidden");
			
			$("#img_control").toggleClass("hidden");
			$("#btn_img_update").toggleClass("hidden");
		});
		
		function sendFile(file,imgParent){
	 		var filename = false;
	 		try{
	 			filename = file['name'];
	 		} catch(e){filename = false;}
	 		if(!filename){$(".note-alarm").remove();}
	 		var data = new FormData();
	 		data.append("file", file);
	 		$.ajax({
	 		data: data,
	 		type: "POST",
	 		url: "/ejwms/police/uploadImg",
	 		cache: false,
	 		contentType: false,
	 		processData: false,
	 		success: function(data) {
	 			//data是返回的hash,key之类的值，key是定义的文件名
	 			var result = eval('(' + data + ')'); 
	 			alert("上传成功！");
	 			imgParent.children('input').val(result.img);
	 			imgParent.children('img').attr('src',result.img);
	 		},
	 		error:function(){
	 			alert("上传失败");
	 		}
	 		});
	 	}
	 	
		var curImg;
		
		/* $(".btn_choose_img").click(function(event){
	 		event.preventDefault();
	 		curImg = $(this).siblings('img');
	 		$('#f_header_img').click();
	 		
	 	});  */
		
	 	 $("#btn_header_img").click(function(event){
	 		event.preventDefault();
	 		curImg = $(this).parent();
	 		$('#f_header_img').click();
	 		
	 	});
	 	$("#btn_idcard_img1").click(function(event){
	 		event.preventDefault();
	 		curImg = $(this).parent();
	 		$('#f_idcard_img1').click();
	 		
	 	});
	 	$("#btn_idcard_img2").click(function(event){
	 		event.preventDefault();
	 		curImg = $(this).parent();
	 		$('#f_idcard_img2').click();
	 		
	 	}); 
	 	
	 	$("#btn_idcard_img3").click(function(event){
	 		event.preventDefault();
	 		curImg = $(this).parent();
	 		$('#f_idcard_img3').click();
	 		
	 	});
	 	$('#f_header_img').change(imgChange);
	 	$('#f_idcard_img1').change(imgChange);
	 	$('#f_idcard_img2').change(imgChange);
	 	$('#f_idcard_img3').change(imgChange);
	 	
	 	function imgChange(){
	 		if(this.files.length==1){
	 			var file = this.files[0];
	 			
	 			if(file.size<4096000)
	 			sendFile(file,curImg);
	 			else alert("图片过大！");
	 		}
	 		
	 	}
	 	
	 	$("#btn_info_confirm").click(function(event){
	 		event.preventDefault();
	 		$(".form-group .editable").toggleClass("hidden");
			$(".form-group .form-control-static ").toggleClass("hidden");
			
			$("#info_control").toggleClass("hidden");
			$("#btn_info_update").toggleClass("hidden");
	 		 var options = {
	 				url:'police/updateInfo',
	 				type:'post',
	 				dataType:'json',
			        success: function(responseText, statusText, xhr, $form)  {
				        
				        if(responseText.code==0){
				        	alert("修改成功！");
				        	location.reload();
				        }else{
				        	alert("修改失败");
				        	
				        }
				    },
			        
			    };
			
			 $('#form_info').ajaxSubmit(options);
			 return false;
	 	});
	 	
	 	$("#btn_img_confirm").click(function(event){
	 		event.preventDefault();
	 		$(".imgs .number").toggleClass("hidden");
			$(".imgs .editable").toggleClass("hidden");
			$(".imgs button").toggleClass("hidden");
			
			$("#img_control").toggleClass("hidden");
			$("#btn_img_update").toggleClass("hidden");
	 		var options = {
	 				url:'police/updateImg',
	 				type:'post',
	 				dataType:'json',
	 				data:{
	 					id:<%=pupil.getInt("id")%>,
	 					
	 					number1:$('.imgs input[name="number1"]').val(),
	 					number2:$('.imgs input[name="number2"]').val(),
	 					number3:$('.imgs input[name="number3"]').val(),
	 					
	 					idcard_img1:$('#i_idcard_img1').val(),
	 					idcard_img2:$('#i_idcard_img2').val(),
	 					idcard_img3:$('#i_idcard_img3').val(),
	 					
	 				},
			        success: function(responseText, statusText, xhr, $form)  {
				        
				        if(responseText.code==0){
				        	alert("修改成功！");
				        	location.reload();
				        }else{
				        	alert("修改失败");
				        	
				        }
				    },
			        
			    };
			
			 $('#form_info').ajaxSubmit(options);
			 return false;
	 	}); 
	});
</script>
<!-- END BODY -->

</html>