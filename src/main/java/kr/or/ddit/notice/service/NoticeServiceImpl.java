package kr.or.ddit.notice.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.notice.dao.NoticeDAO;
import kr.or.ddit.notice.vo.AtchFileDetailVO;
import kr.or.ddit.notice.vo.NoticeExVO;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.util.commcode.dao.AtchFileDetailDao;
import lombok.extern.slf4j.Slf4j;

import kr.or.ddit.board.vo.AtchBrdFileDetailVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 황수빈
 * @since 2023. 11. 20.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      황수빈       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService{

	@Inject
	NoticeDAO noticeDao;
	
	@Inject
	AtchFileDetailDao atchFileDetailDao;
	
	
	@Override
	public int createPost(NoticeVO noticeVO) {
		
		return this.noticeDao.createPost(noticeVO);
	}
	


	@Override
	public NoticeVO detail(NoticeVO noticeVO) {
		
		return this.noticeDao.detail(noticeVO);
	}
	
	//공지사항 전체 행의 수
	@Override
	public int total(Map<String,String> map) {
		return this.noticeDao.total(map);
	}

	public List<NoticeVO> noticeList(Map<String,String> map){
		
		return this.noticeDao.noticeList(map);
	}



	
	 @Override
	    public NoticeVO pageDetail(NoticeVO noticeVO) {
	        NoticeVO result = this.noticeDao.pageDetail(noticeVO);

	        // EMP_CD가 'E201802180101'인 경우 '관리자'로 설정
	        if ("E201802180101".equals(result.getNtcNm())) {
	            result.setEmpNm("관리자");
	        }

	        return result;
	    }



	@Override
	public NoticeVO pageSelect(NoticeVO noticeVO) {
		
		return this.noticeDao.pageSelect(noticeVO);
	}

	@Transactional
	@Override
	public int pageCreatePost(NoticeVO noticeVO) {
		//1) NOTICE 테이블에 insert
		//들어올땐 : NoticeVO(ntcNo=null, ntcTitle=asfd, ntcCont=<p>sdd</p>, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		int result = this.noticeDao.pageCreatePost(noticeVO);
		//나갈땐 : NoticeVO(ntcNo=NTC0000124, ntcTitle=asfd, ntcCont=<p>sdd</p>, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		
		//2) 파일업로드
		MultipartFile[] uploadFile = noticeVO.getUploadFile();
		 
		
		if(uploadFile == null) return result;  // 첨부파일이 없다면 요기서 빠빠이!
		

		String uploadFolder = "C:\\00.tools\\FinalProject\\src\\main\\webapp\\resources\\upload";

		int fileSn = 0;

		// make folder 시작 ---------------------------
		// ..upload\\2023\\11\\27
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);

		// 만약 년/월/일 해당 폴더가 없다면 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make folder 끝 ---------------------------

		// 배열로부터 하나씩 파일을 꺼내오자
		for (MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File MIME : " + multipartFile.getContentType());

			// IE 처리 => 경로를 제외한 파일명만 추출
			// c:\\upload\\image01.jpg => image01.jpg
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

			log.info("only file name : " + uploadFileName);

			// ------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 시작 -------------
			// java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID(); // 임의의 값을 생성
			// 원래의 파일 이름과 구분하기 위해 _를 붙임
			// asfddsasdfsadf_image01.jpg
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// ------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 -------------

			// File 객체 설계(복사할 대상 경로 , 파일명)
//			File saveFile = new File(uploadFolder, uploadFileName);
			// uploadPath :
			// C:\\00.tools\\FinalProject\\src\\main\\webapp\\resources\\upload\\2023\\11\\27
			// , : \\
			// uploadFileName : asfddsasdfsadf_image01.jpg
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				// 파일 복사가 일어남
				multipartFile.transferTo(saveFile);

				// 4) productVO.setFilename(파일full경로+명);
//				String filename = "/" + getFolder().replaceAll("\\\\","/") + "/" + uploadFileName;
				AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO();
				atchFileDetailVO.setAtchFileId(noticeVO.getNtcNo());
				atchFileDetailVO.setFileSn(++fileSn);
				atchFileDetailVO.setFileStreCours(uploadPath + "\\" + uploadFileName);
				atchFileDetailVO.setStreFileNm("/" + getFolder().replaceAll("\\\\", "/") + "/" + uploadFileName);
				atchFileDetailVO.setOrignlFileNm(multipartFile.getOriginalFilename());
				atchFileDetailVO.setFileExtsn(multipartFile.getContentType());
				atchFileDetailVO.setFileCn("");
				atchFileDetailVO.setFileSize(multipartFile.getSize());

				result += atchFileDetailDao.insertAtchFileDetail(atchFileDetailVO);

			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			} // tnd catch
		} // end for
		
		return result;
	}

	public int pageDetailUpdate(NoticeVO noticeVO) {
		
		return this.noticeDao.pageDetailUpdate(noticeVO);
	}
	
	public int pageDetailDelete(NoticeVO noticeVO) {
		return this.noticeDao.pageDetailDelete(noticeVO);
	}


	@Override
	public int pageUpdateHit(NoticeVO noticeVO) {
		return noticeDao.pageUpdateHit(noticeVO);
	}
	
	// 년/월/일 폴더 생성
	public static String getFolder() {
		// 2022-07-22 형식(format) 지정
		// 간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// 날짜 객체 생성(java.util패키지)
		Date date = new Date();
		// 2022-07-22
		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}

	// 용량이 큰 파일을 섬네일 처리를 하지 않으면
	// 모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	// 이미지의 경우 특별한 경우가 아니면 섬네일을 제작해야 함.
	// 섬네일은 이미지만 가능함.
	// 이미지 파일의 판단
	public static boolean checkImageType(File file) {
		/*
		 * .jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		 */
		// MIME 타입을 통해 이미지 여부 확인
		// file.toPath() : 파일 객체를 path객체로 변환
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			// MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 이 파일이 이미지가 아닐 경우
		return false;
	}
}
