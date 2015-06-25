package com.chag.app.web.entity.page;

public class EmpPage extends Page{
	private String ename;
	private String job;
	private Integer mgr;
	private Integer deptno;
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Integer getMgr() {
		return mgr;
	}
	public void setMgr(Integer mgr) {
		this.mgr = mgr;
	}
	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
	public EmpPage() {
		super();
	}
	@Override
	public String toString() {
		return "EmpPage [ename=" + ename + ", job=" + job + ", mgr=" + mgr
				+ ", deptno=" + deptno + "]";
	}
}
