package kr.or.ddit.empInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.empInfo.dao.EmpInfoDao;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.EmployeesVacVO;
import kr.or.ddit.empInfo.vo.FamManageCodeVO;
import kr.or.ddit.empInfo.vo.FamVO;
import kr.or.ddit.empInfo.vo.PaymentEmployeeVO;
import kr.or.ddit.empInfo.vo.PaymentVO;
import kr.or.ddit.empInfo.vo.VacationVO;
import kr.or.ddit.employee.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmpInfoServiceImpl implements EmpInfoService {

   @Inject
   EmpInfoDao empInfoDao;
   
   
   //인사정보 메인 리스트
   @Override
   public EmpInfoVO empDetail(EmpInfoVO empInfoVO) {
      return this.empInfoDao.empDetail(empInfoVO);
   }
   //연차정보
   @Override
   public List<VacationVO> vacGrant(VacationVO vacationVO) {
      return this.empInfoDao.vacGrant(vacationVO);
   }
   
   //총연차 사용연차 내역
   @Override
   public VacationVO vacMain(VacationVO vacationVO){
      return this.empInfoDao.vacMain(vacationVO);
   }
   
   @Override
   public VacationVO findJoinYear(VacationVO vacationVO){
      return this.empInfoDao.findJoinYear(vacationVO);
   }
   
   //인사정보 신상정보 수정
   @Override
   public int updatePersonal(EmpInfoVO empInfoVO) {
      return this.empInfoDao.updatePersonal(empInfoVO);
   }

   //가족 삭제
   @Override
   public int deleteFam(FamVO famVO) {
      return this.empInfoDao.deleteFam(famVO);
   }
   
   //로그인 아이디에 해당되는 가족 데이터 삭제
   @Override
   @Transactional
   public int deleteFamEmpCd(EmpInfoVO empInfoVO) {
      //로그인 아이디에 해당되는 가족 데이터 삭제
      int result = this.empInfoDao.deleteFamEmpCd(empInfoVO);
      
      List<FamVO> famVO = empInfoVO.getFamVO();
      
      for(FamVO vo : famVO) {
         result += this.empInfoDao.insertFam(vo);
      }
      
      log.info("result : " + result);
      
      return result;
   }
      
   //로그인 아이디에 해당 는 가족 insert
   @Override
   public int insertFam(FamVO famVO) {
      return this.empInfoDao.insertFam(famVO);
   }
   
   //공통코드 중 가족관계불러오기
   @Override
   public List<FamManageCodeVO> selectFamManageCode() {
      return this.empInfoDao.selectFamManageCode();
   }
   //연차 사용 내역 현재 년도
   @Override
   public List<VacationVO> detailUsedVac(VacationVO vacationVO) {
      return this.empInfoDao.detailUsedVac(vacationVO);
   }
   //연차사용내역 기존 년도
   @Override
   public List<VacationVO> showVacUsed(VacationVO vacationVO) {
      return this.empInfoDao.showVacUsed(vacationVO);
   }
   //전직원 연차
   @Override
   public List<EmployeesVacVO> employeesVacVO() {
      return this.empInfoDao.employeesVacVO();
   }
   
   //급여 리스트
   @Override
   public List<PaymentVO> paymentVO(PaymentVO paymentVO) {
      return this.empInfoDao.paymentVO(paymentVO);
   }
   
   //급여 상세
   @Override
   public PaymentVO paymentDetail(PaymentVO paymentVO) {
      return this.empInfoDao.paymentDetail(paymentVO);
   }
   
   //급여 계좌 조회
   @Override
   public PaymentVO selectBank(PaymentVO paymentVO) {
      return this.empInfoDao.selectBank(paymentVO);
   }
   
   //급여계좌 변경
   @Override
   public int paymentUpdate(PaymentVO paymentVO) {
      return this.empInfoDao.paymentUpdate(paymentVO);
   }
   //전 직원 급여 리스트
   @Override
   public List<PaymentEmployeeVO> paymentEmployeeList(PaymentEmployeeVO paymentEmployeeVO) {
      return this.empInfoDao.paymentEmployeeList(paymentEmployeeVO);
   }
   
   //전 직원 급여 리스트 엑셀 다운
   @Override
   public List<PaymentVO> paymentEmployeeExcel(PaymentVO paymentVO) {
      return this.empInfoDao.paymentEmployeeExcel(paymentVO);
   }
   
   //직원 사진 변경하기
   @Override
   public int regPic(EmpInfoVO empInfoVO) {
      return this.empInfoDao.regPic(empInfoVO);
   }
   
   //서명 사진 변경하기
   @Override
   public int regSign(EmpInfoVO empInfoVO) {
      return this.empInfoDao.regSign(empInfoVO);
   }
   
   //직원 비밀번호 변경하기
   @Override
   public int changePw(EmpVO empVO) {
      return this.empInfoDao.changePw(empVO);
   }
   
   
   
}