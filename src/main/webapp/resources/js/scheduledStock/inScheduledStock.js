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
		//시작할때 List조회
	getView();
	
	//입고예정 모달
	let detailWindowModal = new bootstrap.Modal($('#purWindow')[0]);
	
	function getView(){
		$.ajax({
			url: '/scheduledStock/in',
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let schduledInStockList = resp.schduledInStockList;
				console.log(schduledInStockList);
				let trTags = "";
		
				if (schduledInStockList?.length > 0) {
					$.each(schduledInStockList, function () {
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
	            <td class='pordCdValue'><a id='detailId' href="javascript:void(0)">${rslt.pordCd}</a></td>
	            <td>${rslt.comNm}</td>
	            <td>${rslt.empNm}</td>
	            <td>${rslt.itemNm} ${additionalItems}</td>
	            <td>${rslt.dueDate}</td>
	            <td>${rslt.itemQty > 0 ? addCommas(rslt.itemQty) : 0}</td>
	            <td>${rslt.pordStat}</td>
	        </tr>    
	    `;
	    return trTag;
	};
	
	
	
	/* --------------------상세조회 ------------------------*/
	let addCommas = function(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };	
	let makeDetailTag = function(rslt){
		
	    let trTag = `
	        <tr>
	            <td><input class="iText" type="text" value="${rslt.itemCd}"></td>
	            <td><input class="iText" type="text" value="${rslt.itemNm}"></td>
	            <td><input class="iText" type="text" value="${rslt.itemUnit}"></td>
	            <td><input class="iText" type="text" value="${rslt.pordQty > 0 ? addCommas(rslt.pordQty) : 0}"></td>
	            <td><input class="iText" type="text" value="${rslt.pordUprc > 0 ? addCommas(rslt.pordUprc) : 0}"></td>
	            <td><input class="iText" type="text" value="${rslt.MULTIPLY > 0 ? addCommas(rslt.MULTIPLY) : 0}"></td>
					<input type="hidden" value="${rslt.empCd}"/>
					<input type="hidden" value="${rslt.comCd}"/>
					
	        </tr>
	    `;
	    return trTag;
	};
	
	$(document).on('click', '#detailId', function() {
	    detailWindowModal.show();

		let pordCd = $(this).text();
		
		$.ajax({
			url: `/scheduledStock/in/${pordCd}`,
			method: "GET",
			success: function(res) {
				
				let stockDetail = res.stockDetail;
				console.log(stockDetail);
				/*
					각 발주서 기본데이터 출력
				*/
				//일자
				let pordDate = stockDetail[0].pordDate;
				//담당자
				let empNm = stockDetail[0].empNm;
				
				//거래처
				let comNm = stockDetail[0].comNm;
				
				//납기일자
				let dueDate = stockDetail[0].dueDate;
				
				
				$('#pordDate').val(pordDate);
				$('#empNm').val(empNm);
				$('#comNm').val(comNm);
				$('#dueDate').val(dueDate);
				
			/*	let rdrecDate = stockDetail[0].rdrecDate;
				let empNm = stockDetail[0].empNm;
				let comNm = stockDetail[0].comNm;
				let rdrecOutdate= stockDetail[0].rdrecOutdate;
				
				$('#relsDate').val(rdrecDate)
				$('#empNm').val(empNm)
				$('#comNm').val(comNm)
				$('#outDate').val(rdrecOutdate)
				*/
				
				console.log(stockDetail);
				let trTags = `
					<tr>
						<th>품목코드</th>
						<th>품목명</th>
						<th>단위</th>
						<th>수량</th>
						<th>단가</th>
						<th>합계</th>
					</tr>
				`;
				
				if (stockDetail!=null) {
					$.each(stockDetail, function() {
						trTags += makeDetailTag(this);
					});
				
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='6'>입고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}
				
				
				trTags +=`
					<tr>
						<td colspan='3'>합계 :</td>
						<td><input class="iText" type="text" value="${stockDetail[0].countQty > 0 ? addCommas(stockDetail[0].countQty) : 0}"></td>
						<td colspan='1'></td>
						<td><input class="iText" type="text" value="${stockDetail[0].sumValue > 0 ? addCommas(stockDetail[0].sumValue) : 0}"></td>
					<tr>
				`
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




   