package kr.or.ddit.empInfo.controller;

import java.io.File;
import java.io.IOException;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.empInfo.service.EmpInfoService;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import kr.or.ddit.util.CommonFile;


/**
 * 내정보페이지로 개인정보 확인 및 비밀번호 변경하는  Controller를 정의한다
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
@Controller
public class MyPageController {
   private final Logger log = LoggerFactory.getLogger(this.getClass());

   @Inject
   EmpService empService;

   @Inject
   EmpInfoService empInfoService;

   @Inject
	private PasswordEncoder encoder;

    /**
     * 내정보
     * @param mav를 통한 값 전달
     * @param authentication 접속자id 확인
     * @return EmpVO의 값
     */
   @RequestMapping("/mypage")
   public ModelAndView myPage(ModelAndView mav, Authentication authentication) {
      EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
      EmpVO empVO = realUser.getRealUser();

      mav.setViewName("empInfo/myPage");
      mav.addObject("empVO", empVO);

      return mav;
   }



   /**
    * 인물사진 변경
    * @param file 변경하고자하는 사진 파일
    * @param authentication 접속자id확인
    * @param empInfoVO 경로 지정
    * @return 결과정보
    * @throws IOException
    */
   @PostMapping("/mypage/personpic")
   @ResponseBody
   public String personpic(@RequestParam("personpic") MultipartFile file, Authentication authentication, EmpInfoVO empInfoVO) throws IOException {
       //log.info("Personpic에왔다");
       EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
       EmpVO empVO = realUser.getRealUser();
       String empCd = empVO.getEmpCd();
       empInfoVO.setEmpCd(empCd);

       // 파일 업로드
       if (!file.isEmpty()) {
           String originalFilename = file.getOriginalFilename();
           //String extension = FilenameUtils.getExtension(originalFilename); // 파일의 확장자 추출
           String saveFileName = empCd + "." + "png"; // 저장될 파일 이름

           // 파일 저장
           String savePath = CommonFile.uploadFolderEmpPic + File.separator + saveFileName;
           //log.info(savePath);
           File saveFile = new File(savePath);
           file.transferTo(saveFile);
           //log.info("saveFile : ", saveFile);

           String empImg = "/empImg/"+saveFileName;
           //log.info(empImg);

           empInfoVO.setEmpImg(empImg);

           int result = this.empInfoService.regPic(empInfoVO);

           if (result > 0) {
               return "success";
           }
       }

       return "fail";
   }




   /**
    * 서명사진 변경
    * @param file 변경하고자하는 사진 파일
    * @param authentication 접속자id확인
    * @param empInfoVO 경로 지정
    * @return 결과정보
    * @throws IOException
    */
   @PostMapping("/mypage/regSign")
   @ResponseBody
   public String regSign(@RequestParam("regSign") MultipartFile file, Authentication authentication, EmpInfoVO empInfoVO) throws IOException {
      log.info("regSign에왔다");
      EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
      EmpVO empVO = realUser.getRealUser();
      String empCd = empVO.getEmpCd();
      empInfoVO.setEmpCd(empCd);

      // 파일 업로드
      if (!file.isEmpty()) {
         String originalFilename = file.getOriginalFilename();
         //String extension = FilenameUtils.getExtension(originalFilename); // 파일의 확장자 추출
         String saveFileName = "sign" + empCd + "." + "png"; // 저장될 파일 이름

         // 파일 저장
         String savePath = CommonFile.uploadFolderEmpSign + File.separator + saveFileName;
         //log.info(savePath);
         File saveFile = new File(savePath);
         file.transferTo(saveFile);
         //log.info("saveFile : ", saveFile);
         String empSign = "/empSign/"+saveFileName;
         //log.info(empImg);

         empInfoVO.setEmpSign(empSign);

         int result = this.empInfoService.regSign(empInfoVO);

         if (result > 0) {
            return "success";
         }
      }

      return "fail";
   }

   
//   @PostMapping("/uploadSignature")
//   public ResponseEntity<String> uploadSignature(@RequestBody String signatureData) {
//	   
//	   EmpVO empVO = new EmpVO();
//	   String empCd = empVO.getEmpCd();
//	   
//       try {
//           // BASE64 디코딩
//           String base64Image = signatureData.split(",")[1];
//           byte[] decodedBytes = Base64.getDecoder().decode(base64Image);
//
//           // 파일로 저장 (예시: 프로젝트 루트의 "uploads" 폴더에 저장)
//           String filePath = "\\resources\\images\\emp\\empSign\\sign"+empCd+".png";
//           Files.write(Paths.get(filePath), decodedBytes);
//
//           System.out.println("Signature saved to: " + filePath);
//
//           // 성공 응답
//           return ResponseEntity.ok("Signature uploaded successfully.");
//       } catch (IOException e) {
//           // 오류 응답
//           return ResponseEntity.status(500).body("Failed to upload signature.");
//       }
//   }


   /**
    * 비밀번호 변경
    * @param empVO empCd, empPw
    * @return 결과정보
    */
   @PostMapping("/mypage/changePw")
   @ResponseBody
   public String changePw(Authentication authentication, @RequestBody EmpVO empVO) {
	  //현재 로그인한 아이디
	  String empCd = authentication.getName();
	  EmpVO emp = new EmpVO();
	  emp = empService.retrieveEmp(empCd);
	  //현재로그인 한 패스워드
	  String empPw = emp.getEmpPw();
	  log.info("changePw에 왔다!");
      log.info(empPw);
      
      //empVO에서 받아온 현재 비밀번호
      String empPpw = empVO.getEmpPpw();
      
      //empVO에서 받아온 새로운 비밀번호
      String newPw = empVO.getEmpPw();
      
      log.info("changePw empPpw {}", empPpw);
      
      String encNewPw = encoder.encode(newPw);
      empVO.setEmpPw(encNewPw);
      int result=0;
      log.info("현재비번 {}", empPw);
      //받아온 현재비밀번호와 로그인한 현재비밀번호 비교
      if(encoder.matches(empPpw,empPw)) {
    	  result = this.empInfoService.changePw(empVO);
      }

      if(result > 0) {
         return "success";
      }else {
         return "fail";
      }

   }//changePw



}