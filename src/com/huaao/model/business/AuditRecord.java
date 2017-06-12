/**
 * 
 */
package com.huaao.model.business;

/** 
* @ClassName: AuditRecord 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月5日 下午4:17:53 
* 
* 
*/
public class AuditRecord {

	private Integer id;
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
	 * @return the communityId
	 */
	public Integer getCommunityId() {
		return communityId;
	}
	/**
	 * @param communityId the communityId to set
	 */
	public void setCommunityId(Integer communityId) {
		this.communityId = communityId;
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
	 * @return the applyId
	 */
	public Integer getApplyId() {
		return applyId;
	}
	/**
	 * @param applyId the applyId to set
	 */
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	/**
	 * @return the audit
	 */
	public String getAudit() {
		return audit;
	}
	/**
	 * @param audit the audit to set
	 */
	public void setAudit(String audit) {
		this.audit = audit;
	}
	/**
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * @return the auditDate
	 */
	public Long getAuditDate() {
		return auditDate;
	}
	/**
	 * @param auditDate the auditDate to set
	 */
	public void setAuditDate(Long auditDate) {
		this.auditDate = auditDate;
	}
	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * @return the preId
	 */
	public Integer getPreId() {
		return preId;
	}
	/**
	 * @param preId the preId to set
	 */
	public void setPreId(Integer preId) {
		this.preId = preId;
	}
	/**
	 * @return the auditId
	 */
	public Integer getAuditId() {
		return auditId;
	}
	/**
	 * @param auditId the auditId to set
	 */
	public void setAuditId(Integer auditId) {
		this.auditId = auditId;
	}
	private Integer communityId;
	private Integer type;
	private Integer applyId;
	private String audit;
	private Integer auditId;
	private Integer status;
	private Long auditDate;
	private String remark;
	private Integer preId;
	
	
	
}
