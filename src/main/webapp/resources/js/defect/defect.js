/**
 * <pre>
 * 
 * </pre>
 * @author 최광식
 * @since 2023. 11. 10.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	 수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.      최광식       최초작성
 * 2023. 11. 12.      최광식       조회 및 상세조회
 * 2023. 11. 15.      최광식       등록
 * 2023. 11. 16.      최광식       수정
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
		$('#defect').addClass('show');
	});

	let cPath = $('.pageConversion').data('contextPath');
	
	const addCommas = function(num) {
       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  	};

	//불량품목 리스트 출력하기 위한 trtag생성
	let makeTrTag = function(rslt) {
		let defectViewURL = ` ${cPath}/defect/view?what=${rslt.defProcCd}`;
		

		let formatdefQty = addCommas(rslt.defQty);

		let trTag = `
	        <tr>
	            <td class="text defProcCd"><a href="${defectViewURL}">${rslt.defProcCd}</a></td>
	            <td class="text wareNm">${rslt.storage.wareNm}</td>
	            <td class="text itemNm">${rslt.item.itemNm}</td>
	            <td class="number defQty">${formatdefQty}</td>
	            <td class="text defNm">${rslt.defNm}</td>
	            <td class="text defProc">${rslt.defProc}</td>
	            <td class="text defNote">${rslt.defNote}</td>
	        </tr>
	    `;

		return trTag;
	};


	let toggleSelect;

	//불량품목 리스트 출력
	//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let url = this.action;
		let data = $(this).serialize();
		console.log("data@@@@@@@@", data);
		$.getJSON(url + '?' + data)
			.done(function(resp) {
				console.log(resp.paging);
				let defectList = resp.paging.dataList;
				let trTags = null;
				if (defectList.length > 0) {
					$.each(defectList, function(idx, defect) {
						trTags += makeTrTag(defect);
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


	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(':input[name=' + name + ']').val(value);
		});
		$(searchForm).submit();
	});

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

	// DOM에서 불량품목 리스트를 업데이트하는 함수
	function updateDefectListInDOM(defectCd, updatedData) {
		// 해당하는 불량코드를 포함하는 행을 찾기
		let $row = $(`.defProcCd:contains(${defectCd})`).closest('tr');

		// 행을 찾지 못했을 경우에 대한 유효성 검사
		if ($row.length === 0) {
			console.error(`Row with defect code ${defectCd} not found.`);
			return;
		}

		// 행 내용 업데이트
		$row.find('.defProcCd a').attr('href', `${cPath}/defect/view?what=${updatedData.defProcCd}`).text(updatedData.defProcCd);

		console.log("dkdkdkdk", updatedData);

		// 업데이트된 값 행에 찍어주기
		$row.find('.wareNm').text(updatedData.wareNm);
		$row.find('.itemNm').text(updatedData.itemNm);
		$row.find('.defQty').text(updatedData.defQty);
		$row.find('.defNm').text(updatedData.defNm);
		$row.find('.defProc').text(updatedData.defProc);
		$row.find('.defNote').text(updatedData.defNote);
	}

	// 해당 품목 상세정보 및 수정 폼출력
	// 모달을 열기 위한 이벤트 처리
	$(document).on('click', '.defProcCd a', function(e) {
		e.preventDefault();
		/*// 현재 페이지 번호 저장
		let defListDataTable = $('#defectListDataTable').DataTable();
		currentPageNumber = defListDataTable.page() + 1;*/

		let defProcCd = $(this).text(); // 클릭한 링크의 텍스트 값 (defProcCd)
		let defectViewURL = `${cPath}/defect/view?what=${defProcCd}`;
		toggleSelect = 'update';
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: defectViewURL,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					let defectView = resp.defectView;
					let defectType = resp.defectTypeList;
					let itemView = resp.itemView;
					let makeTable = "";


					makeTable +=
						`
	                        <table class="table table-bordered table-striped fs--1 mb-0" id="dataTable">
	                            <thead class="bg-200 text-900">
	                                <tr>
	                                    <th>일자</th>
	                                    <td colspan="5">
											<input type="date" id="defectDate" name="defProcdate" class="defectDate" placeholder="처리일자"  style="width: 170px;" max="${getCurrentDate()}" value="${defectView.defProcdate}"/>
	                                        <span id="defProcdate" class="error"></span>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th>발견창고</th>
	                                    <td colspan="2">
	                                        <input type="text" id="findStorage" class="findStorage" name="wareNm" placeholder="발견창고" style="width: 170px;" value="${defectView.storage.wareNm}"/>
	                                        <span id="wareCd" class="error"></span>
	                                        <input type="hidden" id="findStorageCd" class="wareCd" name="wareCd" value="${defectView.storage.wareCd}"/>
	                                    </td>
	                              
										<th>구역</th>
										<td colspan="2">
											<input type="text" id="findStorageSector" class="findStorageSector" name="secCd" placeholder="구역" style="width: 170px;" value="${defectView.secCd}" readonly="readonly"/>
											<span id="secCd" class="error"></span>
										</td>
									</tr>
	                                <tr>
	                                    <th>담당자</th>
	                                    <td colspan="2">
	                                        <input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" placeholder="담당자" style="width: 170px;" value="${defectView.empNm}"/>
	                                        <span id="empNm" class="error"></span>
	                                        <input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd" value="${defectView.empCd}"/>
	                                    </td>
	                             
	                                    <th>처리방법</th>
	                                    <td colspan="2"> 
	                                        <select id="defProc" class="defectAprch" name="defProc" style="width: 170px;" >
											</select>
	                                        <span id="defProc" class="error"></span>
	                                    </td>
	                                </tr>
	                            </thead>
										<input type="hidden" value="${defectView.defProcCd}" name="defProcCd"/>
	
	                            <tbody>
	                                <tr>
	                                    <th class="text">품목코드</th>
	                                    <th class="text">품목명</th>
	                                    <th class="text">단위</th>
	                                    <th class="text">수량</th>
	                                    <th class="text">불량유형</th>
	                                    <th class="text">적요</th>
	                                </tr>
	                                <tr>
	                                    <td>
	                                        <input type="text" id="findItemCd" name="itemCd" class="iText findItemCd" value="${defectView.itemCd}" />
	                                        <span id="itemCd" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemNm" class="iText findItemNm" name="itemNm" value="${defectView.item.itemNm}"/>
	                                        <span id="item.itemNm" class="error"></span> 
	                                    </td>
	                                    <td>
	                                        <input type="text" id="findItemUnit" class="iText findItemUnit" disabled="disabled" value="${itemView.itemUnit}"/>
	                                    </td>
	                                    <td>
	                                        <input type="number" id="count" name="defQty" class="iText" style="width: 120px" value="${defectView.defQty}"/>
	                                        <span id="defQty" class="error"></span>
	                                    </td>
	                                    <td>
	                                        <input type="text" id="defectType" name="defNm" class="iText" value="${defectView.defNm}"/>
	                                        <span id="defNm" class="error"></span>
	                                        <input type="hidden" id="defectTypeCd" name="defCd" class="iText" value="${defectView.defCd}"/>
	                                    </td>
	                                    <td>
	                                        <input type="text" id="defNote" name="defNote" class="note iText" value="${defectView.defNote}"/>
	                                    </td>
	                                </tr>
	                            </tbody>
	                        </table>
	                    
                    `;

					// 모달 내용 업데이트
					$('#defectModal .modal-body').html(makeTable);

					// 불량유형 선택 옵션 업데이트
					$.each(defectType, function(index, type) {
						if (type.commCdNm == defectView.defProc) {
							let temps = `<option selected="selected" value='${type.commCdNm}' label='${type.commCdNm}'>`;
							$('#defProc').append(temps);
						} else {
							$('#defProc').append($('<option>', {
								value: type.commNm,
								text: type.commCdNm
							}));
						}
					});

					// 모달 열기
					$('#defectModal').modal('show');
				}
			});
		} catch (error) {
			console.error(error);
		}
	});
	
	$(document).on('click', '#addItemBtn',function(e){
		$('#defectDate').val('2023-12-14');
		$('#findStorage').val('AIM제2창고');
		$('#findStorageCd').val('W002');
		$('#findEmpNm').val('김원희');
		$('#findEmpCd').val('2014030001');
		$('#defProc').val('폐기');
		$('#findStorageSector').val('S002');
		$('#findItemCd').val('D002TV003');
		$('#findItemNm').val('범종스마트TV(65inch)');
		$('#findItemUnit').val('EA');
		$('#count').val('5');
		$('#defectType').val('찍힘');
		$('#defectTypeCd').val('F004');
		$('#defNote').val('찍힘으로 인한 불량');
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
											autoWidth: false,
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
						autoWidth: false,
						destroy: true
					});
				}
			});
		} catch (error) {
			console.error(error);
		}
	});


	//불량리스트 출력함수
	let makeDefectTypeTrTag = function(rslt) {
		let trTag = `
						 <tr>
					     	<td class="commCd">${rslt.commCd}</td>
					        <td class="commCdNm"><a href="#commCdNm">${rslt.commCdNm}</a></td>
						</tr>	
		`;
		return trTag;
	}

	//불량유형검색 모달
	$(document).on('click', '#defectType', function(e) {
		e.preventDefault();

		// 모달 열기
		$('#findDefectTypeModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: ` ${cPath}/defect/type`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					let defectList = resp.defectList;
					let trTags = "";

					if (defectList?.length > 0) {
						$.each(defectList, function() {
							trTags += makeDefectTypeTrTag(this);
						});

						//선택된 불량명을 불량유형에 입력해주기
						$(document).on('click', '.commCdNm', function(e) {
							e.preventDefault();

							var commCd = $(this).closest('tr').find('.commCd').text();
							var commCdNm = $(this).closest('tr').find('.commCdNm').text();

							$('#defectTypeCd').val(commCd);
							$('#defectType').val(commCdNm);

							$('#findDefectTypeModal').modal('hide');
						});
					} else {
						trTags += `
                        <tr>
                            <td class="text-nowrap" colspan='2'>등록된 데이터가 없습니다.</td>
                        </tr>
                    `;
					}

					// 모달 내용 업데이트
					$('#findDefectTypeModal .list').html(trTags);

					$('#findDefectType').DataTable({
						paging: true,
						searching: true,
						lengthChange: false,
						autoWidth: false,
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

	//품목검색 모달_ 
	$(document).on('click', '.findItemCd', function(e) {
		e.preventDefault();
		targetRow = $(this).closest('tr'); // 클릭된 요소의 가장 가까운 행 가져오기

		var secCd = $('#findStorageSector').val();
		var wareCd = $('#findStorageCd').val();
		
		console.log(secCd);
		console.log(wareCd);
		
		var data = {};
		data.secCd = secCd;
		data.wareCd = wareCd;
	
		console.log("dataaaaaa",data);
		let json = JSON.stringify(data);
		console.log("jsonnnnnnn",json);

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
							destroy: true,
						});

					} else {
						trTags += `
									<tr>
										<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
									</tr>
								`;
					}
					// 모달 내용 업데이트
					$('#findItemDataTable1 .list').html(trTags);
					
					
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
		
		console.log(secCd);
		console.log(wareCd);
		
		var data = {};
		data.secCd = secCd;
		data.wareCd = wareCd;
	
		console.log("dataaaaaa",data);
		let json = JSON.stringify(data);
		console.log("jsonnnnnnn",json);

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
							destroy: true,
						});

					} else {
						trTags += `
									<tr>
										<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
									</tr>
								`;
					}
					// 모달 내용 업데이트
					$('#findItemDataTable2 .list').html(trTags);
					
					
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
	});


	//insertForm / updateForm
	$(document).on('submit', '#defectForm', function(e) {
		e.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;

		console.log("this", $(this));
		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		console.log("data", data);
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
						console.log(res);
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
								updateDefectListInDOM(data.defProcCd, data);
								/*afterDataUpdate();*/
								/*reloadDataTable();*/
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
				confirmButtonText: "Yes"
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
								$('#defectDate').val('');
								$('#findStorage').val('');
								$('#findEmpNm').val('');
								$('#defProc').val('');
								$('#findStorageSector').val('');
								$('#findItemCd').val('');
								$('#findItemNm').val('');
								$('#findItemUnit').val('');
								$('#count').val('');
								$('#defectType').val('');
								$('#defNote').val('');
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
			})
		}
	});

})
