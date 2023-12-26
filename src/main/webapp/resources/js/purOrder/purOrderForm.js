/**
 * 
 * @author 유선영
 * @since 2023. 11. 29.
 * @version 1.0
 * 
 *         
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 29.    유선영      최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          
 */
/*
	serializeJson 쓰면되는데 그냥 이거도 써
*/
$.fn.serializeObject = function() {
  "use strict"
  var result = {}
  var extend = function(i, element) {
    var node = result[element.name]
    if ("undefined" !== typeof node && node !== null) {
      if ($.isArray(node)) {
        node.push(element.value)
      } else {
        result[element.name] = [node, element.value]
      }
    } else {
      result[element.name] = element.value
    }
  }

  $.each(this.serializeArray(), extend)
  return result
}


let domainName = location.href.split("/")[2];

let alarmSocket =  new WebSocket(`ws://${domainName}/purOrdReq`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함

// 연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
const fSocOpen = () =>{
	console.log("연결성공");
	//alarmSocket.send("서버야 내 메세지 받앙");

}

alarmSocket.onopen = fSocOpen;
alarmSocket.onerror = (error) => {
  console.error("WebSocket 오류:", error);
}


let fSend = function() {
	
	alarmSocket.send(JSON.stringify({
	    cmd: "purOrdReq",
	    receiver: "구매부"
	})); 
	
}

let cPath = $('.pageConversion').data('contextPath');

	function fn_paging(page){
		
		searchForm.page.value = page;
		
		let datas = $("#searchForm").serializeObject();
		let orderFrag = datas.orderFrag;
		console.log("datas",datas);
		
		console.log("orderFrag",orderFrag);
		
		$.ajax({
			url: `${cPath}/item`,
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
							<tr id="trColspan">
								<td class="text-nowrap" colspan='2'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('#dataList').html(trTags);
				if(orderFrag==='Y'){
					$('.hide').css('display', ''); 
					
	/*				$('#dataList td a').removeAttr('href'); // a 태그의 href 속성 제거
    				$('#dataList td a').contents().unwrap(); */
					//tr에서 안전재고와 재고를 비교해서 class를 주어 css를 통제
					$('#dataList td.transTdTag a.selectItem').css({
					    'color': 'rgba(128, 128, 128, 1.4)', // 약한 회색, 마지막 값은 투명도입니다 (0에 가까울수록 투명)
					    'text-decoration': 'none', // 원한다면 텍스트에 밑줄 제거할 수 있습니다
						'pointer-events': 'none'
					});
					$('#dataList tr').each(function() {
					    var qtyText = $(this).find('.qty').text(); // qty 값을 가져옵니다.
						var sQtyText = $(this).find('.sQty').text(); // sQty 값을 가져옵니다.
						
						// 쉼표를 제거한 후 정수로 변환합니다.
						var qty = parseInt(qtyText.replace(/,/g, ''), 10);
						var sQty = parseInt(sQtyText.replace(/,/g, ''), 10);

					
					    if (qty <= sQty) {
					        $(this).addClass('lessQty'); // qty가 sQty보다 작을 때 해당 tr에 'lessQty' 클래스를 추가합니다.
					    }
					});
				}else{
					$('#dataList tr').each(function() {
						$(this).removeClass('lessQty');
					});
					$('.hide').css('display', 'none'); 
				}
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
		
	}
	
// 품목 검색 모달 테이블 생성
	let makeItemTrTag = function (item) {
	    let trTag = `
				<tr>
					<td class='hide'><input type="checkbox" name="checkItem"></td>
					<td>${item.itemCd}</td>
					<td class='transTdTag'><a href="javascript:;" class="selectItem"
						data-selected-value="${item.itemNm}" data-selected-cd="${item.itemCd}"> ${item.itemNm} </a>
					</td>
					<td class='hide qty'>${item.itemQty > 0 ? addCommas(item.itemQty) : 0}</td>
					<td class='hide sQty'>${item.itemSafeQty > 0 ? addCommas(item.itemSafeQty) : 0}</td>
				</tr>
		    `;
		
		return trTag;
	};
let addCommas = function(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};	
/*
function fn_paging(page){
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
*/
$(function(){
	// 품목 모달 이벤트 생성
	clickItemModalEvent();
	let orderFrag = $("#orderFrag").val();
	let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	
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
							var deptNm = $(this).closest('tr').find('.deptNm').text();

							$('#findEmpCd').val(empCd);
							$('#findEmpNm').val(empNm);
							$('#findDeptNm').val(deptNm);
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
	
	// 품목 모달 
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		
		let datas = $(this).serialize();
	
		$.ajax({
			url: `${cPath}/item`,
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
								<td class="text-nowrap" colspan='5'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('#dataList').html(trTags);
				$('.hide').css('display', 'none'); 
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
		/*let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();*/
		fn_paging(1);
	});
	//itemCd에 값이 입력될때 혹시 span에 글이 있다면 지우는 역할	
	$('.findItemCd').on('click input', function() {
		$('#itemNullError').empty();
	});
	
	// 저장 버튼 이벤트
	$("#insertBtn").on("click", function() {
		let formData = {};
		let reqList = [];
		let reqForm = {};
		//id가 Error로 끝나는것을 전부 공백으로 변환해줌
		$("[id$='Error']").empty();
		
		formData['preqDueDate'] = $('#findPreqDueDate').val();
		formData['empCd'] = $('#findEmpCd').val();
		formData['empNm'] = $('#findEmpNm').val();
		formData['deptNm'] = $('#findDeptNm').val();
	    // 각 행의 데이터를 객체로 구성하여 배열에 추가
	    $(".purOrderRow").each(function() {
			reqForm = {};
			
			itemCdVal = $(this).find('.findItemCd').val();
			itemNmVal = $(this).find('#findItemNm').val();
			reqItemQty = $(this).find('#findReqItemQty').val();
			
			if(itemCdVal != '' || itemNmVal != '' || reqItemQty !=''){
		        // reqItem 객체 구성
		        reqForm = {
		            'itemCd': itemCdVal,
		            'itemNm': itemNmVal,
		            'reqItemQty': reqItemQty,
		            'reqNote': $(this).find('#findReqNote').val(),
		        };
				reqList.push(reqForm);
			}
	    });
		formData['reqItem'] = reqList;
		console.log(formData);
		
		$.ajax({
				url: `${cPath}/pur/create`,
				type: "POST",
				data: JSON.stringify(formData),
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},
				success: function(res) {
					
					console.log("asdasda",res);
					console.log(res.totalValue.rslt);
					if(res.totalValue.rslt == "success"){
						fSend();
						Swal.fire({
							  title: '등록완료!',
							  text: '등록이 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
						})
						clearTableInputs();
					}else{
						console.log(res.totalValue);
						$.each(res.totalValue, function(fieldName, errorMessage) {
							let errorId = fieldName;
							$('#' + errorId + 'Error').text(errorMessage).css('display', 'block');
						});
						Swal.fire({
							title: '등록실패!',
							text: '등록이 실패했습니다.',
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

	
	function clickItemModalEvent(){
	    $(document).off('click', '#findItemNm, .findItemCd'); // 이벤트 등록 전에 이전 이벤트를 해제
	    $(document).on('click', '#findItemNm, .findItemCd', function () {
	        $('#tdColspan').empty();
	        $("#orderFrag").val("");
	        $('#divData').empty();
	        $('.hide').css('display', 'none'); 
			$('#dataList td.transTdTag a.selectItem').css({
			    'color': 'blue',
			    'pointer-events': 'auto'
			});

			$('#dataList tr').each(function() {
				$(this).removeClass('lessQty');
			});
	        itemWindowModal.show();
	        
	        // 현재 클릭된 행에 대한 데이터 가져오기
	        let currentRow = $(this).closest('tr');
	        let inputItemCd = currentRow.find('.findItemCd');
	        let inputItemNm= currentRow.find('#findItemNm');
	
	        $(document).off('click', '.selectItem');
	        $(document).on('click', '.selectItem', function () {
	            // 선택한 item의 정보 가져오기
	            let selectedItemCd = $(this).data('selected-cd');
	            let selectedItemNm = $(this).data('selected-value');
	
	            // 현재 클릭된 행의 input에 값을 추가
	            if (!checkForDuplicates(selectedItemCd, selectedItemNm)) {
	                inputItemCd.val(selectedItemCd);
	                inputItemNm.val(selectedItemNm);
	
	                // itemWindow 모달 닫기
	                $('#itemWindow').modal('hide');
	
	                inputItemNm.trigger('input');
	            }else{
					Swal.fire({
							title: '중복된 품목입니다',
							text: '등록이 실패했습니다.',
							icon: 'error',
							confirmButtonText: '확인'
						})
				} 
	        });
	    });
	}
	
	// 중복 값을 체크하는 함수
	function checkForDuplicates(selectedItemCd, selectedItemNm) {
	    let isDuplicate = false;
	
	    // 여기서는 각 행마다 품목코드와 품목명을 확인하여 중복을 체크합니다.
	    $('#purTable tbody tr').each(function() {
	        let row = $(this);
	        let existingItemCd = row.find('.findItemCd').val();
	        let existingItemNm = row.find('.findItemNm').val();
	
	        if (existingItemCd === selectedItemCd && existingItemNm === selectedItemNm) {
	            isDuplicate = true;
	            return false; // 중복이 발견되면 반복문 종료
	        }
	    });
	
	    return isDuplicate;
	}
	function clearTableInputs() {
        // 입력 필드들을 찾아서 값 비우기
        $('#purTable input').val('');

        // 에러 메시지 영역 비우기
        $('.error').text('');

		// 첫 번째 행을 제외한 나머지 행 삭제
		$('#purTable tbody tr.purOrderRow:not(:first)').remove();
    }

	//재고 불러오기 버튼 클릭시
	$('#uploadBtn').on('click',function(){
		itemWindowModal.show();
		$('#divData').empty();
		// 품목 모달 
		$("#orderFrag").val("Y");
		fn_paging(1);	
		$('.hide').css('display', '');
		let tdData =`
			<div class="d-flex justify-content-center">
			    <button id="checkItems" class="btn btn-primary" type='button'>선택저장</button>
			</div>
		`;
		$('#divData').html(tdData); 
		
	})
	
	
	//재고불러오기로 선택된 아이템 input에 바인딩
	$(document).on('click', '#checkItems', function(){
	    let checkedItems = []; // 체크된 항목들을 담을 배열
	
	    // dataList 안에 있는 체크된 체크박스들을 선택하여 배열에 추가
	    $('#dataList input[name="checkItem"]:checked').each(function(){
	        let itemCd = $(this).closest('tr').find('td:nth-child(2)').text(); // itemCd 값을 가져옴
	        let itemNm = $(this).closest('tr').find('td:nth-child(3)').text().trim(); // itemNm 값을 가져옴
	        checkedItems.push({ itemCd: itemCd, itemNm: itemNm }); // 객체로 묶어서 배열에 추가
	    });
	
	    let emptyRows = $('#purTable tbody tr:has(.findItemCd:empty)');
	
	    checkedItems.forEach(function(item) {
	        let filledRow = false;
	        let duplicateFound = false;
	
	        emptyRows.each(function() {
	            if (!filledRow && !duplicateFound) {
	                if (!$(this).find('.findItemCd').val().trim()) {
	                    // 빈 행에 값이 없는 경우
	                    $(this).find('.findItemCd').val(item.itemCd);
	                    $(this).find('.findItemNm').val(item.itemNm);
	                    filledRow = true;
	                } else {
	                    // 중복된 값이 있는 경우
	                    let rowItemCd = $(this).find('.findItemCd').val().trim();
	                    let rowItemNm = $(this).find('.findItemNm').val().trim();
	                    if (rowItemCd === item.itemCd && rowItemNm === item.itemNm) {
	                        duplicateFound = true;
	                    }
	                }
	            }
	        });
	
	        if (!filledRow && !duplicateFound) {
	            let newRow = $('.purOrderRow').last().clone(); // 새로운 행 생성
	            newRow.find('.findItemCd').val(item.itemCd);
	            newRow.find('.findItemNm').val(item.itemNm);
	            newRow.find('.findReqNote').val('');
	            newRow.find('.findReqItemQty').val('');
	            $('#purTable tbody').append(newRow); // 테이블에 추가
	        }
	    });
	    
	    // 배열에 담긴 체크된 항목들을 확인
	    console.log(checkedItems);
		itemWindowModal.hide();
	});

	//체크박스로 행 선택
    $('#selectBtn').on('click', function(){
	    let rows = $('.purOrderRow');
	
	    $('.purOrderRow input[name="checking"]:checked').each(function(){
	        let row = $(this).closest('tr'); // 현재 체크박스가 속한 행을 찾음
	
	        // 첫 번째 행이 아닌 경우에만 삭제
	        if (!row.is('.purOrderRow:first-child')) {
	            row.remove(); // 해당 체크박스가 속한 행을 삭제
	        } else {
	            // 첫 번째 행이라면 값만 비워줌
	            row.find('input[type="text"], input[type="number"]').val('');
	        }
	    });
	
	    let remainingRows = $('.purOrderRow');
	    if (remainingRows.length === 0) {
	        let newRow = $('<tr class="purOrderRow">' + 
	            '<td><input type="checkbox" name="checking"></td>' + 
	            '<td><input type="text" required class="iText findItemCd" autocomplete="off" id="${itemCdId}" name="itemCd" style="width: 100%" value=""></td>' +
	            '<td colspan="2"><input type="text" required class="iText findItemNm" autocomplete="off" id="findItemNm" name="itemNm" style="width: 100%" value=""></td>' +
	            '<td><input type="number" required class="iText" id="findReqItemQty" autocomplete="off" name="reqItemQty" style="width: 100%" min=0 value=""></td>' +
	            '<td colspan="2"><input type="text" class="iText" id="findReqNote" name="reqNote" style="width: 100%" value=""></td>' +
	            '</tr>');
	
	        $('#purTable tbody').append(newRow);
	    }
	});
	
	//행추가
	$('#createTrBtn').on('click', function() {
	    let firstRow = $('#purTable tbody tr:last').clone();
		firstRow.find('input').val('');
	    $('#purTable tbody').append(firstRow);
	});






});