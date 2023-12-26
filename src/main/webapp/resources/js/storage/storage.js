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
 * 2023. 11. 10      유선영       조회
 * 2023. 11.11~13    유선영       등록
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


	
$(function(){	
	
	let usageStatusCount =0;
	
	//창고 사용 미사용 여부에 따른 조회
	$('#usageStatus').on('click',function(){
		
		if (usageStatusCount % 2 === 1) {
        	$(this).removeClass('btn-primary').addClass('btn-outline-primary');
	    } else {
	        $(this).removeClass('btn-outline-primary').addClass('btn-primary');
	    }
		
		usageStatusCount++;
		dataTables.destroy();
		$('.list').empty();
		retrieveWare();
	})
	
	/* 사원조회 dataTable 적용*/
	$('#empTable').DataTable({
		        paging: true,
		        searching: true,
		        lengthChange: false,
		        info: false,
		        ordering: false
	});

		
	/* 우편번호를 위한 설정 */
	 function sample4_execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function (data) {
		            const { address } = data;
		
		            new Promise((resolve, reject) => {
		                const geocoder = new daum.maps.services.Geocoder();
		
		                geocoder.addressSearch(address, (result, status) => {
		                    if (status === daum.maps.services.Status.OK) {
		                        const { x, y } = result[0];
		                        resolve({ lat: y, lon: x });
		                    } else {
		                        reject();
		                    }
		                });
		            }).then(result => {
		                console.log(result);
		
		                // 얻어온 좌표를 이용하여 입력란 채우기
		                document.getElementById("sample4_roadAddress").value = address;  // 도로명주소
		                document.getElementById("sample4_detailAddress").value = "";  // 상세주소 초기화
		                document.getElementById("sample4_postcode").value = data.zonecode;  // 우편번호
		                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;  // 지번주소
		                document.getElementById("sample4_extraAddress").value = data.extraAddress;  // 참고항목
		
		                // 원하는 작업을 추가로 수행할 수 있습니다.
		            }).catch(error => {
		                console.error("Error getting coordinates:", error);
		            });
		        },
		        width: "100%",
		        height: window.innerHeight
		    }).embed(".pageConversion");
		}
	
     /* 아작스를 위한 데이터 설정 */
	let makeTrTag = function (rslt) {
		let mapLink = '';
		let trStyle = '';
		if (rslt.wareAddr) {
	        mapLink = `<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#mapWindow" data-address="${rslt.wareAddr}">지도</a>`;
	    }

		if (rslt.wareTemp === 'N') {
			console.log('들어오긴하지?');
		    trStyle = 'background-color: red;';
		}
		
		if(usageStatusCount%2==0){
		    if(rslt.wareTemp=='Y'){
				let trTag = `
			        <tr style="${trStyle}">
			            <td id="wareCd"><a href="javascript:;" id="wareLink">${rslt.wareCd}</a></td>
			            <td id="wareNm">${rslt.wareNm}</td>
			            <td id="wareItem" style="text-align: center;">${rslt.wareItem}</td>
			            <td id="wareAddr">${rslt.wareAddr || ''}</td>
			            <td id="empNm" style="text-align: center;">${rslt.empNm}</td>
			            <td style="text-align: center;">${mapLink}</td>
			            <input type="hidden" id="wareWidth" value="${rslt.wareWidth}"/>
			            <input type="hidden" id="wareY" value="${rslt.wareY}"/>
			            <input type="hidden" id="wareDetail" value="${rslt.wareDetail !== undefined ? rslt.wareDetail : ''}"/>
			            <input type="hidden" id="wareZip" value="${rslt.wareZip}"/>
			            <input type="hidden" id="empCd" value="${rslt.empCd}"/>
			        </tr>
				    `;	
				    return trTag;
			}
		}else{
			let trTag = `
			        <tr>
			            <td id="wareCd"><a href="javascript:;" id="wareLink">${rslt.wareCd}</a></td>
			            <td id="wareNm">${rslt.wareNm}</td>
			            <td id="wareItem" style="text-align: center;">${rslt.wareItem}</td>
			            <td id="wareAddr">${rslt.wareAddr || ''}</td>
			            <td id="empNm" style="text-align: center;">${rslt.empNm}</td>
			            <td style="text-align: center;">${mapLink}</td>
			            <input type="hidden" id="wareWidth" value="${rslt.wareWidth}"/>
			            <input type="hidden" id="wareY" value="${rslt.wareY}"/>
			            <input type="hidden" id="wareDetail" value="${rslt.wareDetail !== undefined ? rslt.wareDetail : ''}"/>
			            <input type="hidden" id="wareZip" value="${rslt.wareZip}"/>
			            <input type="hidden" id="empCd" value="${rslt.empCd}"/>
			            <input type="hidden" id="wareTemp" value="${rslt.wareTemp}"/>
			        </tr>
				    `;	
				    return trTag;
		}
		
	}
	

	let dataTables; 
	let cPath = $('.pageConversion').data('contextPath');
	const baseUrl = `${cPath}/stor`;
	/* 조회 함수 */
	function retrieveWare(){
		$.ajax({
			url: baseUrl,
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let wareList = resp.wareList;
				let trTags = "";
		
				if (wareList?.length > 0) {
					$.each(wareList, function () {
						trTags += makeTrTag(this);
					});
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 창고가 없습니다.</td>
							</tr>
						`;
				}
				$('.list').html(trTags);
			
				dataTables = $('#dataTable').DataTable({
			        	paging: true,
				        searching: true,
				        lengthChange: false,
				        info: false,
				        ordering: false,
						rowCallback: function(row, data, index) {
						   let wareTemp = $(row).find('#wareTemp').val();
						   
			               $(row).removeClass('even odd');
						   
						   if (wareTemp === 'N') {
					           $(row).addClass('red-background');
					       }
						}
				    });

				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});	
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveWare();
	
	
	/* 수정, 등록폼 동시사용*/
	$(document).on('submit', '#wareForm', function(event) {
		event.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;

		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);

		if (formMode == 'update') {
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
							$('.list').html('');
							retrieveWare();
							Swal.fire({
							  title: '수정완료!',
							  text: '수정이 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
							})
							$('#guide').css('display', 'none');
							createWindowModal.hide();
							
							$('.modal-backdrop').remove();
							
						} else if (result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage) {
								let errorId = fieldName;
								console.log(errorId);
								$('#' + errorId).text(errorMessage);
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
					if (result) {
						if (result.rslt == "success") {
							trTags = makeTrTag(res.storVO)
							$('.list').prepend(trTags);
								Swal.fire({
								  title: '등록완료!',
								  text: '등록이 성공적으로 완료되었습니다.',
								  icon: 'success',
								  confirmButtonText: '확인'
								})
								
								 $('#wareNmInput').val('');
							    $('#wareInput').val('');
							    $('#wareWidthInput').val('');
							    $('#wareYInput').val('');
							    $('#empNmInput').val('');
							    $('#sample4_roadAddress').val('');
							    $('#sample4_detailAddress').val('');
							    $('#sample4_postcode').val('');
							    
							    // 기타 초기화 작업 추가
							    $('#guide').css('display', 'none');
							    // 에러 메시지 초기화
							    $('#wareNmError').text('');
							    $('#wareItemError').text('');
							    $('#wareWidthError').text('');
							    $('#wareYError').text('');
							    $('#empCdError').text('');
							    $('#wareAddrError').text('');
							    $('#wareAddrDetailError').text('');
							    $('#wareZipError').text('');
							    
							    // hidden 필드 초기화
			
							    $('#hiddenCode').val('');
							    $('#sample4_jibunAddress').val('');
							    $('#sample4_extraAddress').val('');
							createWindowModal.hide();
							$('.modal-backdrop').remove();
						} else if (result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage) {
								let errorId = fieldName+'Error';
								document.getElementById(errorId).textContent = errorMessage;
								Swal.fire({
								  title: '등록실패!',
								  text: '등록이 실패했습니다.',
								  icon: 'error',
								  confirmButtonText: '확인'
								})
								console.log(errorId);
								console.log(errorMessage);
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

	
	/*
		상세폼 띄우기
	*/
	function modalTitle(titleText) {
	    let title = $('#createWindowLabel');
	    title.text(titleText);
	}
	
	let toggleSelect;
	
	$('#autoData').on('click',function(){
		$('#wareNmInput').val('AIM4창고');
		$('#wareWidthInput').val(500);
		$('#wareYInput').val(500);
	})
	
	
	$(document).on('click','#wareLink', function() {
        createWindowModal.show();

	    let selectValue = $(this).closest('tr');

        let wareCode = selectValue.closest('tr').find('td:eq(1)').text();
        modalTitle(wareCode + " 창고 상세 정보 ");
        $('#buttonSpace').html('');
		createButton('updateBtn', '수정하기');
        
        //wareForm의 id를 update로 변경
    	toggleSelect = 'update';  
        let selectedTr = selectValue.closest('tr');

        // 선택한 tr 안의 값들 가져오기 
        
        let wareCd = selectedTr.find('#wareCd').text();
        let wareNm = selectedTr.find('#wareNm').text();
        let wareItem = selectedTr.find('#wareItem').text();
        let wareAddr = selectedTr.find('#wareAddr').text();
        let empNm = selectedTr.find('#empNm').text();
        let empCd = selectedTr.find('#empCd').val();
        let wareWidth = selectedTr.find('#wareWidth').val();
        let wareY= selectedTr.find('#wareY').val();
        let wareDetail = selectedTr.find('#wareDetail').val();
        let wareZip = selectedTr.find('#wareZip').val();
		let wareTemp = selectedTr.find('#wareTemp').val();
		$('input[name="wareCd"]').val(wareCd);
        $('input[name="wareNm"]').val(wareNm);
        $('input[name="wareItem"]').val(wareItem);
        $('input[name="wareWidth"]').val(wareWidth);
        $('input[name="wareY"]').val(wareY);
        $('input[name="empCd"]').val(empCd);
        $('input[name="empNm"]').val(empNm);
        $('input[name="wareAddr"]').val(wareAddr);
        $('input[name="wareAddrDetail"]').val(wareDetail);
        $('input[name="wareZip"]').val(wareZip);
      	
		if(wareTemp=='Y' || wareTemp==undefined){
	    	//사용/미사용 버튼 생성
	        let unUseBtn = document.createElement('button');
		    unUseBtn.id = 'unUseBtn';
		    unUseBtn.innerText = '창고 미사용';
		    unUseBtn.type = 'button';
		    unUseBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mt-2';
			unUseBtn.setAttribute('data-code', wareCd);
		    $('#buttonSpace').append(unUseBtn);
		}else{
	        let useBtn = document.createElement('button');
		    useBtn.id = 'useBtn';
		    useBtn.innerText = '창고 사용';
		    useBtn.type = 'button';
		    useBtn.className = 'ml-1 btn btn-outline-primary rounded-capsule mr-1 mt-2';
			useBtn.setAttribute('data-code', wareCd);
		    $('#buttonSpace').append(useBtn);				
		}
    });

	$(document).on('click','#insertBtn', function() {
		$('#createWindow input').val('');
        createWindowModal.show();
		toggleSelect = 'insert';     
        modalTitle("창고 등록");
        $('#buttonSpace').html('');
        createButton('resultBtn', '저장하기','n');
        createButton('autoBtn', '자동입력','y');
    });
	
	
	$(document).on('click','#autoBtn', function() {
		$('#wareNmInput').val('AIM제4창고');
		$('#wareWidthInput').val(500);
		$('#wareYInput ').val(500);
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


	$(document).on('click','#unUseBtn',function(){
		$('.modal-backdrop').remove();
		let wareCd = $(this).data('code');
		let url = `${baseUrl}/${wareCd}`;
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
						retrieveWare();
						
						Swal.fire({
					      title: "미사용 처리 완료되었습니다",
					      text: "해당 품목을 다시 보시려면 미사용 품목 버튼을 눌러주세요 ",
					      icon: "success"
					    });
						createWindowModal.hide();
						$('.modal-backdrop').remove();
					} else if (res == "fail") {
						Swal.fire({
					      title: "존재하지 않는 창고입니다.",
					      icon: "error"
					    });
					}
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
		  }
		});
		
	});
	
	
	
	$(document).on('click','#useBtn',function(){
		let wareCd = $(this).data('code');
		let url = `${baseUrl}/use/${wareCd}`;
		console.log(url);
		Swal.fire({
		  title: "사용 처리 하시겠습니까?",
		  text: "사용 처리시 일반조회가 가능합니다.",
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
						retrieveWare();
						
						Swal.fire({
					      title: "사용 처리 완료되었습니다",
					      text: "해당 품목을 다시 조회 하실 수 있습니다.",
					      icon: "success"
					    });
						createWindowModal.hide();
						$('.modal-backdrop').remove();
					} else if (res == "fail") {
						Swal.fire({
					      title: "존재하지 않는 창고입니다.",
					      icon: "error"
					    });
					}
				},
				error: function(error) {
					console.error('Ajax 요청 실패:', error);
				}
			});
		  }
		});
		
	});
	
	
	$(document).on('show.bs.modal', '#mapWindow', function (e) {
        // 창고 주소 가져오기
        let address = $(e.relatedTarget).data('address');

        // 주소를 좌표로 변환
        let geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status === 'OK') {
                let location = results[0].geometry.location;

                // 지도 생성
                let map = new google.maps.Map(document.getElementById('map'), {
                    center: location,
                    zoom: 20
                });

                // 마커 생성
                new google.maps.Marker({
                    map: map,
                    position: location,
                    title: '창고 위치'
                });
            } else {
                console.error('Geocode was not successful for the following reason: ' + status);
            }
        });
    });

	/*
		아래는 2중모달을 위한 설정 데이터
	*/
	let createWindowModal = new bootstrap.Modal($('#createWindow')[0]);
    let empWindowModal = new bootstrap.Modal($('#empWindow')[0]);
    let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);

    $('.empBtn').on('click', function () {
        createWindowModal.hide();
        empWindowModal.show();
    });
    
    $('.wareBtn').on('click', function () {
        createWindowModal.hide();
        wareWindowModal.show();
    });

    $('.selectItem').click(function (e) {
	    e.preventDefault();
	    let selectedValue = $(this).data('selected-value');
		let selectedEmpCdVal = $(this).parents('tr').find('td:nth-child(1)').text().trim();
	    $('#empNmInput').val(selectedValue);
	    $('#empInput').val(selectedEmpCdVal);
	    empWindowModal.hide();
	
	    createWindowModal.show();
	});
	
    $('.selectWare').click(function (e) {
	    e.preventDefault();
	    let selectedValue = $(this).data('selected-value');
	    $('#wareInput').val('');
		$('#wareInput').val(selectedValue);
	
	    wareWindowModal.hide();
	    createWindowModal.show();
	});
	
	
    $('#empClose').on('click', function () {
        createWindowModal.show();
        empWindowModal.hide();
    });
    $('#wareClose').on('click', function () {
        createWindowModal.show();
        wareWindowModal.hide();
    });
    
    $('#createClose').on('click', function () {
       createWindowModal.hide();
       empWindowModal.hide();
       $('span.error').text('');
       $('.modal-backdrop').remove();
       $('#createWindow').find('input[type="text"], input[type="number"]').val('');

    });
});
		
		
		
		