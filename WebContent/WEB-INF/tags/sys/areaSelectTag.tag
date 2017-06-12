<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入域值"%>
<%@ attribute name="limit" type="java.lang.Boolean" required="true" description="限制"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="限制"%>
<link rel="stylesheet"
	href="plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript"
	src="plugins/ztree/js/jquery.ztree.all.js"></script>
<SCRIPT type="text/javascript">
	var setting = {
		async : {
			enable : true,
			url : "${url}",
			autoParam : ["id=pid"],
			dataFilter:function(treeId, parentNode, responseData) {
				var list = responseData.data;
				      for(var i =0; i < list.length; i++) {
				    	  list[i].isParent = true;
				      }
			      return list;
			  }
		},
		view : {
			dblClickExpand : false
		},
		data : {
			simpleData : {
				enable : true,
				idKey : "id",
				pIdKey : "pid",
				rootPId: 0
			}
		},

		callback : {
		}
	};

	var zNodes = [ {
		name : "中国",
		id :1,
		parentid:0,
		isParent : true
	} ];


	$(document).ready(function() {
		
		var treeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
		
		$("#myModal .btn_conform").click(function(e){
			e.preventDefault();
			var nodes = treeObj.getSelectedNodes();
			if(nodes.length==0){
				$("#myModal").modal("hide");
				return;
			}
			
			var path = nodes[0].getPath();
			var pathStr = "";
			$.each(path,function(index,item){
				
				pathStr += item.name+"-";
			});
			if(${limit})
			if(pathStr.indexOf("武汉市")<0){
				alert("该地区暂未开通服务！");
				$("#myModal").modal("hide");
				return;
			}
			var cityObj = $("#citySel");
			cityObj.attr("value", pathStr.substring(0,pathStr.length-1));
			
			$("#myModal").modal("hide");
		});
	});
//-->
</SCRIPT>
<div class="input-group hidden editable">
      <input id="citySel" type="text" class="form-control" name="${name }" readonly value="${value }">
      <span class="input-group-btn">
        <button class="btn btn-primary" id="menuBtn" type="button" data-toggle="modal" data-backdrop="static" data-target="#myModal">选择</button>
      </span>
</div>
</button>

<div class="modal fade" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">请选择</h4>
			</div>
			<div class="modal-body">
				<div style="height:400px;overflow: auto">
					<ul id="treeDemo" class="ztree" ></ul>
				</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn_conform" >确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				
			</div>
		</div>
	</div>
</div>