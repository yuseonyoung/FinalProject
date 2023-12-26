/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.     김도현      최초작성
 * 2023. 11. 21.     김도현	   조회, 상세조회, 등록, 수정 작성
 * 2023. 11. 22.	 김도현	   출하단가, 출하수량 정규식 이용하여 콤마 추가 
 *
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


// 전역변수 선언


// 전역함수 선언
let cPath = $('.pageConversion').data('contextPath');
let currentPageNumber = 1; //현재 페이지 번호를 저장할 변수
	
const  makeTrTag = function(rslt){
	
	 const addCommas = function(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };
	
	let relsViewURL = ` ${cPath}/rels/view?what=${rslt.rdrecCd}`;
	let itemNm = '';

    if (rslt.relsItem.length > 0) {
        itemNm = rslt.relsItem[0].item ? rslt.relsItem[0].item.itemNm : '';
        
        if (rslt.relsItem.length > 1) {
            // 추가 품목이 있는 경우 수를 표시
            itemNm += ` 외 ${rslt.relsItem.length - 1}건`;
        }
    }
	
	// 수량과 단가를 곱하여 총액 계산
    let totalAmount = rslt.relsItem.length > 0
        ? rslt.relsItem[0].rdrecQty * rslt.relsItem[0].rdrecUprc
        : 0;

    // 총액을 콤마로 포맷팅
    let formattedTotalAmount = addCommas(totalAmount);
	
	let trTag = `
		<tr>
			<td class="rdrecCd"><a href="${relsViewURL}">${rslt.rdrecCd}</td>
			<td class="rdrecDate">${rslt.rdrecDate}</td>
			<td class="rdrecOutDate">${rslt.rdrecOutDate}</td>
			<td class="comNm">${rslt.comNm}</td>
			<td class="empNm">${rslt.empNm}</td>
			<td class="itemNm">${itemNm}</td>
			<td class="rdrecQty">${rslt.relsItem.length > 0 ? addCommas(rslt.relsItem[0].rdrecQty) : ''}</td>
			<td class="rdrecUprc">${rslt.relsItem.length > 0 ? addCommas(rslt.relsItem[0].rdrecUprc) : ''}</td>
			<td class="rdrecAmount">${formattedTotalAmount}</td>
			<td class="rdrecStat"><a href="javascript:;">${rslt.rdrecStat}</a></td>
		</tr>	
	`;
	return trTag;
};

let toggleSelect;
//견적서 리스트 출력
const makeList = function(){
	
	const baseUrl = `${cPath}/rels/listView`;

	$.ajax({
		url: baseUrl,
		method: "GET",
		contentType: 'application/json',
		dataType: "json",
		success: function (resp) {
			console.log("체킁:",resp);

			let relsList = resp.relsList;
			let trTags = "";
	
			if (relsList?.length > 0) {
				$.each(relsList, function () {
					trTags += makeTrTag(this);
				});
			} else {
				trTags += `
						<tr>
							<td class="text-norels" colspan='7'>등록된 출하지시서가 없습니다.</td>
						</tr>
					`;
			}

			$('.list').html(trTags);
			
			
			
			
			if ($.fn.DataTable.isDataTable('#relsListDataTable')) {
					// 테이블이 이미 초기화된 경우, 초기화하지 않음
					
					console.log('DataTable already initialized');
				} else {
					// 테이블이 초기화되지 않은 경우, 초기화 진행
					$('#relsListDataTable').DataTable({
						paging: true,
						searching: true,
						lengthChange: false,
						info: false,
						ordering:false,
						order:true,
						destroy: true,
						drawCallback: function(settings) {
							currentPageNumber = settings._iDisplayStart / settings._iDisplayLength + 1;
						}
					});
				}
				
		},
		error: function (xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});
}


	$(document).ready(function(){
		
	});

// DOM에서 견적품목 리스트를 업데이트하는 함수
	function updateRelsListInDOM(rdrecCd, updatedData) {
		// 해당하는 견적서코드를 포함하는 행을 찾기
		let $row = $(`.rdrecCd:contains(${rdrecCd})`).closest('tr');

		// 행을 찾지 못했을 경우에 대한 유효성 검사
		if ($row.length === 0) {
			console.error(`Row with quote code ${rdrecCd} not found.`);
			return;
		}

		// 행 내용 업데이트
		$row.find('.rdrecCd a').attr('href', `${cPath}/rels/view?what=${updatedData.rdrecCd}`).text(updatedData.rdrecCd);

		console.log("업데이트 되랑", updatedData);
		
		// 업데이트된 값 행에 찍어주기
		$row.find('.rdrecDate').text(updatedData.rdrecDate);
		$row.find('.rdrecQty').text(updatedData.rdrecQty);
		$row.find('.rdrecUprc').text(updatedData.rdrecUprc);
		$row.find('.empNm').text(updatedData.empNm);
		$row.find('.comNm').text(updatedData.comNm);
		$row.find('.rdrecOutDate').text(updatedData.rdrecOutDate);
		$row.find('.itemNm').text(updatedData.quoteItem[0].item.itemNm);
	}



$(function(){
	
	makeList();

	let toggleSelect;
	
	// 해당 견적 상세정보 및 수정 폼 출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '.rdrecCd a', function(e) {
		e.preventDefault();
		
		// 현재 페이지 번호 저장
		//let relsListDataTable = $('#relsListDataTable').DataTable();
		//currentPageNumber = relsListDataTable.page() + 1;
		
		let rdrecCd = $(this).text(); // 클릭한 링크의 텍스트 값 (qteCd)
		let relsViewURL = `${cPath}/rels/view?what=${rdrecCd}`;
			toggleSelect = 'update';
		
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: relsViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					console.log("체킁:",resp);
					let relsView = resp.relsView;
					
					let makeTable = "";

						makeTable +=
						 `
							<table class="table table-bordered fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>일자</th>
								<td colspan="5">
									<input type="date" id="rdrecDate" name="rdrecDate" placeholder="일자" style="width: 170px;" value="${relsView.rdrecDate}"/>
									<span id="relsDateError" class="error"></span>
								</td>
							</tr>
							
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" name="empNm" placeholder="담당자" style="width: 170px;" value="${relsView.empNm}" />
									<span id="findEmpNmError" class="error"></span>
									 <input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd" value="${relsView.empCd}"/>
								</td>
							</tr>
							
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" name="comNm" placeholder="거래처명" style="width: 170px;" value="${relsView.comNm}" />
									<span id="findComNmError" class="error"></span>
									 <input type="hidden" id="findComCd" class="findComCd"  name="comCd" value="${relsView.comCd}"/>
								</td>
							</tr>
							<tr>
								<th>납기일자</th>
								<td colspan="5">
									<input type="date" id="rdrecOutDate" name="rdrecOutDate" placeholder="납기일자" style="width: 170px;" value="${relsView.rdrecOutDate}" />
									<span id="findComNmError" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>수량</th>
								<th>단가</th>
								
							</tr>
						</thead>
								<input type="hidden" value="${relsView.rdrecCd}" name="rdrecCd"/>
						<tbody>
							`;
						relsView.relsItem.forEach(function (item, index) {
        				makeTable +=
						  `  
							<tr>
								<td>
									<input type="text" id="findItemCd" name="relsItem[`+index+`].itemCd" class="iText" value="${item.itemCd}"/>
									<span id="relsItem.itemCd" class="error"></span> 
								</td>
								<td>
									<input type="text" id="findItemNm" name="relsItem[`+index+`].item.itemNm" class="iText" value="${item.item.itemNm}"/>
									<span id="relsItem.item.itemNm" class="error"></span> 
								</td>
								<td>
									<input type="number" id="qty" name="relsItem[`+index+`].rdrecQty" class="iText" style="width: 120px" value="${item.rdrecQty}"/>
									<span id="relsItem.rdrecQty" class="error"></span>
								</td>
								<td>
									<input type="number" id="uprc" name="relsItem[`+index+`].rdrecUprc" class="iText" style="width: 120px" value="${item.rdrecUprc}"/>
									<span id="relsItem.rdrecUprc" class="error"></span>
								</td>
							</tr>
							 `;
   					 });

   					 makeTable +=
      						  `
						</tbody>
					</table>
					`;


					// 모달 내용 업데이트
					$('#relsModal .modal-body').html(makeTable);

					// 모달 열기
					$('#relsModal').modal('show');

					$("#relsForm").attr("method","post");
				}

			});

	});
	
	
	
	
	
	
	
	
	
	//사원리스트 출력함수
	let makeEmpTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="empCd">${rslt.empCd}</td>
					        <td class="empNm"><a href="#empNm">${rslt.empNm}</a></td>
					     	<td class="deptNm">${rslt.dept.deptNm}</td>
					     	<td class="empTelNo">${rslt.empTelNo}</td>
						</tr>	
		`;
		return trTag;
	}
	
	//담당자 검색 모달
	$(document).on('click', '#findEmpNm', function(e) {
		e.preventDefault();

			// 모달 열기
			$('#findEmpModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/empList/list`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					let empList = resp.empList;
					let trTags = "";

					if (empList?.length > 0) {
						$.each(empList, function() {
							trTags += makeEmpTrTag(this);
						});
							//선택된 담당자명 담당자에 입력해주기
						$(document).on('click', '.empNm', function(e) {
							e.preventDefault();

							var empCd = $(this).closest('tr').find('.empCd').text();
							var empNm = $(this).closest('tr').find('.empNm').text();

							$('#findEmpCd').val(empCd);
							$('#findEmpNm').val(empNm);

							$('#findEmpModal').modal('hide');
						});
						
					} else {
						trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='4'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
					}

					// 모달 내용 업데이트
					$('#findEmpModal .list').html(trTags);
					
					$('#findEmpDataTable').DataTable({
						paging: true,
						searching: true,
						lengthChange: false,
						info: false,
						destroy: true
					});
				}
			});
		} catch (error) {
			console.error(error);
		}
	});
	
	
		//거래처리스트 출력함수
	let makeComTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="comCd">${rslt.comCd}</td>
					        <td class="comNm"><a href="#comNm">${rslt.comNm}</a></td>
						</tr>	
		`;
		return trTag;
	}
	
	//거래처 검색 모달
	$(document).on('click', '#findComNm', function(e) {
		e.preventDefault();

			// 모달 열기
			$('#findComModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/company/list`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					let comList = resp.companyList;
					let trTags = "";
	
					if (comList?.length > 0) {
						$.each(comList, function() {
						
							trTags += makeComTrTag(this);
						});
							//선택된 거래처명 거래처에 입력해주기
						$(document).on('click', '.comNm', function(e) {
							e.preventDefault();

							var comCd = $(this).closest('tr').find('.comCd').text();
							var comNm = $(this).closest('tr').find('.comNm').text();

							$('#findComCd').val(comCd);
							$('#findComNm').val(comNm);

							$('#findComModal').modal('hide');
						});
						
					} else {
						trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='4'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
					}

					// 모달 내용 업데이트
					$('#findComModal .list').html(trTags);
					
					$('#findComDataTable').DataTable({
						paging: true,
						searching: true,
						lengthChange: false,
						info: false,
						destroy: true
					});
				}
			});
		} catch (error) {
			console.error(error);
		}
	});
	
	
	// 판매 품목 모달창
	// 페이지 로드 후 실행되는 부분
	$(document).ready(function () {
    // 판매 버튼 클릭 시 모달 열기
    $('#SaleBtn').on('click', function () {
		// 모달 열기
        $('#findSaleModal').modal('show');
	try {
            // 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
	$.ajax({
            url: `${cPath}/sale/listView`, // API 엔드포인트 주소를 지정해야 합니다.
            method: 'GET',
            dataType: 'json',
            success: function (resp) {
					let saleList = resp.saleList;
                    let trTags = "";
	 if (saleList?.length > 0) {
                        $.each(saleList, function () {
                            trTags += makeSaleTrTag(this);
                        });
                    } else {
                        trTags += `
                            <tr>
                                <td class="text-nowrap" colspan='5'>등록된 판매가 없습니다.</td>
                            </tr>
                        `;
                    }

                    // 모달 내용 업데이트
                    $('#findSaleDataTable .list').html(trTags);

                    $('#findSaleDataTable').DataTable({
                        paging: true,
                        searching: true,
                        lengthChange: false,
                        info: false,
                        destroy: true,
						order: [[0, "desc"]]
                    });

						// 판매 행 클릭 시 이벤트 처리
                    $('#findSaleDataTable tbody').on('click', 'tr', function () {
                        let saleCd = $(this).find('.saleCd').text();
						let saleDate = $(this).find('.saleDate').text();
						let empCd = $(this).find('.empCd').text();
						let empNm = $(this).find('.empNm').text();
						let comCd = $(this).find('.comCd').text();
						let comNm = $(this).find('.comNm').text();
                        let itemCd = $(this).find('.itemCd').text();
                        let itemNm = $(this).find('.itemNm').text();
                        let saleQty = $(this).find('.saleQty').text();
                        let saleUprc = $(this).find('.saleUprc').text();
						
                        
						$('#rdrecDate').val(saleDate);
						$('#findEmpCd').val(empCd);
						$('#findEmpNm').val(empNm);
						$('#findComCd').val(comCd);
						$('#findComNm').val(comNm);
                        $('#findItemCd').val(itemCd);
                        $('#findItemNm').val(itemNm);
                        $('#qty').val(saleQty);
                        $('#uprc').val(saleUprc);
						
                        //JSON오브젝트
						let data = {
							"saleCd":saleCd
						};
						
						console.log("data : ", data);

						$.ajax({
							url:"/rels/getSaleItemList",
							contentType:"application/json;charset=utf-8",
							data:JSON.stringify(data),
							type:"post",
							dataType:"json",
							success:function(result){
								let str = "";
								//result : List<SaleItemVO>
								$.each(result,function(idx,saleItemVO){
									str += "<tr class='new-row-template'><td><input type='text' id='findItemCd' name='relsItem["+idx+"].itemCd' value='"+saleItemVO.itemCd+"' class='iText'>";
									str += "<span id='relsItem.itemCd' class='error'></span></td><td>";
									str += "<input type='text' id='findItemNm' name='relsItem["+idx+"].item.itemNm' value='"+saleItemVO.itemNm+"' class='iText'>";
									str += "<span id='relsItem.item.itemNm' class='error'></span></td><td>";
									str += "<input type='number' id='qty' name='relsItem["+idx+"].rdrecQty' value='"+saleItemVO.saleQty+"' class='iText' style='width: 120px'>";
									str += "<span id='relsItem.relsQty' class='error'></span></td><td>";
									str += "<input type='number' id='uprc' name='relsItem["+idx+"].rdrecUprc' value='"+saleItemVO.saleUprc+"' class='iText' style='width: 120px'>";
									str += "<span id='relsItem.relsUprc' class='error'></span></td><td>";
									str += "<button class='btn btn-outline-danger rounded-capsule mb-1' type='button' onclick='deleteRow(this)'>삭제</button></td></tr>";
								});
								
								$("#dataTable tbody").children("tr").last().remove();
								$("#dataTable tbody").append(str);
							}
						});
						
                        // 모달 닫기
                        // 여기서 모달을 닫도록 수정
                        $('#findSaleModal').modal('hide');
					});
                }
            });
        } catch (error) {
            console.error(error);
        }
    });

    // 판매 테이블 행 생성 함수
    let makeSaleTrTag = function (sale) {
        let trTag = `
            <tr>
                <td class="saleCd"><a href="#" class="sale-link" data-salecd="${sale.saleCd}">${sale.saleCd}</td>
				<td class="saleDate">${sale.saleDate}</td>
				<td class="empCd">${sale.empCd}</td>
				<td class="empNm">${sale.employee.empNm}</td>
				<td class="comCd">${sale.comCd}</td>
				<td class="comNm">${sale.company.comNm}</td>
                <td class="itemCd">${sale.saleItem[0].itemCd}</td>
                <td class="itemNm">${sale.saleItem[0].item.itemNm}</td>
                <td class="saleQty">${sale.saleItem[0].saleQty}</td>
                <td class="saleUprc">${sale.saleItem[0].saleUprc}</td>
            </tr>	
        `;
        return trTag;
    };

    // 모달이 닫힐 때 이벤트 처리
    $('#findSaleModal').on('hidden.bs.modal', function () {
        // TODO: 모달이 닫힐 때 수행해야 할 작업이 있다면 추가
    });
});
	
	
	
	
	
	// 품목 검색 모달 테이블 생성
	let makeItemTrTag = function (item) {
	    let trTag = `
				<tr>
					<td>${item.itemCd}</td>
					<td><a href="javascript:;" class="selectItem"
						data-selected-value="${item.itemNm}" data-selected-cd="${item.itemCd}"> ${item.itemNm} </a>
					</td>
					<td>${item.itemSafeQty}</td>
				</tr>
		    `;
		
		return trTag;
	};
	
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let datas = $(this).serialize();
		console.log("datas:@@@@@@@@@@@@@@@@@@@@",datas);
		$.ajax({
			url: `${cPath}/item`,
			method: "GET",
			data : datas,
			success: function (resp) {
				let itemList = resp.paging.dataList;
				console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@:",itemList);
				
				let trTags = "";
		
				if (itemList?.length > 0) {
					$.each(itemList, function () {
						trTags += makeItemTrTag(this);
						console.log(this);
						$(pagingArea).html(resp.paging.pagingHTML);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='2'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('.itemList').html(trTags);
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}).submit();

	// 폼목코드 모달 열기
	$(document).on('click', '#findItemCd', function(e) {
			e.preventDefault();
			// 모달 열기
			$('#findItemModal2').modal('show');
	});
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log(name);
			console.log(value);
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});
	
	// 품목 모달 클릭 시 인풋에 값 추가 이벤트
		$(document).off('click', '#findItemNm, #findItemCd'); // 이벤트 등록 전에 이전 이벤트를 해제
		$(document).on('click', '#findItemNm, #findItemCd', function () {
			
			
			// 현재 클릭된 행에 대한 데이터 가져오기
	        let currentRow = $(this).closest('tr');
			let inputItemCd = currentRow.find('#findItemCd');
	        let inputItemNm= currentRow.find('#findItemNm');

			$(document).off('click', '.selectItem');
			$(document).on('click', '.selectItem', function () {
	            // 선택한 item의 정보 가져오기
				let selectedItemCd = $(this).data('selected-cd');
	            let selectedItemNm = $(this).data('selected-value');
	
	            // 현재 클릭된 행의 input에 값을 추가
				inputItemCd.val(selectedItemCd);
	            inputItemNm.val(selectedItemNm);
				console.log("품목코드",selectedItemCd);
				console.log("품목코드",selectedItemNm);
	            // itemWindow 모달 닫기
	            $('#findItemModal2').modal('hide');
	            
			});
	
});
	
	function afterDataUpdate() {
		// 수정 후에 현재 페이지로 이동
		let relsListDataTable = $('#relsListDataTable').DataTable();
		relsListDataTable.page(currentPageNumber - 1).draw(false);
		// 페이지 번호를 변경하고 다시 그리기(draw)를 실행하여 해당 페이지로 이동
	}
	
	function reloadDataTable() {
    let relsListDataTable = $('#relsListDataTable').DataTable();
    relsListDataTable.ajax.reload(null, false);
	}
	
	//insertForm  /  updateForm
	$(document).on('submit', '#relsForm', function(e) {
		/*
		e.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;

		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		*/
		if (formMode == 'update') {
			/*
			$.ajax({
				url : url,
				type : "PUT",
				data : json,
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},
				success: function(res){
					console.log("체킁:",res);
					console.log("성공");
					alert("출하지시서 수정 완료!!");
					//makeList();
					$('#relsModal').modal('hide');
					updateRelsListInDOM(data.rdrecCd, data);
					afterDataUpdate()
					
					let result = res.errors;
					if(result){
						if(result.rslt == "success"){
							
						} else if(result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage){
								let errorId = fieldName;
								$('#' + errorId).text(errorMessage);
							});
						}
					}
				},
				error: function(error){
					console.error('Ajax 요청 실패:', error);
				}
			});
			*/
	} else {
		$("#relsForm").submit();
		/*
			$.ajax({
				url: url,
				type: "POST",
				data: json,
				contentType: 'application/json',
				success: function(res) {
						alert("출하지시서 등록 완료!!");
						console.log("출하지시서 등록 완료!!")
							$('#relsDate').val('');
							$('#findEmpNm').val('');
							$('#findItemCd').val('');
							$('#findItemNm').val('');
							$('#findComNm').val('');
							$('#qty').val('');
							$('#uprc').val('');
							
							makeList();
					let result = res.errors;
					if (result) {
						if (result.rslt == "success") {
						
						} else if (result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage) {
								let errorId = fieldName;
								$('#' + errorId).text(errorMessage);
							});
						}
					}
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
			*/
		}
	});
	
	
});
