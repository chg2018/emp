package com.chag.app.web.entity.page;

public class Page {
	// 分页查询时需要输入的条件

		// 当前页，有客户点击客户端输入，默认为第一页
		private int currentPage = 1;

		// 每页的最大行
		private int pageSize = 10;

		// ------分页SQL所需的条件------
		private int begin; // /起始行 ()

		private int end; // 终止行 ()

		// 数据库查询中总行数
		private int rows;

		// 页面动态创建页码时，需要传递的数值
		private int totalPage;

		public int getCurrentPage() {
			return currentPage;
		}

		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}

		public int getPageSize() {
			return pageSize;
		}

		public void setPageSize(int pageSize) {
			this.pageSize = pageSize;
		}

		public int getBegin() {
			begin = (currentPage - 1) * pageSize+1;
			return begin;
		}

		public void setBegin(int begin) {
			this.begin = begin;
		}

		public int getEnd() {
			end = (currentPage) * pageSize;
			return end;
		}

		public void setEnd(int end) {
			this.end = end;
		}

		public int getRows() {
			return rows;
		}

		public void setRows(int rows) {
			this.rows = rows;
			/*
			 * 总行数发生改变时,可能引起总页数的变化, 从而可能导致当前页大于总页数,在此处理一下这个情况.
			 */
			if (currentPage > getTotalPage()) {
				currentPage = getTotalPage();
			}
		}

		public int getTotalPage() {
			if (rows % pageSize == 0) {
				totalPage = rows / pageSize;
			} else {
				totalPage = rows / pageSize + 1;
			}
			return totalPage;
		}

		public void setTotalPage(int totalPage) {
			this.totalPage = totalPage;
		}
}
