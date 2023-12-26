/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
function fn_paging(page) {
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
$(function(){								
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	$('#createWindow').on('hidden.bs.modal', function () {
	    $('body').css('overflow', ''); 
	});
	
	$('#itemBooleanInput').change(function() {
        let isChecked = $(this).prop('checked');
        $('#itemYnInput').val(isChecked ? "N" : "Y");
    });
    let count = 0;
	$("#unUsebtn").on('click',function(e){
		e.preventDefault();
		count++;
		if(count%2==1){
			$('#itemYnData').val('N');
			$(searchForm).submit();
		}else{
			$('#itemYnData').val('Y');
			$(searchForm).submit();
		}
	})

	let isCreate = true; //create인지 update인지 체크
	let makeTrTag = function (rslt) {
	    let trTag = `
	      		<tr class="${rslt.itemCd}">
		            <td id="itemCd"><a href="javascript:;" id="itemLink">${rslt.itemCd}</td>
		            <td id="itemNm">${rslt.itemNm}</td>
		            <td id="itemUnit">${rslt.itemUnit}</td>
		            <td id="itemNmCate">${rslt.itCateNm}</td>
		            <td id="itemInpr">${rslt.itemInpr > 0 ? addCommas(rslt.itemInpr) : 0}</td>
		            <td id="itemOutpr">${rslt.itemOutpr > 0 ? addCommas(rslt.itemOutpr) : 0}</td>
		            <input type="hidden" id="itemSafeQty" value="${rslt.itemSafeQty > 0 ? addCommas(rslt.itemSafeQty) : 0}"/>
		            <input type="hidden" id="itemYn" value="${rslt.itemYn}"/>
		            <input type="hidden" id="itemNote" value="${rslt.itemNote}"/>
		            <input type="hidden" id="itMaker" value="${rslt.itMaker}"/>
		            <input type="hidden" id="itWght" value="${rslt.itWght}"/>
		            <input type="hidden" id="itColor" value="${rslt.itColor}"/>
		            
		            <input type="hidden" id="itemCdCate" value="${rslt.itemCate}"/>
		        </tr>
		    `;
		    return trTag;
	};

	let cPath = $('.pageConversion').data('contextPath');
	let baseUrl = `${cPath}/item`;
	
	/* 목록 리스트를 띄워주는 아작스 함수 */
	function retrieveItem(urls, datas){
		$.ajax({
			url: urls,
			method: "GET",
			data : datas,
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let itemList = resp.paging.dataList;
				let trTags = "";
		
				if (itemList?.length > 0) {
					$.each(itemList, function () {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='6'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('.list').html(trTags);
			
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
	}
	/* 초기 리스트 띄우는 함수호출 */
	
	
		//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let url = this.action;
		let data = $(this).serialize();
		console.log("나여",data);
		retrieveItem(url,data);
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
	
	
	
	/* 모달 설정 */
	let createWindowModal = new bootstrap.Modal($('#createWindow')[0]);
    let groupWindowModal = new bootstrap.Modal($('#groupWindow')[0]);
	
    $('#groupBtn').on('click', function () {
		$('.modal-backdrop').remove();
        createWindowModal.hide();
        groupWindowModal.show();
    });
    
    $('.selectItem').click(function (e) {
	    e.preventDefault();
	    var selectedNmValue = $(this).data('selected-value');
	    var selectedCdValue = $(this).closest('tr').find('.commCd').text();
	    // 선택된 값을 createWindow 창의 groupInput에 표시
	    $('#groupNmInput').val(selectedNmValue);
	    $('#groupCdInput').val(selectedCdValue);
		
	
	    // groupWindow 모달 닫기
	    groupWindowModal.hide();
		$('.modal-backdrop').remove();
	    // createWindow 모달 열기
	    createWindowModal.show();
	});
	
	    
	$('#groupClose').on('click', function () {
	    createWindowModal.show();
	    groupWindowModal.hide();

	});
	
	 $('#createClose').on('click', function (e) {
        createWindowModal.hide();
        groupWindowModal.hide();
        $('.modal-backdrop').remove();
        $('#createWindow').find('input').val('');
    });
    
    /* 수정, 등록폼 동시사용*/
	$(document).on('submit', '#itemForm', function(event) {
		event.preventDefault();
		$('.modal-backdrop').remove();
		$('span.error').text('');
		let formMode = toggleSelect;

		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		
		if (formMode == 'update') {
			$('.modal-backdrop').remove();
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
						if (result.rslt == "success") {
							$('#dataTable').DataTable().destroy();
							/*$('.list').html('');*/
							let updatedItemCd = data.itemCd;
				            let updatedItemNm = data.itemNm;
				            let updatedItemUnit = data.itemUnit;
				            let updatedItemNmCate = data.itemNmCate;
				            let updatedItemInpr = data.itemInpr;
				            let updatedItemOutpr = data.itemOutpr;
				            let itemSafeQty = data.itemSafeQty > 0 ? addCommas(data.itemSafeQty) : 0;
							let itemYn = data.itemYn;
							let itemNote = data.itemNote;
							let itMaker = data.itMaker;
							let itWght = data.itWght;
							let itColor = data.itColor;
							
							
							$('.list tr').each(function() {
							    let className = $(this).attr('class');
							    
							    if (className === updatedItemCd) {
									$('#itemSafeQty').val(itemSafeQty);
									$('#itemYn').val(itemYn);
									$('#itemNote').val(itemNote);
									$('#itMaker').val(itMaker);
									$('#itWght').val(itWght);
									$('#itColor').val(itColor);
		
		
						            // 변경된 데이터를 각 요소에 반영
						            $(this).find('#itemCd a').text(updatedItemCd);
									$(this).find('#itemNm').text(updatedItemNm);
									$(this).find('#itemUnit').text(updatedItemUnit);
									$(this).find('#itemNmCate').text(updatedItemNmCate);
									$(this).find('#itemInpr').text(updatedItemInpr);
									$(this).find('#itemOutpr').text(updatedItemOutpr);
								}
							});

							
							
							
							//$('#searchForm').submit();
							
							Swal.fire({
							  title: '수정완료!',
							  text: '수정이 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
							})
							createWindowModal.hide();
							$('.modal-backdrop').remove();
							$('#createWindow').find('input').val('');
							$('#itemBooleanInput').prop('checked', false);
						} else if (result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage) {
								let errorId = '#' + fieldName + 'Error';
								$(errorId).text(errorMessage);
							});
							Swal.fire({
							  title: '수정실패!',
							  text: '수정이 실패했습니다.',
							  icon: 'error',
							  confirmButtonText: '확인'
							})
						}
					}

				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
		} else {
			$.ajax({
				url: url,
				type: "POST",
				data: json,
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},

				success: function(res) {
					let trTags = "";
					let result = res.errors;
					console.log(res);
					if (result) {
						if (result.rslt == "success") {
							trTags = makeTrTag(res.itemVO)
							console.log(res.itemVO);
							$('.list').prepend(trTags);
							Swal.fire({
								  title: '등록완료!',
								  text: '등록이 성공적으로 완료되었습니다.',
								  icon: 'success',
								  confirmButtonText: '확인'
								})
							createWindowModal.hide();
							$('.modal-backdrop').remove();
							$('#createWindow').find('input').val('');
							$('#itemBooleanInput').prop('checked', false);
						} else if (result.rslt == "fail") {
							$.each(result, function(fieldName, errorMessage) {
								let errorId = '#' + fieldName + 'Error';
								$(errorId).text(errorMessage).css("color", "red");
								Swal.fire({
								  title: '등록실패!',
								  text: '등록이 실패했습니다.',
								  icon: 'error',
								  confirmButtonText: '확인'
								})
								$(fieldName + 'Input').focus();
							});
						}
					}

				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
		}
	});
	
		
	/* 상세폼 띄우기 */
	function modalTitle(titleText) {
	    let title = $('#createWindowLabel');
	    title.text(titleText);
	}
	let toggleSelect;
	// 모달 열릴 때 이벤트
	
	// 각자 클릭 이벤트로 이동
/*	$(document).on('show.bs.modal', '#createWindow', function (event) {
	    // 수정일 경우
	    if (!isCreate) {
	    	//품목코드 숨김
	    	$('#itemCdDiv').hide();
	    	//모달 타이틀 지정
			let itemName = titleValue.closest('tr').find('td:eq(1)').text();
	        modalTitle(itemName + " 상세 정보 ");
	        $('#buttonSpace').html('');
	        createButton('updateBtn', '수정하기');
	        
	        //itemForm의 id를 update로 변경
	        
	    	toggleSelect = 'update';  
	        let selectedTr = titleValue.closest('tr');

	        // 선택한 tr 안의 값들 가져오기 
	        
	        let itemCd = selectedTr.find('#itemCd').text();
	        let itemNm = selectedTr.find('#itemNm').text();
	        let itemUnit = selectedTr.find('#itemUnit').text();
	        let itemNmCate = selectedTr.find('#itemNmCate').text();
	        let itemCdCate = selectedTr.find('#itemCdCate').val();
	        let itemSafeQty = selectedTr.find('#itemSafeQty').val();
	        let itemYn = selectedTr.find('#itemYn').val();
	        let itemNote = selectedTr.find('#itemNote').val();
	        let itMaker = selectedTr.find('#itMaker').val();
	        let itWght = selectedTr.find('#itWght').val();
			let itColor = selectedTr.find('#itColor').val();
			
			let itemInpr = selectedTr.find('#itemInpr').text();
			let itemOutpr = selectedTr.find('#itemOutpr').text();
			let itemBoolean = false;
			if(itemSafeQty == "null") 
				itemSafeQty = "";
			if(itemYn == null || itemYn == "N") {
				itemBoolean = true; //체크(true)하면 사용중단
			} else{
				itemBoolean = false;
			}
			if (itemNote === "null") 
			    itemNote = "";
			if (itMaker === "null") 
			    itMaker = "";
			if (itWght === "null") 
			    itWght = "";
			if (itColor === "null") 
			    itColor = "";
				
			$('input[name="itemCd"]').val(itemCd);
	        $('input[name="itemNm"]').val(itemNm);
	        $('input[name="itemUnit"]').val(itemUnit);
	        $('#groupNmInput').val(itemNmCate);
	        $('#groupCdInput').val(itemCdCate);
	        $('input[name="itemSafeQty"]').val(itemSafeQty);
	        $('input[id="itemBooleanInput"]').prop('checked', itemBoolean);
	        $('input[name="itemYn"]').val(itemYn);
	        $('input[name="itemNote"]').val(itemNote);
	        $('input[name="itMaker"]').val(itMaker);
	        $('input[name="itWght"]').val(itWght);
	        $('input[name="itColor"]').val(itColor);
	      
	        $('input[name="itemInpr"]').val(itemInpr);
	        $('input[name="itemOutpr"]').val(itemOutpr);
	      	
			let itemYndata = $('#itemYnData').val();
			if(itemYndata==='Y'){
		    	//사용/미사용 버튼 생성
		        let unUseBtn = document.createElement('button');
			    unUseBtn.id = 'unUseBtn';
			    unUseBtn.innerText = '품목 미사용';
			    unUseBtn.type = 'button';
			    unUseBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1';
				unUseBtn.setAttribute('data-code', itemCd);
			    $('#buttonSpace').append(unUseBtn);
			}else{
				//사용/미사용 버튼 생성
		        let useBtn = document.createElement('button');
			    useBtn.id = 'useBtn';
			    useBtn.innerText = '품목사용';
			    useBtn.type = 'button';
			    useBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1';
				useBtn.setAttribute('data-code', itemCd);
			    $('#buttonSpace').append(useBtn);
			}
		   
		// 등록일 경우
	    } else{
	    	//품목코드 숨김
    		$('#itemCdDiv').show();
	 		toggleSelect = 'insert';     
	        modalTitle("품목 등록");
	        $('#buttonSpace').html('');
	        createButton('resultBtn', '저장하기');
    	}
	 });*/
	$(document).on('click','#autoBtn', function() {
		$('#itemCdInput').val('D017GD001');
		$('#itemNmInput').val('수정고데기');
		$('#itemUnitInput').val('EA');
		$('#itemSafeQtyInput').val(100);
		$('#itMakerInput').val('고데귀');
		$('#itWghtInput').val('300g');
		$('#itColorInput').val('빨강색');
		$('#itemNoteInput').val('신규제품');
	})
	 //동적으로 버튼만들어주는 함수
	function createButton(id, text, yn) {
	    let buttonType = "submit";
	    let classToApply = "ml-1 btn btn-outline-primary rounded-capsule mt-2"; // 기본 클래스
	
	    if (yn === "y") {
	        buttonType = "button";
	        classToApply = "btn btn-outline-primary me-1 mb-1 rounded-capsule mt-2"; // 대체할 클래스
	    }
	
	    let buttonHtml = `<button class="${classToApply}" type="${buttonType}" id="${id}" style="margin-right:15px;">${text}</button>`;
	    $('#buttonSpace').append(buttonHtml);
	}
     
     $(document).on('click','#updateBtn',function(){
		$('.modal-backdrop').remove();
		createWindowModal.hide();
	 })
     $(document).on('click','#unUseBtn',function(){
		let itemCd = $(this).data('code');
		let url = `${baseUrl}/${itemCd}`;
		console.log(url);
		Swal.fire({
		  title: "미사용 처리 하시겠습니까?",
		  text: "미사용 처리시 일반조회에서 조회되지 않습니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "미사용",
		  cancelButtonText: "취소" 
		}).then((result) => {
		  if (result.isConfirmed) {
				$.ajax({
					url: url,
					type: "PUT",				
					headers: {
						"Content-Type": "application/json;charset=UTF-8"
					},
		
					success: function(res) {	
						console.log(res);				
						if (res == "success") {
							$('#dataTable').DataTable().destroy();
							$('.list').html('');
							$('#searchForm').submit();
							Swal.fire({
						      title: "미사용 처리 완료되었습니다",
						      text: "해당 품목을 다시 보시려면 미사용 품목 버튼을 눌러주세요 ",
						      icon: "success"
						    });
							$('.modal-backdrop').remove();
							createWindowModal.hide();
						} else if (res == "fail") {
							//이건 토스트 ui든 수정해야함
							Swal.fire({
						      title: "존재하지 않는 품목입니다.",
						      icon: "error"
						    });
							createWindowModal.hide();
							$('.modal-backdrop').remove();
						}
						$('.modal-backdrop').remove();
					},
					error: function(error) {
						console.error('Ajax 요청 실패:', error);
					}
				});
		  }
		
		});
	});
	
	
	$(document).on('click','#itemLink', function() {
        createWindowModal.show();

		let selectValue = $(this).closest('tr');
		//품목코드 숨김
    	$('#itemCdDiv').hide();
    	//모달 타이틀 지정
		let itemName = selectValue.closest('tr').find('td:eq(1)').text();
        modalTitle(itemName + " 상세 정보 ");
        $('#buttonSpace').html('');
        createButton('updateBtn', '수정하기');
        
        //itemForm의 id를 update로 변경
        
    	toggleSelect = 'update';  
        let selectedTr = selectValue.closest('tr');

        // 선택한 tr 안의 값들 가져오기 
        
        let itemCd = selectedTr.find('#itemCd').text();
        let itemNm = selectedTr.find('#itemNm').text();
        let itemUnit = selectedTr.find('#itemUnit').text();
        let itemNmCate = selectedTr.find('#itemNmCate').text();
        let itemCdCate = selectedTr.find('#itemCdCate').val();
        let itemSafeQty = selectedTr.find('#itemSafeQty').val();
        let itemYn = selectedTr.find('#itemYn').val();
        let itemNote = selectedTr.find('#itemNote').val();
        let itMaker = selectedTr.find('#itMaker').val();
        let itWght = selectedTr.find('#itWght').val();
		let itColor = selectedTr.find('#itColor').val();
		
		let itemInpr = selectedTr.find('#itemInpr').text();
		let itemOutpr = selectedTr.find('#itemOutpr').text();
		let itemBoolean = false;
		if(itemSafeQty == "null") 
			itemSafeQty = "";
		if(itemYn == null || itemYn == "N") {
			itemBoolean = true; //체크(true)하면 사용중단
		} else{
			itemBoolean = false;
		}
		if (itemNote === "null") 
		    itemNote = "";
		if (itMaker === "null") 
		    itMaker = "";
		if (itWght === "null") 
		    itWght = "";
		if (itColor === "null") 
		    itColor = "";
			
		$('input[name="itemCd"]').val(itemCd);
        $('input[name="itemNm"]').val(itemNm);
        $('input[name="itemUnit"]').val(itemUnit);
        $('#groupNmInput').val(itemNmCate);
        $('#groupCdInput').val(itemCdCate);
        $('input[name="itemSafeQty"]').val(itemSafeQty);
        $('input[id="itemBooleanInput"]').prop('checked', itemBoolean);
        $('input[name="itemYn"]').val(itemYn);
        $('input[name="itemNote"]').val(itemNote);
        $('input[name="itMaker"]').val(itMaker);
        $('input[name="itWght"]').val(itWght);
        $('input[name="itColor"]').val(itColor);
      
        $('input[name="itemInpr"]').val(itemInpr);
        $('input[name="itemOutpr"]').val(itemOutpr);
      	
		let itemYndata = $('#itemYnData').val();
		if(itemYndata==='Y'){
	    	//사용/미사용 버튼 생성
	        let unUseBtn = document.createElement('button');
		    unUseBtn.id = 'unUseBtn';
		    unUseBtn.innerText = '품목 미사용';
		    unUseBtn.type = 'button';
		    unUseBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1';
			unUseBtn.setAttribute('data-code', itemCd);
		    $('#buttonSpace').append(unUseBtn);
		}else{
			//사용/미사용 버튼 생성
	        let useBtn = document.createElement('button');
		    useBtn.id = 'useBtn';
		    useBtn.innerText = '품목사용';
		    useBtn.type = 'button';
		    useBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1';
			useBtn.setAttribute('data-code', itemCd);
		    $('#buttonSpace').append(useBtn);
		}
    });

	$(document).on('click','#createBtn', function() {
        createWindowModal.show();
		
		//품목코드 숨김
		$('#itemCdDiv').show();
 		toggleSelect = 'insert';     
        modalTitle("품목 등록");
        $('#buttonSpace').html('');
        createButton('resultBtn', '저장하기','n');
        createButton('autoBtn', '자동입력','y');

    });
	
  	$(document).on('click','#useBtn',function(){
		let itemCd = $(this).data('code');
		let url = `${baseUrl}/use/${itemCd}`;
		console.log(url);
		Swal.fire({
		  title: "품목을 다시 사용 하시겠습니까?",
		  text: "사용 처리시 일반조회에서 다시 조회가 가능 합니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "사용",
		  cancelButtonText: "취소" 
		}).then((result) => {
		  	if (result.isConfirmed) {
				$.ajax({
					url: url,
					type: "PUT",				
					headers: {
						"Content-Type": "application/json;charset=UTF-8"
					},
		
					success: function(res) {	
						console.log(res);				
						if (res == "success") {
							$('#dataTable').DataTable().destroy();
							$('.list').html('');
							$('#searchForm').submit();
							Swal.fire({
						      title: "사용 처리 완료되었습니다",
						      text: "해당 품목을 다시 조회 하실수 있습니다.",
						      icon: "success"
						    });
							createWindowModal.hide();
							$('.modal-backdrop').remove();
						} else if (res == "fail") {
							//이건 토스트 ui든 수정해야함
							Swal.fire({
						      title: "존재하지 않는 품목입니다.",
						      icon: "error"
						    });
							$('.modal-backdrop').remove();
							createWindowModal.hide();
							$('.modal-backdrop').remove();
						}
						$('.modal-backdrop').remove();
					},
					error: function(error) {
						console.error('Ajax 요청 실패:', error);
					}
				});
		  	}
		});
	});
});