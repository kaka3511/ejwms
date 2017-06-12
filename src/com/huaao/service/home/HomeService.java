package com.huaao.service.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringHelper;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.home.AccountUser;
import com.huaao.model.home.UserInfo;
import com.huaao.model.system.Menu;

@Service
public class HomeService {

	@Autowired
	private BaseDao baseDao;

	private String sql=null;

//	/**
//	 * 登录验证
//	 * @param userAccount
//	 * @param userPassword
//	 * @return 
//	 * @throws Exception 
//	 */
//	@SuppressWarnings("null")
//	public UserInfo login(AccountUser accountUser) throws Exception {
//		UserInfo userInfo = new UserInfo();;
//		Community community = null;
//		String sql = "select * from jw_user where cellphone=?";     
//		Object[]args = new Object[] {accountUser.getUserAccount()};
//		List list = this.baseDao.queryForList(sql, args);
//		Iterator it = list.iterator();  
//		if(it.hasNext()) {  		//判断用户名是否存在
//			sql = "select * from jw_user where cellphone=? and passwd=? and type=2";
//			args = new Object[] {accountUser.getUserAccount(),StringHelper.md5(accountUser.getUserPassword())};
//			list = this.baseDao.queryForList(sql, args);
//			Iterator it2 = list.iterator();  
//			if(it2.hasNext()) { 		//校验用户密码
//				Map userMap = (Map) it2.next();
//				sql = "select * from jw_community where id=? and passwd=?";
//				args = new Object[] {userMap.get("communityid").toString(),StringHelper.md5(accountUser.getCommunityPassword())};
//				list = this.baseDao.queryForList(sql, args);
//				Iterator it3 = list.iterator();  
//				if(it3.hasNext()) {    //校验社区管理密码
//					community = new Community();
//					Map communityMap = (Map) it3.next();
//					community.setId((Integer) communityMap.get("id"));
//					/*community.setAddress(communityMap.get("address").toString());
//					community.setArea(communityMap.get("area").toString());
//					community.setLocation(communityMap.get("location").toString());
//					community.setName(communityMap.get("name").toString());
//					community.setDescription(communityMap.get("description").toString());
//					community.setImg(communityMap.get("img").toString());*/
//					userInfo.setEnable(true);
//					userInfo.setName(userMap.get("name").toString());
//					userInfo.setAccount(userMap.get("cellphone").toString());
//					userInfo.setId((Integer) userMap.get("id"));
//					userInfo.setCommunityId((Integer) userMap.get("communityid"));
//					userInfo.setCommunity(community);
//				}else{
//					userInfo.setEnable(false);
//					userInfo.setError("社区管理密码错误!");
//				}
//			}else{
//				userInfo.setEnable(false);
//				userInfo.setError("用户个人密码错误!");
//			}
//		}else{
//			userInfo.setEnable(false);
//			userInfo.setError("用户不存在!");
//		}
//		return userInfo;
//	}
//	
//	//原功能正常已注释/**
	 /* 根据父节点ID查找子菜单列表
	* <功能详细描述>
	* @param parentCode
	* @return
	* @see [类、类#方法、类#成员]
	 */
	public List<Menu> findByParentCodeEx(int parentCode) {
		List<Menu> menuList = new ArrayList<Menu>();
		String sql = "select * from sps_s_menu where menu_parent_id=" + parentCode
				+ "  and status='enable' order by menu_order asc";
		Object[] args = new Object[] {};
		List<?> list = this.baseDao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			Menu menu = new Menu();
			Map menuMap = (Map) list.get(i);
			menu.setId((Integer) menuMap.get("id"));
			menu.setMenuName(menuMap.get("menu_name").toString());
			menu.setMenuParentId((Integer) menuMap.get("menu_parent_id"));
			if (menuMap.get("menu_img_cls") != null && menuMap.get("menu_img_cls") != ""){
			  menu.setMenuImgCls(menuMap.get("menu_img_cls").toString());	 
			}
			if (menuMap.get("menu_href") != null && menuMap.get("menu_href") != ""){
			  menu.setMenuHref(menuMap.get("menu_href").toString());	 
			}
			menuList.add(menu);
		}
		return menuList;
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//	
	public UserInfo login(AccountUser accountUser) throws Exception{
		//根据用户名查询，查询用户是否存在
		String sql="select * from jw_user jw where jw.cellphone=? and jw.building_id=?";
		List<Map<String,Object>> list=baseDao.queryForList(sql,new Object[]{accountUser.getUserAccount(),2});
		UserInfo userInfo = new UserInfo();
		if(list.size()>0){
			if(list.get(0).get("passwd").equals(StringHelper.md5(accountUser.getUserPassword()))){
				Map<String,Object> map=list.get(0);
				userInfo.setCommunityId((Integer) map.get("communityid"));  //正式时删除
				
				userInfo.setEnable(true);
				userInfo.setName(map.get("name").toString());
				userInfo.setAccount(map.get("cellphone").toString());
				userInfo.setId((Integer) map.get("id"));
				
				userInfo.setAddress(map.get("address")==null?null:map.get("address").toString());
				userInfo.setCellphone(map.get("cellphone")==null?null:map.get("cellphone").toString());
				userInfo.setGender(map.get("gender")==null?1:Integer.parseInt(map.get("gender").toString()));
				userInfo.setPosition(map.get("position")==null?"":map.get("position").toString());
				userInfo.setImg(map.get("img")==null?null:map.get("img").toString());
				userInfo.setUsertype(Integer.parseInt(map.get("type").toString()));
				userInfo.setUserIdentity(Integer.parseInt(map.get("useridentity").toString()));
			}else{
				userInfo.setEnable(false);
				userInfo.setError("用户个人密码错误!");
			}
		}else{
			userInfo.setEnable(false);
			userInfo.setError("只允许管理账号登录!");
		}
		return userInfo;
	}
	
	
	
	//修改的功能
//	/**
//	 * 先查询子节点，然后根据子节点查询父节点组成 菜单
//	* <功能详细描述>
//	* @param parentCode
//	* @return
//	* @see [类、类#方法、类#成员]
//	 */
	public List<Menu> findByParentCode(int id) {
		String sql="select * from ( "+
" select menu.* from (select  mero.* from (select usro.* from jw_user jw LEFT JOIN sps_s_user_role usro on(jw.id=usro.user_id) where jw.id=? AND usro.type=3 and usro.is_valid=1) resu LEFT JOIN sps_s_menu_role mero on(resu.role_id=mero.role_id) where mero.is_valid=1) as menuRoTable left JOIN sps_s_menu menu on(menuRoTable.menu_id=menu.id) UNION "
+" select menu.* from (select  mero.* from (select usro.* from jw_user  jw LEFT JOIN sps_s_user_role usro on(jw.dept_id=usro.user_id) where jw.id=? and usro.type=1 and usro.is_valid=1) resu LEFT JOIN sps_s_menu_role mero on(resu.role_id=mero.role_id) where mero.is_valid=1) as menuRoTable left JOIN sps_s_menu menu on(menuRoTable.menu_id=menu.id) UNION "
+" select menu.* from (SELECT mero.* from (select usro.* from (select result.* from "
+" (select usty.* from jw_user  jw LEFT JOIN sps_s_user_type usty on(jw.dept_id=usty.dept) where jw.id=? AND usty.`status`=1 ) as result "
+"	LEFT JOIN jw_user  jwone on jwone.type=result.`code` and jwone.useridentity=result.role where jwone.id=?) as re LEFT JOIN sps_s_user_role usro on(re.id=usro.user_id) where usro.type=2) as roleTable LEFT JOIN sps_s_menu_role mero on(roleTable.role_id= mero.role_id) where mero.is_valid=1 ) as me left JOIN sps_s_menu menu on(me.menu_id=menu.id) where `status`='enable' order by menu_order asc) as resultTables   order by menu_parent_id,menu_order asc";
		
		//子节点集合
		List<?> list = this.baseDao.queryForList(sql, new Object[]{id,id,id,id});
		List<?> parea=findParent(id);
		
		//父集合节点
		List<Menu> parentListMenu= new ArrayList<Menu>();
		Menu menu =null;
		for (Object menul : parea) {
			if(menul==null){
				continue;
			}
			//完成父节点的变Menu
			menu= new Menu();
			Map menuMap = (Map) menul;
			menu.setId((Integer) menuMap.get("id"));
			menu.setMenuName(menuMap.get("menu_name").toString());
			menu.setMenuParentId((Integer) menuMap.get("menu_parent_id"));
			if (menuMap.get("menu_img_cls") != null && menuMap.get("menu_img_cls") != ""){
			  menu.setMenuImgCls(menuMap.get("menu_img_cls").toString());	 
			}
			if (menuMap.get("menu_href") != null && menuMap.get("menu_href") != ""){
			  menu.setMenuHref(menuMap.get("menu_href").toString());	 
			}
			//子节点菜单的集合
			
			List<Menu> menuList = new ArrayList<Menu>();
			for (int i = 0; i < list.size(); i++) {
				 
				Map mp=(Map)list.get(i);
				if(mp.get("menu_parent_id").toString().equals(menuMap.get("id").toString())){
					Menu menuChlid = new Menu();
					Map menuMapChlid = (Map) list.get(i);
					menuChlid.setId((Integer) mp.get("id"));
					menuChlid.setMenuName(mp.get("menu_name").toString());
					menuChlid.setMenuParentId((Integer) mp.get("menu_parent_id"));
					if (mp.get("menu_img_cls") != null && mp.get("menu_img_cls") != ""){
						menuChlid.setMenuImgCls(mp.get("menu_img_cls").toString());	 
					}
					if (mp.get("menu_href") != null && mp.get("menu_href") != ""){
						menuChlid.setMenuHref(mp.get("menu_href").toString());	 
					}
					menuList.add(menuChlid);
				}
				
			}
			menu.setChildren(menuList);
			parentListMenu.add(menu);
		}
		return parentListMenu;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	public List findParent(int  id){
		String sql="select smen.* from (select * from ( "
				+" select menu.* from (select  mero.* from (select usro.* from jw_user jw LEFT JOIN sps_s_user_role usro on(jw.id=usro.user_id) where jw.id=? AND usro.type=3 and usro.is_valid=1) resu LEFT JOIN sps_s_menu_role mero on(resu.role_id=mero.role_id) where mero.is_valid=1) as menuRoTable  LEFT JOIN sps_s_menu menu on(menuRoTable.menu_id=menu.id) UNION "
				+" select menu.* from (select  mero.* from (select usro.* from jw_user  jw LEFT JOIN sps_s_user_role usro on(jw.dept_id=usro.user_id) where jw.id=? and usro.type=1 and usro.is_valid=1) resu LEFT JOIN sps_s_menu_role mero on(resu.role_id=mero.role_id) where mero.is_valid=1) as menuRoTable  LEFT JOIN sps_s_menu menu on(menuRoTable.menu_id=menu.id) UNION "
				+" select menu.* from (SELECT mero.* from (select usro.* from (select result.* from  "
				+"	(select usty.* from jw_user  jw LEFT JOIN sps_s_user_type usty on(jw.dept_id=usty.dept) where jw.id=? AND usty.`status`=1 ) as result "
				+"		LEFT JOIN jw_user  jwone on jwone.type=result.`code` and jwone.useridentity=result.role where jwone.id=?) as re LEFT JOIN sps_s_user_role usro on(re.id=usro.user_id) where usro.type=2) as roleTable LEFT JOIN sps_s_menu_role mero on(roleTable.role_id= mero.role_id) where mero.is_valid=1 ) as me LEFT JOIN sps_s_menu menu on(me.menu_id=menu.id) where `status`='enable' order by menu_order asc) as resultTables  order by menu_parent_id,menu_order asc) as menuResult  LEFT JOIN sps_s_menu smen on(menuResult.menu_parent_id=smen.id) GROUP BY id order by smen.id asc ;";
		return baseDao.queryForList(sql,new Object[]{id,id,id,id});
	}
	
	/**
	 * 查询菜单列表
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 * @see [类、类#方法、类#成员]
	 */
	public List<Menu> queryMenuList(int code) throws Exception {
		List<Menu> menuList = findByParentCodeEx(code);
		if (menuList == null || menuList.size() == 0) {
			return null;
		}
		for (Menu menu : menuList) {
			menu.setChildren(queryMenuList(menu.getId()));
		}
		return menuList;
	}
}
