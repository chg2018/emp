package com.chag.app.web.ws;

import java.util.List;

import javax.annotation.Resource;
import javax.jws.WebMethod;
import javax.jws.WebService;

import org.springframework.stereotype.Service;

import com.chag.app.web.dao.EmpDao;
import com.chag.app.web.entity.Emp;

@WebService
@Service
public class EmpWSImpl implements EmpWS {
	@Resource
	private EmpDao empDao;

	@WebMethod
	public String getName(Integer empno) {
		Emp emp = empDao.findById(empno);

		if (emp != null) {
			System.out.println("Server: " + emp);
			return emp.getEname();
		} else {
			return "用户不存在";
		}
	}

	@WebMethod
	public Emp getEmpInfo(Integer empno) {
		Emp emp = empDao.findById(empno);
		if (emp != null) {
			System.out.println("Server: " + emp);
			return emp;
		} 
		return null;
	}

	@WebMethod
	public List<Emp> findAll() {
		List<Emp> emps = empDao.findAll();
		if(emps != null){
			System.out.println("Server: " + emps);
			return emps;
		}
		return null;
	}
}
