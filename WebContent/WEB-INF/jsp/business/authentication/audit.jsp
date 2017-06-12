<%@page import="com.huaao.common.extension.StringUtil"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
<%-- <%@ include file="../../base/importJs.jsp"%>  --%>
<style type="text/css">
.help-block {
	color: red;
	float: left;
	position: relative;
}

#audit_form button {
	margin-left: 40px;
}

.imgs img {
	width: 200px;
	height: 100px;
}

.audit_flow .status {
	border-radius: 20px;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->

<!-- END PAGE LEVEL SCRIPTS -->
<script type="text/javascript" src='plugins/jquery.form.js'></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<%
String oper = (String)request.getAttribute("oper");
		String operAction = oper.equals("show")?"查看":"审核";
			SqlRowSet cureApply = (SqlRowSet)request.getAttribute("userForAudit");
		
			cureApply.next();
// 			String dept_name = cureApply.getString("dept_name");
// 			String dept_id = cureApply.getString("dept_id");
			int iType=0;
			iType = cureApply.getInt("type");
			int iId = cureApply.getInt("useridentity");
			String typeStr="";
			int iTypeEx=iType*100+iId;;
			if(iType==1){
				typeStr="hidden";
			}
			
			String type ="";
			
			
			
			String identity =cureApply.getString("useridentityname")==null?"":cureApply.getString("useridentityname");
			
			/* switch(iType){
				case 1:
					type="居民";
					switch(iId){
					case 1:
						identity="游客";
						break;
					case 2:
						identity="访客";				
						break;
					case 3:
						identity="业主";
						break;
					case 4:
						identity="租客";
						break;
					}
					break;
				case 2:
					type="民警";	
					switch(iId){
					case 1:
						identity="社区民警";
						break;
					case 2:
						identity="派出所民警";				
						break;
					case 3:
						identity="分局民警";
						break;
					}
					break;
				case 3:
					type="群干";
					identity="群干";
					break;
				case 4:
					type="网格员";
					identity="网格员";
					break;
				case 5:
					type="医院医生";
					identity="医院医生";
					break;
				case 6:
					type="社区医生";
					identity="社区医生";
					break;
			}  */
		 	String address = cureApply.getString("address");
			String addr1,addr2;
			if(address!=null&&address.trim().length()>0){
				String[] addrArr = address.split(";",-1);
				if(addrArr.length<3){
					addr1=addrArr[0];
					addr2="";
				}else{
					addr1=addrArr[0];
					addr2=addrArr[2];
				}
			}else{
				addr1 = "";
				addr2 = "";
			}
					
					
			String img1 = StringUtils.isEmpty(cureApply.getString("idcard_img1"))?"images/idcard_default_290_186.png": cureApply.getString("idcard_img1");
			String img2 = StringUtils.isEmpty(cureApply.getString("idcard_img2"))?"images/idcard_default_290_186.png": cureApply.getString("idcard_img2");
			
			String name =cureApply.getString("name");
			String idcard = cureApply.getString("idcard");
			%>
	<div class="panel panel-info">

		<div class="panel-heading">
			<div style='overflow: hidden'>
				<label>基本信息</label>
				<button class='btn btn-primary pull-right' id='btn_info_update'>修改</button>
			</div>
		</div>
		<div class="panel-body">

			<input class=' hidden' type='file' id='f_header_img'> <input
				class=' hidden' type='file' id='f_idcard_img1'> <input
				class=' hidden' type='file' id='f_idcard_img2'>
			<form class='form-horizontal' id='form_info'
				action="authentication/updateInfo" method="post"
				onsubmit="return false;">

				<input type="hidden" value='<%=cureApply.getInt("id")%>' name='id'>

				<div class='form-group'>
					<label class="col-sm-4 control-label">头像：</label>
					<div class='col-sm-8' id='img'>
						<input type="hidden" name='img' id='i_img'
							value='<%=StringUtils.isEmpty(cureApply.getString("img"))?"":cureApply.getString("img")%>'>
						<img class='img-circle' style="width: 80px; height: 80px;"
							src='<%=StringUtils.isEmpty(cureApply.getString("img"))?"images/header_default_96_96.png":cureApply.getString("img")%>'>
						<button class='btn btn-primary hidden btn_choose_img editable'
							id='btn_header_img'>请选择照片</button>
					</div>
				</div>
				<div class='form-group'>
					<label class="col-sm-4 control-label">姓名：</label>
					<div class='col-sm-8' id='name'>
						<label class='form-control-static'><%= cureApply.getString("name")==null?"":cureApply.getString("name")%></label>
						<input class='form-control hidden editable' name='name'
							value='<%= StringUtils.isEmpty(name)?"":name%>'>
					</div>


				</div>

				<div class='form-group'>
					<label class="col-sm-4 control-label">手机号：</label>
					<div class='col-sm-8' id='cellphone'>
						<label class='form-control-static'><%= cureApply.getString("cellphone")==null?"":cureApply.getString("cellphone")%></label>
						<input class='form-control hidden editable' name='cellphone'  readOnly="readonly" 
							value='<%= cureApply.getString("cellphone")==null?"":cureApply.getString("cellphone")%>'>
					</div>


				</div>

				<div class='form-group <%=typeStr %>'>
					<label class="col-sm-4 control-label">职位：</label>
					<div class='col-sm-8' id='position'>
						<label class='form-control-static'><%= cureApply.getString("position")==null?"":cureApply.getString("position")%></label>
						<input class='form-control hidden editable' name='position'
							value='<%= cureApply.getString("position")==null?"":cureApply.getString("position")%>'>
					</div>
				</div>
				<div class='form-group  <%=typeStr %>'>
					<label class="col-sm-4 control-label">警官号（职工号）：</label>
					<div class='col-sm-8' id='number'>
						<label class='form-control-static'><%= cureApply.getString("number")==null?"":cureApply.getString("number")%></label>
						<input class='form-control hidden editable' name='number'
							value='<%= cureApply.getString("number")==null?"":cureApply.getString("number")%>'>
					</div>



				</div>

				<div class='form-group'>
					<label class="col-sm-4 control-label">身份证：</label>
					<div class='col-sm-8' id='idcard'>
						<label class='form-control-static'><%= idcard%></label>
						<input class='form-control hidden editable' name='idcard'
							value='<%= StringUtils.isEmpty(idcard)?"":idcard%>'>
					</div>
				</div>

				<div class='form-group'>
					<label class="col-sm-4 control-label">用户类型：</label>
					<div class='col-sm-8'>
						<label class='form-control-static useridentityname'><%= identity%></label>
						<select
							class='form-control  hidden editable' name='useridentity' id='useridentity'>
						</select>
					</div>
				</div>
		 		<div class='form-group'>
					<label class="col-sm-4 control-label">所属地区：</label>
					<div class='col-sm-8' >
						<label class='form-control-static'><%= addr1 %></label>
						<%-- <input class='form-control hidden' name='addr1' value='<%= addr1%>'> --%>
						<input class='form-control hidden editable'  readonly='readonly'  
							value='<%=addr1%>'>
						
					</div>
				</div> 
				<div class='form-group'>
					<label class="col-sm-4 control-label">住址：</label>
					<div class='col-sm-8' id='address'>
						<label class='form-control-static'><%= addr2 %></label>
						<%-- <input class='form-control hidden' name='address' value='<%=addr2%>'> --%>
						<input class='form-control hidden editable' name='address'  
							value='<%=addr2%>'>
						
					</div>
				</div>

			


				<div style='clear: both;'>
						<div class='col-sm-offset-4 col-sm-8 hidden' id='info_control'>
							<button class='btn btn-primary  ' id='btn_info_confirm'>确定</button>
							<button class='btn btn-default ' id='btn_info_cancel'>取消</button>
						</div>

				</div>
			</form>

		</div>
		<div class="panel-heading">
			<div style='overflow: hidden'>
				<label>身份证照片</label>
				<button class='btn btn-primary pull-right  ' id='btn_img_update'>修改</button>
			</div>
		</div>
		<div class="panel-body imgs ">
			<ul class="clear dowebok" id='ligtbox_links' style='overflow: hidden;'>
				<li class='pull-left' style='margin-right: 40px;'>
					<!-- <h4>医保证</h4> -->
					<input type="hidden" name='idcard_img1' id='i_idcard_img1'
						value='<%= StringUtils.isEmpty(cureApply.getString("idcard_img1"))?"":cureApply.getString("idcard_img1")%>'>
					<img class='img-rounded' src="<%= img1%>">

					<button class='btn btn-primary hidden btn_choose_img'
						id='btn_idcard_img1'>请选择照片</button>
				</li>
				<li class='pull-left' style='margin-right: 40px;'>
					<!-- <h4>低保证</h4> -->
					<input type="hidden" name='idcard_img2' id='i_idcard_img2'
						value='<%= StringUtils.isEmpty(cureApply.getString("idcard_img2"))?"":cureApply.getString("idcard_img2")%>'>
					<img class='img-rounded' src="<%=img2 %>">

					<button class='btn btn-primary hidden btn_choose_img'
						id='btn_idcard_img2'>请选择照片</button>
				</li>
			</ul>
			<div class='hidden' id='img_control'
				style='margin-top: 10px; margin-left: 10px; margin-bottom: 10px;'>
				<a class='btn btn-primary ' id='btn_img_confirm'>确定</a> <a
					class='btn btn-default ' id='btn_img_cancel'>取消</a>
			</div>
		</div>

		<div class="panel-heading">审核意见</div>
		<div class="panel-body ">
			<textarea class="form-control" rows="4" placeholder="不能超过200个字符"
				id="reject_reason" name="reject_reason"
				<%=oper.equals("show")?"readonly":"" %>><%= StringUtils.isEmpty(cureApply.getString("reject_reason"))?"":cureApply.getString("reject_reason")%></textarea>
			<br>

			<c:if test='<%=oper.equals("edit") %>'>
				<button class='btn btn-success' id="accept">通过</button>
				<button class='btn btn-danger' id="reject">不通过</button>
			</c:if>


			<!-- <button class='btn btn-success' id="return"
				onclick="javascript:window.history.back(-1);return false;">返回</button> -->

		</div>
	</div>

	<div class="modal fade" id="imgModal" tabindex="-1" role="dialog"
		style='overflow: hidden;'>
		<div class="modal-dialog modal-lg"></div>

	</div>
</body>
<script type="text/javascript">
$(function() {$('.dowebok').viewer();
	$('[data-toggle="tooltip"]').tooltip();
	var dept_list = [];
	
	$.ajax({
  		type:"post",//不写此参数默认为get方式提交
  		async:true,   //设置为异步
  		url : "organization/queryUserTypeEx.do",//请求的uri
  		cache : false,
  		dataType : 'json',//后台返回前台的数据格式为json
  		data:{
  			typeId:	<%=iType%>
  		},
  		success : function(data) {
			var list = data.data;
			$.each(list,function(index,item){
				//dept_list.push({id:item.id,text:item.name});
				$("select[name='useridentity']").append("<option value='"+(item.code*100+item.role)+"' data-type='"+item.role+"'>"+item.name+"</option>");
			});
 			
				/* $("#sel_dept").change(function(evt){
					var source = $(evt.target);
					$("input[name='type']").val(source.find("option:selected").data("type"));
					$("input[name='useridentityname']").text(source.find("option:selected").text());
				});
				var identityOptions = $("select[name='useridentity'] option");
				if(identityOptions.length>0){
					$(identityOptions[0]).prop("selected",true);
					$("input[name='type']").val($(identityOptions[0]).data("type"));
				} */
      	},
      	error: function () {
			alert('系统出现异常，请稍后再试!');
        }
  	});
	
	<%-- $.ajax( {
  		type:"post",//不写此参数默认为get方式提交
  		async:true,   //设置为异步
  		url : "organization/getCommunityList.do",//请求的uri
  		cache : false,
  		dataType : 'json',//后台返回前台的数据格式为json
  		success : function(data) {
			var list = data.data;
			$.each(list,function(index,item){
				dept_list.push({id:item.id,text:item.name});
				$("#sel_dept").append("<option value='"+item.id+"'>"+item.name+"</option>");
			});
				$("#sel_dept").change(function(evt){
					var source = $(evt.target);
					/* $(".dept_name").text(source.find("option:selected").text()); */
					
					$("select[name='useridentity'] option").remove();
					
					$.ajax( {
				  		type:"post",//不写此参数默认为get方式提交
				  		async:true,   //设置为异步
				  		url : "organization/queryUserTypeEx.do",//请求的uri
				  		cache : false,
				  		dataType : 'json',//后台返回前台的数据格式为json
				  		data:{
				  			//deptid:	$("#sel_dept").val()
				  		},
				  		success : function(data) {
							var list = data.data;
							$.each(list,function(index,item){
								dept_list.push({id:item.id,text:item.name});
								$("select[name='useridentity']").append("<option value='"+item.role+"' data-type='"+item.code+"'>"+item.name+"</option>");
							});
								/* $("#sel_dept").change(function(evt){
									var source = $(evt.target);
									$("input[name='type']").val(source.find("option:selected").data("type"));
									$("input[name='useridentityname']").text(source.find("option:selected").text());
								});
								var identityOptions = $("select[name='useridentity'] option");
								if(identityOptions.length>0){
									$(identityOptions[0]).prop("selected",true);
									$("input[name='type']").val($(identityOptions[0]).data("type"));
								} */
				      	},
				      	error: function () {
							alert('系统出现异常，请稍后再试!');
				        }
				  	}); 
				});
			$("#sel_dept").val(<%=dept_id%>);
			$.ajax( {
		  		type:"post",//不写此参数默认为get方式提交
		  		async:true,   //设置为异步
		  		url : "organization//queryUserType.do",//请求的uri
		  		cache : false,
		  		dataType : 'json',//后台返回前台的数据格式为json
		  		data:{
		  			deptid:	$("#sel_dept").val()
		  		},
		  		success : function(data) {
					var list = data.data;
					$.each(list,function(index,item){
						dept_list.push({id:item.id,text:item.name});
						$("select[name='useridentity']").append("<option value='"+item.role+"'>"+item.name+"</option>");
					});
						$("#sel_dept").change(function(evt){
							var source = $(evt.target);
							$("input[name='useridentityname']").text(source.find("option:selected").text());
						});
					$("select[name='useridentity']").val(<%=iId%>);
		      	},
		      	error: function () {
					alert('系统出现异常，请稍后再试!');
		        }
		  	}); 
      	},
      	error: function () {
			alert('系统出现异常，请稍后再试!');
        }
  	});  --%>
	
	
	
	$('#imgModal').on('mousewheel',function(e){
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

	var oper="<%=oper%>";
	//if(oper=="show")return;
	var applyId = <%= cureApply.getInt("id")%>;
	$("#reject").click(function(e){
		e.preventDefault();
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
	
	$("#accept").click(function(e){
		e.preventDefault();
		var reject = false;
		var reason = $("#reject_reason").val();
		var len = reason.trim().length;
		if(len<200&&len>=2){
			updateStatus(applyId,reject,reason);
		}else if(len>=200){
			alert("审核意见字符数过长！");
		}else if(len<2){
			alert("请输入详细的审核意见！");
		}

	})
	function updateStatus(applyId,reject,reason){
		$.ajax( {
      		type:"post",//不写此参数默认为get方式提交
      		async:true,   //设置为异步
      		url : "<c:url value='/authentication/auditing'/>",//请求的uri
      		data : {
      			applyId:applyId,
      			reject:reject,
      			reason:reason
      			},//传递到后台的参数				
      		cache : false,
      		dataType : 'json',//后台返回前台的数据格式为json
      		success : function(data) {
				alert("操作成功!");
				var row = data.data;
    			row.operation = "";
    			$("#jqGrid").setRowData(data.data.id,row);
    			$(".right-form").html("");
	      	},
	      	error: function () {
				alert('系统出现异常，请稍后再试!');
	        }
      	}); 
	}
	
	$("#btn_info_update").click(function(e){
		
		/* $(".form-group input,.input-group,.form-group select,.form-group button").toggleClass("hidden"); */
		$(".form-group .editable ").toggleClass("hidden");
		$(".form-group .form-control-static ").toggleClass("hidden");
		
		$("#info_control").toggleClass("hidden");
		$(this).toggleClass("hidden");
		$('#useridentity').val("<%=iTypeEx%>");
		 
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
		
		$(".imgs button").toggleClass("hidden");
		
		$("#img_control").toggleClass("hidden");
		
		$(this).toggleClass("hidden");
	});
	
	
	
	$("#btn_img_cancel").click(function(e){
		e.preventDefault();
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
 		url: "/ejwms/authentication/uploadImg",
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
 	$('#f_header_img').change(imgChange);
 	$('#f_idcard_img1').change(imgChange);
 	$('#f_idcard_img2').change(imgChange);
 	
 	function imgChange(){
 		if(this.files.length==1){
 			var file = this.files[0];
 			
 			if(file.size<1024000)
 			sendFile(file,curImg);
 			else alert("图片过大！");
 		}
 		
 	}
 	
 	$("#btn_info_confirm").click(function(event){
 		event.preventDefault();
 		$(".form-group input,.form-group select,.form-group button").toggleClass("hidden");
		$(".form-group .form-control-static ").toggleClass("hidden");
		
		$("#info_control").toggleClass("hidden");
		$("#btn_info_update").toggleClass("hidden");
 		 var options = {
 				url:'authentication/updateInfo',
 				type:'post',
 				dataType:'json',
		        success: function(responseText, statusText, xhr, $form)  {
			        if(responseText.code==0){
			        	alert("修改成功！");
		        	window.location.href = "authentication/index2";
			        	/* location.reload(); */
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
$(".imgs button").toggleClass("hidden");
		
		$("#img_control").toggleClass("hidden");
		$("#btn_img_update").toggleClass("hidden");
 		var options = {
 				url:'authentication/updateImg',
 				type:'post',
 				dataType:'json',
 				data:{
 					id:<%=cureApply.getInt("id")%>,
 					idcard_img1:$('#i_idcard_img1').val(),
 					idcard_img2:$('#i_idcard_img2').val(),
 					
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