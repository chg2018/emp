<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
<!--
	function onQuery(currentPage) {
		$.post("onQuery.do", {
			"currentPage" : currentPage
		}, function(data) {
			//回调函数的参数success,失败返回error
			if (data != "error") {
				//如果返回成功，则刷新页面
				location.href = "emplist.do";
			} else {
				//如果返回失败，则刷新页面
				location.href = "emplist.do";
			}
		});
	}

	function previous() {
		var curPage = $("a[class='current_page']").text().trim();
		onQuery(curPage - 1);
	}

	function next() {
		var curPage = $("a[class='current_page']").text().trim();
		onQuery(curPage + 1);
	}
//-->
</script>
<!-- 分页片段显示操作 -->
<c:choose>
	<c:when test="${empPage.totalPage <= empPage.pageSize}">
		<c:set var="begin" value="1" />
		<c:set var="end" value="${empPage.totalPage}" />
	</c:when>
	<c:otherwise>
		<c:set var="begin" value="${empPage.currentPage}" />
		<c:set var="end" value="${empPage.currentPage+empPage.pageSize-1}" />
		<c:if test="${begin < 1}">
			<c:set var="begin" value="1" />
			<c:set var="end" value="${empPage.pageSize}" />
		</c:if>
		<c:if test="${end > empPage.totalPage}">
			<c:set var="begin" value="${empPage.totalPage - empPage.pageSize+1}" />
			<c:set var="end" value="${empPage.totalPage}" />
		</c:if>
	</c:otherwise>
</c:choose>
<!--分页-->
<div id="pages">
	<c:choose>
		<c:when test="${empPage.currentPage <= 1}">
			<a href="javascript:;">上一页</a>
		</c:when>
		<c:otherwise>
			<%-- <a href="emplist.do?currentPage=${empPage.currentPage-1}">上一页</a> --%>
			<a href="javascript:previous();">上一页</a>
		</c:otherwise>
	</c:choose>
	<c:forEach begin="${begin}" end="${end}" var="p">
		<c:choose>
			<c:when test="${p == empPage.currentPage}">
				<%-- <a href="emplist.do?currentPage=${p}" class="current_page"
					id="currentPage" name="${p}">${p}</a> --%>
				<a href="javascript:onQuery(${p});" class="current_page">${p}</a>
			</c:when>
			<c:otherwise>
				<%-- <a href="emplist.do?currentPage=${p}">${p}</a> --%>
				<a href="javascript:onQuery(${p});">${p}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${end < empPage.totalPage}">>></c:when>
	</c:choose>
	<c:choose>
		<c:when test="${empPage.currentPage >= empPage.totalPage}">
			<a href="javascript:;">下一页</a>
		</c:when>
		<c:otherwise>
			<%-- <a href="emplist.do?currentPage=${empPage.currentPage+1}">下一页</a> --%>
			<a href="javascript:next();">下一页</a>
		</c:otherwise>
	</c:choose>
</div>