/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 11. 22.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 22.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

function deleteRow(btn) {
	  var row = btn.parentNode.parentNode;
	  row.parentNode.removeChild(row);
	}
	
// 알람

let domainName = location.href.split("/")[2];

let alarmSocket =  new WebSocket(`ws://${domainName}/orderPlay`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함

// 연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
const fSocOpen = () =>{
	console.log("연결성공");
	//alarmSocket.send("서버야 내 메세지 받앙");

}



const fSocMsg = () => {
	
/*   alert("mailSend.js 서버에서 온 메세지" + event.data);
  document.querySelector("#toast-body").innerHTML += event.data;
   var toast = new bootstrap.Toast(document.getElementById('liveToast'));
   toast.show();*/
	
}


alarmSocket.onopen = fSocOpen;
alarmSocket.onerror = (error) => {
  console.error("WebSocket 오류:", error);
}


let fSend = function(res) {
			//alarmSocket.send(jbTxt.value);
			console.log("resres",res);
			
			
			var sender = res.mailSen;
			var reciever = res.mailRec;
			var senNm = res.senNm;
			var recNm = res.recNm;
			
			alarmSocket.send(JSON.stringify({
			    cmd: "orderPlay",
			    sender: sender,
			    receiver: reciever,
				senNm:senNm,
				recNm:recNm
			})); 
			
			
			
		}

//서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
alarmSocket.onmessage = fSocMsg;

	
	
	
	
	
	
	

$(function() {
	
	const autoBinding = document.getElementById('autoBinding');
		// excelBtn을 클릭했을 때의 동작을 정의합니다.
		autoBinding.addEventListener('click', function() {
		   
			console.log("히히 ㅠㅠ");
			
		    document.getElementById('pordDate').value = '2023-12-14';
		
		    document.getElementById('dueDate').value = '2023-12-21';
		
		    document.querySelector('.findEmpNm').value = '유선영';
		    document.querySelector('.findEmpCd').value = '2013020001';
		    
		});
	
	
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	

	let cPath = $('.pageConversion').data('contextPath');

	//사원리스트 출력함수
	let makeEmpTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="empCd">${rslt.empCd}</td>
					        <td class="empNm"><a href="#empNm">${rslt.empNm}</a></td>
					     	<td class="deptNm">${rslt.deptNm}</td>
						</tr>	
		`;
		return trTag;
	}
	
	
	//사원 검색 모달
	$(document).on('click', '#findEmpNm', function(e) {
		e.preventDefault();
		
		$('#findEmpModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/orderPlay/emp`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					console.log(resp);
					let empList = resp;
					let trTags = "";

					if (empList?.length > 0) {
						$.each(empList, function() {
							trTags += makeEmpTrTag(this);
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

	//회사리스트 출력함수
	let makeDealComTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="comCd">${rslt.comQte.company.comCd}</td>
					        <td class="comNm"><a href="#comNm">${rslt.comQte.company.comNm}</a></td>
						</tr>	
		`;
		return trTag;
	}
	
	//거래처 검색 모달
	$(document).on('click', '#findComNm', function(e) {
		e.preventDefault();

		// 모달 열기
		$('#findDealComModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/orderPlay/dealCom`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					console.log(resp);
					let dealComList = resp;
					let trTags = "";

					if (dealComList?.length > 0) {
						$.each(dealComList, function() {
							trTags += makeDealComTrTag(this);
						});

					} else {
						trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='4'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
					}

					// 모달 내용 업데이트
					$('#findDealComModal .list').html(trTags);

					$('#findDealComDataTable').DataTable({
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
	
	//선택된 담당자명 담당자에 입력해주기
	$(document).on('click', '.empNm', function(e) {
		e.preventDefault();

		var empCd = $(this).closest('tr').find('.empCd').text();
		var empNm = $(this).closest('tr').find('.empNm').text();

		$('#findEmpCd').val(empCd);
		$('#findEmpNm').val(empNm);
		$('#findEmpModal').modal('hide');
		
	});

	//선택된 회사명 회사에 입력해주기
	$(document).on('click', '.comNm', function(e) {
		e.preventDefault();

		var comCd = $(this).closest('tr').find('.comCd').text();
		var comNm = $(this).closest('tr').find('.comNm').text();

		$('#findComCd').val(comCd);
		$('#findComNm').val(comNm);
		
		
		 // new-row 클래스를 가진 tr 안의 입력 필드를 비우기
	    $('.new-row').each(function() {
        $(this).find('input[type="text"], input[type="number"]').val('');
   		 });
		$('#findDealComModal').modal('hide');
		
	});

	// 선택된 품목 정보를 입력
	$(document).on('click', '.itemNm', function(e) {
		e.preventDefault();

	    var itemCd = $(this).closest('tr').find('.itemCd').text();
	    var itemNm = $(this).closest('tr').find('.itemNm').text();
	    var inUprc = $(this).closest('tr').find('.inUprc').text();
	    var itemUnit = $(this).closest('tr').find('.itemUnit').text();
	    var comCd = $(this).closest('tr').find('.comCd').val();
	    var comNm = $(this).closest('tr').find('.comNm').val();
	
	    // 모든 .new-row를 검색하여 itemNm이 이미 존재하는지 확인
	    var itemNmExists = false;
	    $('.new-row').each(function() {
	        var $row = $(this);
	        var $itemNmInput = $row.find('input[name="itemNm"]');
	        if ($itemNmInput.val() === itemNm) {
	            itemNmExists = true;
	            return false; // itemNm이 이미 존재하므로 반복문 종료
	        }
	    });
		
	
	    // itemNm이 존재하지 않을 경우에만 값을 추가
	    if (!itemNmExists) {
	        $('.new-row').each(function() {
	            var $row = $(this);
	            var $itemNmInput = $row.find('input[name="itemNm"]');
	            if ($itemNmInput.val() === '') {
	                $row.find('input[name="itemCd"]').val(itemCd);
	                $itemNmInput.val(itemNm);
	                $row.find('input[name="itemUnit"]').val(itemUnit);
	                $row.find('input[name="inUprc"]').val(inUprc);
	                if (typeof comCd !== 'undefined' && typeof comNm !== 'undefined') {
	                    $('#findComCd').val(comCd);
	                    $('#findComNm').val(comNm);
	                }
	                return false; // 처리 완료 후 반복문 종료
	            }
	        });
	    }
	
	    $('#findItemModal1').modal('hide');
	});


	//품목 출력함수
	let makeItemListTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="itemCd">${rslt.item.itemCd}</td>
					        <td class="itemNm"><a href="#itemNm">${rslt.item.itemNm}</a></td>
					     	<td class="inUprc">${rslt.inUprc}</td>
					     	<td class="itemUnit">${rslt.item.itemUnit}</td>
						</tr>	
		`;
		return trTag;
	}
	//품목 출력함수
	let makeItemSpecialListTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="itemCd">${rslt.item.itemCd}</td>
					        <td class="itemNm"><a href="#itemNm">${rslt.item.itemNm}</a></td>
					     	<td class="inUprc">${rslt.inUprc}</td>
					     	<td class="itemUnit">${rslt.item.itemUnit}</td>
							<input type="hidden" class="comCd" value="${rslt.comQte.company.comCd}"/>
				            <input type="hidden" class="comNm" value="${rslt.comQte.company.comNm}"/>
						</tr>	
		`;
		return trTag;
	}
	
	var rowNumber;
	
	$(document).on('click', '.new-row input[name="itemCd"]', function(e) {
		e.preventDefault();
		rowNumber = $(this).closest('.new-row').data('row'); // 클릭된 input의 부모인 tr의 data-row 값을 가져옴

		var comCd = $('#findComCd').val();
		var comNm = $('#findComNm').val();
		//var itemCd = $('#findItemCd').val();
		//var itemNm = $('#findItemNm').val();
		

		if (comCd && comNm) {
			// comCd와 comNm이 모두 채워져 있는 경우
			// Ajax 요청을 보내는 코드 작성
			// 모달 열기
			$('#findItemModal1').modal('show');
			try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: ` ${cPath}/orderPlay/dealItem/${comCd}`,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						console.log("결과:",resp);
						let itemList = resp;
						let trTags = "";

						if (itemList?.length > 0) {
							$.each(itemList, function() {
								//console.log("this",this);
								trTags += makeItemListTrTag(this);
							});
							let dataTable = $('#findItemDataTable1').DataTable();
                        	dataTable.clear().destroy(); // 기존 테이블 제거

							// 모달 내용 업데이트
							//alert(trTags);
							// 데이터 테이블 사용법 , 직접 테이블을 만들던가
							$('#findItemModal1 .list').html(trTags);

						} else {
							trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='3'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
						}
						// 모달 내용 업데이트
						$('#findItemModal1 .list').html(trTags);

						$('#findItemDataTable1').DataTable({
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

		} else {
			// comCd나 comNm 중 하나라도 비어 있는 경우
			// 다른 처리를 하거나 오류 메시지를 보여줄 수 있음
			$('#findItemModal1').modal('show');
			try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: ` ${cPath}/orderPlay/dealItem`,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						console.log("체크 : ",resp);
						let itemList = resp;
						let trTags = "";

						if (itemList?.length > 0) {
							$.each(itemList, function() {
								trTags += makeItemSpecialListTrTag(this);
							});

							// 모달 내용 업데이트
							$('#findItemModal1 .list').html(trTags);

							

						} else {
							trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='3'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
						}

						// 모달 내용 업데이트
						$('#findItemModal1 .list').html(trTags);

						$('#findItemDataTable1').DataTable({
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
		}
		
	});
	
	
	
	
	let rowCounter = 1; // 새로운 행을 구분하기 위한 카운터
	// 새로운 행 추가 버튼 이벤트
		$('#addRow').on('click', function(e) {
		    e.preventDefault();
		    // 새로운 행 생성
		    var newRow = `<tr class="new-row" data-row="${rowCounter}">
				          <td><input type="text" class="iText" class="itemCd" name="itemCd"></td>
				          <td><input type="text" class="iText" name="itemNm"></td>
				          <td><input type="text" class="iText" name="itemUnit" disabled="disabled"></td>
				          <td><input type="text" class="iText" name="inUprc" disabled="disabled"></td>
				          <td><input type="number" class="iText" name="defQty" style="width: 120px"></td>
						  <td><button onclick="deleteRow(this)"  class="btn btn-outline-danger btn-sm deleteRowBtn">Delete</button></td>
				          </tr>`;
		    // 새로운 행 추가
		    $('#dataTable tbody').append(newRow);
			rowCounter++;
		});
		
		
		// 입력 값이 비어 있는지 확인하는 함수
		function isAnyInputEmpty() {
		    const inputs = document.querySelectorAll('.iText'); // 'iText' 클래스를 가진 모든 입력 요소 선택
		    for (let i = 0; i < inputs.length; i++) {
		        if (inputs[i].value === '') {
		            return true; // 입력값이 비어 있으면 true 반환
		        }
		    }
		    return false; // 모든 입력이 값이 채워져 있으면 false 반환
		}
		
		$('#insertBtn').on('click', function(e) {
			e.preventDefault();
			 if (isAnyInputEmpty()) {
		        // 모든 입력값을 채우라는 경고 표시
		        alert('모든 입력 필드에 값을 입력해주세요.');
		    } else {
		        // 모든 입력값이 채워져 있으면 orderPlayEnrollData 함수 실행
		        orderPlayEnrollData();
		    }
			
		});
		
		function orderPlayEnrollData(){
			const findComCdInput = document.querySelector('.findComCd');
			const findEmpCdInput = document.querySelector('.findEmpCd');
			const pordDateInput = document.querySelector('.pordDate');
			const dueDateInput = document.querySelector('.dueDate');

			// input 요소의 값(value) 가져오기
			const findComCdValue = findComCdInput.value;
			const findEmpCdValue = findEmpCdInput.value;
			const pordDateValue = pordDateInput.value;
			const dueDateValue = dueDateInput.value;
			
			var rows = $('.itemList').find('tr.new-row');
			var rowData = [];
			
			console.log("rows",rows);
			
			rows.each(function() {
			    var row = $(this);
			    var itemCd = row.find('input[name="itemCd"]').val();
			    var itemNm = row.find('input[name="itemNm"]').val();
			    var itemUnit = row.find('input[name="itemUnit"]').val();
			    var pordUprc = row.find('input[name="inUprc"]').val();
			    var pordQty = row.find('input[name="defQty"]').val();
			
			    console.log('itemCd:', itemCd);
			    console.log('itemNm:', itemNm);
			    console.log('itemUnit:', itemUnit);
			    console.log('pordUprc:', pordUprc);
			    console.log('pordQty:', pordQty);

				var dataObj = 	{
					'itemCd' : itemCd,
					'pordQty' : pordQty,
					'pordUprc' : pordUprc,
					'pordDate' : pordDateValue,
					'dueDate' : dueDateValue,
					'comCd' : findComCdValue,
					'empCd' : findEmpCdValue
				};
				rowData.push(dataObj);
			});
			
			console.log("rowData",rowData);
			
			$.ajax({
				url : `${cPath}/orderPlay/insertOrder`,
				type: 'POST', // POST 방식으로 요청
			    data: JSON.stringify(rowData), // 데이터를 JSON 형태로 변환하여 전송
			    contentType: 'application/json', // 전송할 데이터 유형 설정
			    success: function(response) {
			        // 성공적으로 응답 받았을 때 실행되는 부분
					fSend(response);
					Swal.fire({
					  icon: "success",
					  title: "등록 !",
					  showConfirmButton: false,
					  timer: 1500
					});
					
					
					setTimeout(function() {
			            window.location.href = `${cPath}/orderPlay/enroll`;
			        }, 1500); // 2000ms (2초) 후에 실행됨
					

			    },
			    error: function(error) {
			        console.error('Ajax 요청 실패:', error);
			    }
				
			});
			


		}
		
		
		
		
		
		
		
		
});	 