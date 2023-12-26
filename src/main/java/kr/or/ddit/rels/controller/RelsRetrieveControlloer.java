package kr.or.ddit.rels.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.quote.vo.QuoteVO;
import kr.or.ddit.rels.service.RelsService;
import kr.or.ddit.rels.vo.RelsItemVO;
import kr.or.ddit.rels.vo.RelsVO;
import kr.or.ddit.sale.vo.SaleItemVO;
import kr.or.ddit.sale.vo.SaleVO;
import kr.or.ddit.util.commcode.dao.CommcodeDAO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 김도현
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      김도현       최초작성
 * 2023. 11. 21.	 김도현		조회,등록,수정작성
 * 2023. 11. 22.     김도현		POI 메소드 추가
 * 2023. 11. 24.     김도현		POST, PUT 메소드 내용 수정
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@Controller
@RequestMapping("/rels")
public class RelsRetrieveControlloer {
	
	@Inject
	private RelsService service;
	
	@Inject 
	private CommcodeDAO commDao;
	
	
	
	@ModelAttribute("relsVO")
	public RelsVO relsVO (){
		RelsVO relsVO = new RelsVO();
		return relsVO;
	}
	
	@GetMapping("/list")
	public String relsList() {
		return "rels/relsList";
	}
	
	@PostMapping("/getSaleItemList")
	@ResponseBody
	public List<SaleItemVO> getSaleItemList(@RequestBody SaleItemVO saleItemVO){
		log.info("getSaleItemList->saleItemVO : " + saleItemVO);
		
		String saleCd = saleItemVO.getSaleCd();
		
		List<SaleItemVO> saleItemVOList = this.service.getSaleItemList(saleCd);
		log.info("getSaleItemList->saleItemVOList : " + saleItemVOList);
		
		return saleItemVOList;
	}
	
	@GetMapping("/listView")
	public String relsListJson(Model model) {
		List<RelsVO> relsList = service.retrieveRelsList();
		model.addAttribute("relsList", relsList);
		return "jsonView";
	}
	
	@GetMapping("/view")
	public String relsView(@RequestParam("what") String relsCd, Model model) {
		RelsVO relsView = service.retrieveRels(relsCd);
		model.addAttribute("relsView", relsView);
		return "jsonView";
	}
	
	
	
	@GetMapping("/form")	// post / put 으로 바꿀것
	public String relsForm(Model model) {
		//List<CommcodeVO> comm = commDao.defectGroupList();
		//List<CommcodeVO> defectTypeList = commDao.defectTypeGroupList();
		//List<CommcodeVO> comTypeList = commDao.comGroupList();
		//model.addAttribute("defectTypeList",comm);
		//model.addAttribute("defectTypeList",defectTypeList);
		//model.addAttribute("comTypeList", comTypeList);
		
		return "rels/relsForm";
	}
	
	@GetMapping("/downloadExcel")
	  public void downloadExcel(HttpServletResponse response) {
	        try {
	            // 새로운 워크북 및 시트 생성
	            Workbook workbook = new XSSFWorkbook();
	            Sheet sheet = workbook.createSheet("출하지시서 목록");

	            // 헤더 행 생성
	            Row headerRow = sheet.createRow(0);

	            headerRow.createCell(0).setCellValue("출하지시서코드");
	            headerRow.createCell(1).setCellValue("출하지시서일자");
	            headerRow.createCell(2).setCellValue("거래처명");
	            headerRow.createCell(3).setCellValue("담당자");
	            headerRow.createCell(4).setCellValue("품목");
	            headerRow.createCell(5).setCellValue("수량");
	            headerRow.createCell(6).setCellValue("단가");
	            headerRow.createCell(7).setCellValue("합계");

	            // 서비스에서 출하지시서 목록을 검색
	            List<RelsVO> relsList = service.retrieveRelsList();

	            // 데이터 행 생성
	            int rowNum = 1;
	            for (RelsVO rels : relsList) {
	                Row row = sheet.createRow(rowNum++);

	                row.createCell(0).setCellValue(rels.getRdrecCd());
	                row.createCell(1).setCellValue(rels.getRdrecDate());
	                row.createCell(2).setCellValue(rels.getCompany().getComNm());
	                row.createCell(3).setCellValue(rels.getEmployee().getEmpNm());
	            
	                RelsItemVO firstItem = rels.getRelsItem().get(0);
	                row.createCell(4).setCellValue(firstItem.getItem().getItemNm());
	                row.createCell(5).setCellValue(firstItem.getRdrecQty());
	                row.createCell(6).setCellValue(firstItem.getRdrecUprc());
	                // 합계 계산 및 설정
	                double qty = firstItem.getRdrecQty();
	                double uprc = firstItem.getRdrecUprc();
	                double total = qty * uprc;
	                row.createCell(7).setCellValue(total);
	            }

	            // 응답 헤더 설정
	            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	            response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode("출하지시서목록.xlsx", "UTF-8"));

	            // 워크북 내용을 응답 출력 스트림에 작성
	            try (OutputStream outputStream = response.getOutputStream()) {
	                workbook.write(outputStream);
	            }

	        } catch (IOException e) {
	            e.printStackTrace();  // 예외를 적절히 처리하세요.
	        }
	    }
	
	@PostMapping
	public String insertForm(@Valid RelsVO relsVO
			,Errors errors 
			,Model model) {
		log.info("@@@@@@seachMap 보자 : {}", relsVO);
		
		// relsStat이 제공되지 않았을 경우 기본값으로 진행중 설정
//	    if (!relsMap.containsKey("rdrecStat") || relsMap.get("rdrecStat") == null || relsMap.get("rdrecStat").toString().isEmpty()) {
//	        relsMap.put("rdrecStat", "T001");
//	    }
		
		relsVO.setRdrecStat("T001");
		
		if (errors.hasErrors()) {
	        // 오류가 있다면 처리
	        model.addAttribute("valid", false);
	       
	    } else {
	        // 출하지시서 생성 및 결과 처리
	        ServiceResult result = service.createRels(relsVO);
	        model.addAttribute("valid", true);
	        model.addAttribute("result", result.name());
	       
	    }
		
		return "redirect:/rels/form";
	}
	
	@PostMapping("/relsUpdate")
	public String relsUpdate(@Valid RelsVO relsVO
			,Errors errors 
			,Model model) {
		/*
		 QuoteVO(qteNum=0, qteCd=Q237, qteDate=2023-12-04, qteStat=null, comCd=COM033, comNm=기아나, empCd=E202003150101, empNm=황수빈, btbQteCd=null, qteUprc=0, qteQty=0, itemCd=null, company=null, employee=null,quoteItem=[
		 	QuoteItemVO(qteCd=null, itemCd=D014AD002, qteUprc=21.0, qteQty=11.0, 
		 		item=ItemVO(itemCd=null, itemNm=비스나이프에어드레서(5벌), itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)),
		 	QuoteItemVO(qteCd=null, itemCd=D014AD003, qteUprc=51.0, qteQty=31.0, 
		 		item=ItemVO(itemCd=null, itemNm=비스나이프에어드레서(7벌), itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)), 
		 	QuoteItemVO(qteCd=null, itemCd=D015VC001, qteUprc=91.0, qteQty=71.0, 
		 		item=ItemVO(itemCd=null, itemNm=무선청소기, itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null))])
		 */
		log.info("@@@@@@relsUpdate->relsVO 보자 : {}",relsVO);
		
		// qteStat이 제공되지 않았을 경우 기본값으로 진행중 설정
//	    if (!quoteMap.containsKey("qteStat") || quoteMap.get("qteStat") == null || quoteMap.get("qteStat").toString().isEmpty()) {
//	        quoteMap.put("qteStat", "T001");
//	    }
		relsVO.setRdrecStat("T001");
		
		if (errors.hasErrors()) {
			// 오류가 있다면 처리
			model.addAttribute("valid", false);
			
		} else {
			// 견적서 생성 및 결과 처리
			ServiceResult result = service.modifyRels(relsVO);
			model.addAttribute("valid", true);
			model.addAttribute("result", result.name());
			
		}
		
		return "redirect:/rels/list";
	}
	
	
	@PutMapping	
	public String updaterels(@Valid RelsVO relsVO
			, Errors errors
			, Model model){
		log.info("@@@@@@seachMap 보자 : {}", relsVO);
		
		if (errors.hasErrors()) {
	        // 오류가 있다면 처리
	        model.addAttribute("valid", false);
	       
	    } else {
	        // 견적서 생성 및 결과 처리
	        ServiceResult result = service.modifyRels(relsVO);
	        model.addAttribute("valid", true);
	        model.addAttribute("result", result.name());
	       
	    }
		
		 return "jsonView";
	}
	
}
