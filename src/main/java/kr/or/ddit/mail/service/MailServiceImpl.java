package kr.or.ddit.mail.service;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.mail.MailNotFoundException;
import kr.or.ddit.mail.dao.AttatchDAO;
import kr.or.ddit.mail.dao.MailDAO;
import kr.or.ddit.mail.vo.AttatchVO;
import kr.or.ddit.mail.vo.MailVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 이수정
 * @since 2023. 11. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 15.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Slf4j
@Service
public class MailServiceImpl implements MailService {

	@Inject
	private MailDAO dao;

	@Inject
	private AttatchDAO attatchDAO;

	@Inject
	private AlarmDAO alarmDAO;

	@Inject
	private EmpDAO empDAO;

	@Value("#{appInfo.mailFiles}")
	private Resource mailFiles;

	/**
	 * 첨부파일 등록 프로세스
	 * @param mailVO
	 */
	private void procesMailFiles(MailVO mailVO) {
		List<AttatchVO> attatchList = mailVO.getAttatchList();
		log.info("mailService 첨부파일 리스트 : {}", attatchList);
		if (attatchList != null) {
			//메일 리스트를 for문 돌린 후 인서트
			attatchList.forEach((atch) -> {
				try {
					atch.setMailNo(mailVO.getMailNo());
					attatchDAO.insertAttatch(atch);
					atch.saveTo(mailFiles.getFile());
				} catch (IOException e) {
					throw new RuntimeException(e);
				}

			});
		}

	}

	/**
	 * 받은 메일 목록 조회
	 */
	@Override
	public List<MailVO> retrieveMailList(PaginationInfo<MailVO> paging) {
		log.info("메일 서비스 {}", dao.selectMailList(paging));
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		// 토탈페이지보다 현재페이지가 클 경우 -값이 뜨기 때문에 이를 처리해주는 코드
		if (paging.getTotalPage() < paging.getCurrentPage()) {
			//토탈 페이지가 0보다 같거나 작으면 1을 현재페이지에 넣어준다
			int cpage = paging.getTotalPage() <= 0 ? 1 : paging.getTotalPage();
			paging.setCurrentPage(cpage);
		}
		return dao.selectMailList(paging);
	}

	/**
	 * 안읽은 메일 목록 조회
	 */
	@Override
	public List<MailVO> retrieveUMailList(PaginationInfo<MailVO> paging) {
		int totalRecord = dao.selectTotalURecord(paging);
		paging.setTotalRecord(totalRecord);
		if (paging.getTotalPage() < paging.getCurrentPage()) {
			int cpage = paging.getTotalPage() <= 0 ? 1 : paging.getTotalPage();
			paging.setCurrentPage(cpage);
		}
		return dao.selectUMailList(paging);
	}

	/**
	 * 보낸 메일 목록 조회
	 */
	@Override
	public List<MailVO> retrieveSMailList(PaginationInfo<MailVO> paging) {
		int totalRecord = dao.selectTotalSRecord(paging);
		paging.setTotalRecord(totalRecord);
		if (paging.getTotalPage() < paging.getCurrentPage()) {
			int cpage = paging.getTotalPage() <= 0 ? 1 : paging.getTotalPage();
			paging.setCurrentPage(cpage);
		}
		return dao.selectSMailList(paging);
	}

	/**
	 * 메일 상세 조회
	 */
	@Override
	public MailVO retrieveMail(int mailNo, String empCd) {
		MailVO mailVO = dao.selectMail(mailNo);
		log.info("메일 서비스 empCd : {}", empCd);
		if (mailVO == null) {
			//mailVO가 null일 때 처리
			throw new MailNotFoundException(HttpStatus.NOT_FOUND, String.format("%d 해당 메일이 없음.", mailNo));
		} else if (!mailVO.getMailRec().equals(empCd) && !mailVO.getMailSen().equals(empCd)) {
			throw new MailNotFoundException(HttpStatus.NOT_FOUND, String.format("%d 해당 메일이 없음.", mailNo));
		}
		log.info("메일 서비스 mailNo : {}", mailNo);
		mailVO.setEmpCd(empCd);
		dao.readYN(mailVO);
		return mailVO;

	}

	/**
	 * 메일 보내기
	 */
	@Override
	public ServiceResult createMail(MailVO mailVO) {
		String recs = mailVO.getMailRec();
		AlarmVO alarmVO = new AlarmVO();
		log.info("메일 서비스 mailVO : {}", mailVO);
		log.info("메일 서비스 mailRec : {}", mailVO.getMailRec());
		
		// 쉼표로 문자열을 분할
		String[] rec = recs.split(",");
		int cnt = 0;

		// 분할된 결과 출력
		for (String rrec : rec) {
			mailVO.setMailRec(rrec);
			alarmVO.setAlarmSender(mailVO.getMailSen());
			String sender = empDAO.getName(mailVO.getMailSen());
			String receiver = empDAO.getName(rrec);
			mailVO.setSenNm(sender);
			mailVO.setRecNm(receiver);
			alarmVO.setSenNm(sender);
			alarmVO.setRecNm(receiver);
			alarmVO.setAlarmReceiver(rrec);
			alarmVO.setAlarmUrl("/mail/ulist");
			alarmVO.setAlarmCont(sender + "님이 메일을 보냈습니다.");
			log.info("메일 서비스 메일 발신 mailVO : {}", mailVO);
			cnt = dao.insertMail(mailVO);
			procesMailFiles(mailVO);
			alarmDAO.insertMailAlarm(alarmVO);
		}

		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}

		return result;
	}

	/**
	 * 첨부파일 조회
	 */
	@Override
	public AttatchVO retrieveAttatch(int mailAtchNo) {
		AttatchVO atch = attatchDAO.selectAttatch(mailAtchNo);
		if (atch == null)
			throw new MailNotFoundException(HttpStatus.NOT_FOUND, String.format("%d 해당 파일이 없음.", mailAtchNo));

		return atch;
	}

	@Override
	public List<EmpVO> mailAddr(int deptNo) {
		return dao.mailAddr(deptNo);
	}

	/**
	 * 보낸메일 삭제
	 */
	@Override
	public ServiceResult removeSentMail(int[] mailNos) {
		int cnt = 0;
		for (int mailNo : mailNos) {
			cnt = dao.updateSentMail(mailNo);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	/**
	 * 받은 메일 삭제
	 */
	@Override
	public ServiceResult removeInbox(int[] mailNos) {
		int cnt = 0;
		for (int mailNo : mailNos) {
			cnt = dao.updateInbox(mailNo);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	/**
	 * 안읽은 메일 삭제
	 */
	@Override
	public ServiceResult removeUnreadMail(int[] mailNos) {
		int cnt = 0;
		for (int mailNo : mailNos) {
			cnt = dao.updateUnreadMail(mailNo);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
