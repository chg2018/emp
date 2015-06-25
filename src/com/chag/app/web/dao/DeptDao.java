package com.chag.app.web.dao;

import java.util.List;

import com.chag.app.web.annotation.MyBatisDAO;
import com.chag.app.web.entity.Dept;

@MyBatisDAO
public interface DeptDao {
	
	public void add(Dept dept);
	
	public Dept findById(Integer empno);
	
	public List<Dept> findAll();
	
	public void deleteById(Integer deptno);
	
	public void update(Dept dept);
}
