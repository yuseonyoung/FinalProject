/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 22.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 22.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


	
$(function(){
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	//시작할때 List조회
	getView();
	let detailWindowModal = new bootstrap.Modal($('#rmstWindow')[0]);
	
	function getView(){
		$.ajax({
			url: '/scheduledStock/out',
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let stockList = resp.stockList;
				console.log(stockList);
				let trTags = "";
		
				if (stockList?.length > 0) {
					$.each(stockList, function () {
						trTags += makeTrTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>출고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
																											
				$('#relsListDataTable').DataTable({
			        paging: true,
			        searching: true,
			        lengthChange: false,
			        info: false,
			        ordering: false
			    });
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
			
		});	
	
	} // List 함수끝
	
	//List에 body영역 만들어주는 함수
	const makeTrTag = function(rslt){
	    let additionalItems = rslt.itemCount > 1 ? `외 ${rslt.itemCount - 1}건` : ''; // 조건부 연산으로 외 건수를 확인
	    
	    let trTag = `
	        <tr>
	            <td class='rdrecCdValue'><a id='detailId' href="javascript:void(0)">${rslt.rdrecCd}</a></td>
	            <td>${rslt.comNm}</td>
	            <td>${rslt.empNm}</td>
	            <td>${rslt.itemNm} ${additionalItems}</td>
	            <td>${rslt.rdrecOutdate}</td>
	            <td>${rslt.itemQty > 0 ? addCommas(rslt.itemQty) : 0}</td>
	            <td>${rslt.rdrecStat}</td>
	        </tr>    
	    `;
	    return trTag;
	};
	
	
	

	let makeDetailTag = function(rslt){
	    let trTag = `
	        <tr>
	            <td><input class="iText inputBorder" type="text" value="${rslt.itemCd}"></td>
	            <td><input class="iText inputBorder" type="text" value="${rslt.itemNm}"></td>
	            <td><input class="iText inputBorder" type="text" value="${rslt.itemUnit}"></td>
	            <td><input class="iText inputBorder" type="text" value="${rslt.rdrecQty > 0 ? addCommas(rslt.rdrecQty) : 0}"></td>
	            <td><input class="iText inputBorder" type="text" value="${rslt.rdrecOutdate}"></td>
	        </tr>    
	    `;
	    return trTag;
	};
	
	$(document).on('click', '#detailId', function() {
	    detailWindowModal.show();

		let rdrecCd = $(this).text();
		$.ajax({
			url: `/scheduledStock/out/${rdrecCd}`,
			method: "GET",
			success: function(res) {
				
				let stockDetail = res.stockDetail;
				/*
					각 출하지시서 기본데이터 출력
				*/
				let rdrecDate = stockDetail[0].rdrecDate;
				let empNm = stockDetail[0].empNm;
				let comNm = stockDetail[0].comNm;
				let rdrecOutdate= stockDetail[0].rdrecOutdate;
				
				$('#relsDate').val(rdrecDate)
				$('#empNm').val(empNm)
				$('#comNm').val(comNm)
				$('#outDate').val(rdrecOutdate)
				
				
				console.log(stockDetail);
				let trTags = `
					<tr>
						<th>품목코드</th>
						<th>품목명</th>
						<th>단위</th>
						<th>수량</th>
						<th>납기일자</th>
						
					</tr>
													
				`;
				
				if (stockDetail!=null) {
					$.each(stockDetail, function () {
						trTags += makeDetailTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='5'>출고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}
				$('#detailList').html(trTags);
										
			},
			error: function (request, status, error) {
		        console.log("code: " + request.status)
		        console.log("message: " + request.responseText)
		        console.log("error: " + error);
		    }
		})
	});

})




   