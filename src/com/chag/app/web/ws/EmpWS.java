package com.chag.app.web.ws;

import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.chag.app.web.entity.Emp;

@WebService
public interface EmpWS {
	@WebMethod
	public String getName(Integer empno);
	
	@WebMethod
	public Emp getEmpInfo(Integer empno);
	
	@WebMethod
	public List<Emp> findAll();
}
