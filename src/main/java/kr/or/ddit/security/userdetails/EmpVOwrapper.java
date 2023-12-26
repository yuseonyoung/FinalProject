package kr.or.ddit.security.userdetails;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.employee.vo.EmpVO;
import lombok.ToString;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 10.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
@ToString
public class EmpVOwrapper extends User{
	private EmpVO realUser;
	
	
	
	
	public EmpVOwrapper(EmpVO realUser) {
		super(realUser.getEmpCd(), realUser.getEmpPw(), AuthorityUtils.createAuthorityList(realUser.getUserRole()));
		this.realUser = realUser;
	}




	public EmpVO getRealUser() {
		return realUser;
	}
	
}
