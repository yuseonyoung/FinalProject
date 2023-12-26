package kr.or.ddit.order.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.empInfo.vo.EmployeesVacVO;
import kr.or.ddit.order.service.OrderUnitPriceService;
import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.paging.OrderBootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.paging.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


/**
 * 
 * <pre>
 * /orderUnitPrice(GET)
 * /orderUnitPrice(POST)
 * /orderUnitPrice/{} (GET)
 * /orderUnitPrice/{} (PUT)
 * /orderUnitPrice/{} (DELETE)
 * </pre>
 * @author 범종
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      범종       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/orderUnitPrice")
public class OrderUnitPriceController {
	
	private final OrderUnitPriceService service;
	
	@GetMapping("/list")
	public String orderUnitPriceRetrieve(Model model) {
		return "order/orderUnitPrice";
	}

	/*
	 * @GetMapping("/list2")
	 * 
	 * @ResponseBody public List<OrderUnitPriceVO> orderUnitPriceRetrieve(){
	 * List<OrderUnitPriceVO> orderUnitPriceList = service.retrieveOrderUnitPrice();
	 * return orderUnitPriceList; }
	 */
	
	@GetMapping("/list2")
	@ResponseBody
	public PaginationInfo<OrderUnitPriceVO> orderPlayRetrieve(
			Model model
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			){
		PaginationInfo<OrderUnitPriceVO> paging = new PaginationInfo<>(10,5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		service.retrieveOrderUnitPrice(paging);
		
		paging.setRenderer(new OrderBootstrapPaginationRenderer());
		model.addAttribute("paging",paging);
		
		return paging;
	}
	
	@GetMapping("/enroll")
	public String orderUnitPriceEnrollRetrieve(Model model) {
		return "order/orderUnitPriceEnrollList";
	}
	
	@GetMapping("/view")
	@ResponseBody
	public List<OrderUnitPriceVO> orderUnitPriceDetailRetrieve(@RequestParam("what") String upreqCd){
		List<OrderUnitPriceVO> oupList = service.retrieveUnitPrice(upreqCd);
		return oupList;
	}
	
	
	
	
	@PutMapping(value="/modUnitPrice", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String orderUnitPriceModify(@RequestBody List<Map<String, String>> orderUnitPriceData) {
		log.info("^^ okay {}",orderUnitPriceData);
		ServiceResult modiResult = service.modifyUnitPriceDetail(orderUnitPriceData);
		log.info("modiResult{}",modiResult);
		return modiResult.name();
	}
	
	
	
	@PostMapping(value="/insertUnitPriceOne", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String orderUnitPriceOneCreate(@RequestBody List<Map<String, String>> rowData) {
		System.out.println("rowData"+rowData);
		ServiceResult abc = service.createUnitPriceOne(rowData);
		
		System.out.println("abc"+abc);
		
		return abc.name();
	}
	
	
	
	
	@GetMapping("/excelDown")
	public void orderPlanListViewUnitPrice(@RequestParam("what") String upreqCd, HttpServletResponse response, Authentication authentication) throws IOException {
		
		List<Map<String, Object>> oupList2 = service.retrieveUnitPrice1(upreqCd);
		
		
		 XSSFWorkbook wb = new XSSFWorkbook();
		    Sheet sheet = wb.createSheet("mysheet이름");
			
			
				// 헤더 생성
		    Row headerRow = sheet.createRow(0);
		    headerRow.createCell(0).setCellValue("단가요청코드");
		    headerRow.createCell(1).setCellValue("품목명");
		    headerRow.createCell(2).setCellValue("품목수량");
		    headerRow.createCell(3).setCellValue("단가요청일자");
		    headerRow.createCell(4).setCellValue("유효기간");
		    headerRow.createCell(5).setCellValue("단가요청서 담당사원");
		    headerRow.createCell(6).setCellValue("거래기간");
		    
		    
			//  데이터 저장
			int rowNum = 1;
			for (Map<String, Object> oup : oupList2) {
			    Row dataRow = sheet.createRow(rowNum++);
			    dataRow.createCell(0).setCellValue(String.valueOf(oup.get("upreqCd")));
			    dataRow.createCell(1).setCellValue(String.valueOf(oup.get("itemNm")));
			    dataRow.createCell(2).setCellValue(String.valueOf(oup.get("uprcItQty")));
			    dataRow.createCell(3).setCellValue(String.valueOf(oup.get("upreqDate")));
			    dataRow.createCell(4).setCellValue(String.valueOf(oup.get("upreqValDate")));
			    dataRow.createCell(5).setCellValue(String.valueOf(oup.get("empNm")));
			    dataRow.createCell(6).setCellValue(String.valueOf(oup.get("upreqDur")));
			}
		
		
			    
		    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		    response.setHeader("Content-Disposition", "attachment; filename=unitPriceDetail.xlsx");
		
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment;filename=unitPriceDetail.xlsx");  //파일이름지정.
		    // response OutputStream에 엑셀 작성
		    wb.write(response.getOutputStream());
	}
	
//	
//	@PutMapping("/upload")
//	@ResponseBody
//	public String orderUnitPriceUploadList
//	
	
	
	
	/*
	 * @PostMapping(value="/upload", produces = "application/json; charset=UTF-8")
	 * 
	 * @ResponseBody public ResponseEntity<?> excelFileUpload(@RequestParam("file")
	 * MultipartFile file) { System.out.println("file"+file);
	 * 
	 * if (file.isEmpty()) { return ResponseEntity.badRequest().body("파일이 없습니다!"); }
	 * 
	 * List<List<String>> excelData = new ArrayList<>();
	 * 
	 * 
	 * try { InputStream inputStream = file.getInputStream();
	 * 
	 * Workbook workbook;
	 * 
	 * if (file.getOriginalFilename().endsWith(".xls")) { workbook = new
	 * HSSFWorkbook(inputStream); // XLS 파일 } else if
	 * (file.getOriginalFilename().endsWith(".xlsx")) { workbook = new
	 * XSSFWorkbook(inputStream); // XLSX 파일 } else { return
	 * ResponseEntity.badRequest().body("지원하지 않는 파일 형식입니다!"); }
	 * 
	 * Sheet sheet = workbook.getSheetAt(0);
	 * 
	 * // 엑셀 파일 데이터 읽기 for (Row row : sheet) { List<String> rowData = new
	 * ArrayList<>(); for (Cell cell : row) { rowData.add(getCellValue(cell)); }
	 * excelData.add(rowData); }
	 * 
	 * inputStream.close();
	 * 
	 * ObjectMapper objectMapper = new ObjectMapper();
	 * 
	 * String jsonData = objectMapper.writeValueAsString(excelData);
	 * 
	 * System.out.println("excelDataexcelDataexcelDataexcelData"+excelData);
	 * 
	 * System.out.println("jsonDatajsonDatajsonDatajsonData"+jsonData);
	 * 
	 * 
	 * JsonParser jpars = new JsonParser();
	 * 
	 * JsonElement ele1 = jpars.parse(jsonData);
	 * 
	 * for (int i = 0; i < ele1.getAsJsonArray().size(); i++) {
	 * System.out.println("이게뭐지"+ele1.getAsJsonArray().get(i)); }
	 * 
	 * System.out.println("단가요청코드"+ele1.getAsJsonArray().get(1).getAsJsonArray().get
	 * (5).getAsString()); // 단가요청코드
	 * System.out.println("회사코드"+ele1.getAsJsonArray().get(1).getAsJsonArray().get(4
	 * ).getAsString()); // 회사코드
	 * 
	 * 
	 * String upreqCd =
	 * ele1.getAsJsonArray().get(1).getAsJsonArray().get(6).getAsString();
	 * 
	 * List<Map<String, Object>> aa = service.retrieveUnitPrice1("UR002");
	 * 
	 * System.out.println("aaaaaaaaaaaaaa"+aa);
	 * 
	 * 
	 * //^^ System.out.println(aa.get(0).get("upreqValDate"));
	 * System.out.println(aa.get(0).get("upreqCd"));
	 * System.out.println(aa.get(0).get("upreqStat"));
	 * System.out.println(aa.get(0).get("upreqDur"));
	 * System.out.println(aa.get(0).get("upreqValDate"));
	 * 
	 * 
	 * 
	 * 
	 * for (Map<String, Object> orderUnitPriceMap : aa) { String itemNm = (String)
	 * orderUnitPriceMap.get("itemNm"); System.out.println("itemNm: " + itemNm); }
	 * 
	 * 
	 * 
	 * // SelectUnitPriceVO 객체 생성 SelectUnitPriceVO priceVO = new
	 * SelectUnitPriceVO();
	 * priceVO.setComCd(ele1.getAsJsonArray().get(1).getAsJsonArray().get(5).
	 * getAsString());
	 * 
	 * 
	 * List<SelectUnitPriceItemVO> priceItemVO = new ArrayList<>();
	 * 
	 * for (int i = 2; i < ele1.getAsJsonArray().size(); i++) {
	 * System.out.println("이게뭐지"+ele1.getAsJsonArray().get(i));
	 * SelectUnitPriceItemVO priceItem = new SelectUnitPriceItemVO();
	 * priceItem.setItemNm(null); priceItem.setItemCd(null);
	 * priceItem.setCqteItQty(null);
	 * priceItem.setCqteItUprc((int)ele1.getAsJsonArray().get(i).getAsJsonArray().
	 * get(1).getAsDouble()); priceItem.setUpreqValDate(upreqCd);
	 * 
	 * priceItemVO.add(i-2, priceItem); } System.out.println("떠라"+priceItemVO);
	 * 
	 * //새로운 vo 만들고 ! 그 vo에는 단가가 있다 .. 단가 집어넣고 matching 시켜주는
	 * 
	 * // 여기서 뽑은 단가요청코드를 select ~ 해서
	 * 
	 * // 회사코드
	 * 
	 * // 여기서 뽑은 단가를 ~ vo에 담아서 ~ data 이동 하여 ~ view 에 뿌려준다 .(여기서 단가를 그 품목에 맞는 곳에 정확히
	 * 들어가려면 어떻게 해야되는지 .)
	 * 
	 * // 단가요청코드 상태코드가 변한다! 그다음
	 * 
	 * // 승인을 눌렀을 떄 1 comqtevo /2 comqteitemvo / 3 itemuprcvo / 4 purordvo/ 5
	 * purorditem 에 담아준다 ~
	 * 
	 * return ResponseEntity.ok().body(jsonData);
	 * 
	 * } catch (IOException e) { e.printStackTrace(); return
	 * ResponseEntity.status(500).body("Failed to process the Excel file: " +
	 * e.getMessage()); }
	 * 
	 * 
	 * }
	 * 
	 * // 셀 값 가져오기 private String getCellValue(Cell cell) { if (cell == null) {
	 * return ""; } switch (cell.getCellType()) { case Cell.CELL_TYPE_STRING: return
	 * cell.getStringCellValue(); case Cell.CELL_TYPE_NUMERIC: return
	 * String.valueOf(cell.getNumericCellValue()); case Cell.CELL_TYPE_BOOLEAN:
	 * return String.valueOf(cell.getBooleanCellValue()); default: return ""; } }
	 */
	
}
