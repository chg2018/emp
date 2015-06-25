<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>测试SpringMVC</title>
<script type="text/javascript" src="../scripts/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btn").click(function() {
			var v_empno = $("#empno").val();
			fn(v_empno);
		});

		$("#btn2").click(function() {
			var v_empno = $("#empno").val();
			fn2(v_empno);
		});

		$("#btn3").click(function() {
			fn3();
		});
	});

	function Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.mgr = mgr;
		this.hiredate = hiredate;
		this.sal = sal;
		this.comm = comm;
		this.deptno = deptno;

		this.sayHello = function() {
			alert(this.ename + "," + this.job + "," + this.mgr + "," + this.sal
					+ "," + this.comm + "," + this.deptno);

			this.toString = function n() {
				return this.ename + "," + this.job + "," + this.mgr + ","
						+ this.sal + "," + this.comm + "," + this.deptno;
			};
		};
	}

	function fn(v_empno) {
		/* 请求数据 */
		var data = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:getName xmlns:ns2="http://ws.web.app.chag.com/"><arg0>'
				+ v_empno + '</arg0></ns2:getName></soap:Body></soap:Envelope>';
		$.ajax({
			/* 设置同步请求 */
			async : true,
			/* 数据提交方式 */
			type : 'POST',
			/* 请求地址 */
			url : "http://localhost:8888/Spring_MyBatis_CXF2/ws/empService",
			/* 提交数据 */
			data : data,
			/* 成功回调函数 */
			success : function(msg) {
				var $res = $(msg);
				var value = $res.find("return").eq(0).text();
				alert(value);
			},
			/* 数据类型 */
			dataType : "xml",
			/* 请求头 */
			contentType : "application/x-www-form-urlencoded"
		});
	}

	function fn2(v_empno) {
		/* 请求数据 */
		var data = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:getEmpInfo xmlns:ns2="http://ws.web.app.chag.com/"><arg0>'
				+ v_empno
				+ '</arg0></ns2:getEmpInfo></soap:Body></soap:Envelope>';
		$.ajax({
			/* 设置同步请求 */
			async : true,
			/* 数据提交方式 */
			type : 'POST',
			/* 请求地址 */
			url : "http://localhost:8888/Spring_MyBatis_CXF2/ws/empService",
			/* 提交数据 */
			data : data,
			/* 成功回调函数 */
			success : function(msg) {
				var $res = $(msg);
				var empno = $res.find("empno").eq(0).text();
				var ename = $res.find("ename").eq(0).text();
				var job = $res.find("job").eq(0).text();
				var mgr = $res.find("mgr").eq(0).text();
				var hiredate = $res.find("hiredate").eq(0).text();
				var sal = $res.find("sal").eq(0).text();
				var comm = $res.find("comm").eq(0).text();
				var deptno = $res.find("deptno").eq(0).text();
				var emp = new Emp(empno, ename, job, mgr, hiredate, sal, comm,
						deptno);
				emp.sayHello();
			},
			/* 数据类型 */
			dataType : "xml",
			/* 请求头 */
			contentType : "application/x-www-form-urlencoded"
		});
	}

	function fn3() {
		/* 请求数据 */
		var data = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:findAll xmlns:ns2="http://ws.web.app.chag.com/"/></soap:Body></soap:Envelope>';
		$.ajax({
			/* 设置同步请求 */
			async : true,
			/* 数据提交方式 */
			type : 'POST',
			/* 请求地址 */
			url : "http://localhost:8888/Spring_MyBatis_CXF2/ws/empService",
			/* 提交数据 */
			data : data,
			/* 成功回调函数 */
			success : function(msg) {
				var list = new Array(); //创建一个数组
				var result = "";
				var $res = $(msg);
				var i = 0;
				$res.find("return").each(
						function() {
							var empno = $(this).find("empno").eq(0).text();
							var ename = $(this).find("ename").eq(0).text();
							var job = $(this).find("job").eq(0).text();
							var mgr = $(this).find("mgr").eq(0).text();
							var hiredate = $(this).find("hiredate").eq(0)
									.text();
							var sal = $(this).find("sal").eq(0).text();
							var comm = $(this).find("comm").eq(0).text();
							var deptno = $(this).find("deptno").eq(0).text();
							var emp = new Emp(empno, ename, job, mgr, hiredate,
									sal, comm, deptno);
							list[i] = emp.toString();
							i++;
							result += emp.ename + "," + emp.job + ","
									+ emp.hiredate + "," + emp.sal + ","
									+ emp.deptno + "---------------------";
						});
				alert(result);
			},
			/* 数据类型 */
			dataType : "xml",
			/* 请求头 */
			contentType : "application/x-www-form-urlencoded"
		});
	}
</script>
</head>
<body>
	<form action="" enctype="application/x-www-form-urlencoded"></form>
	<table cellpadding="10px" cellspacing="0" border="1px solid red"
		style="width: 100%; background: fuchsia;">
		<tr>
			<td colspan="3"><input type="number" id="empno" value="7654"></td>
		</tr>
		<tr>
			<td><input type="button" id="btn" value="查询姓名"></td>
			<td><input type="button" id="btn2" value="查询员工信息"></td>
			<td><input type="button" id="btn3" value="查询全部员工"></td>
		</tr>
	</table>
</body>
</html>