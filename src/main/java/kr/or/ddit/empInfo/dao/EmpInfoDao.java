package kr.or.ddit.empInfo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.empInfo.vo.EmployeesVacVO;
import kr.or.ddit.empInfo.vo.FamManageCodeVO;
import kr.or.ddit.empInfo.vo.FamVO;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.PaymentEmployeeVO;
import kr.or.ddit.empInfo.vo.PaymentVO;
import kr.or.ddit.empInfo.vo.VacationVO;
import kr.or.ddit.employee.vo.EmpVO;

@Mapper
public interface EmpInfoDao {
   
   //인사정보 메인 값 읽어오기
   public EmpInfoVO empDetail(EmpInfoVO empInfoVO);
   
   //인사정보 신상정보 변경
   public int updatePersonal(EmpInfoVO empInfoVO);
   
   //가족 삭제
   public int deleteFam(FamVO famVO);
   
   //공통코드 중 가족관계불러오기
   public List<FamManageCodeVO> selectFamManageCode();
   
   //로그인 아이디에 해당되는 가족 데이터 삭제
   public int deleteFamEmpCd(EmpInfoVO empInfoVO);
   
   //로그인 아이디에 해당 는 가족 insert
   public int insertFam(FamVO famVO);
   
   
   
   //연차 리스트
   public List<VacationVO> vacGrant(VacationVO vacationVO);
   
   //총연차 사용연차 내역
   public VacationVO vacMain(VacationVO vacationVO);
   
   //입사일 확인
   public VacationVO findJoinYear(VacationVO vacationVO);
   
   //연차 사용 내역 현재년도
   public List<VacationVO> detailUsedVac(VacationVO vacationVO);
   
   //연차 사용 내역 기존년도
   public List<VacationVO> showVacUsed(VacationVO vacationVO);
   
   //전직원 연차
   public List<EmployeesVacVO> employeesVacVO();
   
   
   
   
   //급여 리스트
   public List<PaymentVO> paymentVO(PaymentVO paymentVO);
   
   //급여 상세
   public PaymentVO paymentDetail(PaymentVO paymentVO);
   
   
   //급여 계좌 조회
   public PaymentVO selectBank(PaymentVO paymentVO);

   
   //급여계좌 변경
   public int paymentUpdate(PaymentVO paymentVO);
   
   
   //전 직원 급여 리스트
   public List<PaymentEmployeeVO> paymentEmployeeList(PaymentEmployeeVO paymentEmployeeVO);
   
   //전 직원 급여 리스트 엑셀 다운
   public List<PaymentVO> paymentEmployeeExcel(PaymentVO paymentVO);
   
   
   
   //직원 사진 변경하기
   public int regPic(EmpInfoVO empInfoVO);
   
   //서명 사진 변경하기
   public int regSign(EmpInfoVO empInfoVO);

   
   //직원 비밀번호 변경하기
   public int changePw(EmpVO empVO);
   
   
}