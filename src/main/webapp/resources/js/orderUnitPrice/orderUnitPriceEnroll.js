/**
 * <pre>
 * 
 * </pre>
 * @author 범종
 * @since 2023. 11. 29.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 29.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


$(function(){
	
	/*$(document).on('click', '#upFile', function() {
		
	    $('#orderUnitPriceExcelForm').submit();

	});*/
	let cPath = $('.pageConversion').data('contextPath');

	const baseUrl = `${cPath}/orderUnitPrice`;
	
	/* 조회 함수 */
	function retrieveOrderPlan() {
		console.log("aaaa");
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				
					oredrUnitPriceView=null;
						
						let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>발주일자</th>
								<td colspan="5">
									<input type="date" id="upreqDate" name="upreqDate" class="upreqDate" style="width: 170px;" />
									<span id="defUpreqDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>납기일자</th>
								<td colspan="5">
									<input type="date" id="upreqValDate" name="upreqValDate" class="upreqValDate" style="width: 170px;" />
									<span id="defUpreqValDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" class="findComNm"  name="comNm" placeholder="거래처" style="width: 170px;" />
									<span id="comNm" class="error"></span>
									<input type="hidden" id="findComCd" class="findComCd"  name="comCd" value="zz" />
								</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" style="width: 170px;" disabled="disabled"/>
									<span id="empNm" class="error"></span>
									<input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd"/>
								</td>
							</tr>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>수량</th>
								<th>단가</th>
								<th>단가유효기간</th>
								<th>진행상태</th>
							</tr>
						</thead>
						<tbody>

						`;
						if (oredrUnitPriceView?.length > 0) {
						$.each(oredrUnitPriceView, function () {
							makeTable += makeUnitPriceTrTag(this);
								});
							} else {
								makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>등록된 품목이 없습니다.</td>
										</tr>
									`;
							}
	
						makeTable += `
							</tbody>
						</table>
						
						`
						;
						$('.itemList').html(makeTable);
	
					
				
			 
			
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveOrderPlan();
	
	
	
	
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log("namename",name);
			console.log("valuevalue",value);
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});
	
	/* 아작스를 위한 데이터 설정 */
	let makeTrTag = function(resp) {
		 let selectUpreqStat = resp.upreqStat === '완료' ?
        `${resp.upreqCd}` :
        `<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${resp.upreqCd}</a>`;
		
		 let upreqStatColor = resp.upreqStat === '완료' ? 'skyblue' : 'red';
		
		
		let trTags = `
		
		<tbody>
		 <tr>
            <td id="upreqCd">${selectUpreqStat}</td>
			<td id="itemNm">${resp.orderUnitPriceItem[0].item.itemNm}${resp.nqty > 0 ? ` 외 ${resp.nqty}건` : ''}</td>
            <td id="upreqDate">${resp.upreqDate}</td>
            <td id="upreqValDate">${resp.upreqValDate}</td>
            <td id="empNm">${resp.empNm}</td>
            <td id="upreqStat"><a href="javascript:;" style="color: ${upreqStatColor};">${resp.upreqStat}</a></td>
        </tr>
		</tbody>
	    `;
		return trTags;
	};
	
	$(document).on('submit', '#orderUnitPriceForm', function(e) {
		e.preventDefault();
		
		console.log("히히");
		
		let url = this.action;
		
		$.ajax({
            url: url+"/list2", 
            method: "GET",
			contentType: 'application/json',
			dataType: "json",
            success: function(resp) {
                console.log(resp);
				console.log("체크!",resp.dataList);
				trTags=`
					<table class="table table-bordered table-striped fs--1 mb-0" id="oredrUnitPriceDetailDataTable">
					<thead class="bg-200 text-900">
			       		<tr>
							<th class="upreqCd">단가요청코드</th>
							<th class="itemNm">품목명</th>
							<th class="upreqDate">단가요청일자</th>
							<th class="upreqValDate">유효기간</th>
							<th class="empNm">단가요청서 담당사원</th>
							<th class="upreqStat">단가요청진행상태</th>
						</tr>
					</thead>
				`;
				let orderUnitPriceList = resp.dataList;
				if (orderUnitPriceList?.length > 0) {
					$.each(orderUnitPriceList, function() {
						trTags += makeTrTag(this);
					});
					
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>진행중인 단가요청서가 없습니다.</td>
							</tr>
						`;
				}
				
				trTags += `
							
							<tfoot>
					<tr><td colspan="7"></td></tr>
				</tfoot>
						</table>
				`;
				
				
				// 모달 내용 업데이트
				$('#orderUnitPriceUploadModal .modal-body').html(trTags);
				$(pagingArea).html(resp.pagingHTML);
				// 모달 열기
				$('#orderUnitPriceUploadModal').modal('show');
				
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
        });
		
			
	});
	
	
	//검색 및 페이징 처리
	$(searchForm).on("submit", function(e) {
		e.preventDefault();
		
		console.log("히히");
		
		let url = this.action;
		let data = $(this).serialize();
		$.ajax({
            url: url, 
            method: "GET",
			data : data,
			contentType: 'application/json',
			dataType: "json",
            success: function(resp) {
                console.log(resp);
				console.log("체크!",resp.dataList);
				trTags=`
					<table class="table table-bordered table-striped fs--1 mb-0" id="oredrUnitPriceDetailDataTable">
					<thead class="bg-200 text-900">
			       		<tr>
							<th class="upreqCd">단가요청코드</th>
							<th class="itemNm">품목명</th>
							<th class="upreqDate">단가요청일자</th>
							<th class="upreqValDate">유효기간</th>
							<th class="empNm">단가요청서 담당사원</th>
							<th class="upreqStat">단가요청진행상태</th>
						</tr>
					</thead>
				`;
				let orderUnitPriceList = resp.dataList;
				if (orderUnitPriceList?.length > 0) {
					$.each(orderUnitPriceList, function() {
						trTags += makeTrTag(this);
					});
					
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>진행중인 단가요청서가 없습니다.</td>
							</tr>
						`;
				}
				
				trTags += `
							
							<tfoot>
					<tr><td colspan="7"></td></tr>
				</tfoot>
						</table>
				`;
				
				
				// 모달 내용 업데이트
				$('#orderUnitPriceUploadModal .modal-body').html(trTags);
				$(pagingArea).html(resp.pagingHTML);
				// 모달 열기
				$('#orderUnitPriceUploadModal').modal('show');
				
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
        });
		
		});
		
		/* 아작스를 위한 데이터 설정 */
	let makeUnitPriceTrTag = function(rslt, index) {
    let trTag = `
        <tr>
            <td id="itemCd">${rslt.itemCd}</td>
            <td id="itemNm">${rslt.itemNm}</td>
            <td id="uprcItQty"><input type="number" class="findUprcItQty" style="width: 100px;" value="${rslt.uprcItQty}"/></td>
            <td id="cqteItUprc"><input type="number" class="findCqteItUprc" id="findCqteItUprc_${index}" style="width: 100px;" /></td>
            <td id="upreqDur"><input type="date" class="findUpreqDur" style="width: 100px;" value="${rslt.upreqDur}"/></td>
            <td id="upreqStat">${rslt.upreqStat}</td>
            <input type="hidden" class="findUpreqCd" value="${rslt.upreqCd}"/>
            <input type="hidden" class="findUprecItCd" value="${rslt.uprcItCd}"/>
            <input type="hidden" class="findItemCd" value="${rslt.itemCd}"/>
        </tr>
    `;
    return trTag;
};

	$(document).on('click', '#upreqCd a', function(e) {
		e.preventDefault();
		let upreqCd =$(this).text();
		console.log(upreqCd);
		let oredrUnitPriceViewURL = `${cPath}/orderUnitPrice/view?what=${upreqCd}`
		
		try {
				// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
				$.ajax({
					url: oredrUnitPriceViewURL,
					method: "GET",
					contentType: 'application/json',
					dataType: "json",
					success: function(resp) {
						let oredrUnitPriceView = resp;
						console.log("check"+oredrUnitPriceView);
						console.log(oredrUnitPriceView);
						let makeTable = `
						    <table class="table table-bordered table-striped fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>발주일자</th>
								<td colspan="5">
									<input type="date" id="upreqDate" name="upreqDate" class="upreqDate" value="${oredrUnitPriceView[0].upreqDate}" style="width: 170px;" />
									<span id="defUpreqDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>납기일자</th>
								<td colspan="5">
									<input type="date" id="upreqValDate" name="upreqValDate" class="upreqValDate" value="${oredrUnitPriceView[0].upreqValDate}"  style="width: 170px;" />
									<span id="defUpreqValDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" class="findComNm"  name="comNm" placeholder="거래처" style="width: 170px;" />
									<span id="comNm" class="error"></span>
									<input type="hidden" id="findComCd" class="findComCd"  name="comCd" value="zz" />
								</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" value="${oredrUnitPriceView[0].empNm}" style="width: 170px;" disabled="disabled"/>
									<span id="empNm" class="error"></span>
									<input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd"  value="${oredrUnitPriceView[0].empCd}"/>
								</td>
							</tr>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>수량</th>
								<th>단가</th>
								<th>단가유효기간</th>
								<th>진행상태</th>
							</tr>
						</thead>
						<tbody>

						`;
						if (oredrUnitPriceView?.length > 0) {
						oredrUnitPriceView.forEach(function(item, index) {
					        makeTable += makeUnitPriceTrTag(item, index);
					    });
							} else {
								makeTable += `
										<tr>
											<td class="text-nowrap" colspan='7'>등록된 품목이 없습니다.</td>
										</tr>
									`;
							}
	
						makeTable += `
							</tbody>
						</table>
						
						`
						;
						$('.itemList').html(makeTable);
	
					}
				});
			} catch (error) {
				console.error(error);
		
		}
		
		
		});
		
		
		const autoBinding = document.getElementById('autoBinding');
		
		autoBinding.addEventListener('click', function() {
		   
			
		    document.getElementById('findComNm').value = '㈜동동전자';
		
		    document.getElementById('findComCd').value = 'COM037';
		    document.getElementById('findCqteItUprc_0').value = '800000';
		    document.getElementById('findCqteItUprc_1').value = '50000';
		
		});
		
		
		$(document).on('submit', '#orderPlayForm', function(e) {
			e.preventDefault();
			
			console.log("zzzz");
			
			const findupreqCdInputs = document.querySelectorAll('.findUpreqCd');
			const findupreqCdInput = document.querySelector('.findUpreqCd');
			const findComCdInput = document.querySelector('.findComCd');
			const findEmpCdInput = document.querySelector('.findEmpCd');
			const findUpreqValDateInput = document.querySelector('.upreqValDate');
			const findupreqCdValue = findupreqCdInput.value;
			const findComCdValue = findComCdInput.value;
			const findEmpCdValue = findEmpCdInput.value;
			const findUpreqValDateValue = findUpreqValDateInput.value;
			console.log(findupreqCdInputs);
			console.log("findupreqCdInput",findupreqCdInput);
			console.log(findComCdValue);
			
			var rowData = [];
			 findupreqCdInputs.forEach(function(input) {
	        let $row = $(input).closest('tr');
			let uprcItQtyValue = $row.find('.findUprcItQty').val();
	        let upreqDurValue = $row.find('.findUpreqDur').val();
	        let uprecItCdValue = $row.find('.findUprecItCd').val();
	        let cqteItUprcValue = $row.find('.findCqteItUprc').val();
	        let itemCdValue = $row.find('.findItemCd').val();
			console.log($row);
			console.log(uprcItQtyValue);
			console.log(upreqDurValue);
			console.log(uprecItCdValue);
			
			var dataObj = 	{
				'upreqCd' :  findupreqCdValue,
				'cqteItQty' : uprcItQtyValue,
				'uprcEdate' : upreqDurValue,
				'uprcItCd': uprecItCdValue,
				'comCd' : findComCdValue,
				'cqteItUprc' : cqteItUprcValue,
				'itemCd' : itemCdValue,
				'empCd' : findEmpCdValue,
				'upreqValDate' : findUpreqValDateValue
				
			};
			
			rowData.push(dataObj);
			})
			
			console.log(rowData);
			
			$.ajax({
		    url: baseUrl+'/insertUnitPriceOne',
		    method: 'POST',
		    contentType: 'application/json',
		    data: JSON.stringify(rowData), //JSON 형식으로 데이터 전송
		    success: function(response) {
				console.log("안녕",response);
		        // 성공적으로 처리된 후의 작업
					//$('#orderPlanEnrollDataTable').DataTable().destroy();
					
					//alert('등록 ! ');
					Swal.fire({
					  icon: "success",
					  title: "등록! !",
					  showConfirmButton: false,
					  timer: 1500
					});
					retrieveOrderPlan();
		    },
		    error: function(error) {
		        // 오류 처리
				console.log(error);
		    }
		});
			
			
		})// orderplayform 끝
		
		//거래처
		//회사리스트 출력함수
	let makeDealComTrTag = function(rslt) {
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
		$('#findDealComModal').modal('show');
		try {
			// 비동기적으로 Ajax 요청을 기다리고 결과를 받아옴
			$.ajax({
				url: `${cPath}/orderPlay/com`,
				method: "GET",
				contentType: 'application/json',
				dataType: "json",
				success: function(resp) {
					
					console.log("zzz");
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
});

