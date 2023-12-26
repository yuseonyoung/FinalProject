package kr.or.ddit.purOrderRequest.vo;

import java.time.LocalDate;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.Future;
import javax.validation.constraints.FutureOrPresent;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.lang.Nullable;

import kr.or.ddit.grouphint.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "preqCd")
@Data
public class PurOrderRequestVO {
	private String preqCd;
	private String preqDate;
	
	@NotNull(message = "납기일자를 지정해야 합니다.")
	@FutureOrPresent(message = "날짜는 현재 날짜나 미래의 날짜여야 합니다",groups = InsertGroup.class)
	@DateTimeFormat(iso = ISO.DATE) 
	private LocalDate preqDueDate;
	private String preqStat;
	@NotBlank
	private String empCd;
	
	private String empNm;
	private String deptNm;
	//신범종이 추가 
	@Nullable
	private String nQty;

	@Valid
	private List<ReqItemVO> reqItem; // has many(1:N)
}
