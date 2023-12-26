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
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	
	/* 아작스를 위한 데이터 설정 */
	let makeTrTag = function(rslt) {
		let trTag = `
        <tr>
            <td id="pordCd"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.pordCd}</a></td>
			<td id="itemNm">${rslt.purOrdItem[0].item.itemNm}${rslt.nqty > 0 ? ` 외 ${rslt.nqty}건` : ''}</td>
            <td id="pordDate">${rslt.pordDate}</td>
            <td id="dueDate">${rslt.dueDate}</td>
            <td id="pordStat"><a href="javascript:;">${rslt.pordStat}</a></td>
        </tr>
	    `;
		return trTag;
	};
	
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

	let cPath = $('.pageConversion').data('contextPath');

	const baseUrl = `${cPath}/orderPlay`;

	/* 조회 함수 */
	function retrieveOrderPlay() {
		$.ajax({
			url: baseUrl + "/list2",
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function(resp) {
				console.log(resp);
				console.log("체크!",resp.dataList);
				let orderPlayList = resp.dataList;
				let trTags = "";
				if (orderPlayList?.length > 0) {
					$.each(orderPlayList, function() {
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
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveOrderPlay();
	
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
				let orderPlayList = resp.dataList;
				let trTags = "";
				if (orderPlayList?.length > 0) {
					$.each(orderPlayList, function() {
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
	
	/* 아작스를 위한 데이터 설정 */
	let makeOrderPlayTrTag = function(rslt) {
		let trTag = `
        
		<tr class="new-row" data-row="0">
          <td>${rslt.itemCd}</td>
          <td>${rslt.itemNm}</td>
			<td id="pordQty">${addCommas(rslt.pordQty)}</td>
          <td>${rslt.itemUnit}</td>
          <td>${addCommas(rslt.inUprc)}</td>
			<td>${addCommas(rslt.inUprc*rslt.pordQty)}</td>
			<td>${addCommas(rslt.inUprc/10)}</td>
			<td id="pordStat">${rslt.pordStat}</td>
        </tr>

	    `;
		return trTag;
	};
	// 해당 단가요청서 상세정보 및 수정 폼출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '#pordCd a', function(e) {
		e.preventDefault();
		let pordCd =$(this).text();
		let oredrPlayViewURL = `${cPath}/orderPlay/view?what=${pordCd}`
		
		try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: oredrPlayViewURL,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						let oredrPlayView = resp;
						makeTable = `
							<table class="table table-bordered table-striped fs--1 mb-0" id="dataTable">
					<thead class="bg-200 text-900">
						<tr>
							<th>발주일자</th>
							<td colspan="7">
								<input type="date" id="pordDate" name="pordDate" class="pordDate" value="${oredrPlayView[0].pordDate}"  style="width: 170px;" />
								<span id="defPordDate" class="error"></span>
							</td>
						</tr>
						<tr>
							<th>납기일자</th>
							<td colspan="7">
								<input type="date" id="dueDate" name="dueDate" class="dueDate" value="${oredrPlayView[0].dueDate}"  style="width: 170px;" />
								<span id="defDueDate" class="error"></span>
							</td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td colspan="7">
								<input type="text" id="findComNm" class="findComNm"  name="comNm" value="${oredrPlayView[0].comNm}" autocomplete="off" style="width: 170px;" />
								<span id="comNm" class="error"></span>
								<input type="hidden" id="findComCd" class="findComCd" value="${oredrPlayView[0].comCd}" name="comCd"  />
							</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td colspan="7">
								<input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" value="${oredrPlayView[0].empNm}" style="width: 170px;" />
								<span id="empNm" class="error"></span>
								<input type="hidden" id="findEmpCd" class="empCd" value="${oredrPlayView[0].empCd}" name="empCd"  />
							</td>
						</tr>
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
							<th>수량</th>
							<th>단위</th>
							<th>단가</th>
							<th>공급가액</th>
							<th>부가세</th>
							<th>상태</th>
						</tr>
					</thead>

					<tbody class="itemList">
						
					
						`;
						if (oredrPlayView?.length > 0) {
						$.each(oredrPlayView, function () {
							makeTable += makeOrderPlayTrTag(this);
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
							`;
	
						// 모달 내용 업데이트
						$('#orderPlayListModal .modal-body').html(makeTable);
	
						// 모달 열기
						$('#orderPlayListModal').modal('show');
					}
				});
			} catch (error) {
				console.error(error);
		
		}
		
	})
	
	
	
	// excelBtn 요소를 가져옵니다.
	const modiBtn = document.getElementById('modiBtn');
	
	// excelBtn을 클릭했을 때의 동작을 정의합니다.
	modiBtn.addEventListener('click', function() {
	    // upreqCd의 텍스트 값을 가져옵니다.
	    //const upreqCd = document.getElementById('upreqCd').innerText;
	    
	    // 가져온 값을 콘솔에 출력하거나 원하는 다른 작업을 수행할 수 있습니다.
	    console.log("ㅎㅎ");
	    //console.log(upreqCd);
	    // 이후 여기에 가져온 값을 사용하는 코드를 추가할 수 있습니다.
		
		//location.href = `/orderUnitPrice/excelDown?what=${upreqCd}`;
		
		
	});
	
	// excelBtn 요소를 가져옵니다.
	const rejectBtn = document.getElementById('rejectBtn');
	
	// excelBtn을 클릭했을 때의 동작을 정의합니다.
	rejectBtn.addEventListener('click', function() {
	    // upreqCd의 텍스트 값을 가져옵니다.
	    //const upreqCd = document.getElementById('upreqCd').innerText;
	    
	    // 가져온 값을 콘솔에 출력하거나 원하는 다른 작업을 수행할 수 있습니다.
	    console.log("ㅋㅋ");
	    //console.log(upreqCd);
	    // 이후 여기에 가져온 값을 사용하는 코드를 추가할 수 있습니다.
		
		//location.href = `/orderUnitPrice/excelDown?what=${upreqCd}`;
		
		
	});
	
	
	
});
