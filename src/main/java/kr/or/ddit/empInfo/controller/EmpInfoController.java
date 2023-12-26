package kr.or.ddit.empInfo.controller;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.ddit.util.commcode.service.CommonService;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import kr.or.ddit.empInfo.service.EmpInfoService;
import kr.or.ddit.empInfo.vo.EmployeesVacVO;
import kr.or.ddit.empInfo.vo.FamManageCodeVO;
import kr.or.ddit.empInfo.vo.FamVO;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.PaymentEmployeeVO;
import kr.or.ddit.empInfo.vo.PaymentVO;
import kr.or.ddit.empInfo.vo.VacationVO;
import kr.or.ddit.employee.vo.EmpVO;


/**
 * @author 우정범
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@RequestMapping("/empInfo")
@Controller
public class EmpInfoController {
	
	@Inject
	EmpInfoService empInfoService;
	
	@Inject
	CommonService commonService;
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	
	/**
	 * 인사정보 메인 페이지
	 * @param empInfoVO
	 * @param model
	 * @param principal
	 * @return 인사정보 페이지로 이동
	 */
	@RequestMapping("/empInfo")
	public String mainEmpInfo(EmpInfoVO empInfoVO, Model model, Principal principal){
		String empCd = principal.getName();
		empInfoVO.setEmpCd(empCd);
		log.info("mainEmpInfo empCd : " + empCd);
		
		empInfoVO = this.empInfoService.empDetail(empInfoVO);
		log.info("empInfoVO : " + empInfoVO);
		model.addAttribute("data",empInfoVO);
		
		List<FamManageCodeVO> famManageCodeVO = this.empInfoService.selectFamManageCode();
		log.info("famManageCodeVO selectFamManageCode : ",famManageCodeVO);
		model.addAttribute("famManageCode",famManageCodeVO);
		
		return "empInfo/empInfo";
	}
	
	
	/**
	 * 인사정보 개인 신상정보 수정
	 * @param empInfoVO
	 * @param model
	 * @return 결과메시지
	 */
	@ResponseBody
	@PostMapping("/updatePersonal")
	public String updatePersonalEmpInfo(@RequestBody EmpInfoVO empInfoVO, Model model) {
		
		log.info("updatePersonalEmpInfo empInfoVO : " + empInfoVO);
		
		int result = empInfoService.updatePersonal(empInfoVO);
		if (result > 0) {
	        return "success";
	    } else {
	        return "fail";
	    }
	}
	

	/**
	 * 가족정보 삭제
	 * @param famVO
	 * @return 결과메시지
	 */ 
	@ResponseBody
	@PostMapping("/deleteFam")
	public String deleteFam(@RequestBody FamVO famVO) {
		log.info("deleteFam famVO : " + famVO);
		
		int result = empInfoService.deleteFam(famVO);
		
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	
	/**
	 * 가족정보 수정
	 * @param empInfoVO
	 * @return 결과메시지
	 */
	@PostMapping("/updateFam")
	public String updateFam(@ModelAttribute EmpInfoVO empInfoVO) {
		log.info("empInfoVO : " + empInfoVO);
		
		this.empInfoService.deleteFamEmpCd(empInfoVO);
		
		return "redirect:/empInfo/empInfo";
	}
	
	
	
	/**
	 * 연차정보 메인
	 * @param model
	 * @param principal
	 * @param vacationVO
	 * @return 연차정보페이지 이동
	 */
	@GetMapping("/vacinfopersonal")
	public String vacInfoPersonal(Model model,Principal principal, VacationVO vacationVO){
		String empCd = principal.getName();
		log.info("vacInfoEmployee empCd : " + empCd);
		
		vacationVO.setEmpCd(empCd);
		
		log.info("mainEmpInfo empCd : " + empCd);
		
		
		List<VacationVO> grantList = this.empInfoService.vacGrant(vacationVO);
		log.info("vacInfoEmployee vacationVO" + grantList);
		
		model.addAttribute("grantList",grantList);
		
		log.info("vacInfoPersonal->vacationVO : " + vacationVO);
		
		VacationVO vacMainList = this.empInfoService.vacMain(vacationVO);
		log.info("vacInfoEmployee vacMainList : " +vacMainList );
		
		model.addAttribute("vacMainList",vacMainList);
		
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("W");
		log.info("selectCommCdList : " + selectCommCdList);
		
		model.addAttribute("selectCommCdList",selectCommCdList);
		
		
		List<VacationVO> detailUsedVac = this.empInfoService.detailUsedVac(vacationVO);
		log.info("detailUsedVac : " + detailUsedVac);
		model.addAttribute("detailUsedVac",detailUsedVac);
		
		VacationVO findJoinYear = this.empInfoService.findJoinYear(vacationVO);
		log.info("vacInfoEmployee findJoinYear : " +findJoinYear );
		
		model.addAttribute("findJoinYear",findJoinYear);
		
		
		return "empInfo/vacInfoPersonal";
	}
	
	/**
	 * 연차 사용내역
	 * @param vacationVO
	 * @param model
	 * @return 결과메시지, JSON형태의 연차 사용내역
	 */
	@ResponseBody
	@PostMapping("/showvacused")
	public String showVacUsed (@RequestBody VacationVO vacationVO, Model model) {
		log.info("showVacUsed vacationVO : " + vacationVO);
		
		List<VacationVO> showVacUsedvacationVO = this.empInfoService.showVacUsed(vacationVO);
		log.info("showVacUsedvacationVO : " + showVacUsedvacationVO);
		
		//model.addAttribute("showVacUsedvacationVO",showVacUsedvacationVO);
		
		// 응답 데이터를 JSON 형태로 반환
	    if (showVacUsedvacationVO != null) {
	        return new Gson().toJson(showVacUsedvacationVO);
	    } else {
	        return "fail";
	    }
		
		
	}
	
	
	

	/**
	 * 연차 정보(전직원)
	 * @param model
	 * @param authentication
	 * @param employeesVacVO
	 * @param vacationVO
	 * @return 전 직원 연차 정보 페이지 이동
	 */
	@GetMapping("/personnel/vacinfoemployee")
	public String vacInfoEmployee(Model model, Authentication authentication, EmployeesVacVO employeesVacVO,  VacationVO vacationVO){
		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO = realUser.getRealUser();
		
	       
		List<EmployeesVacVO> employeesVacVO1 = this.empInfoService.employeesVacVO();
		log.info("employeesVacVO1 : " + employeesVacVO1);
		
		model.addAttribute("data", employeesVacVO1);

		return "empInfo/vacInfoEmployee";
	}
	
	//모달 누르면 나오는 상세정보 가져오는 컨트롤러
	/**
	 * 선택한 직원의 연차 상세정보
	 * @param model
	 * @param authentication
	 * @param employeesVacVO
	 * @param vacationVO
	 * @return 연차 사용리스트
	 */
	@ResponseBody
	@PostMapping("/vacinfoemployee")
	public List<VacationVO> vacInfoEmployeePost(Model model, Authentication authentication, EmployeesVacVO employeesVacVO,  @RequestBody VacationVO vacationVO){
		log.info("zzzzzzzzzzzzzzzzzzzzzzzzzzz");
		log.info("vacationVO : " + vacationVO);
		log.info(vacationVO.getEmpCd());
		
		
		 String empCd = vacationVO.getEmpCd();
		    // 유저 아이디를 활용하여 vacMain 호출 및 데이터 조회
		 List<VacationVO> usedList = empInfoService.detailUsedVac(vacationVO);
		    log.info("usedList!!!!! : "+ usedList);

		    return usedList;
		
	}
	
	
	//전직원 연차정보 엑셀 파일 저장
	/**
	 * 전직원 연차정보 엑셀 파일 저장
	 * @param response
	 * @param authentication
	 * @param employeesVacVO
	 * @throws IOException
	 */
	@GetMapping("/excelDown")
	public void excelDownload( HttpServletResponse response, Authentication authentication, EmployeesVacVO employeesVacVO) throws IOException {
	    log.info("왔나?!!!");
	    
	    EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO = realUser.getRealUser();

		List<EmployeesVacVO> employeesVacVO1 = this.empInfoService.employeesVacVO();
		log.info("employeesVacVO1!!!!!! : " + employeesVacVO1);
		
	    
		//employeesVacVO1
		
		// 엑셀 워크북 생성
	    XSSFWorkbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("mysheet이름");
		
		
			// 헤더 생성
	    Row headerRow = sheet.createRow(0);
	    headerRow.createCell(0).setCellValue("이름");
	    headerRow.createCell(1).setCellValue("부서명");
	    headerRow.createCell(2).setCellValue("발생연차");
	    headerRow.createCell(3).setCellValue("사용연차");
	    headerRow.createCell(4).setCellValue("잔여연차");
	    headerRow.createCell(5).setCellValue("근속 연수");
	    headerRow.createCell(6).setCellValue("상태");
	    
	    
		//  데이터 저장
		int rowNum = 1;
		for (EmployeesVacVO employee : employeesVacVO1) {
		    Row dataRow = sheet.createRow(rowNum++);
		    dataRow.createCell(0).setCellValue(employee.getEmpNm());
		    dataRow.createCell(1).setCellValue(employee.getDeptNoNm());
		    dataRow.createCell(2).setCellValue(employee.getTotalVacGrtDays());
		    dataRow.createCell(3).setCellValue(employee.getTotalVacDays());
		    dataRow.createCell(4).setCellValue(employee.getRemainDays());
		    dataRow.createCell(5).setCellValue(employee.getWorkingYear());
		    dataRow.createCell(6).setCellValue(employee.getHrStat());
		}
	
	
		    
		// 파일 다운로드를 위한 응답 헤더 설정
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment; filename=employeesVac.xlsx");
	
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=employeesVac.xlsx");  //파일이름지정.
	    // response OutputStream에 엑셀 작성
	    wb.write(response.getOutputStream());
			
			
		    
		  //  return "redirect:/empInfo/vacinfoemployee";
	
		}
	
	

	/**
	 * 선택한 직원의 연차정보 엑셀 다운로드
	 * @param employeesVacVO
	 * @param response
	 * @throws IOException
	 */
	@PostMapping("/sendSelectedEmployees")
	public void sendSelectedEmployees(@RequestBody List<EmployeesVacVO> employeesVacVO, HttpServletResponse response) throws IOException {
		// 선택된 직원 정보 처리 로직 작성
		log.info("EmployeesVacVO : " + employeesVacVO);
		
		for (EmployeesVacVO selectedEmployee : employeesVacVO) {
			log.info("zzzz" +selectedEmployee.getEmpNm() );
		}
		
		XSSFWorkbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("mysheet이름");
		
		// 헤더 생성
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("이름");
		headerRow.createCell(1).setCellValue("부서명");
		headerRow.createCell(2).setCellValue("발생연차");
		headerRow.createCell(3).setCellValue("사용연차");
		headerRow.createCell(4).setCellValue("잔여연차");
		headerRow.createCell(5).setCellValue("근속 연수");
		headerRow.createCell(6).setCellValue("상태");
		
		log.debug("체킁:");
		// 데이터 저장
		int rowNum = 1;
		for (EmployeesVacVO selectedEmployee : employeesVacVO) {
			log.debug("pppp {}",selectedEmployee);
			Row dataRow = sheet.createRow(rowNum++);
			dataRow.createCell(0).setCellValue(selectedEmployee.getEmpNm());
			dataRow.createCell(1).setCellValue(selectedEmployee.getDeptNoNm());
			dataRow.createCell(2).setCellValue(selectedEmployee.getTotalVacGrtDays());
			dataRow.createCell(3).setCellValue(selectedEmployee.getTotalVacDays());
			dataRow.createCell(4).setCellValue(selectedEmployee.getRemainDays());
			dataRow.createCell(5).setCellValue(selectedEmployee.getWorkingYear());
			dataRow.createCell(6).setCellValue(selectedEmployee.getHrStat());
		}
		
		wb.write(response.getOutputStream());
		
	}
	
	
	
	
	
	/**
	 * 급여명세서
	 * @param paymentVO
	 * @param model
	 * @param authentication
	 * @param vacationVO
	 * @return 급여페이지 이동
	 */
	@GetMapping("/payment")
	public String payment(PaymentVO paymentVO, Model model, Authentication authentication, VacationVO vacationVO ) {
		log.info("payment paymentVO : " + paymentVO);

		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO =  realUser.getRealUser();
		String empCd = empVO.getEmpCd();
		log.info("payment empCd : " + empCd);
		
		paymentVO.setEmpCd(empCd);
		vacationVO.setEmpCd(empCd);
		paymentVO.setSelectYear(2023);
		
		log.info("paymentVO" , paymentVO);
		
		List<PaymentVO> paymentVOList = this.empInfoService.paymentVO(paymentVO);
		log.info("payment paymentVO : " + paymentVOList);
		model.addAttribute("data" , paymentVOList);
		
		
		VacationVO findJoinYear = this.empInfoService.findJoinYear(vacationVO);
		log.info("payment findJoinYear : " +findJoinYear );
		
		model.addAttribute("findJoinYear",findJoinYear);
		
		PaymentVO paymentVOBank = this.empInfoService.selectBank(paymentVO);
		log.info("paymentVOBank : " + paymentVOBank);
		
		model.addAttribute("paymentVOBank",paymentVOBank);
		

		return "empInfo/payment";
	}
	
	/**
	 * 급여 연도 확인
	 * @param paymentVO
	 * @return 결과메시지, JSON
	 */
	@ResponseBody
	@PostMapping("/paymentPost")
	public String paymentPost(@RequestBody PaymentVO paymentVO) {
		
		List<PaymentVO> paymentVOList = this.empInfoService.paymentVO(paymentVO);
		log.info("paymentPost paymentVOList : " + paymentVOList);
		
		// 응답 데이터를 JSON 형태로 반환
	    if (paymentVOList != null) {
	        return new Gson().toJson(paymentVOList);
	    } else {
	        return "fail";
	    }
	}
	
	
	/**
	 * 급여 상세 내역 조회 및 계좌 조회
	 * @param paymentVO
	 * @param model
	 * @return 결과메시지
	 */
	@ResponseBody
	@PostMapping("/paymentDetail")
	public PaymentVO paymentDetail(@RequestBody PaymentVO paymentVO, Model model) {
		log.info("paymentDetail에 도착");
		log.info("paymentVO : " + paymentVO);
		
		PaymentVO result = this.empInfoService.paymentDetail(paymentVO);
		model.addAttribute("result",result);
		log.info("result : " + result);

		return result;
		
	}
	
	/**
	 * 급여 계좌 변경하기
	 * @param paymentVO
	 * @return 결과메시지
	 */
	@ResponseBody
	@PostMapping("/paymentUpdate")
	public String paymentUpdate(@RequestBody PaymentVO paymentVO) {
		log.info("paymentUpdate paymentVO : " + paymentVO);
		
		int result = this.empInfoService.paymentUpdate(paymentVO);
		
		
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
	//전 직원 급여정보 
	/**
	 * 전직원 급여정보
	 * @param paymentEmployeeVO 
	 * @param model
	 * @param authentication
	 * @return 전 직원 급여정보관리 페이지 이동
	 */
	@GetMapping("/personnel/paymentemployee")
	public String paymentEmployeeList(PaymentEmployeeVO paymentEmployeeVO, Model model, Authentication authentication) {
		log.info("paymentemployee에 왔다!");
		
		//접속유저 정보 가져오기
		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO = realUser.getRealUser();
		String empCd = empVO.getEmpCd();
		
		log.info("paymentemployee : " +  empCd);
		
		// 현재 날짜 가져오기
		LocalDate currentDate = LocalDate.now();
		// 연/월 추출
		int year = currentDate.getYear();
		int month = currentDate.getMonthValue()-1;
		
		log.info("year: {}", year);
		log.info("month: {}", month);
		
		//조회 값 넣어주기
		paymentEmployeeVO.setSelectYear(year);
		paymentEmployeeVO.setSelectMonth(month);
		
		
		List<PaymentEmployeeVO> paymentEmployeeVOs = this.empInfoService.paymentEmployeeList(paymentEmployeeVO);
		log.info("paymentEmployeeVOs : " , paymentEmployeeVOs);
		
		model.addAttribute("data",paymentEmployeeVOs);
		
		
		
		return "empInfo/paymentEmployeeList";
	}
	
	
	/**
	 * 전직원 급여정보 엑셀 파일 저장
	 * @param response
	 * @param authentication
	 * @param paymentVO
	 * @throws IOException
	 */
	@GetMapping("/paymentEmployeeExcel")
	public void paymentEmployeeExcel( HttpServletResponse response, Authentication authentication, PaymentVO paymentVO) throws IOException {
	    EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO = realUser.getRealUser();

		List<PaymentVO> paymentVOList = this.empInfoService.paymentEmployeeExcel(paymentVO);
		log.info("paymentVOList!!!!!! : " + paymentVOList);
		
		
		// 엑셀 워크북 생성
	    XSSFWorkbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("mysheet이름");
		
		
		// 헤더 생성
	    Row headerRow = sheet.createRow(0);
	    headerRow.createCell(0).setCellValue("급여명세번호");
	    headerRow.createCell(1).setCellValue("사번");
	    headerRow.createCell(2).setCellValue("이름");
	    headerRow.createCell(3).setCellValue("부서명");
	    headerRow.createCell(4).setCellValue("직급");
	    headerRow.createCell(5).setCellValue("은행");
	    
	    headerRow.createCell(6).setCellValue("계좌번호");
	    headerRow.createCell(7).setCellValue("급여 연월");
	    headerRow.createCell(8).setCellValue("지급일");
	    headerRow.createCell(9).setCellValue("기본급");
	    headerRow.createCell(10).setCellValue("연장근로수당");
	    
	    headerRow.createCell(11).setCellValue("식대");
	    headerRow.createCell(12).setCellValue("국민연금");
	    headerRow.createCell(13).setCellValue("고용보험");
	    headerRow.createCell(14).setCellValue("소득세");
	    headerRow.createCell(15).setCellValue("지방소득세");
	    
	    headerRow.createCell(16).setCellValue("건강보험");
	    headerRow.createCell(17).setCellValue("장기요양보험");
	    headerRow.createCell(18).setCellValue("지급항목합계");
	    headerRow.createCell(19).setCellValue("공제항목합계");
	    headerRow.createCell(20).setCellValue("실지급액");
	    
	    
		//  데이터 저장
		int rowNum = 1;
		for (PaymentVO employee : paymentVOList) {
		    Row dataRow = sheet.createRow(rowNum++);
		    dataRow.createCell(0).setCellValue(employee.getPayNo());
		    dataRow.createCell(1).setCellValue(employee.getEmpCd());
		    dataRow.createCell(2).setCellValue(employee.getEmpNm());
		    dataRow.createCell(3).setCellValue(employee.getDeptNoNm());
		    dataRow.createCell(4).setCellValue(employee.getHrGradeNm());
		    dataRow.createCell(5).setCellValue(employee.getHrBank());
		    dataRow.createCell(6).setCellValue(employee.getHrBankNo());
		    dataRow.createCell(7).setCellValue(employee.getWorkDate());
		    dataRow.createCell(8).setCellValue(employee.getPayDate());
		    dataRow.createCell(9).setCellValue(employee.getSal());
		    dataRow.createCell(10).setCellValue(employee.getOverWork());
		    
		    dataRow.createCell(11).setCellValue(employee.getFood());
		    dataRow.createCell(12).setCellValue(employee.getNpn());
		    dataRow.createCell(13).setCellValue(employee.getEmpIns());
		    dataRow.createCell(14).setCellValue(employee.getInTax());
		    dataRow.createCell(15).setCellValue(employee.getLinTax());
		    
		    dataRow.createCell(16).setCellValue(employee.getHlthIns());
		    dataRow.createCell(17).setCellValue(employee.getLtc());
		    dataRow.createCell(18).setCellValue(employee.getTotalPay());
		    dataRow.createCell(19).setCellValue(employee.getTotalTax());
		    dataRow.createCell(20).setCellValue(employee.getPay());
		    
		}
	
	
		    
		// 파일 다운로드를 위한 응답 헤더 설정
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment; filename=paymentEmployeeExcel.xlsx");
	
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=paymentEmployeeExcel.xlsx");  //파일이름지정.
	    // response OutputStream에 엑셀 작성
	    wb.write(response.getOutputStream());
			
		}
	
	
	
	
	

	
}
