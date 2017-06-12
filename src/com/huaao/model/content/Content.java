/**
 * 
 */
package com.huaao.model.content;

import java.util.Date;

/** 
* @ClassName: Content 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月9日 下午3:50:44 
* 
* 
*/
public class Content {
	
	private  Integer id;
	private  Integer type;
	private String title;
	private String summary;
	private String content;
	private String startaddr;
	private String starttime;
	private String endtime;
	private Integer cuser;
	private Integer communityid;
	private Long creattime;
	private Long updatetime;
	private Integer subtype;
	private String summary_img;
	private Integer durationtime;
	private String location;
	private Integer pupilId;
	private Integer keeperId;
	
	private String pupil;
	private String keeper;
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @return the type
	 */
	public Integer getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(Integer type) {
		this.type = type;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the summary
	 */
	public String getSummary() {
		return summary;
	}
	/**
	 * @param summary the summary to set
	 */
	public void setSummary(String summary) {
		this.summary = summary;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * @return the startaddr
	 */
	public String getStartaddr() {
		return startaddr;
	}
	/**
	 * @param startaddr the startaddr to set
	 */
	public void setStartaddr(String startaddr) {
		this.startaddr = startaddr;
	}
	/**
	 * @return the starttime
	 */
	public String getStarttime() {
		return starttime;
	}
	/**
	 * @param starttime the starttime to set
	 */
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	/**
	 * @return the endtime
	 */
	public String getEndtime() {
		return endtime;
	}
	/**
	 * @param endtime the endtime to set
	 */
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	/**
	 * @return the cuser
	 */
	public Integer getCuser() {
		return cuser;
	}
	/**
	 * @param cuser the cuser to set
	 */
	public void setCuser(Integer cuser) {
		this.cuser = cuser;
	}
	/**
	 * @return the communityid
	 */
	public Integer getCommunityid() {
		return communityid;
	}
	/**
	 * @param communityid the communityid to set
	 */
	public void setCommunityid(Integer communityid) {
		this.communityid = communityid;
	}
	/**
	 * @return the creattime
	 */
	public Long getCreattime() {
		return creattime;
	}
	/**
	 * @param creattime the creattime to set
	 */
	public void setCreattime(Long creattime) {
		this.creattime = creattime;
	}
	/**
	 * @return the updatetime
	 */
	public Long getUpdatetime() {
		return updatetime;
	}
	/**
	 * @param updatetime the updatetime to set
	 */
	public void setUpdatetime(Long updatetime) {
		this.updatetime = updatetime;
	}
	/**
	 * @return the subtype
	 */
	public Integer getSubtype() {
		return subtype;
	}
	/**
	 * @param subtype the subtype to set
	 */
	public void setSubtype(Integer subtype) {
		this.subtype = subtype;
	}
	/**
	 * @return the summary_img
	 */
	public String getSummary_img() {
		return summary_img;
	}
	/**
	 * @param summary_img the summary_img to set
	 */
	public void setSummary_img(String summary_img) {
		this.summary_img = summary_img;
	}
	/**
	 * @return the durationtime
	 */
	public Integer getDurationtime() {
		return durationtime;
	}
	/**
	 * @param durationtime the durationtime to set
	 */
	public void setDurationtime(Integer durationtime) {
		this.durationtime = durationtime;
	}
	/**
	 * @return the location
	 */
	public String getLocation() {
		return location;
	}
	/**
	 * @param location the location to set
	 */
	public void setLocation(String location) {
		this.location = location;
	}
	/**
	 * @return the donorId
	 */
	/**
	 * @return the pupilId
	 */
	public Integer getPupilId() {
		return pupilId;
	}
	/**
	 * @param pupilId the pupilId to set
	 */
	public void setPupilId(Integer pupilId) {
		this.pupilId = pupilId;
	}
	/**
	 * @return the keeperId
	 */
	public Integer getKeeperId() {
		return keeperId;
	}
	/**
	 * @param keeperId the keeperId to set
	 */
	public void setKeeperId(Integer keeperId) {
		this.keeperId = keeperId;
	}
	/**
	 * @return the pupil
	 */
	public String getPupil() {
		return pupil;
	}
	/**
	 * @param pupil the pupil to set
	 */
	public void setPupil(String pupil) {
		this.pupil = pupil;
	}
	/**
	 * @return the keeper
	 */
	public String getKeeper() {
		return keeper;
	}
	/**
	 * @param keeper the keeper to set
	 */
	public void setKeeper(String keeper) {
		this.keeper = keeper;
	}

}
