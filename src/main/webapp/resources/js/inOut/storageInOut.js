/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 23.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 23.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 



$(function (){
	
	getView();
	
	let detailWindowModal = new bootstrap.Modal($('#rmstWindow')[0]);
	function getView(){
		$.ajax({
			url: '/storInOut/out',
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let inOutList = resp.inOutList;
				console.log(inOutList);
				let trTags = "";
		
				if (inOutList?.length > 0) {
					$.each(inOutList, function () {
						trTags += makeTrTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='9'>출고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}
				
				
				$('.list').html(trTags);
				$('#buttonDiv').html("<button type='submit' class='btn btn-primary' value='출고'>출고확정</button>");

																									
				$('#dataTable').DataTable({
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
	} // List 함수끝
	
	//List에 body영역 만들어주는 함수
	const makeTrTag = function(rslt){
	    
	    let trTag = `
	        <tr>
	            <td class='rdrecCdValue'><a id='detailId' href="javascript:void(0)">${rslt.rdrecCd}</a></td>
	            <td>${rslt.comNm}</td>
	            <td>${rslt.wareNm}</td>
	            <td>${rslt.secCd}</td>
	            <td>${rslt.itemNm}</td>
	            <td>${rslt.rdrecOutdate}</td>
                <td class='rdrecQtyValue'>${rslt.rdrecQty}</td>
				<td><input type='text' class='inQtyInput' name='inQty'></td>
	            <td><input type='text' name='itemNote'></td>
							
				<input type='hidden' name='rdrecCd' value='${rslt.rdrecCd}'/>
				<input type='hidden' name='wareCd' value='${rslt.wareCd}'/>
				<input type='hidden' name='itemCd' value='${rslt.itemCd}'/>
				<input type='hidden' name='rdrecOutdate' value='${rslt.rdrecOutdate}'/>
				<input type='hidden' name='secCd' value='${rslt.secCd}'/>
	        </tr>    
	    `;
	    return trTag;
	};
	
	let makeDetailTag = function(rslt){
	    let trTag = `
	        <tr>
	            <td><input class="iText" type="text" value="${rslt.itemCd}"></td>
	            <td><input class="iText" type="text" value="${rslt.itemNm}"></td>
	            <td><input class="iText" type="text" value="${rslt.itemUnit}"></td>
	            <td><input class="iText" type="text" value="${rslt.rdrecQty}"></td>
	            <td><input class="iText" type="text" value="${rslt.rdrecOutdate}"></td>
	        </tr>    
	    `;
	    return trTag;
	};
	
	$(document).on('click', '#detailId', function() {
	    detailWindowModal.show();

		let rdrecCd = $(this).text();
		
		$.ajax({
			url: `/scheduledStock/out/${rdrecCd}`,
			method: "GET",
			success: function(res) {
				console.log("dadasd",res);
				let stockDetail = res.stockDetail;
				/*
					각 출하지시서 기본데이터 출력
				*/
				let rdrecDate = stockDetail[0].rdrecDate;
				let empNm = stockDetail[0].empNm;
				let comNm = stockDetail[0].comNm;
				let rdrecOutdate= stockDetail[0].rdrecOutdate;
				
				$('#relsDate').val(rdrecDate)
				$('#empNm').val(empNm)
				$('#comNm').val(comNm)
				$('#outDate').val(rdrecOutdate)
				
				
				console.log(stockDetail);
				let trTags = `
					<tr>
						<th>품목코드</th>
						<th>품목명</th>
						<th>단위</th>
						<th>수량</th>
						<th>납기일자</th>
					</tr>
				`;
				
				if (stockDetail!=null) {
					$.each(stockDetail, function () {
						trTags += makeDetailTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='5'>출고예정인 정보가 없습니다.</td>
							</tr>
						`;
				}
				$('#detailList').html(trTags);
										
			},
			error: function (request, status, error) {
		        console.log("code: " + request.status)
		        console.log("message: " + request.responseText)
		        console.log("error: " + error);
		    }
		})
	});
	
	$('#inOutForm').on('submit', function (e) {
	    e.preventDefault();
		
		
		
		var isValid = true;
		
	   $('.list').find('tr').each(function() {
	        var rdrecQty = $(this).find('.rdrecQtyValue').text().trim();
	        var inQty = $(this).find('.inQtyInput').val();
			
			if(inQty){
		        if (rdrecQty !== inQty) {
		            Swal.fire({
							  title: '등록실패',
							  text: '출고 예정 수량과 출고 확정 수량이 다릅니다. 출고확정 수량을 확인 후 다시 입력해주세요.',
							  icon: 'error',
							  confirmButtonText: '확인'
							})
					isValid = false;
					return false; 
		        }
			}
	    });

		if(isValid){
			let form = document.getElementById('inOutForm');
			let formData = new FormData(form);
			let array = [];
			let map = new Map();
			formData.forEach(function (value, key) {
				
			    if (key === 'inQty') {
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
			    array.push(Object.fromEntries(copiedMap));
			}
	
			console.log(array); 
	
			
			$.ajax({
				url: '/storInOut/out',
				method: "POST",
			    data :JSON.stringify(array),
				contentType: 'application/json',
				success: function(res) {
					if (res === 'ok') {
					Swal.fire({
							  title: '출하완료',
							  text: '출하가 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
							})
					  $('.list').html('');
					  $('#dataTable').DataTable().destroy();
					  getView();
				    } else {
						Swal.fire({
							  title: '수정실패!',
							  text: '출하가 실해 하였습니다. 다시 시도해 주세요',
							  icon: 'error',
							  confirmButtonText: '확인'
							})
					}	
				},
				error: function (request, status, error) {
		            console.log("code: " + request.status)
		            console.log("message: " + request.responseText)
		            console.log("error: " + error);
		        }
			});
		}
	});
})