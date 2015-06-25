package com.chag.app.web.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.chag.app.web.dao.DeptDao;
import com.chag.app.web.dao.EmpDao;
import com.chag.app.web.entity.Dept;
import com.chag.app.web.entity.Emp;
import com.chag.app.web.entity.page.EmpPage;

//emp������
@Controller
@RequestMapping("/emp")
@SessionAttributes("empPage")
// ��session��ע��empPage����
public class EmpController {
	// Spring�Զ���װ
	@Autowired
	private EmpDao empDao;
	
	@Autowired
	private DeptDao deptDao;

	// ��ҳ����
	@RequestMapping("/emplist.do")
	public String findAll(EmpPage empPage, Model model,
			HttpServletRequest request) {
		
		
		
		
		if(empPage.getEname() != null){
			if("".equalsIgnoreCase(empPage.getEname())){
				empPage.setEname(null);
			}
		}
		
		if(empPage.getEname() != null){
			if("".equalsIgnoreCase(empPage.getJob())){
				empPage.setJob(null);
			}
		}
		if(empPage.getDeptno() != null){
			if(-1 == empPage.getDeptno()){
				empPage.setDeptno(null);
			}
		}
		
		int rows = empDao.findRows(empPage);
		empPage.setRows(rows);

		// ��ȡ��ǰҳ��Ϣ
		if (request.getParameter("currentPage") != null) {
			Integer currentPage = Integer.parseInt(request
					.getParameter("currentPage"));

			// �����ǰҳ������ҳ������ǰҳΪ��ҳ��
			if (currentPage > empPage.getTotalPage()) {
				empPage.setCurrentPage(empPage.getTotalPage());

				// �����ǰҳС��1����ǰҳΪ
			} else if (currentPage < 1) {
				empPage.setCurrentPage(1);
			}
		}

		List<Emp> emps = empDao.findByPage(empPage);
		List<Dept> depts = deptDao.findAll();

		if (emps.size() < 1) {
			empPage.setCurrentPage(1);
		}
		
		model.addAttribute("emps", emps);
		model.addAttribute("depts", depts);
		model.addAttribute("empPage", empPage);
		return "emp/emp_list";
	}

	// ����ID����emp
	@RequestMapping("/onmodify.do")
	public String findById(Integer empno, Model model) {
		Emp emp = empDao.findById(empno);
		Dept dept = deptDao.findById(emp.getDeptno());
		
		model.addAttribute("emp", emp);
		model.addAttribute("dept", dept);
		
		return "emp/emp_modify";
	}

	// �첽���и���
	@ResponseBody
	@RequestMapping("/update.do")
	public String update(HttpServletRequest request) throws Exception {
		try {
			Integer empno = Integer.parseInt(request.getParameter("empno"));
			String ename = request.getParameter("ename");
			String job = request.getParameter("job");
			Double sal = Double.parseDouble(request.getParameter("sal"));
			Double comm = Double.parseDouble(request.getParameter("comm"));
			Integer mgr = Integer.parseInt(request.getParameter("mgr"));
			Integer deptno = Integer.parseInt(request.getParameter("deptno"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(request.getParameter("hiredate"));
			Timestamp timestamp = new Timestamp(date.getTime());

			Emp emp = new Emp(empno, ename, job, mgr, timestamp, sal, comm,
					deptno);

			empDao.update(emp);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// �첽ɾ������
	@ResponseBody
	@RequestMapping("/delete.do")
	public String delete(EmpPage empPage, Integer empno) {
		try {
			Emp emp = empDao.findById(empno);
			if (emp == null) {
				return "fail";
			} else {
				empDao.deleteById(empno);
				return "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// ����ҳ���Զ�����empPage
	@ResponseBody
	@RequestMapping("/onQuery.do")
	public String onQuery(EmpPage empPage, HttpServletRequest request) {
		try {
			Integer currentPage = Integer.parseInt(request
					.getParameter("currentPage"));
			// �����ǰҳ������ҳ������ǰҳΪ��ҳ��
			if (currentPage > empPage.getTotalPage()) {
				currentPage = empPage.getTotalPage();

				// �����ǰҳС��1����ǰҳΪ1
			} else if (currentPage < 1) {
				currentPage = 1;
			}
			empPage.setCurrentPage(currentPage);
			return currentPage + "";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	@RequestMapping("/onAdd.do")
	public String onAdd(Model model) {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		Emp emp = new Emp(null, null, null, null, timestamp, null, null,
				null);
		List<Dept> depts = deptDao.findAll();
		
		model.addAttribute("emp", emp);
		model.addAttribute("depts", depts);
		
		return "emp/emp_add";
	}
	
	// ����emp����
	@ResponseBody
	@RequestMapping("/add.do")
	public String add(HttpServletRequest request) throws Exception {
		try {
			String ename = request.getParameter("ename");
			String job = request.getParameter("job");
			Double sal = Double.parseDouble(request.getParameter("sal"));
			Double comm = Double.parseDouble(request.getParameter("comm"));
			Integer mgr = Integer.parseInt(request.getParameter("mgr"));
			Integer deptno = Integer.parseInt(request.getParameter("deptno"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(request.getParameter("hiredate"));
			Timestamp timestamp = new Timestamp(date.getTime());

			Emp emp = new Emp(null, ename, job, mgr, timestamp, sal, comm,
					deptno);
			empDao.add(emp);
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
