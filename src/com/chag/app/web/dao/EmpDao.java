package com.chag.app.web.dao;

import java.util.List;

import com.chag.app.web.annotation.MyBatisDAO;
import com.chag.app.web.entity.Emp;
import com.chag.app.web.entity.page.EmpPage;

@MyBatisDAO
public interface EmpDao {
	public void add(Emp emp);
	
	public Emp findById(Integer empno);
	
	public List<Emp> findAll();
	
	public void deleteById(Integer empno);
	
	public void update(Emp emp);
	
	public Integer findRows(EmpPage page);
	
	public List<Emp> findByPage(EmpPage page);
}
