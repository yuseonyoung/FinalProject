/**
 * <pre>
 * 
 * </pre>
 * @author 이수정
 * @since 2023. 11. 19.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 19.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
console.log("gg");
let cPath = $('.pageConversion').data('contextPath');
console.log(cPath);




/* 메일 상세조회 div*/
let makeMail = function(rslt) {
	console.log("dddddddddddkkkkk")
	console.log(rslt.empImg);
	let mail =
		`
		<div class="col-md d-flex">
        	<div class="avatar avatar-2xl">
            	<img class="rounded-circle" src="${rslt.empImg}"/>
            </div>
            <div class="flex-1 ms-2">
            	<h5 class="mb-0">${rslt.mailTitle}</h5><a class="text-800 fs--1" href="#!"><span class="fw-semi-bold">${rslt.senNm}</span><span class="ms-1 text-500">&lt;${rslt.senCmail}&gt;</span></a>
            </div>
       	</div>
       	<div class="col-md-auto ms-auto d-flex align-items-center ps-6 ps-md-3"><small>${rslt.mailDate}</small></div>
        </div>
		<div class="d-inline-flex flex-column">
        </div>
		<div class="card-body bg-light" style="min-height: 600px;">
        <div >
            <div class="col-lg-8 col-xxl-6" style="width: auto";>
              <div class="card shadow-none mb-3" style="margin-left:100px; margin-right:100px;">
				<img class="card-img-top" src="../../assets/img/icons/spot-illustrations/international-women-s-day-2.png" alt="" />
                <div class="card-body" style="min-height: 550px">
                  <h3 class="fw-semi-bold">${rslt.mailTitle}</h3>
                  <p>${rslt.mailCont}</p>
                </div>
              </div>
            </div>
          </div>
		</div>
	    `;
	return mail;
};


/* 상세조회 ajax */
function retrieveMail() {
	var currentUrl = window.location.href;
	var spliturl = currentUrl.split('/mail/');
	var realurl = spliturl[1].trim();
	console.log("realurl"+realurl);
	console.log("substringResult"+realurl);
	let baseUrl = `${cPath}/mail/view/${realurl}`;
	console.log(baseUrl);
	$.ajax({
		url: baseUrl,
		method: "GET",
		contentType: 'application/json',
		dataType: "json",
		success: function(resp) {
			
			let mailVO = resp.mailVO;
			console.log("4545454545454545");
			console.log(resp);
			console.log(resp.mailVO.empImg);
			let mails = "";
			let mailAtt="";
			console.log(mailVO.attatchList.length);
			
		
			if (mailVO!=null) {
				console.log("ok")
						mails += makeMail(mailVO);
						console.log(mails);
						
			} else {
				console.log("no")
				mails += `
							<tr>
								<td class="text-nowrap">메일이 없습니다.</td>
							</tr>
						`;
			}

           
		async function processAttachments() {
		    if (mailVO.attatchList != null) {
		        for (let i = 0; i < mailVO.attatchList.length; i++) {
		            console.log(mailVO.attatchList[i].mailOrgNm);
		            mailAtt += `<div class="border px-2 rounded-3 bg-white dark__bg-1000 my-1 fs--1">
		                            <span class="fs-1 far fa-file-archive"></span>
		                            <a href="/mail/${mailVO.mailNo}/mailFile/${mailVO.attatchList[i].mailAtchNo}"><span class="ms-2">${mailVO.attatchList[i].mailOrgNm} (${mailVO.attatchList[i].mailAtchFancysize})</span></a>
		                        </div>`;
		        }
		    } else {
		        mailAtt += `<p>첨부파일이 없습니다.</p>`;
		    }
		    console.log(mailAtt);
		    $('.list').html(mails);
		    $('.d-inline-flex.flex-column').html(mailAtt);
		}
		
		processAttachments();
					

			  
		},
		error: function(xhr, status, error) {
				Swal.fire({
	                icon: 'error',
	                title: '실패',
	                text: '존재하지 않는 메일입니다.'
	            }).then(function(){
					location.href="/mail/list";                   
				})
			console.log(xhr);
			console.log(status.reason);
			console.log(error);
		}
	});
};
retrieveMail();
