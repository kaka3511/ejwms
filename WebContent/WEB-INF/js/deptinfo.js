var marker = null;    //地图位置标记
//var communityLocation = "114.31995,30.647734";
var communityArea="";
var polygon=null;   //地图多边形
var editorTool = null; //编辑控件
var mouseTool =null;
var path = null;
var map=null;
$(function() {
	//map = new AMap.Map('mapContainer');
/*	if(communityLocation!=null&&communityLocation!=""&&communityLocation!="null"){
		 // 设置缩放级别和中心点
	    map.setZoomAndCenter(16, communityLocation.split(","));
	    // 添加 marker 并设置中心点
	    marker = new AMap.Marker({
	      map: map,
	      position: communityLocation.split(",")
	    }); 
	}else{
		alert("组织未设置GPS地理位置");
	}*/
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
    		alert("新的组织位置未设置!");
    		return false;
    	}else{
    		communityLocation = marker.getPosition().toString();
			marker.setDraggable(false);
			$('.setLocation').removeClass("hidden");
			$('.setLocation').addClass("show");
			$('.showLocation').removeClass("show");
			$('.showLocation').addClass("hidden");
    		//alert("保存成功！")
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
    		alert("未设置组织区域");
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
    	
	/*	$.ajax( {
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
	        }});*/

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
/*	map.plugin(["AMap.ToolBar","AMap.OverView","AMap.Scale","AMap.MapType","AMap.PolyEditor","AMap.MouseTool"],function(){
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
	});*/
});

