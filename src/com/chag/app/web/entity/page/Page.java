package com.chag.app.web.entity.page;

public class Page {
	// ��ҳ��ѯʱ��Ҫ���������

		// ��ǰҳ���пͻ�����ͻ������룬Ĭ��Ϊ��һҳ
		private int currentPage = 1;

		// ÿҳ�������
		private int pageSize = 10;

		// ------��ҳSQL���������------
		private int begin; // /��ʼ�� ()

		private int end; // ��ֹ�� ()

		// ���ݿ��ѯ��������
		private int rows;

		// ҳ�涯̬����ҳ��ʱ����Ҫ���ݵ���ֵ
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
			 * �����������ı�ʱ,����������ҳ���ı仯, �Ӷ����ܵ��µ�ǰҳ������ҳ��,�ڴ˴���һ��������.
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
