/**
 * <pre>
 * 
 * </pre>
 * @author 우정범
 * @since 2023. 11. 17.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        		   수정자              수정내용
 * --------    		 --------    ----------------------
 * 2023. 11. 17.       우정범              최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
	var authFn = function(value){
	console.log("값변경테스트: " + value);
	console.log(res.empVO)
	//empVO.setEmpAuth(value);
}
$(function(){
	let cPath = $('.pageConversion').data('contextPath');
	const baseUrl = `${cPath}/account/list`;
	
	let makeSelect = function(rslt){
		let selectTag = `
		<option value="${rslt.authCd}">${rslt.authCd}</option>
		`;
		return selectTag;
	}

	let makeUseSel = function(rslt){
		let selectTag2 = `
		<option value="${rslt.commCdNm}">${rslt.commCdNm}</option>
		`;
		return selectTag2;
	}
 


	  /* 아작스를 위한 데이터 설정 */
	let makeTrTag = function (rslt) {
    let trTag = `
        <tr>
            <td id="empCd" value="${rslt.empCd}"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.empCd}</a></td>
            <td id="empNm">${rslt.empNm}</td>
            <td id="deptNm">${rslt.deptNm}</td>
			<td><select class="authSelect" name="empAuth" onchange="authFn(this.value);">
			</select></td>
            <td id="hrCharge">${rslt.hrCharge}</td>
            <td><select class="useSelect" name="empUse">
			</select></td>
			<input type="hidden" id="empPpw" value="${rslt.empPpw}"/>
        </tr>
	    `;	
	    return trTag;
	};
	

	/* 조회 함수 */
	function retrieveAccount(){
		$.ajax({
			url: baseUrl,
			method: "GET",
			contentType: 'application/json',
			dataType: "json",
			success: function (resp) {
				let empList = resp.empList;
				console.log(resp.authList);
				console.log(resp.useList);
				console.log(resp.empList);
				let trTags = "";
				let selectTags ="";
				let selectTags2 ="";
				
				if (empList?.length > 0) {
					for(let i=0; i< empList.length; i++){
						if(empList[i].empAuth!=null)
							trTags += makeTrTag(empList[i]);
					};
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='7'>등록된 계정이 없습니다.</td>
							</tr>
						`;
				}
				
				
				if (resp.authList?.length > 0) {
					$.each(resp.authList, function () {
						selectTags += makeSelect(this);
					});
					
				}

				if (resp.useList?.length > 0) {
					$.each(resp.useList, function () {
						selectTags2 += makeUseSel(this);
					});
					
				}
		
				
				$('.list').html(trTags);
				$('.authSelect').html(selectTags);
				$('.useSelect').html(selectTags2);

				// 해당 auth 선택!
				let authSel = document.querySelectorAll(".authSelect");
				let empCd = document.querySelectorAll("#empCd");
				console.log(empCd[0].innerText)
				for(let i=0; i< authSel.length; i++){
					for(let j=0; j<empList.length; j++){
						if(empList[j].empCd==empCd[i].innerText)
							authSel[i].value = empList[j].empAuth;
							//console.log(authSel[i].value,empList[j].empAuth)
					}
					
				}
				
				
				// 해당 use 선택!
				let useSel = document.querySelectorAll(".useSelect");
				console.log(empCd[0].innerText)
				for(let i=0; i< useSel.length; i++){
					for(let j=0; j<empList.length; j++){
						if(empList[j].empCd==empCd[i].innerText)
							useSel[i].value = empList[j].empUse;
							console.log(useSel[i].value,empList[j].empUse)
					}
					
				}
/*
				let useSel = document.querySelectorAll(".useSelect");
				for(let i=0; i< useSel.length; i++){
					console.log(useSel[i].value, empList[i].empUse);
					useSel[i].value = empList[i].empUse;
				}
*/


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
	};
	/*초기 리스트 띄우는 함수호출*/
	retrieveAccount();
	
	
	/* 수정, 등록폼 동시사용*/
	$(document).on('submit', '#empForm', function(event) {
		
		var csrfToken = document.querySelector("input[name='_csrf']").value;
		event.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;
		console.log(this);
		console.log(toggleSelect);
		let url = this.action;
		let data = $(this).serializeJSON();
		
		let json = JSON.stringify(data);
		console.log(data);
		if (formMode == 'insert') {

			$.ajax({
				url: url,
				type: "POST",
				headers: {
	               'Content-Type': 'application/x-www-form-urlencoded',
	               'X-CSRF-TOKEN': csrfToken
          		},
				data: json,
				headers: {
					"Content-Type": "application/json;charset=UTF-8"
				},

				success: function(res) {
					let trTags = "";
					let result = res.errors;
					if (result) {
						console.log(result.rslt)
						if (result.rslt == "success") {
							$('#dataTable').DataTable().destroy();
							trTags = makeTrTag(res.empVO)
							$('.list').prepend(trTags);
							retrieveAccount();
							createWindowModal.hide();
							$('.modal-backdrop').remove();
							
						} else if (result.rslt == "fail") {
							$.each(res.errors, function(fieldName, errorMessage) {
								let errorId = fieldName;
								$('#' + errorId).text(errorMessage);
								
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
	

	

	
	$(document).on('click', '#updateBtn', function() {
		console.log(document.querySelectorAll(".authSelect"));
		console.log("gg");
		auth
		let url = `${cPath}/account/edit`;
		let data = $(this).serializeJSON();
		
		let json = JSON.stringify(data);
		console.log(data);
		
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
							createWindowModal.hide();
							$('.modal-backdrop').remove();
							
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
		});
	
	let toggleSelect;
	let createWindowModal = new bootstrap.Modal($('#createWindow')[0]);
	
	$(document).on('show.bs.modal', '#createWindow', function (event) {
	    //이벤트 타겟을 가져옴
	    let titleValue = $(event.relatedTarget);
	    console.log(titleValue);
	    if (titleValue.is('button')) {
	    	toggleSelect = 'insert';  
	        
			
		}
	   
	 });
	
});

