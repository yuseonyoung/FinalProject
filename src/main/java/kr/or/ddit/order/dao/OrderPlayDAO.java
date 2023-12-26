package kr.or.ddit.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;

@Mapper
public interface OrderPlayDAO {
	//발주서 조회
	public List<PurOrdVO> selectOrderPlayList();
	//발주서 상세조회
	public List<PurOrdVO> selectOrderPlayDetailList(String pordCd);
	//회사 조회
	public List<CompanyVO> selectCompanyList();
	
	//발주넣을 회사 조회
	public List<ItemUprcVO> selectDealCompanyList();
	//발주 가능 품목 조회
	public List<ItemUprcVO> selectDealItemList();
	//발주 가능 품목 조회 (거래처가 선택됐을 때)
	public List<ItemUprcVO> selectDealItemSpecialList(String comCd);
	
	public List<EmpVO> selectResponsibleEmp();
	
	//되냐
    public int selectTotalRecord(PaginationInfo<PurOrdVO> paging);
    public List<PurOrdVO> selectOrderPlayList2(PaginationInfo<PurOrdVO> paging);
	
	public int insertPurOrd(PurOrdVO poVO);
	
	public int insertPurOrd2(PurOrdVO poVO);
	
	public int insertPurOrdItem(PurOrdItemVO poiVO);
	
	/**
	 * 입고예정 조회를 위한 메소드
	 * 
	 * @return
	 */
    public List<Map<String,Object>> selectPurOrderList();
    
    /**
     * 
     * 입고예정을 위한 상세조회 발주서 정보
     * 
     * @param pordCd
     * @return
     */
    public List<Map<String,Object>> purOrderDetail(String pordCd);
    
    /**
     * 입고 예정 폼 정보
     * 
     * @return
     */
    public List<Map<String,Object>> purOrderConfirmed(); 
    /**
     * 
     * 입고 확정이 실행되면 발주서 상태 변경
     * 
     * @return
     */
    public int purOderStatUpdate(String pordCd);
    
    //발주서 현황
    public List<Map<String,Object>> orderPlayCurrentList(Map<String, Object> orderPlayParam);
    
    public List<Map<String, Object>> selectOrderPlay(String pordCd);
}
