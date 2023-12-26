/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 11. 15.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 15.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

function formatDate(dateArray) {
  if (Array.isArray(dateArray) && dateArray.length >= 3) {
    const year = dateArray[0];
    const month = String(dateArray[1]).padStart(2, '0');
    const day = String(dateArray[2]).padStart(2, '0');
    
    return `${year}-${month}-${day}`;
  } else {
    return '0000-00-00';
  }
}


$(function(){	
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	
	/* 아작스를 위한 데이터 설정 */
	let makeTrTag = function (rslt) {
		
		
    let trTag = `
        <tr>
			<td>
				<div>
					<input type="checkbox" class="preqCheckbox" />
				</div>
			</td>
            <td id="preqCd" class="preqCd"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.preqCd}</a></td>
			<td id="itemNm" class="itemNm">${rslt?.reqItem[0]?.item?.itemNm ?? '뭐여'}${rslt.nqty > 0 ? ` 외 ${rslt.nqty}종` : ''}</td>
			<td id="preqDate" class="preqDate">${rslt.preqDate}</td>
			<td id="preqDueDate" class="preqDueDate">${formatDate(rslt.preqDueDate)}</td>
			<td id="preqStat" class="preqStat">${rslt.preqStat}</td>
            
        </tr>
	    `;	
	    return trTag;
	};
	
	
	let cPath = $('.pageConversion').data('contextPath');
	
	const baseUrl = `${cPath}/orderPlan`;
	
	/* 조회 함수 */
	function retrieveOrderPlanEnroll(){
		$.ajax({
			url: baseUrl+"/enroll2",
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				
				console.log(resp.pagingHTML);
				console.log(resp.dataList);
				
				let opeList = resp.dataList;
				let trTags = "";
		
				if (opeList?.length > 0) {
					$.each(opeList, function () {
						
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
				
				

				handleCheckboxes();
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});	
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveOrderPlanEnroll();
	
	
	
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
				
				let opeList = resp.dataList;
				let trTags = "";
		
				if (opeList?.length > 0) {
					$.each(opeList, function () {
						
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
				handleCheckboxes();
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
	
	
	//진행완료됐을 때 체크박스 제어하기
	function handleCheckboxes() {
        $('.preqCheckbox').each(function() {
            var preqStatValue = $(this).closest('tr').find('.preqStat').text().trim();
			// preqStat이 'Y'인 경우 링크 비활성화
            if (preqStatValue === '완료') {
                $(this).prop('disabled', true);
            }	
        });

		/*$('.preqCd a').each(function() {
            let preqStatValue = $(this).closest('tr').find('.preqStat').text().trim();
            
            if (preqStatValue === '완료') {
                // preqStat이 'Y'인 경우 링크 비활성화
                $(this).replaceWith(`<span>${$(this).text()}</span>`);
            }
        });*/
    }
	
	/* 아작스를 위한 데이터 설정 */
	let makeTrTags = function (rslt) {
    let trTag = `
				 <tr>
		            <td class="preqCd">${rslt.preqCd}</td>
		            <td class="itemNm">${rslt.itemNm}</td>
		            <td class="reqItemQty">${rslt.reqItemQty}</td>
		            <td class="preqDate">${rslt.preqDate}</td>
		            <td class="preqDueDate">${rslt.preqDueDate}</td>
		            <td class="empNm">${rslt.empNm}</td>
		            <td class="uprcEdate">${rslt.uprcEdate ? rslt.uprcEdate : 'X'}</td>
		            <td class="preqStat">${rslt.preqStat}</td>
					<input type="hidden" id="preqCd" name="preqCd" value="${rslt.preqCd}"/>
		        </tr>
	    `;	
	    return trTag;
	};
	
	// 해당 품목 상세정보 및 수정 폼출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '#preqCd a', function(e) {
		e.preventDefault();
		let preqCd = $(this).text(); // 클릭한 링크의 텍스트 값 (preqCd)
		let orderPlanViewURL = `${cPath}/orderPlan/view?what=${preqCd}`;
		
		
			try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: orderPlanViewURL,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						$('.modal-backdrop').remove();
						console.log("resp",resp);
						let orderPlanView = resp;
						let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="defectDetailDataTable">
						        <thead class="bg-200 text-900">
						            <tr>
									<th class="preqCd">발주요청코드</th>
									<th class="itemNm">발주요청품목명</th>
									<th class="reqItemQty">발주요청품목수량</th>
									<th class="preqDate">발주요청일자</th>
									<th class="preqDueDate">발주요청납기일자</th>
									<th class="empNm">발주요청 담당사원</th>
									<th class="uprcEdate">단가책정종료일자</th>
									<th class="preqStat">발주요청진행여부</th>
								</tr>
						        </thead>
						        <tbody>
						`;
						if (orderPlanView?.length > 0) {
						$.each(orderPlanView, function () {
							makeTable += makeTrTags(this);
								});
							} else {
								makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>등록된 창고가 없습니다.</td>
										</tr>
									`;
							}
	
						makeTable += `
							</tbody>
						</table>
						
						`
						;
						
						
						if (resp.length > 0 && resp[0].preqStat === '완료') {
					    makeTable += ``;
						}else{
							makeTable += `
								
							<div>
								<button type="submit" id="doOrderPlanEnroll" class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1">발주계획등록</button>
							</div>
							`
							;
						}
						
	
						// 모달 내용 업데이트
						$('#orderPlanEnrollModal .modal-body').html(makeTable);
						
						$('.modal-backdrop').remove();
	
						// 모달 열기
						$('#orderPlanEnrollModal').modal('show');
					}
				});
			} catch (error) {
				console.error(error);
		
		}

	});
	
	//발주요청서 발주계획서에 등록하기
	$(document).on('submit', '#orderPlanForm', function(e) {
		e.preventDefault();
		
		let url = this.action;
		console.log(url);
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		
		
		$.ajax({
				url: url,
				method: "POST",
				data: json,
				contentType: 'application/json',
				success: function(res) {
					$('#orderPlanEnrollDataTable').DataTable().destroy();
					
					$('#orderPlanEnrollModal').modal('hide');
					
					
					Swal.fire({
					  icon: "success",
					  title: "등록 !",
					  showConfirmButton: false,
					  timer: 1500
					});
					
					retrieveOrderPlanEnroll();
					
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
	});
	
	
	/*checkbox 여러개 선택후 등록하기*/
	$(document).on('click','#insertBtn', function() {
    
    orderPlanEnrollData();

	});
	
	function orderPlanEnrollData() {
		var checkedRows = $('.list input:checked').closest('tr');
        var rowData = [];

        checkedRows.each(function() {
            var row = $(this);
            var preqCd = row.find('.preqCd').text();
            var preqDate = row.find('.preqDate').text();
            var preqDueDate = row.find('.preqDueDate').text();
            var preqStat = row.find('.preqStat').text();

            // 데이터를 객체에 저장
            var dataObj = {
                'preqCd': preqCd,
                'preqDate': preqDate,
                'preqDueDate': preqDueDate,
                'preqStat': preqStat
            };

            rowData.push(dataObj); // 객체를 배열에 추가
        });
		
		$.ajax({
		    url: baseUrl+'/enrollData',
		    method: 'POST',
		    contentType: 'application/json',
		    data: JSON.stringify(rowData), // JSON 형식으로 데이터 전송
		    success: function(response) {
		        // 성공적으로 처리된 후의 작업
					$('#orderPlanEnrollDataTable').DataTable().destroy();
					
					//alert('등록 ! ');
					Swal.fire({
					  icon: "success",
					  title: "등록 !",
					  showConfirmButton: false,
					  timer: 1500
					});
					
					retrieveOrderPlanEnroll();
		    },
		    error: function(error) {
		        console.error('Ajax 요청 실패:', error);
		    }
		});
		
		}
		
		    
		
})