<%@page import="java.util.HashMap"%>
<%@page import="java.io.IOException"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

 <%@ include file="../base/taglib.jsp"%>

 <%@ include file="../base/importCss.jsp"%>
<%@ include file="../base/importJs.jsp"%> 
 <%--
<script type="text/javascript"
	src="http://webapi.amap.com/maps?v=1.3&key=dc224c3fa3a1878bf789a04f9ffa89f9&plugin=AMap.Geocoder"></script>
	 --%>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.min.css'/>" />
   	<script type="text/javascript" src="<c:url value='/js/jstree.min.js'/>"></script>
   	
   	<style type="text/css">
   	
   	 .jstree-group-icon {
    background-image: url(../images/group.png) !important;
}
.jstree-person-icon {
    background-image: url(../images/person.png) !important;
}
   	</style>
</head>
<body>
	<%
		String oper = (String)request.getAttribute("oper");
	    String flag = (String)request.getAttribute("flag");
	    if(flag==null||flag==""){
	    	flag="1";
	    }
		String operAction = oper.equals("show")?"查看":"处理";
	
		SqlRowSet rowSet = (SqlRowSet) request.getAttribute("rowSet");
		boolean more = rowSet.next();

		int  id = -1;
		int uid = -1;
		String supplyTime = "";
		String supplierName = "";
		String supplierPhone = "";
		String location = "";
		String address = "";
		String supplyAddress = "";
		String policeLocation = "";
		String description = "";
		String result = "";

		Integer type = 1;
		Integer status = 1;
		String typeName = "";
		String statusName = "";

		ArrayList<String> imgList = new ArrayList<String>();
		ArrayList<String> voiceList = new ArrayList<String>();
		ArrayList<String> videoList = new ArrayList<String>();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (more) {
			id = rowSet.getInt("id");
			uid = rowSet.getInt("uid");
			supplyTime = format.format(new Date(rowSet.getLong("createtime") * 1000));
			supplierName = rowSet.getString("apply");
			supplierPhone = rowSet.getString("cellphone");
			description = rowSet.getString("description") == null ? "" : rowSet.getString("description");
			result = rowSet.getString("result") == null ? "" : rowSet.getString("result");

			type = rowSet.getInt("type");
			status = rowSet.getInt("status");
			if (type == 1)
				typeName = "居民报警";
			else if (type == 2)
				typeName = "民警举报";
			else if (type == 3)
				typeName = "居民举报";

			if (status == 0)
				statusName = "未处理";
			else if (status == 1)
				statusName = "已处理";

			location = rowSet.getString("location") == null ? "" : rowSet.getString("location");
			address = rowSet.getString("address") == null ? "" : rowSet.getString("address");
			supplyAddress = address;
			/* if(StringUtils.isEmpty(location)){
				supplyAddress = address;
			}else{
				supplyAddress = location;
			} */

			policeLocation = rowSet.getString("police_location") == null
					? "114.31995,30.647734"
					: rowSet.getString("police_location");

			String imgs = rowSet.getString("imgs");
			String voices = rowSet.getString("voices");
			String videos = rowSet.getString("videos");
			if (!StringUtils.isEmpty(imgs)) {
				if (imgs.contains("[")) {
					ObjectMapper mapper = new ObjectMapper();
					try {
						imgList = mapper.readValue(imgs, new ArrayList<String>().getClass());
					} catch (IOException e) {
					}
				} else {
					String[] imgArr = imgs.split(",");
					for (String item : imgArr) {
						if (!StringUtils.isEmpty(item))
							imgList.add(item);
					}
				}
			}
			
			if (!StringUtils.isEmpty(voices)) {
				if (voices.contains("[")) {
					ObjectMapper mapper = new ObjectMapper();
					try {
						voiceList = mapper.readValue(voices, new ArrayList<HashMap<String,Object>>().getClass());
					} catch (IOException e) {
					}
				} 
			}
			
			if (!StringUtils.isEmpty(videos)) {
				if (videos.contains("[")) {
					ObjectMapper mapper = new ObjectMapper();
					try {
						videoList = mapper.readValue(videos, new ArrayList<HashMap<String,Object>>().getClass());
					} catch (IOException e) {
					}
				} 
			}
		}
	%>
	<div class="panel panel-info">

		<div class="panel-heading">基础信息</div>
		<div class="panel-body">


			<form class="form-horizontal " action='case/update'>
				<input type="hidden" value='<%=id %>' name='id' >
				<div class='form-group'>
					<label class='col-xs-4 control-label'>报警类型：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=typeName%></p>

					</div>
				</div>
				<div class='form-group'>
					<label class='col-xs-4 control-label'>状态：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=statusName%></p>

					</div>
				</div>
				<div class='form-group'>
					<label class='col-xs-4 control-label'>报警时间：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=supplyTime%></p>

					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>报警人：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=supplierName%></p>

					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>电话：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=supplierPhone%></p>

					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>地点：</label>
					<div class="col-xs-8">
						<p class="form-control-static"><%=supplyAddress%></p>
						<!-- <button class='btn btn-primary' id='btn_show_map'>查看地图位置</button> -->

					</div>
				</div>

				<div class='form-group ' style='clear:left;'>
					<label class='col-xs-4 control-label'>描述：</label>
					<div class="col-xs-8">

						<p class="form-control-static"><%=description%></p>
					</div>
				</div>

			</form>
		</div>

		<div class="panel-heading">多媒体资料</div>
		<div class="panel-body">
			<form class='form-horizontal'>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>图片：</label>
					<div class="col-xs-8">
						<ul class="clear dowebok" id="dowebok">
							<c:forEach items="<%=imgList%>" var="item">
								<li class='pull-left' >
									<img src='${item }' class='img img-rounded' style='width: 200px; height: 100px;margin:10px;cursor: pointer;'>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>语音：</label>
					<div class="col-xs-8">

						<div>
							<c:forEach items="<%=voiceList%>" var="item">
								<div class='pull-left'>
									<audio controls="controls" height="100" width="100" style='margin:10px;'>
										  <source src="${item.url }" type="audio/mp3" />
										  <source src="${item.url }" type="audio/ogg" />
										<embed height="100" width="100" src="${item.url }" />
									</audio>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>视频：</label>
					<div class="col-xs-8">

						<div>
							<c:forEach items="<%=videoList%>" var="item">
								<div>
										<OBJECT classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B " width="200" height="100" id="MediaPlayer1">
										<EMBED src="${item.url }" autostart="false" loop="false" width='300' height='200'>
										</EMBED> 
										</OBJECT>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 control-label'>处理意见：</label>
					<div class="col-xs-8">

						<textarea class="form-control" rows="3" id='ta_result' <%=oper.equals("edit")?"":"readonly" %>><%=result %></textarea>
					</div>
				</div>

				<div class='form-group'>
					<div class="col-xs-offset-4 col-xs-8">
						<c:if test='<%=oper.equals("edit")%>'>
							<button class='btn btn-primary' id='btn_form_confirm'>直接处理</button>




							<button class='btn btn-info' id='btn_show_dialog'>委派处理</button>
						</c:if>


					<!-- 	<button class='btn btn-success'
							onclick="javascript:window.history.back(-1);return false;">返回</button> -->
						<c:if test='<%=oper.equals("edit")%>'>
						<div style='margin-top: 10px;'>
							
								 <input type="hidden"
									value='<%=uid %>' class='reward_id'>
								情况属实，奖励<input type="text" class='reward_points' value='0'>积分
						</div>
						</c:if>



					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">请选择要委派的对象</h4>
				</div>
				<div class="modal-body">
					<div class='center-block' style='width: 800px;height:400px;overflow: auto;'>
						<!-- <div style='width: 800px; margin-bottom: 10px;'>
							<form class='form-inline' action="">
								<div class='form-group'>
									<label>姓名：</label> <input class='form-control' type='text'
										id='query_keeper'>
								</div>

								<div class='form-group'>
									<label>手机号：</label> <input class='form-control' type='text'
										id='query_cellphone'>
								</div>

							</form>
						</div>
						<table id="jqGrid"></table>
						<div id="jqGridPager"></div> -->
						<div id='forward_tree'>
						
						</div>
					</div>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-primary"
						id='btn_modal_confirm'>确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button> 
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="imgModal" tabindex="-1" role="dialog" style='overflow: hidden;'>
		 <div class="modal-dialog modal-lg" >
		 </div>
		
	</div>
</body>
<script type="text/javascript">
$(function() {$('.dowebok').viewer();
	var oper = "<%=oper%>";
	var flag="<%=flag%>";
	$('.modal').on('mousewheel',zoom);
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
	var count = 0;
	var zoomFactor = 100;
	function zoom(e){
		count++;
		$img = $('.modal img');
		var height = $img.height();   //get initial height 
         var width = $img.width();     // get initial width
         var offset = $img.offset();
         var stepex = height / width;   //get the percentange of height / width
         var minHeight = 150;   // min height
         var tempStep = 10;    // evey step for scroll down or up


         if (e.deltaY>0) {  //up
        	 $img.height(height + e.deltaY*tempStep);
        	 $img.width(width + e.deltaY*tempStep / stepex);
        	 
        	 $img.offset({left:offset.left-e.deltaY*tempStep / stepex/2,top:offset.top-e.deltaY*tempStep/2});
         }
         else if (e.deltaY<0) { //down
             if (height > minHeight&&width > minHeight / stepex){
            	 $img.height(height +e.deltaY*tempStep);
            	 $img.width(width +e.deltaY*tempStep / stepex);
            	 $img.offset({left:offset.left-e.deltaY*tempStep / stepex/2,top:offset.top-e.deltaY*tempStep/2});
             }
             else{
            	 $img.height(minHeight);
            	 $img.width(minHeight / stepex); 
             }
            	 
         }
         
	}
	if(oper=="show")return;
	$('#btn_show_dialog').click(function(e){
		e.preventDefault();
		$('#myModal').modal('show');
		
		
	});
	
	
	
	var tree = $('#forward_tree').jstree({
		"themes" : { "stripes" : true },
		"plugins" : ["checkbox"],
	    'core' : {
	    	multiple:false,
	      'data' : {
	          "url" : "alert/listForward",
	          "dataType" : "json"
	    	}
		}
	  }).on("select_node.jstree", function(e, data){
		  
		  var id = data.id;
			
		});
	/* $("#jqGrid").jqGrid({
        url:"<c:url value='/notify/listUser'/>",
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
				label : '姓名',
                name: 'name',
            },
            {
				label: '手机号',
                name: 'cellphone',
            },
            {
				label: '状态',
                name: 'status',
                formatter:'select', 
                editoptions:{value:"1:未认证;2:资料审核中;3:已认证;4:认证失败"},
            },
            {
				label: '积分',
                name: 'points',
            
            } 
            	,
        	 {
				label: '注册时间',
                name: 'createtime',
            
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
        deselectAfterSort:false,
         loadonce: true,
 		viewrecords: true,
         height: 400,
         width:800,
         //shrinkToFit:true,
         autowidth:false,
         multiselect:false,
         rownumbers:true,
         rownumWidth:50,
         rowNum: 10,
         pager: "#jqGridPager",
    }); */
	
	/* function add(event){
		event.preventDefault();
		
		var grid = $("#jqGrid");
        var rowKey = grid.getGridParam("selrow");
        var row = grid.getRowData(rowKey); 
        
        var forwardId = $(this).data('rowid');
        if(confirm("确定委派处理吗？")){
        	$.ajax({
        		url:"alert/handle",
        		type:"post",
        		contentType:"application/json",
        		data:JSON.stringify({
        			id:$('form input[name="id"]').val(),
        			forwardId:forwardId,
        			
        		}),
        		success:function(data){
        			alert("操作成功！");
        			window.history.back(-1);
        		},
        		error:function(){
        			alert("操作失败，请稍后再试！");
        		}
        	});
        }
	} */
	$('#btn_modal_confirm').click(function(e){
		e.preventDefault();
		
		var ids = $('#forward_tree').jstree('get_selected',false); 
		if(ids.length==0){
			
			alert('请选择要委派的对象！');
		}else{
			if(confirm("确定委派处理吗？")){
	        	$.ajax({
	        		url:"alert/auditing",
	        		type:"post",
	        		contentType:"application/json",
	        		data:JSON.stringify({
	        			id:$('form input[name="id"]').val(),
	        			forwardId:ids[0],
	        			
	        		}),
	        		success:function(data){
	        			alert("操作成功！");
	        		},
	        		error:function(){
	        			alert("操作失败，请稍后再试！");
	        		}
	        	});
	        }
		}
		
	});
	$('#btn_form_confirm').click(function(e){
		e.preventDefault();
		var rewardId = $('.reward_id').val();
		var reward_points = $('.reward_points').val();
		if(/^\d+$/.test(reward_points)){
			if(reward_points==0||(reward_points>=50&&reward_points<=200)){
				if(confirm("确定处理吗？")){
		        	$.ajax({
		        		url:"alert/auditing",
		        		type:"post",
		        		contentType:"application/json",
		        		data:JSON.stringify({
		        			id:$('form input[name="id"]').val(),
		        			result:$('#ta_result').val(),
		        			rewardId:rewardId,
		        			rewardPoints:reward_points
		        			
		        		}),
		        		success:function(data){
		        			alert("操作成功！");
		        			var row = data.data;
		        			row.operation = "";
		        			$("#jqGrid").setRowData(data.data.id,row);
		        			$(".right-form").html("");
		        			if(flag=="0"){
		        				 window.history.back(-1); 	
		        			}
		        		},
		        		error:function(){
		        			alert("操作失败，请稍后再试！");
		        		}
		        	});
		        }
				return;
			}
		}
		alert('奖励积分必须大于50小于200');
        
		
	});
	var f = { groupOp: "AND", rules: [] };
	var timer;
     $('#query_keeper').keyup(function(){
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
     
     var timer1;
     $('#query_cellphone').keyup(function(){
 		var self = this;
 		var value = self.value;
 		var grid = $('#jqGrid');
      	var field = "cellphone";
      	var op = "cn";
      	
 		if(timer1) { clearTimeout(timer1); }
 		timer1 = setTimeout(function(){
 			//timer = null;
 			filter(f,grid,field,op,value);
 		},0);
      	
      }); 
     
	<%-- $('#btn_show_map').click(function(e){
		e.preventDefault();
		$('#locationModal').modal('show');
	});
	
	var location = "<%=location%>";
	var locationArr = [];
	var address = "<%=address%>";
	var policeLocation = "<%=policeLocation%>";
	var policeLocationArr = policeLocation.split(',');
	
	
	 	var map = new AMap.Map('container',{
 	    	zoom: 13,
 		});
	 	var sMarker = new AMap.Marker({
	         map: map,
	         position: policeLocationArr
	     });
	 	if(location){
			locationArr = location.split(',');
			
			
			regeocoder(locationArr,address);
		}else if(address){
			geocoder(address);
		}
	 	 
	     var lnglat = new AMap.LngLat(116.368904, 39.923423);
	     
	     
	     function geocoder(address) {
	         var geocoder = new AMap.Geocoder({
	             city: "010", //城市，默认：“全国”
	             radius: 1000 //范围，默认：500
	         });
	         //地理编码,返回地理编码结果
	         geocoder.getLocation(address, function(status, result) {
	             if (status === 'complete' && result.info === 'OK') {
	                 geocoder_CallBack(result);
	             }
	         });
	     }
	     
	     function addMarker(i, d) {
	         var marker = new AMap.Marker({
	             map: map,
	             position: [ d.location.getLng(),  d.location.getLat()]
	         });
	         var infoWindow = new AMap.InfoWindow({
	             content: d.formattedAddress,
	             offset: {x: 0, y: -30}
	         });
	         marker.on("mouseover", function(e) {
	             infoWindow.open(map, marker.getPosition());
	         });
	     }
	     //地理编码返回结果展示
	     function geocoder_CallBack(data) {
	         var resultStr = "";
	         //地理编码结果数组
	         var geocode = data.geocodes;
	         for (var i = 0; i < geocode.length; i++) {
	             //拼接输出html
	             //resultStr += "<span style=\"font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\">" + "<b>地址</b>：" + geocode[i].formattedAddress + "" + "&nbsp;&nbsp;<b>的地理编码结果是:</b><b>&nbsp;&nbsp;&nbsp;&nbsp;坐标</b>：" + geocode[i].location.getLng() + ", " + geocode[i].location.getLat() + "" + "<b>&nbsp;&nbsp;&nbsp;&nbsp;匹配级别</b>：" + geocode[i].level + "</span>";
	             addMarker(i, geocode[i]);
	         }
	         map.setFitView();
	         //document.getElementById("result").innerHTML = resultStr;
	     }
	     function regeocoder(lnglatXY, addr) {  //逆地理编码
	         var geocoder = new AMap.Geocoder({
	             radius: 1000,
	             extensions: "all"
	         });        
	         geocoder.getAddress(lnglatXY, function(status, result) {
	             if (status === 'complete' && result.info === 'OK') {
	                 geocoder_CallBack(result,addr);
	             }
	         });        
	         var marker = new AMap.Marker({  //加点
	             map: map,
	             position: lnglatXY
	         });
	         map.setFitView();
	     }
	     function geocoder_CallBack(data,addr) {
	    	 addr = data.regeocode.formattedAddress; //返回地址描述
	         //document.getElementById("result").innerHTML = address;
	     }
	 --%>
});
//@ sourceURL=alert_mgr.js
</script>
</html>