package com.huaao.model.home;

/**
 * 用户信息
 * @author Administrator
 *
 */
public class UserInfo {

	private int id;					//用户ID
	private String account;			//用户账号
	private String name;			//用户姓名
	private int usertype;			//用户类型
	private boolean enable;			//用户是否可用
	private String error;			//用户登录失败原因
	private int communityId;		//所属社区id
	private int communityName;		//社区名称
	private Community community;
	private int userIdentity; //用户身份
	private String position;
	
	private String address;
	private String cellphone;
	private int gender;
	private String img;
	private String idcard;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isEnable() {
		return enable;
	}
	public void setEnable(boolean enable) {
		this.enable = enable;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getCommunityId() {
		return communityId;
	}
	public void setCommunityId(int communityId) {
		this.communityId = communityId;
	}
	public int getCommunityName() {
		return communityName;
	}
	public void setCommunityName(int communityName) {
		this.communityName = communityName;
	}
	public Community getCommunity() {
		return community;
	}
	public void setCommunity(Community community) {
		this.community = community;
	}
	public int getUsertype() {
		return usertype;
	}
	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the cellphone
	 */
	public String getCellphone() {
		return cellphone;
	}
	/**
	 * @param cellphone the cellphone to set
	 */
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	/**
	 * @return the gender
	 */
	public int getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(int gender) {
		this.gender = gender;
	}
	/**
	 * @return the img
	 */
	public String getImg() {
		return img;
	}
	/**
	 * @param img the img to set
	 */
	public void setImg(String img) {
		this.img = img;
	}
	/**
	 * @return the userIdentity
	 */
	public int getUserIdentity() {
		return userIdentity;
	}
	/**
	 * @param userIdentity the userIdentity to set
	 */
	public void setUserIdentity(int userIdentity) {
		this.userIdentity = userIdentity;
	}
	/**
	 * @return the idcard
	 */
	public String getIdcard() {
		return idcard;
	}
	/**
	 * @param idcard the idcard to set
	 */
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	/**
	 * @return the position
	 */
	public String getPosition() {
		return position;
	}
	/**
	 * @param position the position to set
	 */
	public void setPosition(String position) {
		this.position = position;
	}
	
}
