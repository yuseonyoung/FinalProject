/**
 * <pre>
 * 
 * </pre>
 * @author 작성자명
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

	function fn_paging(page) {
		searchForm.page.value = page;
		searchForm.requestSubmit();
		searchForm.page.value = "";
		
	}
$(function() {

	$(document).ready(function() {
		showDates();
		$('#actInven').addClass('show');
	})

	let cPath = $('.pageConversion').data('contextPath');
	let toggleSelect;
	
	const addCommas = function(num) {
       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  	};

	const removeCommas = function(num) {
       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "");
  	};


	//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let url = this.action;
		let data = $(this).serialize();
		console.log("data@@@@@@@@", data);
		$.getJSON(url + '?' + data)
			.done(function(resp) {
				console.log(resp.paging);
				let actInvenList = resp.paging.dataList;
				let trTags = null;
				if (actInvenList.length > 0) {
					$.each(actInvenList, function(idx, actInven) {
						trTags += makeTrTag(actInven);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
					 <tr>
                         <td class="text-nowrap" colspan='7'>등록된 데이터가 없습니다.</td>
                    </tr>
				`;
					$(pagingArea).empty();
				}
				$(".listBody").html(trTags);

			});
	}).submit();

	//실사재고 리스트 출력하기 위한 trtag생성
	let makeTrTag = function(rslt) {
		let actInvenViewURL = ` ${cPath}/actInven/view?what=${rslt.realCd}`;
		let itemNm = "";
		let errorStatus = "";
		let totalRinvQty = 0;

		//품목 여러건일 경우 몇건인지
		if (rslt.realCdCount > 1) {
			itemNm += ` <td class="text itemNm">${rslt.item.itemNm} 외 ${rslt.realCdCount - 1} 건</td>	`;
		} else {
			itemNm += ` <td class="text itemNm">${rslt.item.itemNm}</td>`;
		}
		console.log("@@@@@@@@@@@@rslt", rslt);
		//해당 입력건에 대한 모든 품목의 실사재고 합
		console.log("@@@@@@@@@@@@rslt.actInvenItem", rslt.actIvenItem);
		if (rslt.actIvenItem && rslt.actIvenItem.length > 0) {
			$.each(rslt.actIvenItem, function(index, item) {
				totalRinvQty += item.rinvQty;
			});
		}
		let state = function(rslt) {
			//오차 여부 찍어주기
			if (rslt.actIvenItem && rslt.actIvenItem.length > 0) {
				let yState = 0;
				$.each(rslt.actIvenItem, function(index, item) {
					console.log("item.itemWare.wareQty", item.itemWare.wareQty);
					console.log("item.rinvQty", item.rinvQty);
					if (item.itemWare.wareQty != item.rinvQty) {
						yState++;
					} 
				})
				console.log("y값 : ", yState);
				if (yState >= 1) {
					console.log("@@@@@@떠라!!!!!")
					errorStatus += `<td class="text errorStatus" style="color:red; font-weight:bold;">Y</td>`;
				} else {
					errorStatus += `<td class="text errorStatus">N</td>`;
					console.log("여기도 먹음??");
				}
			}
			return errorStatus;
		}



		let trTag = `
	        <tr>
	            <td class="text realCd"><a href="${actInvenViewURL}">${rslt.realCd}</a></td>
	            <td class="text wareNm">${rslt.storage.wareNm}</td>
	            ${itemNm}
	            <td class="text empNm">${rslt.emp.empNm}</td>
	            <td class="number totalWareQty">${addCommas(rslt.totalWareQty)}</td>				
	            <td class="number rinvQty">${addCommas(totalRinvQty)}</td>
	             ${state(rslt)}
	        </tr>
	    `;

		return trTag;
	};

	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(':input[name=' + name + ']').val(value);
		});
		$(searchForm).submit();
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
			return year + '/' + month + '/' + day;
		}

		// 날짜를 p 태그에 표시
		document.getElementById('searchDate').innerText = formatDate(oneMonthAgo) + ' ~ ' + formatDate(today);
	}


	$(document).on('click', '.realCd a', function(e) {
		e.preventDefault();
		let realCd = $(this).text();

		let actInvenUrl = `${cPath}/actInven/view?what=${realCd}`;
		toggleSelect = 'update';

		try {
			$.ajax({
				url: actInvenUrl,
				method: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(resp) {
					let actInvenView = resp.actInvenView;
					let itemList = actInvenView.actIvenItem;
					let makeTable = "";
					let makeTrTag = "";

					function makeRows() {

						if (itemList?.length > 0) {
							$.each(itemList, function(index, item) {
								console.log("@@@@@@@@2", item.itemWare.wareQty);
								let errorNumber = item.rinvQty - item.itemWare.wareQty;
								let number = "";

								if (errorNumber == 0) {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText number" value="${addCommas(errorNumber)}" disabled="disabled" style="font-weight: bold;"/>`;
								} else if (errorNumber > 0) {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText number" value="${addCommas(errorNumber)}" disabled="disabled" style="background-color: lightskyblue; font-weight: bold;"/>`;
								} else {
									number += ` <input type="text" id="errorNumber" name="errorNumber" class="iText number" value="${addCommas(errorNumber)}" disabled="disabled" style="background-color: lightpink; font-weight: bold;"/>`;
								}

								makeTrTag += ` 
									<tr id="itemRow_${item.item.itemCd}">
	                                    <td>
	                                        <input type="text" id="findItemCd" name="itemCd" class="iText text findItemCd" value="${item.item.itemCd}" />
	                                        <span id="itemCd" class="error"></span> 
											<input type="hidden" class="hiddenItemCd" name="itemCd" value="${item.item.itemCd}"/>
											<input type="hidden" class="hiddenItemNum" name="itemNum" value="${item.itemNum}"/>
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemNm" class="iText text findItemNm" name="itemNm" value="${item.item.itemNm}"/>
	                                        <span id="itemNm" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemUnit" class="iText text findItemUnit" disabled="disabled" value="${item.item.itemUnit}"/>
	                                    </td>	
	                                    <td>
	                                        <input type="text" id="findWareQty" name="wareQty" class="iText number" style="width: 120px" value="${addCommas(item.itemWare.wareQty)}" disabled="disabled"/>
	                                        <span id="wareQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                        <input type="text" name="rinvQtyData" class="iText number findRinvQty" value="${item.rinvQty}" />
	                                        <span id="rinvQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                       ${number}
	                                    </td>
										<td>
											<button class="btn btn-outline-danger btn-sm deleteRowBtn" data-item-code="${item.item.itemCd}">삭제</button>
										</td>
	                                </tr>
								`;
							});
						};
						return makeTrTag;
					};

					makeTable +=
						`
					<table class="table table-bordered fs--1 mb-0" id="dataTable">
	                            <thead class="bg-200 text-900">
	                                <tr>
	                                    <th>일자</th>
	                                    <td colspan="2">
											<input type="hidden" id="actInvenCd" name="realCd" class="realCd" value="${actInvenView.realCd}"/>
											<input type="date" id="actInvenDate" name="rinvDate" class="rinvDate actInvenDate" placeholder="조사일자"  style="width: 170px;" max="${getCurrentDate()}" value="${actInvenView.rinvDate}"/>
	                                        <span id="rinvDate" class="error"></span>
	                                    </td>
										<th>담당자</th>
	                                    <td colspan="3">
	                                        <input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" placeholder="담당자" style="width: 170px;" value="${actInvenView.emp.empNm}"/>
	                                        <span id="empNm" class="error"></span>
	                                        <input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd" value="${actInvenView.emp.empCd}"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th>창고명</th>
	                                    <td colspan="2">
	                                        <input type="text" id="findStorage" class="findStorage" name="wareNm" placeholder="발견창고" style="width: 170px;" value="${actInvenView.storage.wareNm}"/>
	                                        <span id="wareCd" class="error"></span>
	                                        <input type="hidden" id="findStorageCd" class="wareCd" name="wareCd" value="${actInvenView.storage.wareCd}"/>
	                                    </td>
	                              
										<th>구역</th>
										<td colspan="3">
											<input type="text" id="findStorageSector" class="findStorageSector" name="secCd" placeholder="구역" style="width: 170px;" value="${actInvenView.secCd}" readonly="readonly"/>
											<span id="secCd" class="error"></span>
										</td>
									</tr>
	                                <tr>
	                            </thead>
	
	                            <tbody id='itemBody' style='text-align: center;'>
	                                <tr>
	                                    <th class="text">품목코드</th>
	                                    <th class="text">품목명</th>
	                                    <th class="text">단위</th>
	                                    <th class="text">시스템수량</th>
	                                    <th class="text">실사수량</th>
	                                    <th class="text">오차수량</th>
	                                </tr>
	                               ${makeRows()}	<!-- TrTag 생성 함수 호출 -->
	                            </tbody>
	                        </table>
					`;

					//모달 바디에 값 테이블 만들기
					$('#actInvenModal .modal-body').html(makeTable);

					//모달열기
					$('#actInvenModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}

	});
	
	$(document).on('click', '#addItemBtn', function(e){
		var today = new Date();
		$('#actInvenDate').val('2023-12-14');
		$('.findEmpNm').val('김원희');
		$('.findEmpCd').val('2014030001');
		$('.findStorage').val('AIM제1창고');
		$('#findStorageCd').val('W001');
		$('.findStorageSector').val('S001');
		$('.findItemCd').val('D011KD003');
		$('.hiddenItemCd').val('D011KD003');
		$('.findItemNm').val('게이밍키보드');
		$('.findItemUnit').val('EA');
		$('.findRinvQty').val('120'); 
		
	})


	//창고 리스트 출력함수
	let makeStorTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="wareCd">${rslt.wareCd}</td>
					        <td class="wareNm"><a href="#wareNm">${rslt.wareNm}</a></td>
					        <td class="wareAddr">${rslt.wareAddr}</td>
						</tr>	
		`;
		return trTag;
	}

	//창고 섹터 검색코드
	let makeStorSecTrTag = function(rslt) {
		let trTag = `	
						<tr>
					        <td class="secCd"><a href="#secCd">${rslt.secCd}</td>
					        <td class="wsecZ">${rslt.wsecZ}</td>
						</tr>
		`;
		return trTag;
	}
	//창고 검색 모달
	$(document).on('click', '#findStorage', function(e) {
		e.preventDefault();

		// 모달 열기
		$('#findStorageModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/stor`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					let wareList = resp.wareList;
					let trTags = "";

					if (wareList?.length > 0) {
						$.each(wareList, function() {
							trTags += makeStorTrTag(this);
						});
						//선택된 창고명 발견창고에 입력해주기
						$(document).on('click', '.wareNm', function(e) {
							e.preventDefault();
							var wareCd = $(this).closest('tr').find('.wareCd').text();
							var wareNm = $(this).closest('tr').find('.wareNm').text();

							var selectedWareCd = wareCd;

							$('#findStorageSectorModal').modal('show');
							try {
								$.ajax({
									url: `${cPath}/sector/${selectedWareCd}`,
									method: "GET",
									contentType: 'application/json',
									dataType: "json",
									success: function(resps) {
										let $wareSecList = resps.wareList;

										//res에 있는 has many관계를 통해 list형식으로 담겨있는값 뽑아오기
										const wareSecList = $wareSecList.map(item => item.wareSecList).flat();

										let trTags = "";

										//선택된 창고 섹터 출력하기
										if (wareSecList?.length > 0) {
											$.each(wareSecList, function() {
												trTags += makeStorSecTrTag(this);
											});
											$(document).on('click', '.secCd', function(e) {
												e.preventDefault();
												var secCd = $(this).closest('tr').find('.secCd').text();


												$('#findStorageSector').val(secCd);
												$('#findStorageCd').val(wareCd);
												$('#findStorage').val(wareNm);


												$('#findStorageSectorModal').modal('hide');
												$('#findStorageModal').modal('hide');
											});
										} else {
											trTags += `
						                        <tr>
						                            <td class="text-nowrap" colspan='4'>등록된 데이터가 없습니다.</td>
						                        </tr>
						                    `;
										}
										// 모달 내용 업데이트
										$('#findStorageSectorModal .list').html(trTags);

										$('#findStorageSectorDataTable').DataTable({
											paging: true,
											searching: true,
											lengthChange: false,
											info: false,
											destroy: true
										});
									}
								})
							} catch (error) {
								console.error(error);
							}
						});

					} else {
						trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='3'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
					}


					// 모달 내용 업데이트
					$('#findStorageModal .list').html(trTags);

					$('#findStorageDataTable').DataTable({
						paging: true,
						searching: true,
						lengthChange: false,
						info: false,
						destroy: true
					});

					// 모달 열기
					/*$('#findStorageModal').modal('show');*/
				}
			});
		} catch (error) {
			console.error(error);
		}
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

	//품목 출력함수
	let makeItemListTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="itemCd">${rslt.itemCd}</td>
					        <td class="itemNm"><a href="#itemNm">${rslt.itemNm}</a></td>
					     	<td class="itemUnit">${rslt.itemUnit}</td>
						</tr>	
		`;
		return trTag;
	}
	var targetRow;

	//품목검색 모달_ 품목코드
	$(document).on('click', '.findItemCd', function(e) {
		e.preventDefault();
		targetRow = $(this).closest('tr'); // 클릭된 요소의 가장 가까운 행 가져오기
		
		var secCd = $('#findStorageSector').val();
		var wareCd = $('#findStorageCd').val();
		
		var data = {};
		data.secCd = secCd;
		data.wareCd = wareCd;
		let json = JSON.stringify(data);

		// 모달 열기
		$('#findItemModal1').modal('show');
			$.ajax({
				url: `${cPath}/item/datatable`,
				method: "POST",
				data : json,
				headers: {
						"Content-Type": "application/json;charset=UTF-8"
					},
				success: function(resp) {
					console.log(resp);
					let itemList = resp.itemList;
					let trTags = "";

					if (itemList?.length > 0) {
						$.each(itemList, function() {
							console.log("itemLiostttt", itemList);
							trTags += makeItemListTrTag(this);
						});


						// 선택된 품목 정보를 입력
						$(document).on('click', '.itemNm', function(e) {
							e.preventDefault();

							var itemCd = $(this).closest('tr').find('.itemCd').text();
							var itemNm = $(this).closest('tr').find('.itemNm').text();
							var itemUnit = $(this).closest('tr').find('.itemUnit').text();

							targetRow.find('.findItemCd').val(itemCd);
							targetRow.find('.hiddenItemCd').val(itemCd);
							targetRow.find('.findItemNm').val(itemNm);
							targetRow.find('.findItemUnit').val(itemUnit);

							$('#findItemModal1').modal('hide');

						});
							$('#findItemDataTable1').DataTable({
							paging: true,
							searching: true,
							lengthChange: false,
							info: false,
							ordering:false,
							order:true,
							destroy: true
						});

					} else {
						trTags += `
									<tr>
										<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
									</tr>
								`;
					}
					// 모달 내용 업데이트
					$('#findItemDataTable1 .list1').html(trTags);
					
					
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
	});
	
	//품목검색 모달_ 품목명
	$(document).on('click', '.findItemNm', function(e) {
		e.preventDefault();
		targetRow = $(this).closest('tr'); // 클릭된 요소의 가장 가까운 행 가져오기

		var secCd = $('#findStorageSector').val();
		var wareCd = $('#findStorageCd').val();
		
		var data = {};
		data.secCd = secCd;
		data.wareCd = wareCd;
		
		console.log(secCd);
		console.log(wareCd);
	
		let json = JSON.stringify(data);
		
		// 모달 열기
		$('#findItemModal2').modal('show');
			$.ajax({
				url: `${cPath}/item/datatable`,
				method: "POST",
				data : json,
				headers: {
						"Content-Type": "application/json;charset=UTF-8"
					},
				success: function(resp) {
					console.log(resp);
					let itemList = resp.itemList;
					let trTags = "";

					if (itemList?.length > 0) {
						$.each(itemList, function() {
							console.log("itemLiostttt", itemList);
							trTags += makeItemListTrTag(this);
						});


						// 선택된 품목 정보를 입력
						$(document).on('click', '.itemNm', function(e) {
							e.preventDefault();

							var itemCd = $(this).closest('tr').find('.itemCd').text();
							var itemNm = $(this).closest('tr').find('.itemNm').text();
							var itemUnit = $(this).closest('tr').find('.itemUnit').text();

							targetRow.find('.findItemCd').val(itemCd);
							targetRow.find('.hiddenItemCd').val(itemCd);
							targetRow.find('.findItemNm').val(itemNm);
							targetRow.find('.findItemUnit').val(itemUnit);

							$('#findItemModal2').modal('hide');

						});
						
							$('#findItemDataTable2').DataTable({
							paging: true,
							searching: true,
							lengthChange: false,
							info: false,
							ordering:false,
							order:true,
							destroy: true
						});

					} else {
						trTags += `
									<tr>
										<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
									</tr>
								`;
					}
					// 모달 내용 업데이트
					$('#findItemDataTable2 .list1').html(trTags);
					
					
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
	});


	//품목추가 하는 이벤트
	$(document).on('click', '#addRowBtn', function(e) {
		// 새로운 행을 생성
		var newRow = document.createElement('tr');

		// 행 안에 들어갈 셀들을 생성
		var itemCdCell = document.createElement('td');
		var itemNmCell = document.createElement('td');
		var itemUnitCell = document.createElement('td');
		var rinvQtyCell = document.createElement('td');
		var delBtnCell = document.createElement('td');

		// 각 셀에 입력 요소 추가
		itemCdCell.innerHTML = `<input type="text" name="itemCd" class="iText findItemCd" />
								<span id="itemCd" class="error"></span> 
								<input type="hidden" class="hiddenItemCd" name="itemCd"  />`;
		itemNmCell.innerHTML = `<input type="text" name="itemNm" class="iText findItemNm" />
								<span id="itemNm" class="error"></span>`;
		itemUnitCell.innerHTML = `<input type="text" name="itemUnit" class="iText findItemUnit" disabled="disabled" />`;
		rinvQtyCell.innerHTML = `<input type="number" name="rinvQty" class="iText findRinvQty" />
								<span id="rinvQty" class="error"></span>`;
		//삭제
		delBtnCell.innerHTML = `<button class="btn btn-outline-danger btn-sm deleteRowBtn">삭제</button>`;


		// 셀들을 행에 추가
		newRow.appendChild(itemCdCell);
		newRow.appendChild(itemNmCell);
		newRow.appendChild(itemUnitCell);
		newRow.appendChild(rinvQtyCell);
		newRow.appendChild(delBtnCell);

		// 행을 테이블에 추가
		document.getElementById('itemBody').appendChild(newRow);
	});

	// 삭제 버튼에 대한 클릭 이벤트 처리
	$('#itemBody').on('click', '.deleteRowBtn', function() {
		// 현재 클릭된 삭제 버튼이 속한 행을 찾아서 삭제
		$(this).closest('tr').remove();
	});
	//행 삭제 함수
	function deleteRow(itemCode) {
		$('#itemRow_' + itemCode).remove();
	}

	$('#actInvenModal').on('click', '.deleteRowBtn', function() {
		var itemCode = $(this).data('item-code');
		deleteRow(itemCode);
	});




	//insertForm / updateForm
	$(document).on('submit', '#actInvenForm', function(e) {
		e.preventDefault();

		let realCd = $("#actInvenCd").val();
		let rinvDate = $("#actInvenDate").val();
		let empCd = $("#findEmpCd").val();
		let wareCd = $("#findStorageCd").val();
		let secCd = $("#findStorageSector").val();

		let itemArray = [];

		$('tbody tr').each(function() {
			let $row = $(this);
			let itemCd = $row.find(".hiddenItemCd").val();
			if (itemCd != null && itemCd != "") {
				let actIvenItem = {
					itemCd: itemCd,
					realCd: realCd,
					itemNum: $row.find(".hiddenItemNum").val(),
					rinvQty: $row.find(".findRinvQty").val()
				};
				itemArray.push(actIvenItem);
			}

		});

		if (itemArray.length > 0) {
			let ActInvenVO = {};
			ActInvenVO.realCd = realCd;
			ActInvenVO.rinvDate = rinvDate;
			ActInvenVO.empCd = empCd;
			ActInvenVO.wareCd = wareCd;
			ActInvenVO.secCd = secCd;
			ActInvenVO.actIvenItem = itemArray;

			$('span.error').text('');

			let formMode = toggleSelect;

			let url = this.action;
			let json = JSON.stringify(ActInvenVO);

			console.log("json", json);

			if (formMode == 'update') {

				Swal.fire({
					title: "수정하시겠습니까?",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "Yes"
				}).then((rslt) => {
					$.ajax({
						url: url,
						type: "PUT",
						data: json,
						headers: {
							"Content-Type": "application/json;charset=UTF-8"
						},
						success: function(res) {
							console.log("res", res);
							let result = res.errors;
							if (result) {
								if (result.rslt == "success" && rslt.isConfirmed) {
									console.log("성공~");
									Swal.fire({
										title: '수정완료!',
										text: '수정이 성공적으로 완료되었습니다.',
										icon: 'success',
										confirmButtonText: '확인'
									});
									/*alert("수정완");*/
									/*	updateDefectListInDOM(data.defProcCd, data);
										afterDataUpdate();*/
									/*getActInvenList();
									afterDataUpdate();*/
									window.location.reload();

									$('#actInvenModal').modal('hide');
								} else if (result.rslt == "fail") {
									Swal.fire({
										title: "수정실패!",
										text: "수정이 실패했습니다.",
										icon: 'error',
								  		confirmButtonText: '확인'
									});
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
				});
			} else {
				Swal.fire({
					title: "등록하시겠습니까?",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "Yes",
					cancelButtonTest: "취소"
				}).then((rslt) => {

					$.ajax({
						url: url,
						type: "POST",
						data: json,
						contentType: 'application/json',
						success: function(res) {
							let result = res.errors;
							if (result) {
								if (result.rslt == "success" && rslt.isConfirmed) {
									console.log("성공~");
									Swal.fire({
										title: '등록완료!',
										text: '등록이 성공적으로 완료되었습니다.',
										icon: 'success',
										confirmButtonText: '확인'
									});
									$('.actInvenDate').val('');
									$('.findEmpNm').val('');
									$('.findEmpCd').val('');
									$('.findStorage').val('');
									$('.findStorageCd').val('');
									$('.findStorageSector').val('');
									$('.findItemCd').val('');
									$('.hiddenItemCd').val('');
									$('.findItemNm').val('');
									$('.findItemUnit').val('');
									$('.findRinvQty').val('');
								} else if (result.rslt == "fail") {
									Swal.fire({
										title: '등록실패!',
									  	text: '등록이 실패했습니다.',
									  	icon: 'error',
									  	confirmButtonText: '확인'
									});
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
				});
			}
		}
	});
})