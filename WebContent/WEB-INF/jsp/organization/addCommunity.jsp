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
<script type="text/javascript" src="<c:url value='/js/ajaxfileupload.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>	
	<input type="hidden" name="communityLocation" id="communityLocation" >
	<input type="hidden" name="communityArea" id="communityArea" >
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>组织架构</li>
		<li>社区管理</li>
	</ul>
	<div class="panel panel-info">
		<div class="panel-heading">
			社区基本资料
			<button class="btn-primary pull-right saveInfo">保存提交</button>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-sm-4">
					<label class="col-sm-3 control-label">社区名称：</label>
					<div class="col-sm-9"><input type="text" class="form-control col-sm-6 disableInfo" placeholder="社区名称不能超过64个字符" id="communityName" name="communityName" ></div>
				</div>
				<div class="col-sm-4">
					<label class="col-sm-3 control-label">管理密码：</label>
					<div class="col-sm-9"><input type="password" class="form-control col-sm-6 disableInfo" placeholder="社区名称不能超过32个字符" id="communityPW" name="communityPW" ></div>
				</div>
				<div class="col-sm-4">
					<label class="col-sm-3 control-label">社区地址：</label>
					<div class="col-sm-9"><input type="text" class="form-control col-sm-6 disableInfo" placeholder="社区地址不能超过64个字符" id="communityAddress" name="communityAddress" ></div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<label class="col-sm-3 control-label">社区描述：</label>
					<div class="col-sm-9">
						<textarea class="form-control col-sm-1 disableInfo" rows="4" placeholder="社区描述不能超过64个字符" id="communityDescription" name="communityDescription" ></textarea>
					</div>
				</div>
				
				<!--设置图片  -->
				<div class="col-sm-4 imgDiv">
					<label class="col-sm-3 control-label">设置社区图片：</label>
					<div class="col-sm-9">
						<input type="file" id="uploadImg" class="form-control" name="uploadImg">
					</div>
				</div>
			</div>
		</div>
		
		<div class="panel-heading">
			社区地图定位
			<button class="btn-success pull-right updateLocation setLocation" id="updateLocation">设置社区位置</button>
			<div class="pull-right">&nbsp;&nbsp;&nbsp;</div>
			<button class="btn-success pull-right updateArea setLocation" id="updateArea">设置社区区域</button>
			<button class="btn-info pull-right hidden showLocation" id="cancelLocation">取消</button>
			<div class="pull-right">&nbsp;&nbsp;&nbsp;</div>
			<button class="btn-primary pull-right hidden showLocation" id="saveLocation">保存</button>
			<button class="btn-info pull-right hidden showArea" id="cancelArea">取消</button>
			<div class="pull-right">&nbsp;&nbsp;&nbsp;</div>
			<button class="btn-primary pull-right hidden showArea" id="saveArea">保存</button>
		</div>
		<div class="panel-body" style="position: fixed;width:100%;height:100%;">
			<div id="mapContainer"></div>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
var marker = null;    //地图位置标记
var communityName = $("#communityName").val();
var communityDescription=$("#communityDescription").val();
var communityAddress=$("#communityAddress").val();
var communityPW=$("#communityPW").val();
var communityLocation = "115.304596,35.048748";
var communityArea="";
var polygon=null;   //地图多边形
var editorTool = null; //编辑控件
var mouseTool =null;
var path = null;
$(function() {
	
	var map = new AMap.Map('mapContainer');
	if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){
		 // 设置缩放级别和中心点
	    map.setZoomAndCenter(16, communityLocation.split(","));
	    // 添加 marker 并设置中心点
	    marker = new AMap.Marker({
	      map: map,
	      position: communityLocation.split(",")
	    }); 
	}else{
		alert("社区未设置GPS地理位置");
	}
    AMap.event.addDomListener(document.getElementById('updateLocation'),'click', function () {   //设置编辑位置
    	if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){   //编辑
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
    	if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){
        	map.setZoomAndCenter(16, communityLocation.split(","));
        	marker.setPosition(communityLocation.split(","));
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
    		communityLocation = marker.getPosition().toString();
			marker.setDraggable(false);
			$('.setLocation').removeClass("hidden");
			$('.setLocation').addClass("show");
			$('.showLocation').removeClass("show");
			$('.showLocation').addClass("hidden");
    		alert("保存成功！")
    	}
      });
   

	var polygonArr = null;
    AMap.event.addDomListener(document.getElementById('updateArea'),'click', function () {   //编辑区域按钮
    	if(communityArea == null || communityArea == ""){
        	var pt = marker.getPosition();
        	var polygonArr = new Array();
        	polygonArr.push([pt.lng+0.003, pt.lat+0.002]);
        	polygonArr.push([pt.lng+0.003, pt.lat-0.002]);
        	polygonArr.push([pt.lng-0.003, pt.lat-0.002]);
        	polygonArr.push([pt.lng-0.003, pt.lat+0.002]);
        	polygonArr.push([pt.lng+0.003, pt.lat+0.002]);
        	communityArea = polygonArr.toString();
        	polygon = new AMap.Polygon({
    			path: polygonArr,//设置多边形边界路径
    			strokeColor: "#FF33FF", //线颜色
    			strokeOpacity: 1, //线透明度
    			strokeWeight: 2,    //线宽
    			fillColor: "#1791fc", //填充色
    			fillOpacity: 0.35//填充透明度
    		});
    		polygon.setMap(map);
    	}
    	
    	
    	if(communityArea!=null&&communityArea!=""&&communityArea!="null"){  //编辑区域
    		editorTool = new AMap.PolyEditor(map, polygon);
    		editorTool.open();
    	}else{                        	//新增一个区域
    		 //设置多边形的属性
    	    var polygonOption = {
    	    		strokeColor: "#FF33FF", //线颜色
            		strokeOpacity: 1, //线透明度
            		strokeWeight: 2,    //线宽
            		fillColor: "#1791fc", //填充色
            		fillOpacity: 0.35//填充透明度
    	    };
    	    mouseTool = new AMap.MouseTool(map);
    	    AMap.event.addListener(mouseTool, "draw", function(e) {
    	        path = e.obj.getPath();
    	    });
    	    mouseTool.polygon(polygonOption);   //使用鼠标工具绘制多边形
      	}
    	$('.showArea').removeClass("hidden");
		$('.showArea').addClass("show");
		$('.setLocation').removeClass("show");
		$('.setLocation').addClass("hidden");
	});
    AMap.event.addDomListener(document.getElementById('saveArea'),'click', function () {   //绑定保存按钮
    	if(polygon){
    		path = polygon.getPath();
    	}
    	if(path==null){
    		alert("未设置社区区域");
    		return false;
    	}
		var arr = "";
    	for(var i=0;i<path.length;i++){
    		arr+=",["+path[i]+"]";
    	}
    	if(arr!=""){
    		arr = arr.substring(1);
    	}
    	var arrString = "["+arr+"]";
		$.ajax( {
			type:"post",//不写此参数默认为get方式提交
			async:false,   //设置为同步
			url : "/ejwms/communityManage/saveCommunityArea.do",//请求的uri
			data : {area:arrString},//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				communityArea = arrString;
				$('.setLocation').removeClass("hidden");
				$('.setLocation').addClass("show");
				$('.showArea').removeClass("show");
				$('.showArea').addClass("hidden");
		    	if(editorTool){
		    		editorTool.close();
		    	}
		    	if(mouseTool){
		    		mouseTool.close();
		    	}
	    		if(polygon){
	        		polygon.setPath(path);    //去掉原来的
	    		}else{
	    			map.clearMap();
	    			if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){
	    			    map.setZoomAndCenter(16, communityLocation.split(","));
	    			    marker = new AMap.Marker({
	    			      map: map,
	    			      position: communityLocation.split(",")
	    			    }); 
	    			}
			    	polygon = new AMap.Polygon({
						path: path,//设置多边形边界路径
						strokeColor: "#FF33FF", //线颜色
						strokeOpacity: 1, //线透明度
						strokeWeight: 2,    //线宽
						fillColor: "#1791fc", //填充色
						fillOpacity: 0.35//填充透明度
					});
					polygon.setMap(map);
	    		}
		    	alert("保存成功");
			},error: function () {
	            alert('系统出现异常，请稍后再试!');
	        }});

    });
    AMap.event.addDomListener(document.getElementById('cancelArea'),'click', function () {   //绑定取消按钮
    	if(mouseTool){
    		mouseTool.close();
    	}
    	if(editorTool){
    		editorTool.close();
    	}
    	if(communityArea!=null&&communityArea!=""&&communityArea!="null"){
    		polygonArr = eval("(" + communityArea + ")");
    		if(polygon){
        		polygon.setPath(polygonArr);    //去掉原来的
    		}
    	}else{
    		if(polygon){
        		polygon.setMap(null);    //去掉原来的
        		polygon = null;
    		}else{
    			map.clearMap();
    			if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){
    			    map.setZoomAndCenter(16, communityLocation.split(","));
    			    marker = new AMap.Marker({
    			      map: map,
    			      position: communityLocation.split(",")
    			    }); 
    			}
    		}
    	}
	    $('.setLocation').removeClass("hidden");
		$('.setLocation').addClass("show");
		$('.showArea').removeClass("show");
		$('.showArea').addClass("hidden");
    });
	map.plugin(["AMap.ToolBar","AMap.OverView","AMap.Scale","AMap.MapType","AMap.PolyEditor","AMap.MouseTool"],function(){
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


//保存社区基本资料
$(document).on('click','.saveInfo',function(){
	if($("#communityName").val().length>64){
		alert("社区名称不能超过64个字符");
		return false;
	}
	if($("#communityDescription").val().length>64){
		alert("社区描述不能超过64个字符");
		return false;
	}
	if($("#communityPW").val().length>32){
		alert("社区管理密码不能超过32个字符");
		return false;
	}
	if($("#communityAddress").val().length>64){
		alert("社区地址不能超过64个字符");
		return false;
	}
	if($("#communityName").val().length==0){
		alert("社区名称不能为空");
		return false;
	}
	if($("#communityDescription").val().length==0){
		alert("社区描述不能为空");
		return false;
	}
	if($("#communityPW").val().length==0){
		alert("社区管理密码不能为空");
		return false;
	}
	if($("#communityAddress").val().length==0){
		alert("社区地址不能为空");
		return false;
	}
	var szFileName = $("#uploadImg").val();
	if(szFileName!=null&&szFileName!=""){
		szFileName = szFileName.replace(/(^\s*)|(\s*$)/g, "");
		var hzm = szFileName.substr(szFileName.length - 3).toLowerCase();
		if (hzm != "jpg"&&hzm!="png"&&hzm!="bmp"&&hzm!="jpeg") {
			alert("请上传jpg,png,bmp,jpeg格式的图片!");
			return false;
		}
	}

	
	$.ajaxFileUpload({  
        url : '/ejwms/communityManage/newCommunityInfo.do',  
        secureuri : false,//安全协议  
        fileElementId:'uploadImg',//id  
        type : 'POST',  
        dataType : 'text',  
        data:{communityName:$("#communityName").val(),
			communityDescription:$("#communityDescription").val(),
			communityPW:$("#communityPW").val(),
			location:communityLocation,
			area:communityArea,
			address: $("#communityAddress").val()},//传递到后台的参数		
        async : false,  
        error : function() {  
        	alert('系统出现异常，请稍后再试!');
        },  
        success : function(data) {  
        	var result = eval('(' + data + ')'); 
        	if(result.flag!=null&&result.flag!=""){
        		$('#communityImg').attr("src",result.img);
        	}
			alert("保存成功!");
			window.location = "/ejwms/organization/organization";
        }  
    });  
});

//取消修改社区基本资料
$(document).on('click','.cancelInfo',function(){
	$("#communityName").val(communityName);
	$("#communityDescription").val(communityDescription);
	$("#communityAddress").val(communityAddress);
	$('.updateInfo').removeClass("hidden");
	$('.updateInfo').addClass("show");
	$('.showInfo').removeClass("show");
	$('.showInfo').addClass("hidden");
	$('.disableInfo').attr("disabled",true);
	$('.imgDiv').removeClass("show");
	$('.imgDiv').addClass("hidden");
	$("#uploadImg").val("");
});
</script>
</html>