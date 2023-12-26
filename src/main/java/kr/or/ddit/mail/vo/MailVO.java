package kr.or.ddit.mail.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

/**
 * @author 이수정
 * @since 2023. 11. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 15.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */


@Data
@EqualsAndHashCode(of = "mailNo")
public class MailVO implements Serializable{
	private Integer rnum;
	private String empCd;
	private Integer mailNo;
	private String mailSen;
	private String mailRead;
	private String mailDate;
	@ToString.Exclude
	private String mailCont;
	private String mailTitle;
	private String mailDel;
	private String mailDdate;
	private String mailTrash;
	private String mailRec;
	private String mailRecs;
	private String recDel;
	private String recTrash;
	private String senNm;
	private String recNm;
	private String recCmail;
	private String senCmail;
	private String empImg;
	
	@JsonIgnore
	private MultipartFile[] mailFile;
	private List<AttatchVO> attatchList; //has many
	public void setMailFile(MultipartFile[] mailFile) {
		if(mailFile!=null) {
			this.mailFile = Arrays.stream(mailFile)
				.filter((f)->!f.isEmpty())
				.toArray(MultipartFile[]::new);
		}
		if(this.mailFile!=null) {
			this.attatchList = Arrays.stream(this.mailFile)
									.map((f)->new AttatchVO(f))
									.collect(Collectors.toList());
			
		}
	}
	


}
