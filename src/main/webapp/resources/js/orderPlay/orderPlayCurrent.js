/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 12. 1.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 1.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

function fn_paging(page){
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}

$(function() {
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	
initDate();

function initDate(){
		let currentDate = new Date();
	
	    // 현재 날짜를 rmstLdate에 설정 (YYYY-MM-DD 형식)
	    let preqLdate = currentDate.toISOString().slice(0, 10);
	    $('#preqLdate').val(preqLdate);
	
	    // 1달 전 날짜 계산
	    let prevMonth = new Date(currentDate);
	    prevMonth.setMonth(prevMonth.getMonth() - 1);
	
	    // 1달 전 날짜를 rmstSdate에 설정 (YYYY-MM-DD 형식)
	    let preqSdate = prevMonth.toISOString().slice(0, 10);
	    $('#preqSdate').val(preqSdate);
	}
	
	
	
let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	let empModal = new bootstrap.Modal($('#findEmpModal')[0]);
	let cPath = $('.pageConversion').data('contextPath');
		
	$('#itemWindowModal').on('hidden.bs.modal', function () {
	 	$('.modal-backdrop').remove();   
	 	$('body').css('overflow', ''); 
	});
	
	$('#findEmpModal').on('hidden.bs.modal', function () {
	 	$('.modal-backdrop').remove();   
	 	$('body').css('overflow', ''); 
	});
	
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
	let makeItemTrTag = function (result) {
	     let trTag = `
				<tr>
       	  			<td><input class="form-check-input checkData" type="checkbox" /></td>
           	  		<td>${result.itemCd}</td>
           	  		<td><a href="javascript:;" class="selectItem" data-selected-value="${result.itemNm}">
           	  			${result.itemNm}
           	  		</a></td>
       	  		</tr>
		`;
		
		return trTag;
	};
	
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let urls = this.action;
		let datas = $(this).serialize();
		$.ajax({
			url: urls,
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
								<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('#itemWindow .list').html(trTags);
			
			/*	$('#dataTable').DataTable({
			        paging: true,
			        searching: true,
			        lengthChange: false,
			        info: false,
			        ordering: false
			    });*/
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}).submit();
	
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
	
	
	
	
	$(document).on('click', '#findItemNm, #itemSearchBtn', function() {
		itemWindowModal.show();
	});
	
	$(document).on('click', '#findEmpNm, #empSearchBtn', function() {
		empModal.show();
	});
	
	//담당자 검색 모달
	$(document).on('click', '#findEmpNm, #empSearchBtn', function(e) {
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
							let removeTag = `<button type="button" id='empClean' class="btn searchBtn p-1 border-0 removeSpan">
								                <i class="fas fa-times-circle"></i>
								            </button>`;
							$('#findEmpCd').val(empCd);
							$('#findEmpNm').val(empNm);
							$('#removeEmp').html(removeTag);
							empModal.hide();
							$('.modal-backdrop').remove();   
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
	
	
	//담당자 초기화 버튼
	$(document).on('click','#empClean',function(){
		$('#findEmpCd').val('');
		$('#findEmpNm').val('');
		$('#empClean').empty();
	})
	
	
	//중복검사를 통해 중복된 값이 추가되려하면 막음.
	function appendSpanIfNotDuplicate(selectedValue,itemCd) {
	    let isDuplicate = false;
	    $('#spanSpace').find('.customSpan').each(function() {
	        if ($(this).text().trim() === selectedValue.trim()) {
	            isDuplicate = true;
	            return false; 
	        }
	    });
	
	    if (!isDuplicate) {
	        let spanTag = spanMaker(selectedValue,itemCd);
	        $('#spanSpace').append(spanTag);
	    }
	}
	
	// span 태그 삭제
	$(document).on('click', '.removeSpan', function() {
	    $(this).closest('.customSpan').remove();
	});
	
	//품목코드 한개를 선택시 span태그에 저장
	$('.modal-body').on('click', '.selectItem', function (e) {
	  e.preventDefault();
 	  let row = $(this).closest('tr');
	  let itemCd = row.find('td:eq(1)').text();
	  let selectedValue = $(this).data('selected-value');
	  
	  appendSpanIfNotDuplicate(selectedValue,itemCd);
	  
	  $('.modal-backdrop').remove();
	  itemWindowModal.hide();
	});	
	
	//모달에서 품목선택시 발생하는 이벤트
	$('.modal-body').on('click', '.selectWare', function (e) {
	  e.preventDefault();
	  let selectedValue = $(this).data('selected-value');
	  
	  $('#wareSearch').val(selectedValue);
	  wareWindowModal.hide();
	  $('.modal-backdrop').remove();
	});
	
	// 품목 span 태그 생성
	function spanMaker(selectedValue,itemCd) {
	    return `
	        <span id =${itemCd} class ="customSpan" style="margin-left: 3px; margin-top: 10px; padding: 3px; background-color: #3498db; color: white; border-radius: 5px;">
	            ${selectedValue}
	            <button type="button" class="btn searchBtn p-1 border-0 removeSpan">
	                <i class="fas fa-times-circle"></i>
	            </button>
	        </span>
	    `;
	}
	
	//저장버튼을 클릭하면 생기는 이벤트
	$('#saveBtn').on('click',function(){
	    $('.checkData:checked').each(function() {
			let row = $(this).closest('tr');
	        let itemCd = row.find('td:eq(1)').text();
	        let itemNm = row.find('td:eq(2)').text(); 
	        let spanTag = appendSpanIfNotDuplicate(itemNm, itemCd);
			$('#spanSpace').append(spanTag);
			$(this).prop('checked', false);
	    });
	})
	
	
	
	$('#orderPlayCurrentForm').on('submit', function(e){
		e.preventDefault();
		
		let itemCd=[];
		$('.customSpan').each(function() {
           let datas = $(this).attr('id');
           itemCd.push(datas);
		});
		
		let jsonTrans = [];
        //저장된 배열을 for문돌려서 json형식으로 만들어줌
		itemCd.forEach(code => {
		     let itemCode = { 'itemCd': code };
   			 jsonTrans.push(itemCode);
		});

		let data = $(this).serializeJSON();
		data.itemList = jsonTrans;
		
		let preqSdate = data.preqSdate;
		let preqLdate = data.preqLdate;
		
		let jsonData = JSON.stringify(data);
		
		let url = $(this).attr('action');
		let method = $(this).attr('method');

		$.ajax({
			url: url,
			method: method,
			data : jsonData,
			contentType: 'application/json',
			success: function (resp) {
				console.log("체크"+resp.orderPlayCurrentList);
				console.log(resp.orderPlayCurrentList);
				let orderPlayCurrentList = resp.orderPlayCurrentList;
				if(orderPlayCurrentList.length > 0 ){
					$('#tableDiv').css('display', 'block');
					
					let tbody = $('#purListDataTable tbody');
					
					// 기존 행 삭제
			        tbody.empty();
			
			        // dataList를 순회하며 각 데이터를 테이블에 추가
			        orderPlayCurrentList.forEach(function (data) {
						let additionalItems = data.itemCount > 1 ? `외 ${data.itemCount - 1}건` :''; 
			            let row = $('<tr>');
			            row.append('<td><a href="javascript:;" class="preqLink">' + data.PORD_DATE + '</a></td>');
			            row.append('<td>' + (data.DUE_DATE ? data.DUE_DATE : '') + '</td>');
			            row.append('<td>' + data.ITEM_NM + additionalItems + '</td>');
			            row.append('<td>' + addCommas(data.PORD_QTY) + '</td>');
			            row.append('<td>' + data.PORD_STAT + '</td>');
						row.append('<input type="hidden" class="pordCd" id="pordCd" value="' + data.PORD_CD + '"/>');
						row.append('<input type="hidden" id="itemCd" value="' + data.ITEM_CD + '"/>');
						row.append('<input type="hidden" id="empNm" value="' + data.EMP_NM + '"/>');
						row.append('<input type="hidden" id="empCd" value="' + data.EMP_CD + '"/>');
			            tbody.append(row);
			        });

					$('#searchDate').text(preqSdate + ' ~ ' + preqLdate);
				}else{
					$('#tableDiv').css('display', 'block');
					let tbody = $('#purListDataTable tbody');
					
					// 기존 행 삭제
			        tbody.empty();
					let row = $('<tr>');
		            row.append('<td colspan="6">검색조건에 맞는 발주요청이 없습니다.</td>');
		            tbody.append(row);
				}
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});	
	});
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
	
	//수정
	$(document).on('click', '.preqLink', function(e){
		let pordCd = $(this).closest('tr').find('#pordCd').val();

		$.ajax({
			url : `/orderPlay/${pordCd}`,
			method : "GET",
			success: function(res){
				console.log(res.orderPlayDetailList);
				let orderPlayDetailList = res.orderPlayDetailList;
				let tableHead = ` <table class="table table-bordered fs--1 mb-0" id="purTable">
	                            <thead class="bg-200 text-900">
	                                <tr>
	                                    <th>일자</th>
	                                    <td colspan="1">
											<input type="date" class="iText" id="findPordDate" name="pordDate" placeholder="일자" style="width:90%" max="${getCurrentDate()}" value="${orderPlayDetailList[0].PORD_DATE}"/>
	                                        <span id="preqDateError" class="error"></span>
											<input type="hidden" id="findPordCd" name="pordCd" value="${orderPlayDetailList[0].PORD_CD}"/>
	                                    </td>
										<td></td>
	                                    <th>납기일자</th>
	                                    <td colspan="1">
	                                        <input type="date" class="iText" id="findDueDate" name="dueDate" placeholder="납기일자" style="width:90%" max="${getCurrentDate()}" value="${orderPlayDetailList[0].DUE_DATE}"/>
	                                        <span id="preqDueDateError" class="error"></span>
											<input type="hidden" id="findPordStat" name="pordStat" value="${orderPlayDetailList[0].PORD_STAT}"/>
	                                    </td>
										<td></td>
									</tr>
									<tr>
	                                    <th>담당자</th>
	                                    <td colspan="1">
	                                        <input type="text" class="iText" id="findEmpNm" name="empNm" placeholder="담당자" style="width:90%" value="${orderPlayDetailList[0].EMP_NM}"/>
	                                        <span id="empNmError" class="error"></span>
	                                        <input type="hidden" id="findEmpCd" name="empCd" value="${orderPlayDetailList[0].EMP_CD}"/>
	                                    </td>
										<td></td>
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
				for (let i = 0; i < orderPlayDetailList.length; i++) {
					const itemCd = orderPlayDetailList[i].ITEM_CD;
				    const itemNm = orderPlayDetailList[i].ITEM_NM;
				    const pordQty = orderPlayDetailList[i].PORD_QTY;
				    const reqNote = orderPlayDetailList[i].REQ_NOTE;
					
					let itemCdId = "findItemCd_" + i
					tableBody += `
                                <tr class="purOrderRow">
                                    <td>
                                        <input type="text" readOnly class="iText boderNone" id="${itemCdId}" name="itemCd" style="width: 100%" value="${itemCd}"/>
                                        <span id="itemCdError" class="error"></span> 
                                    </td>
                                    <td colspan="2">
                                        <input type="text" readOnly class="iText boderNone" name="itemNm" style="width: 100%" value="${itemNm}"/>
                                        <span id="itemNmError" class="error"></span> 
                                    </td>
                                    <td>
                                        <input type="number" readOnly class="iText boderNone" id="findReqItemQty" name="reqItemQty" style="width: 100%" value="${addCommas(pordQty)}"/>
                                        <span id="reqItemQtyError" class="error"></span>
                                    </td>
                                    <td colspan="2">
                                        <input type="text" readOnly class="iText boderNone" id="findReqNote" name="reqNote" style="width: 100%" value="${reqNote|| ''}"/>
                                    </td>
                                </tr>`;

				}
				tableBody += `<tr class="purOrderRow">
                                    <td>
                                        <input type="text" readOnly class="iText boderNone" id="findItemCdNew" name="itemCd" style="width: 100%"/>
                                        <span id="itemCdError" class="error"></span> 
                                    </td>
                                    <td colspan="2">
                                        <input type="text" readOnly class="iText boderNone" name="itemNm" style="width: 100%"/>
                                        <span id="itemNmError" class="error"></span> 
                                    </td>
                                    <td>
                                        <input type="number" readOnly class="iText boderNone" id="findReqItemQty" name="reqItemQty" style="width: 100%"/>
                                        <span id="reqItemQtyError" class="error"></span>
                                    </td>
                                    <td colspan="2">
                                        <input type="text" readOnly class="iText boderNone" id="findReqNote" name="reqNote" style="width: 100%"/>
                                    </td>
                             </tr>`;
				let makeTable = tableHead + tableBody + "</tbody></table>"

				// 모달 내용 업데이트
				$('#orderPlayCurrnetModal .modal-body').html(makeTable);
		
				// 모달 열기
				$('#orderPlayCurrnetModal').modal('show');
				
				//clickItemModalEvent();
				addInputEvent();
				disabledButton(orderPlayDetailList[0].PORD_STAT);
				
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
	
})