package kr.or.ddit.paging.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.DefaultPaginationRenderer;
import kr.or.ddit.paging.PaginationRenderer;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 페이징 처리와 관련된 모든 속성을 가진 자바빈.
 */
@Getter
@ToString
@NoArgsConstructor
@JsonIgnoreProperties("renderer")
public class PaginationInfo<T> implements Serializable{
	
	
	
	public PaginationInfo(int screenSize, int blockSize) {
		super();
		
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	private String empCd;
	private int totalRecord; // select 쿼리 필요
	private int currentPage; // request parameter
	
	private int screenSize = 10;
	private int blockSize = 5;
	
	// 연산식 필요
	private int totalPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	
	private List<T> dataList;
	
	private List<Map<String,Object>> dataMapList;
	
	private SearchVO simpleCondition; // 단순 키워드 검색 조건
	private T detailCondition; // 상세 검색 조건
	
//	@JsonIgnore
	private transient PaginationRenderer renderer = new BootstrapPaginationRenderer();
	
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
	
	public void setSimpleCondition(SearchVO simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	
	public void setRenderer(PaginationRenderer renderer) {
		this.renderer = renderer;
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord + (screenSize - 1)) / screenSize;
	}
	public void setDataMapList(List<Map<String, Object>> dataMapList) {
		this.dataMapList = dataMapList;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		endPage = blockSize * ((currentPage+(blockSize-1)) / blockSize);
		startPage = endPage - (blockSize - 1);
	}
	
	public int getEndPage() {
		return endPage < totalPage ? endPage : totalPage;
	}
	
	public String getPagingHTML() {
		return renderer.renderPagination(this);
	}

	public void setEmpCd(String empCd) {
		this.empCd = empCd;
	}
	
	
	
	
	
	
}











