/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 10.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.     김도현      최초작성 및 조회작성
 * 2023. 11. 13.     김도현      상세조회 작성
 * 2023. 11. 15.	 김도현	   등록작성
 * 2023. 11. 17.     김도현      수정작성
 * 2023. 11. 22.     김도현	   견적단가, 견적수량 정규식 이용하여 콤마 추가
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
	
	let quoteViewURL = ` ${cPath}/quote/view?what=${rslt.qteCd}`;
	let itemNm = '';

    if (rslt.quoteItem.length > 0) {
        itemNm = rslt.quoteItem[0].item ? rslt.quoteItem[0].item.itemNm : '';
        
        if (rslt.quoteItem.length > 1) {
            // 추가 품목이 있는 경우 수를 표시
            itemNm += ` 외 ${rslt.quoteItem.length - 1}건`;
        }
    }

	// 수량과 단가를 곱하여 총액 계산
    let totalAmount = rslt.quoteItem.length > 0
        ? rslt.quoteItem[0].qteQty * rslt.quoteItem[0].qteUprc
        : 0;

    // 총액을 콤마로 포맷팅
    let formattedTotalAmount = addCommas(totalAmount);

    let trTag = `
        <tr>
            <td class="qteCd"><a href="${quoteViewURL}">${rslt.qteCd}</a></td>
            <td class="qteDate">${rslt.qteDate}</td>
			<td class="comNm">${rslt.comNm}</td>
			<td class="empNm">${rslt.empNm}</td>
			<td class="itemNm">${itemNm}</td>
			<td class="qteQty">${rslt.quoteItem.length > 0 ? addCommas(rslt.quoteItem[0].qteQty) : ''}</td>
            <td class="qteUprc">${rslt.quoteItem.length > 0 ? addCommas(rslt.quoteItem[0].qteUprc) : ''}</td>
            <td class="qteAmount">${formattedTotalAmount}</td>
			<td class="qteStat"><a href="javascript:;">${rslt.qteStat}</a></td>
        </tr>
    `;

    return trTag;
};

// 견적서상태 변경하는 코드
// 문서에 이벤트 리스너를 위임하기 위해 document에 이벤트 리스너를 추가
$(document).on('click', '.qteStat a', function() {
	
	// 현재 클릭된 링크를 저장
    let clickedLink = $(this);
	
    // 부모 행에서 qteCd 가져오기
    let qteCd = clickedLink.closest('tr').find('.qteCd a').attr('href').split('=')[1];

     // SweetAlert을 사용하여 확인 메시지 표시
    Swal.fire({
        title: '견적서 상태 변경',
        text: '견적서 상태를 완료로 변경하시겠습니까?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '확인'
    }).then((result) => {
        if (result.isConfirmed) {

	
    $.ajax({
        url: `${cPath}/quote/updateQteStat`,
        method: "POST", 
        data: {
            qteCd: qteCd
        },
	    dataType:"text",
        success: function(response) {
			console.log("서버에서 받은값:",response);            

            if (response == "OK") {
                console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@체킁@@@@@",response);
                clickedLink.text('완료'); 
            
                Swal.fire('성공', '견적서 상태가 완료로 변경되었습니다.', 'success');
				console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@체킁@@@@@",response);
			} else {
                console.error('qteStat 업데이트 실패');
				console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@체킁@@@@@",response);
                Swal.fire('오류', '견적서 상태 변경에 실패했습니다.', 'error');
            }
        },
        error: function() {
            console.error('qteStat 업데이트 중 오류 발생');
			
            Swal.fire('오류', '견적서 상태 변경 중 오류가 발생했습니다.', 'error');
        }
    });
}
});
});







let toggleSelect;
//견적서 리스트 출력
const makeList = function(){
	
	const baseUrl = `${cPath}/quote/listView`;

	$.ajax({
		url: baseUrl,
		method: "GET",
		contentType: 'application/json',
		dataType: "json",
		success: function (resp) {
			console.log("체킁:",resp);

			let quoteList = resp.quoteList;
			let trTags = "";
	
			if (quoteList?.length > 0) {
				$.each(quoteList, function () {
					trTags += makeTrTag(this);
				});
			} else {
				trTags += `
						<tr>
							<td class="text-noquote" colspan='7'>등록된 견적서가 없습니다.</td>
						</tr>
					`;
			}

			$('.list').html(trTags);
			
			
			
			
			if ($.fn.DataTable.isDataTable('#quoteListDataTable')) {
					// 테이블이 이미 초기화된 경우, 초기화하지 않음
					
					console.log('DataTable already initialized');
				} else {
					// 테이블이 초기화되지 않은 경우, 초기화 진행
					$('#quoteListDataTable').DataTable({
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
	function updateQuoteListInDOM(qteCd, updatedData) {
		// 해당하는 견적서코드를 포함하는 행을 찾기
		let $row = $(`.qteCd:contains(${qteCd})`).closest('tr');

		// 행을 찾지 못했을 경우에 대한 유효성 검사
		if ($row.length === 0) {
			console.error(`Row with quote code ${qteCd} not found.`);
			return;
		}

		// 행 내용 업데이트
		$row.find('.qteCd a').attr('href', `${cPath}/quote/view?what=${updatedData.qteCd}`).text(updatedData.qteCd);

		console.log("업데이트 되랑", updatedData);
		
		// 업데이트된 값 행에 찍어주기
		$row.find('.qteDate').text(updatedData.qteDate);
		$row.find('.qteQty').text(updatedData.qteQty);
		$row.find('.qteUprc').text(updatedData.qteUprc);
		$row.find('.empNm').text(updatedData.empNm);
		$row.find('.comNm').text(updatedData.comNm);
        
    	 // 품목명 업데이트
    
        $row.find('.itemNm').text(updatedData.quoteItem[0].item.itemNm);
    
		
	}



$(function(){
	
	makeList();

	let toggleSelect;
	
	// 해당 견적 상세정보 및 수정 폼 출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '.qteCd a', function(e) {
		e.preventDefault();
		
		// 현재 페이지 번호 저장
		let qteListDataTable = $('#quoteListDataTable').DataTable();
		currentPageNumber = qteListDataTable.page() + 1;
		
		let qteCd = $(this).text(); // 클릭한 링크의 텍스트 값 (qteCd)
		let quoteViewURL = `${cPath}/quote/view?what=${qteCd}`;
			toggleSelect = 'update';
		
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: quoteViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					console.log("체킁:",resp);
					let quoteView = resp.quoteView;
					
		
					
					
					let makeTable = "";

						makeTable +=
						 `
							<table class="table table-bordered  fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>일자</th>
								<td colspan="5">
									<input type="date" id="quoteDate" name="qteDate" placeholder="일자" style="width: 170px;" value="${quoteView.qteDate}"/>
									<span id="quoteDateError" class="error"></span>
								</td>
							</tr>
							
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" class="findEmpNm" name="empNm" placeholder="담당자" style="width: 170px;" value="${quoteView.empNm}" />
									<span id="findEmpNmError" class="error"></span>
									<input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd" value="${quoteView.empCd}" />
								</td>
							</tr>
							
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" name="comNm" placeholder="거래처명" style="width: 170px;" value="${quoteView.comNm}" />
									<span id="findComNmError" class="error"></span>
									<input type="hidden" id="findComCd" class="comCd"  name="comCd" value="${quoteView.comCd}"/>
								</td>
							</tr>
							
								<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>수량</th>
								<th>단가</th>
								
							</tr>
						</thead>
								
								<input type="hidden" value="${quoteView.qteCd}" name="qteCd"/>
						<tbody>
						`;
						quoteView.quoteItem.forEach(function (item, index) {
        				makeTable +=
						  `  
						
								<tr>
								<td>
									<input type="text" id="findItemCd" name="quoteItem[`+index+`].itemCd" class="iText" value="${item.itemCd}"/>
									<span id="quoteItem.itemCd" class="error"></span> 
								</td>
								<td>
									<input type="text" id="findItemNm" name="quoteItem[`+index+`].item.itemNm" class="iText" value="${item.item.itemNm}"/>
									<span id="quoteItem.item.itemNm" class="error"></span> 
								</td>
								<td>
									<input type="number" id="qty" name="quoteItem[`+index+`].qteQty" class="iText" style="width: 120px" value="${item.qteQty}"/>
									<span id="quoteItem.qteQty" class="error"></span>
								</td>
								<td>
									<input type="number" id="uprc" name="quoteItem[`+index+`].qteUprc" class="iText" style="width: 120px" value="${item.qteUprc}"/>
									<span id="quoteItem.qteUprc" class="error"></span>
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
					$('#quoteModal .modal-body').html(makeTable);

					// 모달 열기
					$('#quoteModal').modal('show');

					$("#quoteForm").attr("method","post");
					
					
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
						//console.log(this);
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
				console.log("품목명",selectedItemNm);
	            // itemWindow 모달 닫기
	            $('#findItemModal2').modal('hide');
	            
			});
	
});
	
	
	
	function afterDataUpdate() {
		// 수정 후에 현재 페이지로 이동
		let qteListDataTable = $('#quoteListDataTable').DataTable();
		qteListDataTable.page(currentPageNumber - 1).draw(false);
		// 페이지 번호를 변경하고 다시 그리기(draw)를 실행하여 해당 페이지로 이동
	}
	
	function reloadDataTable() {
    let qteListDataTable = $('#quoteListDataTable').DataTable();
    qteListDataTable.ajax.reload(null, false);
	}
	
	//insertForm  /  updateForm
	$(document).on('submit', '#quoteForm', function(e) {
		/*
		e.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;

		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		*/
		/*json : {
			"qteDate":"2023-12-13","empNm":"조현준","empCd":"E201001110501","comNm":"㈜트린프","comCd":"COM036",
			"quoteItem":{"0.itemCd":"","0.item.itemNm":"","0.qteQty":"","0.qteUprc":"","1.itemCd":"D015VC005","1.item.itemNm":"테스트품목입니다","1.qteQty":"2","1.qteUprc":"7"},
			"itemCd":"dsaf","qteQty":"1","qteUprc":"3"}*/
		//console.log("json : " + json);

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
					alert("견적서 수정 완료!!");
					$('#quoteModal').modal('hide');
					updateQuoteListInDOM(data.qteCd, data);
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
			$("#quoteForm").submit();
			/*
			$.ajax({
				url: url,
				type: "POST",
				data: json,				
				contentType: 'application/json;charset=utf-8',
				success: function(res) {
					alert("견적서 등록 완료!!");
					console.log("인서트확인:",res);
							$('#quoteDate').val('');
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



