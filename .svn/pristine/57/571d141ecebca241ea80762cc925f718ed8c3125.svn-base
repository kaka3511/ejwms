/*
 * page.js
 * @detail 分页插件
 */

 /*
  * 初始化分页插件
  * @params nav_dom 分页nav元素; total 总记录数; data_max 单页记录数; pageEvent 分页事件，返回页码;	
  * @description
  * 一次最多显示10页
  * << 左移10页
  * >> 右移10页
  * current_page从0开始，0表示第1页
  */
var PageSpace = window.PageSpace || {};  
  
  
PageSpace.pageObj = {total: 0, data_max: 0, current_page: 0, page_cnt: 0, page_max: 10};
PageSpace.initPages = function (nav_dom, total, data_max, pageEvent){
	var pageObj = PageSpace.pageObj;
	pageObj.current_page = 0;
	pageObj.total = total;
	pageObj.data_max = data_max;
	
	if(!(total || data_max))	$(nav_dom).hide();
	
	var page_cnt = Math.ceil(total/data_max);	//页数
	pageObj.page_cnt = page_cnt;
	
	PageSpace.initPageItems(nav_dom, 0);
	$(nav_dom).find("ul li").eq(1).addClass("active");
	
	$(nav_dom).undelegate("li", "click");
	$(nav_dom).on("click", "li", function(){
		if($(this).attr("name") == "p"){
			var new_page = (Math.floor(pageObj.current_page/pageObj.page_max) - 1) * pageObj.page_max ;
			if(new_page<0)	return;
			else{
				pageObj.current_page = new_page + pageObj.page_max - 1;
				PageSpace.initPageItems(nav_dom, new_page);
				$(nav_dom).find("ul li").eq(-2).addClass("active");
			} 
		}else if($(this).attr("name") == "n"){
			var new_page = (Math.floor(pageObj.current_page/pageObj.page_max) + 1) * pageObj.page_max ;
			if(new_page>pageObj.page_cnt-1)	return;
			else{
				pageObj.current_page = new_page;
				PageSpace.initPageItems(nav_dom, new_page);
				$(nav_dom).find("ul li").eq(1).addClass("active");
			} 
		}else{
			$(nav_dom).find("li").removeClass("active");
			$(this).addClass("active");
			pageObj.current_page = parseInt($(this).attr("name"));
			$(nav_dom).find(".description").text("当前第" + (pageObj.current_page+1) + "页（共"+pageObj.page_cnt+"页）");
		}
		pageEvent(pageObj.current_page);
		
	});

}
PageSpace.initPageItems = function (nav_dom, si){	
	var pageObj = PageSpace.pageObj;
	var ei = si + pageObj.page_max;
	if(ei > pageObj.page_cnt)	ei = pageObj.page_cnt;

	var preNode = $(nav_dom).find("li").first().clone(true);
	var nextNode = $(nav_dom).find("li").last().clone(true);
	$(nav_dom).find("li").remove();
	
	preNode.attr("name", 'p');
	$(nav_dom).find("ul").append(preNode);
	
	
	for(var i=si; i<ei; i++){
		$(nav_dom).find("ul").append("<li name='"+i+"'><a>"+(i+1)+"</a></li>");
	}
	
	nextNode.attr("name", 'n');
	$(nav_dom).find("ul").append(nextNode);
	$(nav_dom).find(".description").text("当前第" + (pageObj.current_page+1) + "页（共"+pageObj.page_cnt+"页）");
} 