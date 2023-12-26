package kr.or.ddit.websocket.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.security.userdetails.EmpVOwrapper;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 우정범
 * @since 2023. 11. 14.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 14.      우정범       최초작성
 * 2023. 12. 02.      이수정       웹소켓 세션 설정
 * 2023. 12. 03.      이수정       handleTextMessage 작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Slf4j
public class CustomWebSocketHandler extends TextWebSocketHandler {

	// private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> deptSessions = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 접속 요청 성공");
		// list.add(session);

		String empCd = getId(session);
		String dept = getDept(session);
		userSessions.put(empCd, session);
		deptSessions.put(dept, session);
		log.info("로그인한 사용자ID {}", empCd);
		log.info("로그인한 사용자DEPT {}", dept);
		log.info("로그인한 정보 {}", userSessions.get(empCd).getPrincipal());

		String senderId = session.getPrincipal().getName(); // getId(session);

		userSessions.put(senderId, session);
		deptSessions.put(dept, session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("클라이언트로부터:" + message.getPayload());
		String senderId = session.getPrincipal().getName(); // getId(session);

		Set<String> keySet = userSessions.keySet();
		Set<WebSocketSession> valueSet = new HashSet<WebSocketSession>(userSessions.values());
		Set<Entry<String, WebSocketSession>> entrySet = userSessions.entrySet();
		Set<Entry<String, WebSocketSession>> deptEntrySet = deptSessions.entrySet();

		Iterator<String> itr = keySet.iterator();

		// 접속한 모든이에게 메세지 전달, 메세지를 보낸 사람 포함!

		for (String empCd : keySet) {
			log.info("로그인한 키셋:{}", empCd);
		}

		for (Entry<String, WebSocketSession> entry : entrySet) {
			String msg = message.getPayload();
			JSONParser parser = new JSONParser();

			try {
				JSONObject jsonObj = (JSONObject) parser.parse(msg);

				if (StringUtils.isNotEmpty(msg) && jsonObj != null) {
					String cmd = (String) jsonObj.get("cmd");
					//String sender = (String) jsonObj.get("sender");
					String receiver = (String) jsonObj.get("receiver");
					String senNm = (String) jsonObj.get("senNm");
					//String recNm = (String) jsonObj.get("recNm");
					if ("mail".equals(cmd) && entry != null && entry.getKey().equals(receiver)) {
						TextMessage tmpMsg = new TextMessage(senNm + "님이 메일을 보냈습니다");
						log.info("메일을 보낼 사람: {}", entry.getKey());
						entry.getValue().sendMessage(tmpMsg);
					}

				}
			} catch (Exception e) {
				log.info(e.getMessage());
			}
		}

		for (Entry<String, WebSocketSession> entry : deptEntrySet) {
			String msg = message.getPayload();
			JSONParser parser = new JSONParser();

			try {
				JSONObject jsonObj = (JSONObject) parser.parse(msg);

				if (StringUtils.isNotEmpty(msg) && jsonObj != null) {
					String cmd = (String) jsonObj.get("cmd");
					String receiver = (String) jsonObj.get("receiver");
					log.info("receiver확인 : {}", receiver);
					if ("purOrdReq".equals(cmd) && entry != null && entry.getKey().equals(receiver)) {
						TextMessage tmpMsg = new TextMessage("발주요청서가 등록되었습니다.");
						log.info("메일을 보낼 사람: {}", entry.getKey());
						entry.getValue().sendMessage(tmpMsg);
					}

				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}

	}

	private String getId(WebSocketSession session) {

		Map<String, Object> sessionMap = session.getAttributes();
		SecurityContext sc = (SecurityContext) sessionMap.get("SPRING_SECURITY_CONTEXT");
		String empCd = ((EmpVOwrapper) (sc.getAuthentication().getPrincipal())).getRealUser().getEmpCd();
		return empCd;

	}

	private String getDept(WebSocketSession session) {

		Map<String, Object> sessionMap = session.getAttributes();
		SecurityContext sc = (SecurityContext) sessionMap.get("SPRING_SECURITY_CONTEXT");
		String dept = ((EmpVOwrapper) (sc.getAuthentication().getPrincipal())).getRealUser().getDeptNm();
		return dept;

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남");
		// list.remove(session);

		String empCd = getId(session);
		String dept = getDept(session);
		// empCd값이 안 나오면 userSessions안에 있는 entry에서 열리지 않은 세션 삭제!
		// session.isOpen()
		userSessions.remove(empCd);
		deptSessions.remove(dept);

	}

}
