<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EMP_ADD</title>
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global_color.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/jquery.datetimepicker.css" />
<script language="javascript" type="text/javascript"
	src="../scripts/jquery-1.11.2.min.js"></script>
<script language="javascript" type="text/javascript"
	src="../scripts/jquery.datetimepicker.js"></script>
<script language="javascript" type="text/javascript">
	$(function() {
		$('#hiredate').datetimepicker({
			lang : "ch", //语言选择中文
			format : "Y-m-d", //格式化日期
			timepicker : false, //关闭时间选项
			yearStart : 1900, //设置最小年份
			yearEnd : 2999, //设置最大年份
			todayButton : true
		//关闭选择今天按钮
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
	}

	function save() {
		var ename = $("input[name='ename']").val().trim();
		var job = $("input[name='job']").val().trim();
		var mgr = $("select[name='mgr']").val().trim();
		var hiredate = $("input[name='hiredate']").val().trim();
		var sal = $("input[name='sal']").val().trim();
		var comm = $("input[name='comm']").val().trim();
		var deptno = $("select[name='deptno']").val().trim();
		//var emp = new Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno);
		var r = window.confirm("确定要修改该条信息吗？");

		/* ?empno="+empno+"&ename="+ename+"&job="+
			job+"&mgr="+mgr+"&hiredate="+hiredate+"&sal="+
			sal+"&comm"+comm+"&deptno="+deptno */
		if (r) {
			$.post("add.do", {
				"ename" : ename,
				"job" : job,
				"mgr" : mgr,
				"hiredate" : hiredate,
				"sal" : sal,
				"comm" : comm,
				"deptno" : deptno
			}, function(data) {
				if (data == "success") {
					//如果服务端删除成功，给DIV添加成功样式，并添加文字信息
					$("#save_result_info").text("新增员工" + ename + "信息成功！");
					$("#save_result_info").removeClass("save_fail").addClass(
							"save_success");
					$("#save_result_info").fadeIn("slow");

					//推迟2S，执行function
					setTimeout(function() {
						//关闭提示框
						$("#operate_result_info").fadeOut("slow");

						//如果开通成功，则刷新页面
						location.href = "emplist.do";
					}, 2000);
				} else if (data == "error") {
					$("#save_result_info").text("新增员工" + ename + "信息失败！");
					$("#save_result_info").removeClass("save_success")
							.addClass("save_fail");
					$("#save_result_info").fadeIn("slow");

					//推迟2S，执行function
					setTimeout(function() {
						//关闭提示框
						$("#save_result_info").fadeOut("slow");
					}, 2000);
				}
			});
		}
	}
</script>
</head>
<body>
	<!--Logo区域开始-->
	<!-- <div id="header"></div> -->
	<!--Logo区域结束-->
	<!--导航区域开始-->
	<!-- <div id="navi"></div> -->
	<!--导航区域结束-->
	<!--主要区域开始-->
	<div id="main" style="margin: 100px auto">
		<div id="save_result_info" class="save_success">保存成功！</div>
		<form action="" method="" class="main_form">
			<div class="text_info clearfix">
				<span>姓名：</span>
			</div>
			<div class="input_info">
				<input type="text" class="width300" value="${emp.ename}"
					name="ename" /> <span class="required">*</span>
				<div class="validate_msg_short">30长度的字母、数字、汉字和下划线的组合</div>
			</div>
			<div class="text_info clearfix">
				<span>岗位：</span>
			</div>
			<div class="input_info">
				<input type="text" class="width300" value="${emp.job}" name="job" />
				<span class="required">*</span>
				<div class="validate_msg_short">20长度的字母、汉字的组合</div>
			</div>

			<div class="text_info clearfix">
				<span>入职时间：</span>
			</div>
			<div class="input_info">
				<input type="text" class="width200"
					value="<fmt:formatDate value="${emp.hiredate}"
										pattern="yyyy-MM-dd" />"
					name="hiredate" pattern="yyyy-MM-dd" id="hiredate" /> <span
					class="required">*</span>
				<div class="validate_msg_short"></div>
			</div>

			<div class="text_info clearfix">
				<span>上司：</span>
			</div>
			<div class="input_info">
				<select name="mgr" class="width200" style="width: 205px;">
					<option value="-1">请选择</option>
					<option value="7654">SCOOT</option>
					<option value="7788">JACK</option>
				</select> <span class="required">*</span>
				<div class="validate_msg_short"></div>
			</div>

			<div class="text_info clearfix">
				<span>月薪：</span>
			</div>
			<div class="input_info">
				<input type="number" class="width200" value="${emp.sal}" name="sal" />
				<span class="required">*</span>
				<div class="validate_msg_short">10位以内的数字</div>
			</div>
			<div class="text_info clearfix">
				<span>福利：</span>
			</div>
			<div class="input_info">
				<input type="number" class="width200" value="${emp.comm}"
					name="comm" /> <span class="required">*</span>
				<div class="validate_msg_short">10位以内的数字</div>
			</div>
			<div class="text_info clearfix">
				<span>部门：</span>
			</div>
			<div class="input_info">
				<select name="deptno" class="width200" style="width: 205px;">
					<option value="-1">请选择</option>
					<c:forEach items="${depts}" var="dept">
						<option value="${dept.deptno}">${dept.dname}</option>
					</c:forEach>
				</select> <span class="required">*</span>
				<div class="validate_msg_short"></div>
			</div>

			<div class="button_info clearfix">
				<input type="button" value="保存" class="btn_save" onclick="save()" />
				<input type="button" value="取消" class="btn_save"
					onclick="location.href = 'emplist.do'" />
			</div>
		</form>
	</div>
	<!--主要区域结束-->
	<!-- <div id="footer"></div> -->
</body>
</html>
