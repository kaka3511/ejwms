<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统设置-监控设备管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
<%@ include file="../base/taglib.jsp"%>
<%@ include file="../base/importCss.jsp"%>
<!-- END PAGE LEVEL STYLES -->
<style type="text/css">
.help-block {
	color: red;
	float: left;
	position: relative;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
<%@ include file="../base/importJs.jsp"%>
<script src="http://webapi.amap.com/maps?v=1.3&key=719a4823ac1230f35bb05aa020617e55"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>	
	<input type="hidden" name="entityLocation" id="entityLocation" value="${entity.location}">
	<input type="hidden" name="entityId" id="entityId" value="${entity.id}">
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>系统设置</li>
		<li>站点管理</li>
	</ul>
	<div class="panel panel-info">
		<div class="panel-heading">
			社区站点地图定位(<label class="text-danger">${entity.name}</label>)
			<button class="btn-success pull-right updateLocation setLocation" id="updateLocation">修改站点位置</button>
			<div class="pull-right">&nbsp;&nbsp;&nbsp;</div>
			<button class="btn-success pull-right setLocation" id="back" onclick="javascript:window.history.back(-1)">返回</button>
			<button class="btn-info pull-right hidden showLocation" id="cancelLocation">取消</button>
			<div class="pull-right">&nbsp;&nbsp;&nbsp;</div>
			<button class="btn-primary pull-right hidden showLocation" id="saveLocation">保存</button>
		</div>
		<div class="panel-body" style="position: fixed;width:100%;height:100%;">
			<div id="mapContainer"></div>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
var marker = null;    //地图位置标记
var entityLocation = $('#entityLocation').val();
$(function() {
	var map = new AMap.Map('mapContainer');
	if(entityLocation!=null&&entityLocation!=""&&entityLocation!="null"){
		 // 设置缩放级别和中心点
	    map.setZoomAndCenter(16, entityLocation.split(","));
	    // 添加 marker 并设置中心点
	    marker = new AMap.Marker({
	      map: map,
	      position: entityLocation.split(",")
	    }); 
	}else{
		$.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/communityManage/queryCommunityLocation.do",//请求的uri
			data : {},//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				map.setZoomAndCenter(16, data.location.split(","));
			},error: function () {
	            alert('系统出现异常，请稍后再试!');
	        }});
		alert("社区站点未设置GPS地理位置");
	}
    AMap.event.addDomListener(document.getElementById('updateLocation'),'click', function () {   //设置编辑位置
    	if(entityLocation!=null&&entityLocation!=""&&entityLocation!="null"){   //编辑
    		marker.setDraggable(true);
    	}else{							//新增
    		map.on( 'click', setPosition);
    	    function setPosition(e) {
				if(marker){
					return;
				}
				//map.setZoomAndCenter(16, newPosition);
				// 添加 marker 并设置中心点
				marker = new AMap.Marker({
					draggable: true,
					map: map,
					position: [e.lnglat.getLng(),e.lnglat.getLat()]
				});
    	    }
    	}
    	$('.showLocation').removeClass("hidden");
		$('.showLocation').addClass("show");
		$('.setLocation').removeClass("show");
		$('.setLocation').addClass("hidden");
    });
    AMap.event.addDomListener(document.getElementById('cancelLocation'),'click', function () {   //绑定取消按钮
    	if(entityLocation!=null&&entityLocation!=""&&entityLocation!="null"){
        	map.setZoomAndCenter(16, entityLocation.split(","));
        	marker.setPosition(entityLocation.split(","));
        	marker.setDraggable(false);
    	}else{
    		if(marker){
    			marker.setMap(null);    //去掉原来的
        		marker =null;
			}
    	}
	    $('.setLocation').removeClass("hidden");
		$('.setLocation').addClass("show");
		$('.showLocation').removeClass("show");
		$('.showLocation').addClass("hidden");
      });
    AMap.event.addDomListener(document.getElementById('saveLocation'),'click', function () {   //绑定保存按钮
    	if(marker==null){
    		alert("新的社区位置未设置!");
    		return false;
    	}else{
    		$.ajax( {
    			type:"post",//不写此参数默认为get方式提交
    			async:false,   //设置为同步
    			url : "/ejwms/entityManage/saveEntityLocation.do",//请求的uri
    			data : {location:marker.getPosition().toString(),
    				id:$('#entityId').val()},//传递到后台的参数				
    			cache : false,
    			dataType : 'json',//后台返回前台的数据格式为json
    			success : function(data) {
    				entityLocation = marker.getPosition().toString();
    				marker.setDraggable(false);
    				$('.setLocation').removeClass("hidden");
    				$('.setLocation').addClass("show");
    				$('.showLocation').removeClass("show");
    				$('.showLocation').addClass("hidden");
    				alert("保存成功!");
    			},error: function () {
    	            alert('系统出现异常，请稍后再试!');
    	        }});
    	}
      });
   
	map.plugin(["AMap.ToolBar","AMap.OverView","AMap.Scale","AMap.MapType"],function(){
		  //加载工具条
		tool = new AMap.ToolBar({
		    direction:false,//隐藏方向导航
		    ruler:false,//隐藏视野级别控制尺
		    autoPosition:false//禁止自动定位
		});
		map.addControl(tool);
		//加载鹰眼
		view = new AMap.OverView();
		map.addControl(view);
		//加载比例尺
		scale = new AMap.Scale();
		map.addControl(scale);
		var type = new AMap.MapType({
			defaultType: 0
		});
		map.addControl(type);
	});
});
</script>
</html>