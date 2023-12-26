/**
 * 
 * @author 유선영
 * @since 2023. 11. 27.
 * @version 1.0
 * 
 *         
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.    유선영      최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          
 */

function fn_paging(page){
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
$(function(){
	
	showDates();
	addInputEvent();
	
	let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	let purOrderModal = new bootstrap.Modal($('#purOrderModal')[0]);
	let cPath = $('.pageConversion').data('contextPath');
	let baseUrl = `${cPath}/pur`;

	// 수정할 때 필요한 원래의 itemCd값 담을 map 변수
	let originItemCdMap = new Map();
	
	// 발주요청 조회 테이블 생성
	let makePurOrderTrTag = function (rslt) {
		let additionalItems = rslt.itemCount > 1 ? `외 ${rslt.itemCount - 1}건` :''; 
	    let trTag = `
	      		<tr>
		            <td id="preqDate"><a href="javascript:;" class="preqLink">${rslt.PREQ_DATE}</a></td>
		            <td id="preqDueDate">${rslt.PREQ_DUE_DATE}</td>
		            <td id="itemNm">${rslt.ITEM_NM}${additionalItems}</td>
		            <td id="reqItemQty">${rslt.itemQty}</td>
		            <td id="preqStat">${rslt.PREQ_STAT}</td>
		            <td id="reqNote">${rslt.REQ_NOTE || ''}</td>
		            <input type="hidden" class="preqCd" id="preqCd" value="${rslt.PREQ_CD}"/>
		            <input type="hidden" id="itemCd" value="${rslt.ITEM_CD}"/>
					<input type="hidden" id="empNm" value="${rslt.EMP_NM}"/>
					<input type="hidden" id="empCd" value="${rslt.EMP_CD}"/>
		        </tr>
		    `;
		
		    return trTag;
	};
	
	// 담당자 검색 모달 테이블 생성
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
	
	// 품목 검색 모달 테이블 생성
	let makeItemTrTag = function (item) {
	    let trTag = `
				<tr>
					<td>${item.itemCd}</td>
					<td><a href="javascript:;" class="selectItem"
						data-selected-value="${item.itemNm}" data-selected-cd="${item.itemCd}"> ${item.itemNm} </a>
					</td>
				</tr>
		    `;
		
		return trTag;
	};
	
	// 품목 모달 
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let datas = $(this).serialize();
		$.ajax({
			url: `${cPath}/sector/list`,
			method: "GET",
			data : datas,
			success: function (resp) {
				console.log(resp);
				let itemList = resp.paging.dataList;
				let trTags = "";
		
				if (itemList?.length > 0) {
					$.each(itemList, function () {
						trTags += makeItemTrTag(this);
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
				$('#dataList').html(trTags);
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}).submit();
	
	// 품목 모달에서 검색
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});
	$(document).on('change', '#findPreqDate', function() {
	    $("#dateNullError").empty();
	});
	
	$(document).on('change', '#findPreqDueDate', function() {
	    $("#preqDueDateError").empty();
	});
	// 수정 버튼 이벤트
	$("#updateBtn").on("click", function() {
		let formData = {};
		let reqList = [];
		let reqForm = {};
		
		$("[id$='Error']").empty();
		
		formData['preqCd'] = $('#findPreqCd').val();
	    formData['preqDate'] = $('#findPreqDate').val();
		formData['preqDueDate'] = $('#findPreqDueDate').val();
		formData['preqStat'] = $('#findPreqStat').val();
		formData['empCd'] = $('#findEmpCd').val();
		
	    // 각 행의 데이터를 객체로 구성하여 배열에 추가
	    $(".purOrderRow").each(function() {
			reqForm = {};
			
			// id를 찾아와서 originItemCdMap에 있는 key로 사용
			let itemCdId = $(this).find('.findItemCd').attr('id');
			
			itemCdVal = $(this).find('.findItemCd').val();
			itemNmVal = $(this).find('#findItemNm').val();
			reqItemQty = $(this).find('#findReqItemQty').val();
			 
			if(itemCdVal != '' || itemNmVal != '' || reqItemQty !=''){
				// 새로 생긴 행이면
				if(!originItemCdMap.get(itemCdId)){
					reqForm = {
						'preqCd': $('#findPreqCd').val(),
			            'itemCd': $(this).find('.findItemCd').val(),
			            'itemNm': $(this).find('#findItemNm').val(),
			            'reqItemQty': $(this).find('#findReqItemQty').val(),
			            'reqNote': $(this).find('#findReqNote').val()
			        };
				}else{ // 원래 있던 행이면
					// reqItem 객체 구성
			        reqForm = {
						'preqCd': $('#findPreqCd').val(),
			            'itemCd': originItemCdMap.get(itemCdId),
			            'itemNm': $(this).find('#findItemNm').val(),
			            'reqItemQty': $(this).find('#findReqItemQty').val(),
			            'reqNote': $(this).find('#findReqNote').val(),
						'newItemCd': $(this).find('.findItemCd').val()
			        };
				}
				reqList.push(reqForm);
			}
	    });
		formData['reqItem'] = reqList;
		console.log(formData);
		
		$.ajax({
				url: `${cPath}/pur/update`,
				type: "POST",
				data: JSON.stringify(formData),
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},
				success: function(res) {
					console.log(res.totalValue.rslt);
					if(res.totalValue.rslt == "success"){
						Swal.fire({
							  title: '수정완료!',
							  text: '수정이 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
							})
						retrievePurOrder(baseUrl);
					}else{
						$.each(res.totalValue, function(fieldName, errorMessage) {
							let errorId = fieldName;
							$('#' + errorId + 'Error').text(errorMessage);
						});
						Swal.fire({
							title: '수정실패!',
							text: '수정이 실패했습니다.',
							icon: 'error',
							confirmButtonText: '확인'
						})
					}
					
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
		});
	});
	
	// 삭제 버튼 이벤트
	$("#deleteBtn").on("click", function() {
		let preqCd = $('#findPreqCd').val();

		Swal.fire({
		  title: "삭제하시겠습니까?",
		  text: "이 발주요청서를 삭제하시겠습니까? 되돌릴 수 없습니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#d33",
		  cancelButtonColor: "#3085d6",
		  confirmButtonText: "삭제",
		  cancelButtonText: "취소" 
		}).then((result) => {
		  if (result.isConfirmed) {
			$.ajax({
				url: `${cPath}/pur/remove`,
				type: "POST",
				data: preqCd,
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},
				success: function(res) {	
					console.log(res);				
					if (res.totalValue.rslt == "success") {
						purOrderModal.hide();
						$('.modal-backdrop').remove();
						
						Swal.fire({
					    	title: "삭제 완료!",
					    	text: "발주요청서가 삭제되었습니다.",
					    	icon: "success"
					    });
	
						$("#purListDataTable tbody tr").each(function() {
						    var preqCdValue = $(this).find(".preqCd").val().trim();
						    if (preqCdValue === preqCd) {
						        $(this).remove(); // 해당 행 삭제
						        return false; // 루프 종료
						    }
						});
					} else if (res.totalValue.rslt == "fail") {
						Swal.fire({
					    	title: "삭제 실패!",
					    	text: "존재하지 않는 발주요청서입니다.",
					    	icon: "error"
					    });
					}
					
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
		  }
		});
	});
		
	// 발주요청일자 클릭 시 발주요청 코드로 데이터 요청 후 상세요청 페이지에 테이블 생성
	$(document).on('click', '.preqLink', function(e){
		let preqCd = $(this).closest('tr').find('#preqCd').val();

		$.ajax({
			url : `/pur/${preqCd}`,
			method : "GET",
			success: function(res){
				console.log(res.purOrderDetailList);
				let purOrderList = res.purOrderDetailList;
				let tableHead = ` <table class="table table-bordered fs--1 mb-0" id="purTable">
	                            <thead class="bg-200 text-900">
	                                <tr>
	                                    <th>일자</th>
	                                    <td colspan="1">
											<input type="date" class="iText" id="findPreqDate" name="preqDate" placeholder="일자" style="width:90%" max="${getCurrentDate()}" value="${purOrderList[0].PREQ_DATE}"/>
											<input type="hidden" id="findPreqCd" name="preqCd" value="${purOrderList[0].PREQ_CD}"/>
	                                    </td>
										<td><span id="dateNullError" class="error"></span></td>
	                                    <th>납기일자</th>
	                                    <td colspan="1">
	                                        <input type="date" class="iText" id="findPreqDueDate" name="preqDueDate" placeholder="납기일자" style="width:90%" value="${purOrderList[0].PREQ_DUE_DATE}"/>
											<input type="hidden" id="findPreqStat" name="preqStat" value="${purOrderList[0].PREQ_STAT}"/>
	                                    </td>
										<td><span id="preqDueDateError" class="error"></span></td>
									</tr>
									<tr>
	                                    <th>담당자</th>
	                                    <td colspan="1">
	                                        <input type="text" class="iText" id="findEmpNm" name="empNm" placeholder="담당자" style="width:90%" value="${purOrderList[0].EMP_NM}"/>
	                                        
	                                        <input type="hidden" id="findEmpCd" name="empCd" value="${purOrderList[0].EMP_CD}"/>
	                                    </td>
										<td><span id="empNmError" class="error"></span></td>
										<th>
										<td colspan="1">
										</td>
										<td></td>
	                                </tr>
	                            </thead>
								<tbody>
									<tr>
	                                    <th class="text">품목코드</th>
	                                    <th class="text" colspan="2">품목명</th>
	                                    <th class="text">수량</th>
	                                    <th class="text" colspan="2">적요</th>
	                                </tr>`;

				let tableBody = '';
				for (let i = 0; i < purOrderList.length; i++) {
					const itemCd = purOrderList[i].ITEM_CD;
				    const itemNm = purOrderList[i].ITEM_NM;
				    const reqItemQty = purOrderList[i].REQ_ITEM_QTY;
				    const reqNote = purOrderList[i].REQ_NOTE;
					
					let itemCdId = "findItemCd_" + i
					tableBody += `
                                <tr class="purOrderRow">
                                    <td>
                                        <input type="text" class="iText findItemCd" id="${itemCdId}" name="itemCd" style="width: 100%" value="${itemCd}"/>
                                        <span id="itemCdError" class="error"></span> 
                                    </td>
                                    <td colspan="2">
                                        <input type="text" class="iText findItemNm" id="findItemNm" name="itemNm" style="width: 100%" value="${itemNm}"/>
                                        <span id="itemNmError" class="error"></span> 
                                    </td>
                                    <td>
                                        <input type="number" class="iText" id="findReqItemQty" name="reqItemQty" style="width: 100%" value="${reqItemQty}"/>
                                        <span id="reqItemQtyError" class="error"></span>
                                    </td>
                                    <td colspan="2">
                                        <input type="text" class="iText" id="findReqNote" name="reqNote" style="width: 100%" value="${reqNote|| ''}"/>
                                    </td>
                                </tr>`;

				}
				tableBody += `<tr class="purOrderRow">
                                    <td>
                                        <input type="text" class="iText findItemCd" id="findItemCdNew" name="itemCd" style="width: 100%"/>
                                        <span id="itemNullError" class="error"></span> 
                                    </td>
                                    <td colspan="2">
                                        <input type="text" class="iText findItemNm" id="findItemNm" name="itemNm" style="width: 100%"/>
                                        <span id="itemNmError" class="error"></span> 
                                    </td>
                                    <td>
                                        <input type="number" class="iText" id="findReqItemQty" name="reqItemQty" style="width: 100%"/>
                                        <span id="reqItemQtyError" class="error"></span>
                                    </td>
                                    <td colspan="2">
                                        <input type="text" class="iText" id="findReqNote" name="reqNote" style="width: 100%"/>
                                    </td>
                             </tr>`;
				let makeTable = tableHead + tableBody + "</tbody></table>"

				// 모달 내용 업데이트
				$('#purOrderModal .modal-body').html(makeTable);
		
				// 모달 열기
				$('#purOrderModal').modal('show');
				
				clickItemModalEvent();
				addInputEvent();
				disabledButton(purOrderList[0].PREQ_STAT);
				
				let count = 0;
				$(".purOrderRow").each(function() {
					let id = 'findItemCd_' + count;
					let itemCdVal = $(this).find('#'+id).val();
					originItemCdMap.set(id, itemCdVal);
					count ++;
				});
				
				console.log(originItemCdMap);
			},
			error: function (request, status, error) {
		        console.log("code: " + request.status)
		        console.log("message: " + request.responseText)
		        console.log("error: " + error);
		    }
		});
		
	});
	
	//담당자 검색 모달
	$(document).on('click', '#findEmpNm', function(e) {
		e.preventDefault();
		$('#empNmError').empty();
		// 모달 열기
		$('#findEmpModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/emp/list`,
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
						autoWidth: false,
						destroy: true
					});
				}
			});
		} catch (error) {
			console.error(error);
		}
	});
	
	$(document).on('input','.findItemCd', function() {
		//이 input값이 변경될때 부모의 td의 부모의 tr에서 input을찾아 value를 비워줌
		$(this).closest('td').parent('tr').find('input').val('');
	});
	// 품목 모달 클릭 시 인풋에 값 추가 이벤트
	function clickItemModalEvent(){
		$(document).off('click', '#findItemNm, .findItemCd'); // 이벤트 등록 전에 이전 이벤트를 해제
		$(document).on('click', '#findItemNm, .findItemCd', function () {
			itemWindowModal.show();
	        
			// 현재 클릭된 행에 대한 데이터 가져오기
	        let currentRow = $(this).closest('tr');
			currentRow.find('input').val('');
			let inputItemCd = currentRow.find('.findItemCd');
	        let inputItemNm= currentRow.find('#findItemNm');

			$(document).off('click', '.selectItem');
			$(document).on('click', '.selectItem', function () {
	            // 선택한 item의 정보 가져오기
				let selectedItemCd = $(this).data('selected-cd');
	            let selectedItemNm = $(this).data('selected-value');
	
	            // 현재 클릭된 행의 input에 값을 추가
				inputItemCd.val(selectedItemCd);
	            inputItemNm.val(selectedItemNm);
	
	            // itemWindow 모달 닫기
	            $('#itemWindow').modal('hide');
				inputItemNm.trigger('input');
			});
		});
	}
	
	// 발주요청 조회 데이터 요청
	function retrievePurOrder(urls){
		$.ajax({
			url: urls,
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let purOrderList = resp.purOrderList;
				let trTags = "";
		
				if (purOrderList?.length > 0) {
					$.each(purOrderList, function () {
						trTags += makePurOrderTrTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='6'>등록된 품목이 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
				$('#purListDataTable').DataTable({
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
	}
	
	retrievePurOrder(baseUrl);
	
	// 테이블 위에 날짜 생성
	function showDates() {
		// 오늘 날짜
		var today = new Date();

		// 세 달 전 날짜
		var oneMonthAgo = new Date();
		oneMonthAgo.setMonth(today.getMonth() - 3);
		
		// 포맷팅 함수
		function formatDate(date) {
			var year = date.getFullYear();
			var month = (date.getMonth() + 1).toString().padStart(2, '0');
			var day = date.getDate().toString().padStart(2, '0');
			return year + '-' + month + '-' + day;
		}

		// 날짜를 p 태그에 표시
		document.getElementById('searchDate').innerText = formatDate(oneMonthAgo) + ' ~ ' + formatDate(today);
	}
	
	function getCurrentDate() {
		const today = new Date();
		const year = today.getFullYear();
		let month = today.getMonth() + 1;
		let day = today.getDate();

		if (month < 10) {
			month = `0${month}`;
		}

		if (day < 10) {
			day = `0${day}`;
		}

		return `${year}-${month}-${day}`;
	}
	
	function addInputEvent() {
		$('#purTable tbody input').on('input', function(){
			var allInputsFilled = true;
	        $('#purTable tbody input').each(function () {
	            if ($(this).attr('name') !== 'reqNote' && $(this).val() === '') {
                	allInputsFilled = false;
                	return false;
				} 
	        });
	
	        // 다 채워졌을 경우 마지막 행을 복사
	        if (allInputsFilled) {
	            var lastRow = $('#purTable tbody tr:last');
	            var newRow = lastRow.clone();
	            lastRow.after(newRow);
	            newRow.find('input').val('');
				addInputEvent();
	        }
		});
	}
	
	function disabledButton(stat){
		if(stat != 'T001'){
			// 수정 버튼 비활성화
			$("#updateBtn").prop("disabled", true);
			// 배경색 변경
			$("#updateBtn").css("background-color", "#d3d3d3");
			// 삭제 버튼 비활성화
			$("#deleteBtn").prop("disabled", true);
			// 배경색 변경
			$("#deleteBtn").css("background-color", "#d3d3d3");
		} else{
			$("#updateBtn").prop("disabled", false);
			$("#updateBtn").css("background-color", "#ffffff");
			$("#deleteBtn").prop("disabled", false);
			$("#deleteBtn").css("background-color", "#ffffff");
		}
	}
});