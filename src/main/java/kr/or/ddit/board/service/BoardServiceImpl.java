package kr.or.ddit.board.service;

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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.dao.BoardDAO;
import kr.or.ddit.board.vo.AtchBrdFileDetailVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.notice.vo.AtchFileDetailVO;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.util.commcode.dao.AtchFileDetailDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



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
public class BoardServiceImpl implements BoardService {
 
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	AtchFileDetailDao atchFileDetailDao;
	
	@Override
	public int createPost(BoardVO boardVO) {
		//1) board 테이블에 insert
		/*
		BoardVO(rnum=0, brdNo=null, brdTitle=asdf, brdCont=<p>sss</p>
		, brdRdate=null, brdHit=0, brdTemp=null, empNm=null, empAuth=null, atchBrdFileDetailVOList=null, uploadFile=[org.sprin
		, brdNm=null
		 */
		int result = this.boardDao.createPost(boardVO); 
		System.out.println("result의 값이 너무 궁금해요"+result); //값은 1 나옴 ㅠㅠ
		/*
		BoardVO(rnum=0, brdNo=BRD0000006, brdTitle=asdf, brdCont=<p>sss</p>
		, brdRdate=null, brdHit=0, brdTemp=null, empNm=null, empAuth=null, atchBrdFileDetailVOList=null, uploadFile=[org.sprin
		, brdNm=null
		 */
		
		//2) 첨부파일 처리
		MultipartFile[] uploadFile = boardVO.getUploadFile();
		 

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
//				File saveFile = new File(uploadFolder, uploadFileName);
				// uploadPath :
				// C:\\00.tools\\FinalProject\\src\\main\\webapp\\resources\\upload\\2023\\11\\27
				// , : \\
				// uploadFileName : asfddsasdfsadf_image01.jpg
				File saveFile = new File(uploadPath, uploadFileName);

				try {
					// 파일 복사가 일어남
					multipartFile.transferTo(saveFile);

					// 4) productVO.setFilename(파일full경로+명);
//					String filename = "/" + getFolder().replaceAll("\\\\","/") + "/" + uploadFileName;
					AtchBrdFileDetailVO atchBrdFileDetailVO = new AtchBrdFileDetailVO();
					atchBrdFileDetailVO.setAtchFileId(boardVO.getBrdNo());
					atchBrdFileDetailVO.setFileSn(++fileSn);
					atchBrdFileDetailVO.setFileStreCours(uploadPath + "\\" + uploadFileName);
					atchBrdFileDetailVO.setStreFileNm("/" + getFolder().replaceAll("\\\\", "/") + "/" + uploadFileName);
					atchBrdFileDetailVO.setOrignlFileNm(multipartFile.getOriginalFilename());
					atchBrdFileDetailVO.setFileExtsn(multipartFile.getContentType());
					atchBrdFileDetailVO.setFileCn("");
					atchBrdFileDetailVO.setFileSize(multipartFile.getSize());

					result += atchFileDetailDao.insertAtchBrdFileDetail(atchBrdFileDetailVO);

				} catch (IllegalStateException e) {
					log.error(e.getMessage());
				} catch (IOException e) {
					log.error(e.getMessage());
				} // tnd catch
			} // end for
		
		return result;
	}
	
	public String list(BoardVO boardVO) {
		return this.boardDao.list(boardVO);
	}
	@Override
	public int pageCreatePost(BoardVO boardVO) {
	
		return this.boardDao.pageCreatePost(boardVO);
	}
	
	@Override
	public BoardVO pageDetail(BoardVO boardVO) {
		
		return this.boardDao.pageDetail(boardVO);
	}
	@Override
	public BoardVO pageSelect(BoardVO boardVO) {
		
		return this.boardDao.pageSelect(boardVO);
	}

	@Override
	public List<BoardVO> boardList(Map<String, String> map) {
		
		return this.boardDao.boardList(map);
	}

	@Override
	public int total(Map<String, String> map) {
		
		return this.boardDao.total(map);
	}

	@Override
	public int pageUpdateHit(BoardVO boardVO) {
		
		return boardDao.pageUpdateHit(boardVO);
	}
	
	public int pageDetailUpdate(BoardVO boardVO) {
		return boardDao.pageDetailUpdate(boardVO);
	}
	
	public int pageDetailUpdatePost(BoardVO boardVO) {
		return boardDao.pageDetailUpdatePost(boardVO);
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

	@Override
	public int pageDetailDelete(BoardVO boardVO) {
		return this.boardDao.pageDetailDelete(boardVO);
	}
}








