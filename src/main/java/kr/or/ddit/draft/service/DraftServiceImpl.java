package kr.or.ddit.draft.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.draft.dao.DraftDao;
import kr.or.ddit.draft.vo.DraftAtchVO;
import kr.or.ddit.draft.vo.DraftFormVO;
import kr.or.ddit.draft.vo.DraftOrderVO;
import kr.or.ddit.draft.vo.DraftVO;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.util.CommonFile;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DraftServiceImpl implements DraftService {

	@Inject
	private DraftDao draftDao;

	/**
	 * 사용자 한명의 기안을 올리기 위한 정보를 조회하는 메소드
	 * @param empCd 조회할 유저의 아이디
	 * @return 유저 정보
	 */
	@Override
	public EmpInfoVO retrieveDraftEmpInfo(String empCd) throws Exception {
		return draftDao.selectDraftEmpInfo(empCd);
	}

	/**
	 * 기안시 연계된 테이블에 기안내용 인서트
	 */
	@Override
	@Transactional
	public int createDraft(DraftVO draftVO) throws Exception {
		int result = 0;
		// 임시 기안 문서일 경우 update 진행
		if(draftVO.getDrftStatTemp() != null && draftVO.getDrftStatTemp().equals("L001")) {
			result += draftDao.logicalDelDraft(draftVO);
		}
		
		// 기안 테이블 인서트
		result += draftDao.insertDraft(draftVO);
		
		// 결재선 인서트
		if(draftVO.getDrftLineVOList() != null) {
		result += draftDao.insertDraftLine(draftVO);
		}
		// 기안 의견 테이블 인서트
		if(draftVO.getDrftOpVOList() != null) {
			result += draftDao.insertDraftOp(draftVO);
		}
		
		// 기안 - 첨부파일 인서트
		MultipartFile[] files = draftVO.getAttachFiles();
		List<DraftAtchVO> DraftAtchVOList = new ArrayList<DraftAtchVO>();
		if (!files[0].isEmpty()) {
			for (MultipartFile mf : files) {
				DraftAtchVO DraftAtchVO = new DraftAtchVO();
				
				// 업로드 파일명
				String uploadFileName = "";

				String path = CommonFile.uploadFolderDraft;
				File uploadPath = new File(path, CommonFile.getFolder());
				if (uploadPath.exists() == false) {
					uploadPath.mkdirs();
				}
				
				// 파일명
				String drftOrgNm = mf.getOriginalFilename();
				DraftAtchVO.setDrftOrgNm(drftOrgNm);
				
				// 중복방지 uuid
				UUID uuid = UUID.randomUUID();
				DraftAtchVO.setDrftSaveNm(uuid + "");
				uploadFileName = uuid.toString() + "_" + drftOrgNm;

				// 설계. 저장될 폴더와 파일명
				File saveFile = new File(uploadPath, uploadFileName);

				// 저장 실행
				String drftType = mf.getContentType();
				
				DraftAtchVO.setDrftType(drftType);
				// 파일 path
				DraftAtchVO.setDrftPath("/" + CommonFile.getFolder().replace("\\", "/") + "/" + uploadFileName);
				
				DraftAtchVO.setDrftSize(mf.getSize());
				
				DraftAtchVOList.add(DraftAtchVO);
				
				draftVO.setDrftAtchVOList(DraftAtchVOList);
				
				try {
					mf.transferTo(saveFile);
					// 파일 확장자

				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage());
					throw new RuntimeException(e);
				}
			}
			result += draftDao.insertDraftAtch(draftVO);
		}
		
		return result;
	}

	/**
	 * 임시/ 완료/ 진행중 등 기안상태에 따른 기안문서 리스트 조회
	 * @param empCd 기안 작성자
	 * @param drftStat 기안 상태코드
	 * @return
	 */
	@Override
	public List<DraftVO> retrieveMyDraftList(String empCd, String drftStat) {
		return draftDao.selectMyDraftList(empCd, drftStat);
	}
	
	/**
	 * 기안문서 상세 조회
	 * @param empCd 기안 작성자
	 * @return 기안문서
	 */
	@Override
	public DraftVO retrieveDraft(int drftNo) {
		return draftDao.selectDraft(drftNo);
	}
	
	@Override
	public List<DraftVO> retrieveMyDraftLineList(String empCd) {
		return draftDao.myDraftLineList(empCd);
	}
	@Override
	public List<DraftVO> retrieveMyDraftSusinList(String empCd) {
		return draftDao.myDraftSusinList(empCd);
	}
	@Override
	public List<DraftVO> retrieveMyDraftRamList(String empCd) {
		return draftDao.myDraftRamList(empCd);
	}
	
	@Override
	public int modifyDlineStat(DraftVO draftVO) throws Exception {
		int result = 0;
		// 내 결재 상태 변경
		result += draftDao.updateDlineStat(draftVO);
		
		// 추가 의견이 있을 경우 의견 업데이트
		if(draftVO.getDrftOpVOList() != null) {
			result += draftDao.insertDraftOp(draftVO);
		}
		// 내가 등록할 결재 상태 번호
		String dlineStatCd = draftVO.getDrftLineVOList().get(0).getDlineStatCd();
		//최종 결재 순번 번호
		int maxDlineSq = draftVO.getDrftLineVOList().get(0).getMaxDlineSq();
		// 내 결재 순번
		int DlineSq = draftVO.getDrftLineVOList().get(0).getDlineSq();
		
		// 반려일 경우
		if(dlineStatCd.equals("N002")) {
			//기안문서의의 상태를 반려로 변환
			result += draftDao.updateDraftStat(draftVO);
		}
		// 회수일 경우
		if(dlineStatCd.equals("N003")) {
			//기안문서의의 상태를 회수로 변환
			result += draftDao.updateDraftStat(draftVO);
		}
		
		System.out.println(dlineStatCd);
		System.out.println(maxDlineSq);
		System.out.println(DlineSq);
		
		// 최종 결재일 경우
		if (maxDlineSq == DlineSq && dlineStatCd.equals("N001")) {
			log.info("최종"+draftVO);
			// 기안 - 휴가 인서트
			if(draftVO.getDraftVacVO() != null) {
				log.info("휴가등록");
				result += draftDao.insertDraftVac(draftVO);
			}
			// 기안 - 발주서 상태 업데이트
			if(draftVO.getPordCd() != null) {
				log.info("발주진행");
				result += draftDao.updatePordStat(draftVO.getPordCd());
			}
			result += draftDao.updateDraftStat(draftVO);
		}
		return result;
	}
	
	
	
	
	
	// 발주서 일련번호 선택
	@Override
	public List<DraftOrderVO> selectPordCd() {
		return draftDao.selectPordCd();
	} 
	
	@Override
	public List<DraftOrderVO> selectOrderPlayDetailList(String pordCd) {
		return draftDao.selectOrderPlayDetailList(pordCd);
	}
	
	// 발주서 상태변경
	@Override
	public int modifyPordStat(String pordCd) {
		return draftDao.updatePordStat(pordCd);
	};

	
	
	
	
	
	
	
	
	
	@Override
	public List<DraftFormVO> retrieveDformList() {
		return draftDao.selectDformList();
	}

	@Override
	public int createDform(DraftFormVO draftFormVO) {
		return draftDao.insertDform(draftFormVO);
	}

	@Override
	public DraftFormVO retrieveDform(int dformNo) {
		return draftDao.selectDform(dformNo);
	}	

}
