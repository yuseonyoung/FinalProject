/**
 * <pre>
 * 
 * </pre>
 * @author 작성자명
 * @since 2023. 11. 17.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 17.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


function gkgkgk(){
	const baseUrl = `${cPath}/defect/listView`;
table = $('#defectListDataTable').DataTable({
                    ajax: {
                        url: baseUrl,
                        type: "GET",
                        dataType: "JSON",
                        complete: function (data) {
                            info = data['responseJSON']
                            console.log('데이터 확인', info);
                            // 이렇게 success 대신 complete 사용해야 출력 가능.

                        },
                        dataSrc: function (res) {
                            var defectList = res.defectList;
                            var result = []
                            
                            
                            // 상태가 waiting인 객체 빼고 리턴하기
                            for (let i = 0; i < defectList.length; i++) {
                                if ( defectList[i].status == 'waiting' ) {
                                    continue;
                                }
                                result.push(defectList[i])
                            }

			// 배열에 인덱스 번호 매기기 (테이블에 인덱스 보여지게)
                            for (let i = 0; i < defectList.length; i++) {
                                defectList[i].index = i + 1
                                // console.log(data[i])
                            }                            
                            return result
                        }
                    },
                   	paging: true,
					searching: true,
                    lengthChange: false,
                    info: false,
                    ordering: false,
					destroy: true,
					drawCallback: function(settings) {
						currentPageNumber = settings._iDisplayStart / settings._iDisplayLength + 1;
						},
                    columns: [
                        { title: '번호', data: "index" },
                        { title: '일자', data: "defProcCd" },
                        { title: '발견창고', data: "storage.wareNm" },
                        { title: '품목명', data: "item.itemNm" },
                        { title: '수량', data: "defQty" },
                        { title: '불량유형', data: "defCd" },
                        { title: '처리방법', data: "defProc" },
                        { title: '적요', data: "defNote" }, 
                    ],
                })
}


function makeRows(){
						
						if(itemList?.length>0){
							 $.each(itemList, function (index, item) {
         						let errorNumber = item.rinvQty - actInvenView.itemWare.wareQty;
								let number ="";
									if(errorNumber<0){
										number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="${errorNumber}" disabled="disabled" style="background-color: lightpink; font-weight: bold;"/>`;
									}else if(errorNumber>0){
										number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="+${errorNumber}" disabled="disabled" style="background-color: lightskyblue; font-weight: bold;"/>`;
									}else{
										number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="${errorNumber}" disabled="disabled" style="font-weight: bold;"/>`;
									}
								makeTrTag+=` 
									<tr>
	                                    <td>
	                                        <input type="text" id="findItemCd" name="itemCd" class="iText" value="${item.item.itemCd}" />
	                                        <span id="itemCd" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemNm" class="iText" name="itemNm" value="${item.item.itemNm}"/>
	                                        <span id="itemNm" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemUnit" class="iText" disabled="disabled" value="${item.item.itemUnit}"/>
	                                    </td>	
	                                    <td>
	                                        <input type="text" id="findWareQty" name="wareQty" class="iText" style="width: 120px" value="${actInvenView.itemWare.wareQty}" disabled="disabled"/>
	                                        <span id="wareQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                        <input type="number" id="findRinvQty" name="rinvQty" class="iText" value="${item.rinvQty}" />
	                                        <span id="rinvQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                       ${number}
	                                    </td>
	                                </tr>
								`;
							});
						};		
						return makeTrTag;		
					};
					
					makeTable+=
					`
					<table class="table table-bordered table-striped fs--1 mb-0" id="dataTable">
	                            <thead class="bg-200 text-900">
	                                <tr>
	                                    <th>일자</th>
	                                    <td colspan="2">
											<input type="date" id="actInvenDate" name="rinvDate" class="rinvDate" placeholder="조사일자"  style="width: 170px;" max="${getCurrentDate()}" value="${actInvenView.rinvDate}"/>
	                                        <span id="rinvDate" class="error"></span>
	                                    </td>
										<th>담당자</th>
	                                    <td colspan="2">
	                                        <input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" placeholder="담당자" style="width: 170px;" value="${actInvenView.emp.empNm}"/>
	                                        <span id="empNm" class="error"></span>
	                                        <input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd" value="${actInvenView.emp.empCd}"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th>창고명</th>
	                                    <td colspan="2">
	                                        <input type="text" id="findStorage" class="findStorage" name="wareNm" placeholder="발견창고" style="width: 170px;" value="${actInvenView.storage.wareNm}"/>
	                                        <span id="wareCd" class="error"></span>
	                                        <input type="hidden" id="findStorageCd" class="wareCd" name="wareCd" value="${actInvenView.storage.wareCd}"/>
	                                    </td>
	                              
										<th>구역</th>
										<td colspan="2">
											<input type="text" id="findStorageSector" class="findStorageSector" name="secCd" placeholder="구역" style="width: 170px;" value="${actInvenView.secCd}" readonly="readonly"/>
											<span id="secCd" class="error"></span>
										</td>
									</tr>
	                                <tr>
	                            </thead>
	
	                            <tbody style='text-align: center;'>
	                                <tr>
	                                    <th>품목코드</th>
	                                    <th>품목명</th>
	                                    <th>단위</th>
	                                    <th>시스템수량</th>
	                                    <th>실사수량</th>
	                                    <th>오차수량</th>
	                                </tr>
	                               ${makeRows()}	<!-- TrTag 생성 함수 호출 -->
	                            </tbody>
	                        </table>
					`;


$('#saveBtn').on("click", function(){
   let bookmarkVal = $("#bookmark").val();
    // 보내야 되는 값
   let sanctionArray = []; 
    
   $("#orgTreeResult > div input:hidden").each((i,itext)=>{
      console.log(itext.value);
      let boDeVO = {
         sanctner: itext.value
      };
      sanctionArray.push(boDeVO);
   });

   console.log("결재라인 체크:",sanctionArray);

   // 요즘은 다 덩어리로 보통 1개로 
   if(sanctionArray.length > 0) {
      let BookmarkVO = {};
      BookmarkVO.bkmkNm = bookmarkVal;
      BookmarkVO.detailList = sanctionArray;
   
      $.ajax({
         type:"post",
         url:"/bookmark/new",
         contentType:"application/json",  // post
         data: JSON.stringify(BookmarkVO) ,
         dataType:"text",
         success:function(rslt){
            // JSON.parse(rslt)  jQuery가 몰래해줌
            console.log("서버에서 온 값:", rslt);

            if(rslt == "OK"){
               Swal.fire({
                  icon: "success",
                  title: "즐겨찾기 등록완료!",
                  text: "결재선 즐겨찾기가 등록완료 되었습니다",
                  showConfirmButton: false,
                  timer: 2000
               });
               //console.log("체킁",$(".swal2-container.swal2-center.swal2-backdrop-show"));
               $(".swal2-container.swal2-center.swal2-backdrop-show").css("z-index",3000);   // default 1060, 동적생성이라 맹글고 바꿔야 함!
            }
         },
          error: function (request, status, error) {
              console.log("code: " + request.status)
              console.log("message: " + request.responseText)
              console.log("error: " + error);
          }
      });
   } else {
      alert("결재선을 1명이상 등록해주세요");
   }
});


   @ResponseBody
   @PostMapping("new")
   public String createBookmark(@RequestBody BookmarkVO bookmark 
         , Authentication authentication
         , RedirectAttributes ra
         ) {
   
      String empCd = authentication.getName();
      bookmark.setBkmkOwner(empCd);
      
      ServiceResult result = service.createBookmark(bookmark);
      
      String msg = "FAIL";
      
      if(result.equals(ServiceResult.OK)) {
         msg = "OK";
      } 
      
      return msg;
      
   }



package kr.or.ddit.groupware.sanction.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.groupware.sanction.dao.BookmarkDAO;
import kr.or.ddit.vo.groupware.BookmarkDetailVO;
import kr.or.ddit.vo.groupware.BookmarkVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 전수진
 * @since 2023. 11. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자               수정내용
 * --------     --------    ----------------------
 * 2023. 11. 17.  전수진       최초작성
 * 2023. 11. 18.  전수진       즐겨찾기 리스트, 상세보기 구현 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Service
public class BookmarkServiceImpl implements BookmarkService {
   
   @Inject
   private BookmarkDAO dao;


   @Transactional
   @Override
   public ServiceResult createBookmark(BookmarkVO bookmark) {
      
      /*
       BookmarkVO(bkmkNo=null, bkmkOwner=E220901003, bkmkNm=안녕, bkmkNote=null, 
       detailList=[
          BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=null, sanctnOrdr=null, sanctner=E220801001, bookmark=null), 
          BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=null, sanctnOrdr=null, sanctner=E221001001, bookmark=null), 
          BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=null, sanctnOrdr=null, sanctner=E220101002, bookmark=null)
       ], sanction=null, emp=null)
       */
      
      // 즐겨찾기 추가
      int cnt = dao.insertBookmark(bookmark);
      ServiceResult result = null;

      if(cnt > 0) {
         List<BookmarkDetailVO> sanctnerList = bookmark.getDetailList();
         if(sanctnerList!=null) {
            int sanctnOrdrCnt = 1;
            
            // 즐겨찾기상세에 즐겨찾기 추가
            for(BookmarkDetailVO vo : sanctnerList) {
               vo.setBkmkNo(bookmark.getBkmkNo());
               vo.setSanctnOrdr(sanctnOrdrCnt++);
//            vo : BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=BKE220901003004, sanctnOrdr=1, sanctner=E220801001, bookmark=null)
//            vo : BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=BKE220901003004, sanctnOrdr=2, sanctner=E221001001, bookmark=null)
//            vo : BookmarkDetailVO(bkmkDetailCd=null, bkmkCd=BKE220901003004, sanctnOrdr=3, sanctner=E220101002, bookmark=null)
               log.info("vo : " + vo);
               
               dao.insertBookmarkDetail(vo);
            }
         }
         result = ServiceResult.OK;
      } else {
         result = ServiceResult.FAIL;
      }
      return result;
   }

   @Override
   public int removeBookmark(String bkmkNo) {
      // 즐겨찾기 삭제, 디테일도 같이 삭제
      return 0;
   }

   @Override
   public List<BookmarkVO> retrieveBookmarkList(String bkmkOwner) {
      // 소유자의 즐겨찾기 리스트 출력
      return dao.selectBookmarkList(bkmkOwner);
   }

   @Override
   public List<BookmarkDetailVO> retrieveBookmarkDetailList(String bkmkNo) {
      // 즐겨찾기 번호로 결재자리스트 조회
      return dao.selectBookmarkDetailList(bkmkNo);
   }

   


}


title: '실사수량',
					data: function(row) {
						let rinvQty = 0; // 기본값 설정

						if (row.actIvenItem && row.actIvenItem.length > 0) {
							// actIvenItem이 배열이고, 항목이 있는 경우
							for (let i = 0; i < row.actIvenItem.length; i++) {
								// 여기서 각 항목의 rinvQty를 더합니다.
								rinvQty += row.actIvenItem[i].rinvQty;
							}
				




let actInvenView = resp.actInvenView;
					let itemList = actInvenView.actIvenItem;
					let makeTable = "";
					let makeTrTag = "";

					function makeRows() {

						if (itemList?.length > 0) {
							$.each(itemList, function(index, item) {
								let errorNumber = item.rinvQty - actInvenView.itemWare.wareQty;
								let number = "";
								
								if (errorNumber < 0) {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="${errorNumber}" disabled="disabled" style="background-color: lightpink; font-weight: bold;"/>`;
								} else if (errorNumber > 0) {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="+${errorNumber}" disabled="disabled" style="background-color: lightskyblue; font-weight: bold;"/>`;
								} else {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText" value="${errorNumber}" disabled="disabled" style="font-weight: bold;"/>`;
								}
								
								makeTrTag += ` 
									<tr id="itemRow_${item.item.itemCd}">
	                                    <td>
	                                        <input type="text" id="findItemCd" name="itemCd" class="iText findItemCd" value="${item.item.itemCd}" />
	                                        <span id="itemCd" class="error"></span> 
											<input type="hidden" class="hiddenItemCd" name="itemCd" value="${item.item.itemCd}"/>
											<input type="hidden" class="hiddenItemNum" name="itemNum" value="${item.itemNum}"/>
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemNm" class="iText findItemNm" name="itemNm" value="${item.item.itemNm}"/>
	                                        <span id="itemNm" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemUnit" class="iText findItemUnit" disabled="disabled" value="${item.item.itemUnit}"/>
	                                    </td>	
	                                    <td>
	                                        <input type="text" id="findWareQty" name="wareQty" class="iText" style="width: 120px" value="${actInvenView.itemWare.wareQty}" disabled="disabled"/>
	                                        <span id="wareQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                        <input type="number" id="findRinvQty" name="rinvQty" class="iText findRinvQty" value="${item.rinvQty}" />
	                                        <span id="rinvQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                       ${number}
	                                    </td>
										<td>
											<button class="btn btn-outline-danger btn-sm deleteRowBtn" data-item-code="${item.item.itemCd}">삭제</button>
										</td>
	                                </tr>
								`;
							});
						};
						return makeTrTag;
					};

/*

<select id="selectOrderPlayList2" parameterType="kr.or.ddit.paging.vo.PaginationInfo" resultMap="orderPlayMap">
    WITH ORDEREDPO AS(
         
         SELECT A.* , ROWNUM RNUM
         FROM (
              select * 
                from pur_ord
                order by due_date desc
         )A
   ),PO as(
         SELECT * FROM ORDEREDPO 
         <![CDATA[ WHERE RNUM >= #{startRow} AND RNUM <= #{endRow} ]]>
         
      )
         select 
                     po.pord_cd
                     , item.item_nm
                     , po.pord_date
                     , po.due_date
                     , FN_GET_COMM_CD_NM(po.pord_stat) AS PORD_STAT
                     , (select count(*) from pur_ord_item where pur_ord_item.pord_cd= po.pord_cd)-1 nQty
                 from PO
                    left outer join pur_ord_item poi
                                 on po.pord_cd=poi.pord_cd
                    left outer join item item
                                 on item.item_cd=poi.item_cd
                                 order by rnum
   </select>




<sql id="searchFrag">
	    <trim prefix="WHERE" prefixOverrides="AND">
	        RI.RINV_DATE BETWEEN TO_CHAR(ADD_MONTHS(SYSDATE,-3),'YYYY-MM-DD') AND TO_CHAR(SYSDATE,'YYYY-MM-DD')
	        <if test="detailCondition.searchType != null and @org.apache.commons.lang3.StringUtils@isNotBlank(detailCondition.searchType)">
	            <if test="detailCondition.searchType == 'wareNm'">
	                AND W.WARE_NM LIKE '%' || #{detailCondition.searchWord} || '%'
	            </if>
	            <if test="detailCondition.searchType == 'itemNm'">
	                AND I.ITEM_NM LIKE '%'|| #{detailCondition.searchWord}||'%'
	            </if>
	            <if test="detailCondition.searchType == 'empNm'">
	                AND E.EMP_NM LIKE'%'|| #{detailCondition.searchWord}||'%'
	            </if>
	            
	             <choose>
                    <when test="detailCondition.searchType eq 'wareNm'">
                        INSTR(W.WARE_NM, #{detailCondition.searchWord}) > 0
                    </when>
                    <when test="detailCondition.searchType eq 'itemNm'">
                        INSTR(I.ITEM_NM, #{detailCondition.searchWord}) > 0
                    </when>
                    <when test="detailCondition.searchType eq 'empNm'">
                        INSTR(E.EMP_NM, #{detailCondition.searchWord}) > 0
                    </when>
                    <otherwise>
                        INSTR(W.WARE_NM, #{detailCondition.searchWord}) > 0
                        OR
                        INSTR(I.ITEM_NM, #{detailCondition.searchWord}) > 0
                        OR
                        INSTR(E.EMP_NM, #{detailCondition.searchWord}) > 0
                    </otherwise>
                </choose>
	        </if>
	    </trim>
	</sql>
	
	
	
	Swal.fire({
  title: "Are you sure?",
  text: "You won't be able to revert this!",
  icon: "warning",
  showCancelButton: true,
  confirmButtonColor: "#3085d6",
  cancelButtonColor: "#d33",
  confirmButtonText: "Yes, delete it!"
}).then((result) => {
  if (result.isConfirmed) {
    Swal.fire({
      title: "Deleted!",
      text: "Your file has been deleted.",
      icon: "success"
    });
  }
});
	
*/


