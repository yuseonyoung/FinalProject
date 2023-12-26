<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-lg-6 pe-lg-2">
	<div class="card mb-3">
		<div class="card-header">
			<h5 class="mb-0">${empInfoVO.empNm} ${empInfoVO.hrGradeNm}</h5>
		</div>
		<div class="card-body bg-light ">
			<form class="row g-3" >
				<div class="col-lg-6">
					<label class="form-label" for="empCd">사원번호</label>
					<input class="form-control" id="empCd" name="empCd" type="text" value="${empInfoVO.empCd}" placeholder="자동생성" readonly>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="empNm">이름</label>
					<input class="form-control" id="empNm" name="empNm" type="text" value="${empInfoVO.empNm}" required readonly>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="empMail">이메일</label>
					<input class="form-control" id="empMail" name="empMail" type="email" value="${empInfoVO.empMail}" required readonly><span id="emailcheck"></span></input>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="empTelNo">전화번호</label>
					<input class="form-control" id="empTelNo" name="empTelNo" type="text" placeholder="숫자만 입력" readonly required value="${empInfoVO.empTelNo}" maxlength='11' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="empZip">우편번호</label>
					<input class="form-control" id="empZip" name="empZip" type="text" value="${empInfoVO.empZip}" readonly required>
				</div>
				<div class="col-lg-2">
					<label class="form-label" for="btnPostCode">&nbsp;</label>
					<input class="form-control btn btn-secondary me-1 mb-1" type="button" name="btnPostCode" id="btnPostCode" value="검색" />
				</div>
				<div class="col-lg-12">
					<label class="form-label" for="empAddr">주소</label>
					<input class="form-control" id="empAddr" name="empAddr" type="text" value="${empInfoVO.empAddr}" readonly required />
				</div>
				<div class="col-lg-12">
					<label class="form-label" for="empDaddr">상세주소</label>
					<input class="form-control" id="empDaddr" name="empDaddr" type="text" readonly value="${empInfoVO.empDaddr}" />
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="deptNo">부서</label>
					<input class="form-select" id="deptNo" name="deptNo" type="text" value="${empInfoVO.deptNm}" readonly required />
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="hrGrade">직급</label>
					<input class="form-select" id="hrGrade" name="hrGrade" type="text" value="${empInfoVO.hrGradeNm}" readonly required/>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="hrCharge">직책</label>
					<input class="form-select" id="hrCharge" name="hrCharge" type="text" value="${empInfoVO.hrChargeNm}" readonly required/>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="empGend">성별</label>
          	  <c:choose>
		          <c:when test="${empInfoVO.empGend == 'M'}">
					<input class="form-select" id="empGend" name="empGend" value="남자" readonly required />
		          </c:when>
				  <c:otherwise>
					<input class="form-select" id="empGend" name="empGend" value="여자" readonly required />
		          </c:otherwise>
	          </c:choose>

				</div>

				<div class="col-lg-6">
					<label class="form-label" for="hrSal">연봉</label>
					<input class="form-control" id="hrSal" name="hrSal" type="number" value="${empInfoVO.hrSal}" readonly required>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="hrSalKo"> &nbsp; </label>
					<div class="fs-0" id="hrSalKo"></div>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="hrBank">은행</label>
					<input class="form-control" id="hrBank" name="hrBank" type="text" value="${empInfoVO.hrBank}" readonly required>
				</div>
				<div class="col-lg-6">
					<label class="form-label" for="hrBankNo">계좌번호</label>
					<input class="form-control" id="hrBankNo" name="hrBankNo" type="" value="${empInfoVO.hrBankNo}" readonly required>
				</div>

				<div class="col-lg-6">
					<label class="form-label" for="hrMilYn">병역이행</label>
					<input class="form-select" id="hrMilYn" name="hrMilYn" value="${empInfoVO.hrMilYnNm}" readonly required>
				</div>

				<div class="col-12 d-flex justify-content-end">
					<input type="button" class="btn btn-primary me-2 mb-2" onClick="location.href='/emp/update/${empInfoVO.empCd}'" value="수정" />
					<input type="button" class="btn btn-secondary me-2 mb-2" onClick="location.href='/emp/selectList'" value="목록" />
				</div>
			</form>
		</div>
	</div>
</div>

