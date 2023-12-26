/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 11. 11.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 *   수정일        수정자          수정내용
 * --------     --------    ----------------------
 * 2023. 11. 11.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

$(function() {
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};
	
	let ConvertToNumber = function(str) {
	    let withoutCommas = str.replace(/,/g, ''); // 쉼표 모두 제거
	    return parseInt(stringWithoutCommas, 10); // 문자열을 정수로 변환
	};	
	/* 사원조회 dataTable 적용*/
	/*$('#empTable').DataTable({
				paging: true,
				searching: true,
				lengthChange: false,
				info: false,
				ordering: false
	});*/

	/* 아작스를 위한 데이터 설정 */
	let makeTrTag = function(rslt) {
		let trTag = `
        <tr>
            <td class="pplanDate"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.pplanDate}</a></td>
			<td class="itemNm">${rslt.purOrderRequeset.reqItem[0].item.itemNm}</td>
            <td class="reqItemQty">${rslt.purOrderRequeset.reqItem[0].reqItemQty}</td>
            <td class="empNm">${rslt.emp.empNm}</td>
            <td class="pplanStat"><a href="javascript:;">${rslt.pplanStat}</a></td>
            <input type="hidden" id="itemCd" value="${rslt.itemCd}"/>
            <input type="hidden" id="pplanCd" value="${rslt.pplanCd}"/>
            <input type="hidden" id="preqCd" value="${rslt.preqCd}"/>
        </tr>
	    `;
		return trTag;
	};

	let cPath = $('.pageConversion').data('contextPath');

	const baseUrl = `${cPath}/orderPlan`;

	/* 조회 함수 */
	function retrieveOrderPlan() {
		$.ajax({
			url: baseUrl + "/list2",
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function(resp) {
				console.log("체크체크체크체크!",resp)
				console.log("체크!",resp.dataList);
				let orderPlanList = resp.dataList;
				let trTags = "";
				if (orderPlanList?.length > 0) {
					$.each(orderPlanList, function() {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 창고가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
				/*$('#dataTable').DataTable({
					paging: true,
					searching: true,
					lengthChange: false,
					info: false,
					ordering: true,
					order: [[0, "desc"]]
				});*/
				
				//handleCheckboxes();
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveOrderPlan();
	
	function handleCheckboxes() {
		console.log("asd");
		$('.pplanDate').each(function() {
			var pplanStatText = $(this).closest('tr').find('.pplanStat').text().trim();
			console.log(pplanStatText);
	
	        if (pplanStatText === "완료") {
	            $(".pplanDate a").removeAttr("href");
	            $(".pplanDate a").css("pointer-events", "none");
	            // 추가적인 스타일링을 위해 필요한 경우에는 여기에 추가합니다.
	        }
 		});
			
	}
	
	
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
				let orderPlanList = resp.dataList;
				let trTags = "";
				if (orderPlanList?.length > 0) {
					$.each(orderPlanList, function() {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 창고가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
				//handleCheckboxes();
				/*formtag 넣어보자*/
				
				/*$('#dataTable').DataTable({
					paging: true,
					searching: true,
					lengthChange: false,
					info: false,
					ordering: true,
					order: [[0, "desc"]]
				});*/
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
		
		
		});
	
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log("namename",name);
			console.log("valuevalue",value);
			console.log($(searchForm));
			$(searchForm).find(`:input[name=${name}]`).val(value);
			
		});
		$('#searchForm').submit();
	});
	
	

	var orderPlanData; // 발주 데이터

	/* 아작스를 위한 데이터 설정 */
	let makeTrTags = function(rslt) {
		let trTag = `
				 <tr>
		            <td class="pplanDate">${rslt.pplanDate}</td>
		            <td class="pplanCd">${rslt.pplanCd}</td>
		            <td class="empNm">${rslt.empNm}</td>
		            <td class="itemCd">${rslt.itemCd}</td>
		            <td class="itemNm">${rslt.itemNm}</td>
		            <td class="itemQty">${rslt.reqItemQty}</td>
		            <td class="expired">${rslt.expired === 'N' ? '가능' : '불가'}</td>
					<input type="hidden" id="pplanCd" name="pplanCd" value="${rslt.pplanCd}"/>
		        </tr>
	    `;
		return trTag;
	};

	// 해당 품목 상세정보 및 수정 폼출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '.pplanDate a', function(e) {
		e.preventDefault();
		
		

		const trElement = e.target.closest('tr');

		const pplanCdValue = trElement.querySelector('#pplanCd').value;

		let orderPlanViewURL = `${cPath}/orderPlan/listView?what=${pplanCdValue}`;

		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: orderPlanViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					orderPlanData = null;

					orderPlanData = resp;
					console.log(orderPlanData);
					console.log("orderPlanData");
					

					let orderPlanView = resp;
					let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="orderPlanDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
									<th class="pplanDate">발주요청일자</th>
									<th class="pplanCd">발주요청코드</th>
									<th class="empNm">담당자</th>
									<th class="itemCd">품목코드</th>
									<th class="itemNm">품목명</th>
									<th class="itemQty">수량</th>
									<th class="yesNo">발주가능여부</th>
								</tr>
						        </thead>
						        <tbody>
						`;
					if (orderPlanView?.length > 0) {
						$.each(orderPlanView, function() {
							makeTable += makeTrTags(this);
						});
					} else {
						makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>등록된 창고가 없습니다.</td>
											<input type="hidden" id="pplanCd" name="pplanCd" value="${rslt.pplanCd}"/>
										</tr>
									`;
					}

					makeTable += `
							</tbody>
						</table>
						
						`
						;
						
					if (resp.length > 0 && resp[0].pplanStat === 'T002') {
					    makeTable += ``;
					}else{
						makeTable += `
							
						<div>
								<button type="submit" id="letsgo" class="btn btn-outline-primary">승인</button>
						</div>
						`
						;
					}

					// 모달 내용 업데이트
					$('#orderPlanListModal .modal-body').html(makeTable);
					

					// 모달 열기
					$('#orderPlanListModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}

	});
	
	
	

	/* 아작스를 위한 데이터 설정 발주 단가 선택 */
	let makeOrderTrTags = function(rslt) {
		let trTag = `
				 <tr>
		            <td class="pplanDate">${rslt.pplanDate}</td>
		            <td class="pplanCd">${rslt.pplanCd}</td>
		            <td class="empNm">${rslt.empNm}</td>
		            <td class="itemCd">${rslt.itemCd}</td>
		            <td class="itemNm">${rslt.itemNm}</td>
					<th class="comCd">${rslt.comCd}</th>
					<th class="comNm">${rslt.comNm}</th>
		            <td class="itemQty">${rslt.reqItemQty}</td>
					<th class="inUprc">${rslt.inUprc}</th>
					<th class="supplyPrice">${addCommas(rslt.inUprc*rslt.reqItemQty)}</th>
					<th class="vat">${addCommas(rslt.inUprc/10)}</th>
					<input type="hidden" id="pplanCd" name="pplanCd" value="${rslt.pplanCd}"/>
		        </tr>
	    `;
		return trTag;
	};
	/*버튼을 눌러서 전체 발주 단가 선택해서 보기*/
	// '전체' 버튼을 눌렀을 때
	document.querySelector('button[name="allButton"]').addEventListener('click', function() {
		var hiddenValues = document.querySelectorAll('input[name="pplanCd"]');
		const pplanCdValue = hiddenValues[0].value
		
		let orderPlanViewURL = `${cPath}/orderPlan/listView?what=${pplanCdValue}`;

		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: orderPlanViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					orderPlanData = null;

					orderPlanData = resp;
					console.log("resp",resp);

					let orderPlanView = resp;
					let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="orderPlanDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
									<th class="pplanDate">발주요청일자</th>
									<th class="pplanCd">발주요청코드</th>
									<th class="empNm">담당자</th>
									<th class="itemCd">품목코드</th>
									<th class="itemNm">품목명</th>
									<th class="itemQty">수량</th>
									<th class="yesNo">발주가능여부</th>
								</tr>
						        </thead>
						        <tbody>
						`;
					if (orderPlanView?.length > 0) {
						$.each(orderPlanView, function() {
							makeTable += makeTrTags(this);
						});
					} else {
						makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>품목이 없습니다.</td>
											<input type="hidden" id="pplanCd" name="pplanCd" value="${pplanCdValue}"/>
										</tr>
									`;
					}

					makeTable += `
							</tbody>
						</table>
						<div>
								<button type="submit" id="letsgo" class="btn btn-outline-primary">승인</button>
						</div>
						`
						;

					// 모달 내용 업데이트
					$('#orderPlanListModal .modal-body').html(makeTable);

					// 모달 열기
					$('#orderPlanListModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}
		
	});

	// '발주' 버튼을 눌렀을 때
	document.querySelector('button[name="orderPlanButton"]').addEventListener('click', function() {
		var hiddenValues = document.querySelectorAll('input[name="pplanCd"]');
		const pplanCdValue = hiddenValues[0].value
		
		let orderPlanViewURL = `${cPath}/orderPlan/listViewOrderPlan?what=${pplanCdValue}`;

		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: orderPlanViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					orderPlanData = null;

					orderPlanData = resp;
					console.log("resp",resp);

					let orderPlanView = resp;
					let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="orderPlanDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
									<th class="pplanDate">발주요청일자</th>
									<th class="pplanCd">발주요청코드</th>
									<th class="empNm">담당자</th>
									<th class="itemCd">품목코드</th>
									<th class="itemNm">품목명</th>
									<th class="comCd">거래처코드</th>
									<th class="comNm">거래처명</th>
									<th class="itemQty">수량</th>
									<th class="inUprc">단가</th>
									<th class="supplyPrice">공급가액</th>
									<th class="vat">부가세</th>
								</tr>
						        </thead>
						        <tbody>
						`;
					if (orderPlanView?.length > 0) {
						$.each(orderPlanView, function() {
							makeTable += makeOrderTrTags(this);
						});
					} else {
						makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>발주할 품목이 없습니다.</td>
											<input type="hidden" id="pplanCd" name="pplanCd" value="${pplanCdValue}"/>
										</tr>
									`;
					}

					makeTable += `
							</tbody>
						</table>
						
						`
						;

					// 모달 내용 업데이트
					$('#orderPlanListModal .modal-body').html(makeTable);

					// 모달 열기
					$('#orderPlanListModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}
	});
	
	
	
	/* 아작스를 위한 데이터 설정 */
	let makeUnitTrTags = function(rslt) {
		let trTag = `
				 <tr>
		            <td class="pplanDate">${rslt.pplanDate}</td>
		            <td class="pplanCd">${rslt.pplanCd}</td>
		            <td class="empNm">${rslt.empNm}</td>
		            <td class="itemCd">${rslt.itemCd}</td>
		            <td class="itemNm">${rslt.itemNm}</td>
		            <td class="itemQty">${rslt.reqItemQty}</td>
					<input type="hidden" id="pplanCd" name="pplanCd" value="${rslt.pplanCd}"/>
		        </tr>
	    `;
		return trTag;
	};

	// '단가요청' 버튼을 눌렀을 때
	document.querySelector('button[name="unitPriceButton"]').addEventListener('click', function() {
		var hiddenValues = document.querySelectorAll('input[name="pplanCd"]');
		const pplanCdValue = hiddenValues[0].value
		let orderPlanViewURL = `${cPath}/orderPlan/listViewUnitPrice?what=${pplanCdValue}`;

		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: orderPlanViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					orderPlanData = null;

					orderPlanData = resp;
					console.log("resp",resp);

					let orderPlanView = resp;
					let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="orderPlanDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
									<th class="pplanDate">발주요청일자</th>
									<th class="pplanCd">발주요청코드</th>
									<th class="empNm">담당자</th>
									<th class="itemCd">품목코드</th>
									<th class="itemNm">품목명</th>
									<th class="itemQty">수량</th>
								</tr>
						        </thead>
						        <tbody>
						`;
					if (orderPlanView?.length > 0) {
						$.each(orderPlanView, function() {
							makeTable += makeUnitTrTags(this);
						});
					} else {
						makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>단가요청할 품목이 없습니다.</td>
											<input type="hidden" id="pplanCd" name="pplanCd" value="${pplanCdValue}"/>
										</tr>
									`;
					}

					makeTable += `
							</tbody>
						</table>
						
						`
						;

					// 모달 내용 업데이트
					$('#orderPlanListModal .modal-body').html(makeTable);

					// 모달 열기
					$('#orderPlanListModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}
	});

	$(document).on('submit', '#orderPlanListForm', function(e) {
		e.preventDefault();

		let url = this.action;
		// 'expired'가 'Y'인 데이터 필터링
		var expiredItems = orderPlanData.filter(function(item) {
			return item.expired === 'Y';
		});

		// 'expired'가 'N'인 데이터 필터링
		var nonExpiredItems = orderPlanData.filter(function(item) {
			return item.expired === 'N';
		});
		

		function sendDataToServer(dataToSend, urls) {
			console.log(urls)
			$.ajax({
				url: url + urls,
				type: 'POST',
				data: JSON.stringify(dataToSend),
				contentType: 'application/json',
				success: function(response) {
					// 성공 시 처리하는 부분
					console.log('데이터 전송 성공:', response);
					
					Swal.fire({
					  icon: "success",
					  title: "등록완료 !",
					  showConfirmButton: false,
					  timer: 1500
					});
					
					retrieveOrderPlan();
					
					
				},
				error: function(error) {
			        console.error('Ajax 요청 실패:', error);
			    }
			});
		}

		// 만료된 상품을 서버로 보냅니다.
		if (expiredItems.length > 0) {
			sendDataToServer(expiredItems, "/unitPrice");
		}
		// 만료되지 않은 상품을 서버로 보냅니다.
		if (nonExpiredItems.length > 0) {
			// comCd 값을 기준으로 항목을 저장할 객체 생성
			let itemsByComCd = {};
			
			nonExpiredItems.forEach(function(item) {
			    let comCdValue = item.comCd;
			
			    // 객체에 comCd 값이 이미 있는지 확인
			    if (!itemsByComCd.hasOwnProperty(comCdValue)) {
			        // 없으면 해당 comCd 값에 대한 배열 생성
			        itemsByComCd[comCdValue] = [];
			    }
			
			    // 해당 comCd 값에 대한 배열에 항목 추가
			    itemsByComCd[comCdValue].push(item);
			});
			
			// 이제 itemsByComCd 객체에 comCd 값별로 항목이 그룹화되어 있습니다
			console.log("체크");
			console.log(itemsByComCd);
			
			// nonExpiredItems를 comCd 값으로 그룹화한 itemsByComCd 객체 생성하는 과정

			// 이후, 각 comCd 그룹에 대해 sendDataToServer() 호출
			for (let comCdValue in itemsByComCd) {
			    if (itemsByComCd.hasOwnProperty(comCdValue)) {
			        let itemsForComCd = itemsByComCd[comCdValue];
			
			        // 각 comCd 그룹에 속하는 항목들을 서버로 전송
			        if (itemsForComCd.length > 0) {
				console.log("itemsForComCd",itemsForComCd)
			            sendDataToServer(itemsForComCd, `/order`);
			            // 혹은 다른 URL 형태로 전송하려는 경우 '/order' 다음에 comCdValue를 추가하여 보낼 수 있습니다.
			        }
			    }
			}
			
			//sendDataToServer(nonExpiredItems, "/order");
		}
	})

})