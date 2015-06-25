package com.chag.app.web.test;

import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.chag.app.web.dao.DeptDao;
import com.chag.app.web.entity.Dept;

public class TestCase {
	@Test
	public void test1(){
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		DeptDao deptDao = (DeptDao) ctx.getBean("deptDao");
		Dept dept = new Dept(null, "XXXX", "À¥Ã÷");
		deptDao.add(dept);
		
		ctx.close();
	}
}
