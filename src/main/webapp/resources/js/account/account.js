/**
 * <pre>
 * 
 * </pre>
 * @author 이수정
 * @since 2023. 11. 14.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        		   수정자              수정내용
 * --------    		 --------    ----------------------
 * 2023. 11. 14.       이수정              최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

let cPath = $('.pageConversion').data('contextPath');
const emp = {
    empAuth: new Map()
	
};

let empAuthObject = {};

function setEmpAuth(key, value) {
    emp.empAuth.set(key, value); // Map의 set 메소드를 사용하여 값을 설정

}


function getEmpAuth() {
    return emp.empAuth;
}


var authFn = function(authCd) {
    var empCd = authCd.closest(".aa").previousElementSibling.previousElementSibling.previousElementSibling.innerText;
    var empUse = authCd.closest(".aa").nextElementSibling.nextElementSibling.innerText;
	console.log(empUse);
    // 기존의 Map 객체 가져오기
    var empMap = getEmpAuth();
    // 기존 Map 객체에 새로운 키-값 추가
    setEmpAuth("empCd", empCd);
    setEmpAuth("empAuth", authCd.value);
    // 값을 가져오려면 getEmpAuth 함수를 사용
    console.log(empMap.get(empCd));
    console.log(empMap);
    empAuthObject = Object.fromEntries(Array.from(emp.empAuth.entries()));
	console.log(empAuthObject);
}

var useFn = function(empUse) {
    var empCd = empUse.closest(".bb").previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
	console.log(empCd)
    // 기존의 Map 객체 가져오기
    // 기존 Map 객체에 새로운 키-값 추가
    setEmpAuth("empCd", empCd);
    setEmpAuth("empUse", empUse.value);
    // 값을 가져오려면 getEmpAuth 함수를 사용
    //console.log(empMap.get(empCd));
    empAuthObject = Object.fromEntries(Array.from(emp.empAuth.entries()));
	console.log(empAuthObject);
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
    let trTag = 
		`
        <tr>
            <td class="empCd" value="${rslt.empCd}"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#createWindow">${rslt.empCd}</a></td>
            <td class="empNm">${rslt.empNm}</td>
            <td class="deptNm">${rslt.deptNm}</td>
			<td class="aa">
				<select class="authSelect" name="empAuth" onchange="authFn(this);">
				</select></td>
            <td class="hrCharge">${rslt.hrCharge}</td>
            <td class="bb" value="${rslt.empUse}">
				<select class="useSelect" name="empUse" onchange="useFn(this);">
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
				let empCd = document.querySelectorAll(".empCd");
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
/*

				$('#dataTable').DataTable({
			        paging: true,
			        searching: true,
			        lengthChange: false,
			        info: false,
			        ordering: false
			    });
				*/
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});	
	};
	/*초기 리스트 띄우는 함수호출*/
	/* retrieveAccount(); */
	
	//var g_empVo;
	
	/*
	$(document).on('submit', '#empForm', function(event) {
		event.preventDefault();
		$('span.error').text('');
		let formMode = toggleSelect;
		console.log(this);
		console.log(toggleSelect);
		let url = this.action;
		let data = $(this).serializeJSON();
		let json = JSON.stringify(data);
		console.log(json);
		if (formMode == 'insert') {
		$.ajax({
			url: url,
			type: "POST",
			contentType: "application/json;charset=UTF-8",
			data: json,
			success: function(res) {
				console.log(res);
				let trTags = "";
				let result = res.errors;
				console.log(res.errors);
				if (result) {
					console.log(result.rslt)
					if (result.rslt == "success") {
						$('#dataTable').DataTable().destroy();
						
						g_empVo = res.empVO;
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
	*/
	
	$(document).on('click', '#updateBtn', function() {
		console.log(document.querySelectorAll(".authSelect"));
		let url = `${cPath}/account/edit`;
		console.log($(empAuthObject));
		
		let json = JSON.stringify(empAuthObject);
		console.log(json);
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
					console.log(res.errors);
					if (result) {
						if (result.rslt == "success") {
							$('.list').html('');
							retrieveAccount();
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



	
	$("#insertBtn").on("click", function(){
		console.log("ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
		$.ajax({
			url : `${cPath}/account/newEmpList`,
			type: "post",
			contentType: "application/json",
			dataType: "json",
			success : function(res){
				var html = "<option >선택</option>";
				for(var i = 0; i < res.length; i++){
					html += "<option value='"+res[i].empCd+"'>"+res[i].empNm+"("+res[i].empCd+")"+"</option>";
				};
				$("#empCdInput").html(html);
			}
		});
		
		$("#createWindow").modal("show");
	});

	$(".list").on("click", ".udtBtn", function(){
		var cd = $(this).data("cd");
		var auth = $(this).parents("tr").find("td:eq(3)").find("select")[0].value;
		/*var use = $(this).parents("tr").find("td:eq(5)").find("select")[0].value;*/
		
		/*console.log(cd + ",,,," + auth + ",,,,,0" + use);*/
		var html = "<input type='hidden' name='empCd' value='"+cd+"'/>";
		html += "<input type='hidden' name='empAuth' value='"+auth+"'/>";
		/*html += "<input type='hidden' name='empUse' value='"+use+"'/>";*/
		$("#editForm").append(html);
		$("#editForm").submit();
	});



});

