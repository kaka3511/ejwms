<%@page import="com.huaao.model.home.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="../base/taglib.jsp"%>
	<%@ include file="../base/importCss.jsp"%>
   	
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<%@ include file="../base/importJs.jsp"%>
   	<!-- END PAGE LEVEL SCRIPTS -->
<html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8" />
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<meta name="MobileOptimized" content="320">
</head>

<!-- BEGIN BODY -->
<body >

<%
													UserInfo cuser = (UserInfo)request.getAttribute("cuser");
													//String address = cuser.getAddress();
// 													if(address!=null){
// 														String[] addrArr = address.split(";");
// 														address = addrArr[2];
// 													}else{
// 														address = "";
// 													}
												
													int iType = cuser.getUsertype();
													String type ="";
													
													int iId = cuser.getUserIdentity();
													String identity ="";
													
													switch(iType){
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
															type="医生";
															identity="医生";
															break;
													}
													String position =cuser.getPosition();
													%>
	<div class='container-fluid'>
		<div class="row">
			<div class='col-xs-9'>
					
					<div class='row'>
						<div class='col-xs-12'>
								<table id="jqGrid">
								
								<!--   <thead>
                <tr style="background: #F5F5F5;">
                	<th class="text-center" style="background: #3499db;color: #ffffff;">序号</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">ID</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">类型</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">申请人</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">申请时间</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">审批状态</th>
                    <th class="text-center" style="background: #3499db;color: #ffffff;">操作</th>
                </tr>
            </thead> -->
								</table>
					   		 <div id="jqGridPager"></div>
						</div>
							
					</div>
			</div>
			
			<div class='col-xs-3'>
				<div class="list-group">
						<div class="list-group-item active">
						
							<div class='row'>
								<div class='col-xs-12'>
								
									
									<div >
											<div  style='margin-left:40px;margin-top: 30px; '>
												<img class='img img-circle' style='width:128px;height:128px;' src='${cuser.img==null?"../images/header_default_96_96.png":cuser.img}' >
											</div>
											<h2 style='margin-left: 40px;'>${cuser.name }</h2>
											<ul class=" " style='list-style: none;'>
												<%-- li><span class="fa fa-user m-r-xs" style="width: 12px;"></span> <label> 角 &nbsp;&nbsp;色:</label>
													<%=type %></li>
													<li><span class="fa fa-user m-r-xs" style="width: 12px;"></span> <label> 身 &nbsp;&nbsp;份:</label>
													<%=identity %></li> --%>
													<li><span class="fa fa-user m-r-xs" style="width: 12px;"></span> <label> 职 &nbsp;&nbsp;位:</label>
													<%=position %></li> 
												<li><span class="fa fa-user m-r-xs" style="width: 12px;"></span> <label> 性 &nbsp;&nbsp;别:</label>
													${cuser.gender==1?"男":"女" }</li>
												<%-- <li><span class="fa fa-group m-r-xs" style="width: 12px;"></span> <label>社 &nbsp;&nbsp;区:</label>
													<span>${cuser.community.name }</span></li> --%>
<!-- 												<li><span class="fa fa-home m-r-xs" style="width: 12px;"></span> <label>地  &nbsp;&nbsp;址:</label> -->
<%-- 													<span><%=address %></span></li> --%>
<!-- 												<li><span class="fa fa-phone m-r-xs" style="width: 12px;"></span> <label>手机号:</label> -->
<%-- 													${cuser.cellphone==null?"": cuser.cellphone}</li> --%>
											</ul>
									</div>
									
								</div>
								
							
							</div>
							
						</div>
					</div>
				
				
			</div>
			
		
		</div>
	</div>
	
	
	
	
</body>
<!-- END BODY -->

<script type="text/javascript">

$(function(){
	$(window).resize(function(){
		$("#jqGrid").setGridHeight($(window).height()-110);
	});
	$("#jqGrid").jqGrid({
		
		url:"<c:url value='/home/wellcome/list'/>",
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
            }
            ,
            {
				label: '类型',
                name: 'rtype',
                classes: 'thread',
                formatter:function( cellvalue, options, rowObject ){
                	
                	var type = rowObject.rtype;
                	var typeName ;
                	if(type==1){
                		
                		typeName = "自助登记";
                	}else if(type==2){
                		typeName = "网上办事";
                		
                	}else if(type==3){
                		typeName = "爱心义卖";
                		
                	}else if(type==4){
                		typeName = "实名认证";
                		
                	}else if(type==5){
                		typeName = "报警处理";
                		
                	}
                	
                	return typeName;
                } 
            },
            {
                name: 'type',
                hidden:true,
                
            },
            {
				label: '申请人',
                name: 'cuser',
                
            },
            {
				label : '申请时间',
                name: 'createtime',
				formatter:function(cellvalue, options, rowObject){
                	
                	return ToDate("Y-m-d H:i:s",cellvalue);
                },
            },
            {
				label: '审批状态',
                name: 'status',
                formatter:function( cellvalue, options, rowObject ){
                	var result = formatter(rowObject.rtype,rowObject.status);
                	
                	return result.status;
                }
                
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
		loadonce: true,
		viewrecords: true,
        shrinkToFit :true,
        autowidth:true,
        height:$(window).height()-100,
        rownumbers:true,
        rownumWidth:50,
        rowNum: 10,
        pager: "#jqGridPager"
    });
		        
	function operFormat( cellvalue, options, rowObject ){
		
		var result = formatter(rowObject.rtype,rowObject.status);
       		return "<div><a class='btn btn-primary edit'  href='<c:url value='/"+result.path+"/view/?oper=edit&flag=0&type="+rowObject.type+"&id='/>"+rowObject.id+"'>审核</a></div>";
		
	}
	
	function operUnFormat( cellvalue, options, cell){
		return "";
	}
	
	function formatter(type,statu){
	    	var status;
	    	var path;
	    	if(type==1){
	    		path = "police/registerApply";
	    		switch(statu){
	    		case 0:
	    			status = "已提交";
	    			break;
	    		case 1:
	    			status = "网格员审核";
	    			break;
				case 2:
					status = "民警审核";
	    			break;
				case 3:
					status = "关联关系";
					break;
				case 4:
					status = "网格员驳回";
					break;
				case 5:
					status = "民警驳回";
					break;
				case 6:
					status = "群干委派";
					break;
				case 7:
					status = "群干驳回";
					break;
				case 8:
					status = "已结束";
					break;
	    	
	    		}
	    	}else if(type==2){
	    		path = "onlineJob";
	    		switch(statu){
	    		case 0:
	    			status = "已提交";
	    			break;
	    		case 1:
	    			status = "社区复核";
	    			break;
				case 2:
					status = "社区民警审核";
	    			break;
				case 3:
					status = "确认收治";
					break;
				case 4:
					status = "社区驳回";
					break;
				case 5:
					status = "社区民警驳回";
					break;
				case 11:
					status = "入院";
					break;
				case 7:
					status = "派出所民警审核";
					break;
				case 8:
					status = "分局民警审核";
					break;
	    	
	    		}
	    	}else if(type==3){
	    		path = "goodsSale";
	    		switch(statu){
	    		case 0:
	    			status = "已删除";
	    			break;
	    		case 1:
	    			status = "已提交";
	    			break;
				case 2:
					status = "审批已通过";
	    			break;
				case 3:
					status = "驳回";
					break;
	    	
	    		}
	    		
	    	}else if(type==4){
	    		path='authentication';
	    		status = '资料审核中';
	    	}else if(type==5){
	    		path='alert';
	    		status='未处理';
	    	}
	    	
	
	    	return {status:status,path:path};
	
	}
	
});
$("#jqGrid").closest("div.ui-jqgrid-view").children("div.ui-jqgrid-titlebar").children("span.ui-jqgrid-title").css("background-color", "goldenrod");
</script>

<style type="text/css">
.ui-th-div ui-jqgrid-sortable{
color:goldenrod;
}

</style>
</html>