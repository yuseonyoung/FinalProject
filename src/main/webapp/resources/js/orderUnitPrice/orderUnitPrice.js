/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

$(function(){
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log("namename",name);
			console.log("valuevalue",value);
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});

	
	/* 아작스를 위한 데이터 설정 */
	let makeTrTag = function(rslt) {
		let trTag = `
        <tr>
            <td id="upreqCd"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.upreqCd}</a></td>
			<td id="itemNm">${rslt.orderUnitPriceItem[0].item.itemNm}${rslt.nqty > 0 ? ` 외 ${rslt.nqty}건` : ''}</td>
            <td id="upreqDate">${rslt.upreqDate}</td>
            <td id="upreqValDate">${rslt.upreqValDate}</td>
            <td id="empNm">${rslt.empNm}</td>
            <td id="upreqStat"><a href="javascript:;">${rslt.upreqStat}</a></td>
        </tr>
	    `;
		return trTag;
	};

	let cPath = $('.pageConversion').data('contextPath');

	const baseUrl = `${cPath}/orderUnitPrice`;

	/* 조회 함수 */
	function retrieveOrderUnitPrice() {
		$.ajax({
			url: baseUrl + "/list2",
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function(resp) {
				console.log(resp);
				console.log("체크!",resp.dataList);
				let orderUnitPriceList = resp.dataList;
				let trTags = "";
				if (orderUnitPriceList?.length > 0) {
					$.each(orderUnitPriceList, function() {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 단가요청서가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
				
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveOrderUnitPrice();
	
	
	//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let url = this.action;
		let data = $(this).serialize();
		
		$.ajax({
			url: url,
			method: "GET",
			data : data,
			contentType: 'application/json',
			dataType: "json",
			success: function(resp) {
				console.log(resp);
				console.log("체크!",resp.dataList);
				let orderUnitPriceList = resp.dataList;
				let trTags = "";
				if (orderUnitPriceList?.length > 0) {
					$.each(orderUnitPriceList, function() {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 단가요청서가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
				
				
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
		
		});
	
	/* 아작스를 위한 데이터 설정 */
	let makeUnitPriceTrTag = function(rslt) {
		let trTag = `
        <tr>
            <td id="upreqCd"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.upreqCd}</a></td>
			<td id="itemNm">${rslt.itemNm}</td>
			<td id="uprcItQty"><input type="number" class="findUprcItQty" style="width: 100px;" value="${rslt.uprcItQty}"/></td>
            <td id="upreqDate">${rslt.upreqDate}</td>
            <td id="upreqValDate">${rslt.upreqValDate}</td>
            <td id="empNm">${rslt.empNm}</td>
            <td id="upreqDur"><input type="date" class="findUpreqDur" style="width: 100px;" value="${rslt.upreqDur}"/></td>
            <td id="upreqStat">${rslt.upreqStat}</a></td>
			<input type="hidden" class="findUpreqCd" value="${rslt.upreqCd}"/>
			<input type="hidden" class="findUprecItCd" value="${rslt.uprcItCd}"/>
        </tr>
	    `;
		return trTag;
	};
	// 해당 단가요청서 상세정보 및 수정 폼출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '#upreqCd a', function(e) {
		e.preventDefault();
		let upreqCd =$(this).text();
		let oredrUnitPriceViewURL = `${cPath}/orderUnitPrice/view?what=${upreqCd}`
		
		try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: oredrUnitPriceViewURL,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						console.log("resprespresp",resp);
						let oredrUnitPriceView = resp;
						let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="oredrUnitPriceDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
										<th class="upreqCd">단가요청코드</th>
										<th class="itemNm">품목명</th>
										<th class="uprcItQty">품목수량</th>
										<th class="upreqDate">단가요청일자</th>
										<th class="upreqValDate">유효기간</th>
										<th class="empNm">단가요청서 담당사원</th>
										<th class="upreqDur">거래기간</th>
										<th class="upreqStat">단가요청진행상태</th>
									</tr>
						        </thead>
						        <tbody>
						`;
						if (oredrUnitPriceView?.length > 0) {
						$.each(oredrUnitPriceView, function () {
							makeTable += makeUnitPriceTrTag(this);
								});
							} else {
								makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>등록된 품목이 없습니다.</td>
										</tr>
									`;
							}
	
						makeTable += `
							</tbody>
						</table>
						
						`
						;
						
						if (resp.length > 0 && resp[0].upreqStat === '완료') {
					    makeTable += `
							
	
							`;
						}else{
							makeTable += `
							<div>
								<button type="submit" id="orderUnitPriceModify" class="btn btn-secondary">수정</button>
							</div>
							
							`
							;
						}
						
						
						
						
						// 모달 내용 업데이트
						$('#orderUnitPriceModal .modal-body').html(makeTable);
	
						// 모달 열기
						$('#orderUnitPriceModal').modal('show');
					}
				});
			} catch (error) {
				console.error(error);
		
		}
		
		
	})
	
	// excelBtn 요소를 가져옵니다.
	const excelBtn = document.getElementById('excelBtn');
	
	// excelBtn을 클릭했을 때의 동작을 정의합니다.
	excelBtn.addEventListener('click', function() {
	    // upreqCd의 텍스트 값을 가져옵니다.
	    const upreqCd = document.getElementById('upreqCd').innerText;
	    

		
		location.href = `/orderUnitPrice/excelDown?what=${upreqCd}`;
		
		
	});
	
	$(document).on('submit', '#orderUnitPriceForm', function(e) {
		e.preventDefault();
		const findupreqCdInputs = document.querySelectorAll('.findUpreqCd');
		const findupreqCdInput = document.querySelector('.findUpreqCd');
		const findupreqCdValue = findupreqCdInput.value;
		
		var rowData = [];
		
		 findupreqCdInputs.forEach(function(input) {
	        let $row = $(input).closest('tr');
	        let uprcItQtyValue = $row.find('.findUprcItQty').val();
	        let upreqDurValue = $row.find('.findUpreqDur').val();
	        let uprecItCdValue = $row.find('.findUprecItCd').val();

			var dataObj = 	{
				'upreqCd' :  findupreqCdValue,
				'uprcItQty' : uprcItQtyValue,
				'upreqDur' : upreqDurValue,
				'uprcItCd': uprecItCdValue
			};
	        rowData.push(dataObj);
	    });

		$.ajax({
		    url: baseUrl+'/modUnitPrice',
		    method: 'PUT',
		    contentType: 'application/json',
		    data: JSON.stringify(rowData), //JSON 형식으로 데이터 전송
		    success: function(response) {
				console.log("안녕",response);
		        // 성공적으로 처리된 후의 작업
					//$('#orderPlanEnrollDataTable').DataTable().destroy();
					
					//alert('등록 ! ');
					Swal.fire({
					  icon: "success",
					  title: "수정완료 !",
					  showConfirmButton: false,
					  timer: 1500
					});
					
					retrieveOrderUnitPrice();
		    },
		    error: function(error) {
		        // 오류 처리
				console.log(error);
		    }
		});
		
		
	});
	
});