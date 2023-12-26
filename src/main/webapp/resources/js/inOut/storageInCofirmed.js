/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 28.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 28.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */


/*


let domainName = location.href.split("/")[2];

let alarmSocket =  new WebSocket(`ws://${domainName}/storIn`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함

// 연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
const fSocOpen = () =>{
	console.log("연결성공");
	//alarmSocket.send("서버야 내 메세지 받앙");

}



const fSocMsg = () => {

}


alarmSocket.onopen = fSocOpen;
alarmSocket.onerror = (error) => {
  console.error("WebSocket 오류:", error);
}

console.log("ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ")

let fSend = function(res) {
			//alarmSocket.send(jbTxt.value);
			console.log("resres");
			console.log(res);
			
			
			var sender = res.mailSen;
			var reciever = res.mailRec;
			var senNm = res.senNm;
			var recNm = res.recNm;
			console.log("아래 확인해봐ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ")
			console.log(senNm);
			console.log(recNm);
			
			alarmSocket.send(JSON.stringify({
				cmd: "storIn",
				sender: sender, //보내는 사람 아이디
				receiver: reciever, //받는사람 사람 아이디
				senNm:senNm, //
				recNm:recNm // 
			})); 
			
			
			
		}

//서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
alarmSocket.onmessage = fSocMsg;


*/




$(function() {
	let cPath = $('.pageConversion').data('contextPath');
	getView();


	let detailWindowModal = new bootstrap.Modal($('#purWindow')[0]);

	function getView() {
		let baseUrl = `${cPath}/storInOut/in`;
		$.ajax({
			url: baseUrl,
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function(resp) {
				let inList = resp.inList;
				console.log(inList);
				let trTags = "";

				if (inList?.length > 0) {
					$.each(inList, function() {
						trTags += makeTrTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='9'>입고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}


				$('.list').html(trTags);
				$('#buttonDiv').html("<button type='submit' class='btn btn-primary' value='입고'>입고확정</button>");


				$('#inTable').DataTable({
					paging: true,
					searching: true,
					lengthChange: false,
					info: false,
					ordering: false
				});

			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	} // List 함수끝

	//List에 body영역 만들어주는 함수
	const makeTrTag = function(rslt) {

		let trTag = `
	        <tr>
	            <td class='rdrecCdValue'><a id='detailId' href="javascript:void(0)">${rslt.pordCd}</a></td>
	            <td>${rslt.comNm}</td>
	            <td>${rslt.itemNm}</td>
	            <td>${rslt.dueDate}</td>
	            <td class="pordQtyInput">${rslt.pordQty}</td>
	            <td><input type='text' class="rmstQtyValue" name='rmstQty' style="width: 80px;" value=${rslt.pordQty}></td>
	            <td><input type='text' class="selectedWareNm" data-bs-target="#wareWindow" data-bs-toggle="modal" id="wareNm" autocomplete="off" style="width: 80px;"></td>
	            <td><input type='text' id="secCd" class="selectedSector" readOnly style="width: 80px;"></td>

	            <td><input type='text' name='rmstNote'></td>
							
				<input type='hidden' name='pordCd' value='${rslt.pordCd}'/>
				<input type='hidden' name='pordQty' value='${rslt.pordQty}'/>
				<input type='hidden' name='itemCd' value='${rslt.itemCd}'/>
				<input type='hidden' name='dueDate' value='${rslt.dueDate}'/>
				<input type='hidden' class="wareValue" name='wareCd' value='${rslt.wareCd}'/>
				<input type='hidden' class="sectorValue" name='secCd2' value='${rslt.secCd}'/>
	        </tr>    
	    `;
		return trTag;
	};





	let addCommas = function(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};
	let makeDetailTag = function(rslt) {

		let trTag = `
	        <tr>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.itemCd}"></td>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.itemNm}"></td>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.itemUnit}"></td>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.pordQty > 0 ? addCommas(rslt.pordQty) : 0}"></td>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.pordUprc > 0 ? addCommas(rslt.pordUprc) : 0}"></td>
	            <td><input class="iText inputNoneBorder" type="text" value="${rslt.MULTIPLY > 0 ? addCommas(rslt.MULTIPLY) : 0}"></td>
					<input type="hidden" value="${rslt.empCd}"/>
					<input type="hidden" value="${rslt.comCd}"/>
					
	        </tr>
	    `;
		return trTag;
	};

	$(document).on('click', '#detailId', function() {
		detailWindowModal.show();

		let pordCd = $(this).text();

		$.ajax({
			url: `${cPath}/scheduledStock/in/${pordCd}`,
			method: "GET",
			success: function(res) {

				let stockDetail = res.stockDetail;
				console.log(stockDetail);
				/*
					각 발주서 기본데이터 출력
				*/
				//일자
				let pordDate = stockDetail[0].pordDate;
				//담당자
				let empNm = stockDetail[0].empNm;

				//거래처
				let comNm = stockDetail[0].comNm;

				//납기일자
				let dueDate = stockDetail[0].dueDate;


				$('#pordDate').val(pordDate);
				$('#empNm').val(empNm);
				$('#comNm').val(comNm);
				$('#dueDate').val(dueDate);

				console.log(stockDetail);
				let trTags = `
					<tr>
						<th>품목코드</th>
						<th>품목명</th>
						<th>단위</th>
						<th>수량</th>
						<th>단가</th>
						<th>합계</th>
					</tr>
				`;

				if (stockDetail != null) {
					$.each(stockDetail, function() {
						trTags += makeDetailTag(this);
					});

				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='6'>입고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}


				trTags += `
					<tr>
						<td colspan='3'>합계 :</td>
						<td><input class="iText inputNoneBorder" type="text" value="${stockDetail[0].countQty > 0 ? addCommas(stockDetail[0].countQty) : 0}"></td>
						<td colspan='1'></td>
						<td><input class="iText inputNoneBorder" type="text" value="${stockDetail[0].sumValue > 0 ? addCommas(stockDetail[0].sumValue) : 0}"></td>
					<tr>
				`
				$('#detailList').html(trTags);
			},
			error: function(request, status, error) {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
			}
		})
	});

	/*
		모달이 열릴때 이벤트를 잡아와서 ajax를 돌려서 ware와 sector의 정보를 가져와서 Tree구조로 보여줌
		
	*/
	$(document).on('click', '#wareNm', function(event) {
		let baseUrl = `${cPath}/stor`;
		let arrays = [];
		$.ajax({
			url: baseUrl,
			method: "GET",
			success: function(res) {
				let wareList = res.wareList;
				console.log("ppp", wareList);

				let ckLength = wareList.length;
				let ckCnt = 0;
				wareList.forEach(function(item, index) {
					console.log("item", item);
					if (item.wareTemp === 'Y') {
						arrays.push({
							"id": item.wareCd,
							"parent": "#",
							"text": item.wareNm,
							"icon": "far fa-building"
						});
					}
					$.ajax({
						url: `${cPath}/sector/${item.wareCd}`,
						method: "GET",
						//					async:false,
						success: function(resp) {
							ckCnt++;
							let secWareList = resp.wareList;
							let sectorValue = secWareList[0]?.wareSecList;
							if (sectorValue !== null && sectorValue !== undefined) {
								sectorValue.forEach(function(i, v) {
									arrays.push({
										"id": i.secCd + i.wareCd + v,
										"parent": i.wareCd,
										"text": i.secCd,
										"icon": "fas fa-cubes"
									});
								});
							}

							if (ckCnt == ckLength) {
								//alert("다 끝났어용");
								$("#jstree").jstree({
									'core': {
										'data': arrays,
										"check_callback": true,  // 요거이 없으면, create_node 안먹음
									}
								});
								$('#jstree').on('select_node.jstree', function(e, data) {
									// jstree에서 노드를 클릭했을 때 발생하는 이벤트
									let selectedNode = data.node;
									let inputData = `
										<div class="mb-3">
						                  <label class="form-label" for="parentId">창고코드</label>
						                  <input class="form-control" id="parentId" type="text" placeholder="창고코드" value='${selectedNode.parent}'/>
						                </div>
						                <div class="mb-3">
						                  <label class="form-label" for="parentNm">창고명</label>
						                  <input class="form-control" id="parentNm" type="text" placeholder="창고명" value=''/>
						                </div>
						                <div class="mb-3">
						                  <label class="form-label" for="textId">창고구역명</label>
						                  <input class="form-control" id="textId" type="text" placeholder="구역명" value='${selectedNode.text}'/>
						                </div>
						            `;

									// 선택한 노드가 자식 노드인지 확인
									if (selectedNode.parent === '#') {
										// 선택한 노드가 자식 노드인 경우에만 데이터 표시
										$('#jstree').jstree(true).open_node(data.node);

										$('#treeValue').html('');
									} else {
										console.log(data.node);
										// 다른 노드를 클릭했을 때는 데이터를 표시하지 않음
										$('#treeValue').html(inputData);
										let parentNode = $('#jstree').jstree(true).get_node(selectedNode.parent);
										let parentText = parentNode.text; // 부모 노드의 text 값

										$('#parentNm').val(parentText);

									}
								});
							}

						},
						error: function(request, status, error) {
							console.log("code: " + request.status)
							console.log("message: " + request.responseText)
							console.log("error: " + error);
						}
					})

				});


			},
			error: function(request, status, error) {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
			}
		})

	}); //ajax 끝

	// 모달이 닫힐 때 초기화
	$('#wareWindow').on('hidden.bs.modal', function(e) {
		$('#treeValue').empty();
		$('#jstree').jstree('close_all');
	});
	//수량이 입력될떄 vlaue속성을 없애야 값이 다 안넘어감
	$(document).on('input', '.rmstQtyValue', function() {
		$(this).removeAttr('value');
	});


	// 입고창고명 클릭시 이벤트를잡아와서 행의 정보가져와 데이터를 select해주는코드
	$(document).off('click', '.selectedWareNm');
	$(document).on('click', '.selectedWareNm', function() {
		let currentRow = $(this).closest('tr');
		let inputWareCd = currentRow.find('.wareValue');
		let inputWareNm = currentRow.find('.selectedWareNm');
		let inputSector = currentRow.find('.selectedSector');
		let inputSectorCd = currentRow.find('.sectorValue');

		$(document).off('click', '#savedBtn');
		$(document).on('click', '#savedBtn', function() {
			let wareValue = $('#parentId').val();
			let wareName = $('#parentNm').val();
			let sectorValue = $('#textId').val();
			inputWareNm.val(wareName);
			inputSector.val(sectorValue);
			inputWareCd.val(wareValue);
			inputSectorCd.val(sectorValue);
			//$('.selectedWareNm').val(wareName);

		});
	});


	$(document).on('submit', '#inForm', function(e) {
		e.preventDefault();

		var isValid = true;

		$('.list').find('tr').each(function() {
			var rmstQty = $(this).find('.rmstQtyValue').val();
			var pordQty = $(this).find('.pordQtyInput').text().trim();

			if (rmstQty) {
				if (rmstQty !== pordQty) {
					Swal.fire({
						title: '등록실패',
						text: '입고 예정 수량과 입고 확정 수량이 다릅니다. 입고확정 수량을 확인 후 다시 입력해주세요.',
						icon: 'error',
						confirmButtonText: '확인'
					})
					isValid = false;
					return false;
				}
			}
		});


		if (isValid) {
			let form = document.getElementById('inForm');
			let formData = new FormData(form);
			let array = [];
			let map = new Map();
			formData.forEach(function(value, key) {
				if (key === 'rmstQty') {
					if (map.size !== 0) {
						let copiedMap = new Map(map);
						// Map을 Object로 변환하여 array에 추가했음
						// 이유 : 자바에서 javaScript의 map타입을 인식하지 못했음.
						array.push(Object.fromEntries(copiedMap));
						map.clear();
					}
				}
				map.set(key, value);
			});
			if (map.size !== 0) {
				let copiedMap = new Map(map);
				// Map을 Object로 변환하여 array에 추가했음
				// 이유 : 자바에서 javaScript의 map타입을 인식하지 못했음.
				array.push(Object.fromEntries(copiedMap));
			}

			console.log("@@@array", array);

			$.ajax({
				url: `${cPath}/storInOut/in`,
				method: "POST",
				data: JSON.stringify(array),
				contentType: 'application/json',
				success: function(res) {
					console.log("res", res)
					if (res === 'ok') {
						//fSend(res);	
						Swal.fire({
							title: '입고완료',
							text: '입고가 성공적으로 완료되었습니다.',
							icon: 'success',
							confirmButtonText: '확인'
						})
						$('.list').html('');
						$('#inTable').DataTable().destroy();
						getView();
					} else {
						Swal.fire({
							title: '입고실패',
							text: '입고가 실패 하였습니다. 다시 시도해 주세요',
							icon: 'error',
							confirmButtonText: '확인'
						})
					}
				},
				error: function(request, status, error) {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
				}
			});
		}
	});
});