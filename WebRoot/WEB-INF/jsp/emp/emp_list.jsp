<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EMP_LIST</title>
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global_color.css" />
<script language="javascript" type="text/javascript"
	src="../scripts/jquery-1.11.2.min.js"></script>

<style type="text/css">
.width120 {
	width: 125px;
}
</style>
<script language="javascript" type="text/javascript">
	//删除员工
	function deleteEmp(empno, tag) {
		//$(tag).parent().parent().prop('tagName') 获取当前元素的标签
		var ename = $(tag).parent().parent().children("td[name='ename']")
				.text().trim();
		var r = window.confirm("确定要删除该条信息吗？");
		if (r) {
			$.post("delete.do", {
				"empno" : empno
			}, function(data) {
				//回调函数的参数即为返回的ename,删除失败返回error
				if (data == "success") {
					//如果服务端删除成功，给DIV添加成功样式，并添加文字信息
					$("#operate_result_info").text("删除员工" + ename + "成功！");
					$("#operate_result_info").removeClass("operate_fail")
							.addClass("operate_success");
					$("#operate_result_info").fadeIn("slow");

					//推迟2S，执行function
					setTimeout(function() {
						//关闭提示框
						$("#operate_result_info").fadeOut("slow");

						//如果开通成功，则刷新页面
						location.href = "emplist.do";
					}, 2000);
				} else if (data == "error") {
					$("#operate_result_info").text("删除员工" + ename + "失败！");
					$("#operate_result_info").removeClass("operate_success")
							.addClass("operate_fail");
					$("#operate_result_info").fadeIn("slow");

					//如果删除失败，则刷新页面
					//推迟2S，执行function
					setTimeout(function() {
						//关闭提示框
						$("#operate_result_info").fadeOut("slow");

						//如果开通成功，则刷新页面
						location.href = "emplist.do";
					}, 2000);
				} else if (data == "fail") {
					$("#operate_result_info").text("员工" + ename + "不存在，删除失败！");
					$("#operate_result_info").removeClass("operate_success")
							.addClass("operate_fail");
					$("#operate_result_info").fadeIn("slow");

					//如果删除失败，则刷新页面
					//推迟2S，执行function
					setTimeout(function() {
						//关闭提示框
						$("#operate_result_info").fadeOut("slow");

						//如果开通成功，则刷新页面
						location.href = "emplist.do";
					}, 2000);
				}
			});
		}
	}

	//修改页面
	function modifyEmp(empno) {
		$("input[name='empno']").val(empno);
		$("#empForm").submit();
	}

	//新增页面
	function onAdd() {
		location.href = "onAdd.do";
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
		<form action="emplist.do" method="post">
			<!--查询-->
			<div class="search_add">
				<div>
					姓名：<input type="text" value="${empPage.ename}"
						class="width120 text_search" name="ename" />
				</div>
				<div>
					职位：<input type="text" value="${empPage.job}"
						class="width120 text_search" name="job" />
				</div>
				<div>
					上司：<input type="number" value="${empPage.mgr}"
						class="width120 text_search" name="mgr" />
				</div>
				<div>
					部门： <select class="width120 select_search" name="deptno">
						<option value="-1" <c:if test="${empPage.deptno == '-1'}">selected</c:if>>请选择</option>
						<option value="10" <c:if test="${empPage.deptno == '10'}">selected</c:if>>系统集成部</option>
						<option value="20" <c:if test="${empPage.deptno == '20'}">selected</c:if>>产品研发部</option>
						<option value="30" <c:if test="${empPage.deptno == '30'}">selected</c:if>>市场部</option>
						<option value="40" <c:if test="${empPage.deptno == '40'}">selected</c:if>>人力资源部</option>
						<option value="50" <c:if test="${empPage.deptno == '50'}">selected</c:if>>其它</option>
					</select>
				</div>
				<div>
					<input type="submit" value="搜索" class="btn_search"
						style="cursor: pointer;" />
				</div>
				<input type="button" value="增加" class="btn_add" onclick="onAdd()" />
			</div>
		</form>

		<form action="onmodify.do" method="post" id="empForm">
			<!--启用操作的操作提示-->
			<div id="operate_result_info" class="operate_success">
				<img src="../images/close.png"
					onclick="this.parentNode.style.display='none';" /> 删除成功！
			</div>
			<!--数据区域：用表格展示数据-->
			<div id="data">
				<table id="datalist">
					<tr>
						<th>姓名</th>
						<th class="width100">职位</th>
						<th>上司</th>
						<th>入职时间</th>
						<th>薪水</th>
						<th>奖金</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<tbody id="tbody_text">
						<c:forEach items="${emps}" var="e" varStatus="s">
							<tr>
								<td name="ename">${e.ename}</td>
								<td>${e.job}</td>
								<td>${e.mgr}</td>
								<td><fmt:formatDate value="${e.hiredate}"
										pattern="yyyy-MM-dd" /></td>
								<td>${e.sal}</td>
								<td>${e.comm}</td>
								<td><c:choose>
										<c:when test="${e.deptno == 10}">系统集成部</c:when>
										<c:when test="${e.deptno == 20}">产品研发部</c:when>
										<c:when test="${e.deptno == 30}">市场部</c:when>
										<c:when test="${e.deptno == 40}">人力资源部</c:when>
										<c:otherwise>其它</c:otherwise>
									</c:choose></td>
								<td><input type="hidden" value="" name="empno" /> <input
									type="button" value="修改" class="btn_modify"
									onclick="modifyEmp(${e.empno});" /> <input type="button"
									value="删除" class="btn_delete"
									onclick="deleteEmp(${e.empno},this);" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p></p>
			</div>
			<%@include file="pages.jsp"%>
		</form>
	</div>
	<!--主要区域结束-->
	<!-- <div id="footer">
		<p></p>
	</div> -->
</body>
</html>