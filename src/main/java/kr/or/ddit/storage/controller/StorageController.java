package kr.or.ddit.storage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.maps.model.LatLng;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.storage.service.AddressService;
import kr.or.ddit.storage.service.StorageService;
import kr.or.ddit.storage.vo.StorageVO;
import kr.or.ddit.util.commcode.dao.CommcodeDAO;
import kr.or.ddit.util.commcode.vo.CommcodeVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/stor")
public class StorageController {
	
	@Inject
	private StorageService service;
	@Inject
	private EmpDAO empDao;
	@Inject
	private CommcodeDAO commDao;
	
	@Inject
    private AddressService addressService;

	
	@ModelAttribute("storVO")
	public StorageVO storage() {
		StorageVO storage = new StorageVO();
		return storage;
	}
	
	@GetMapping("/view")
	public String storageRetrieveView(Model model) {	
		List<CommcodeVO> wareGroupList = commDao.wareGroupList();
		List<EmpVO> empGroupList = empDao.commEmpList();
		model.addAttribute("wareGroupList", wareGroupList);				
		model.addAttribute("empGroupList", empGroupList);			
		
		return "storage/storageList";
	}
	
	@GetMapping
	public String storageRetrieve(Model model) {	
		List<StorageVO> wareList =  service.retrieveStorageList();
		
		model.addAttribute("wareList", wareList);				
		
		return "jsonView";
	}
	
	  
	  @PostMapping 
	  public String storageForm(@Valid @RequestBody StorageVO storVO, Errors errors, Model model ){
		  //errors가 error를 가지고있는지 여부
		  boolean valid = !errors.hasErrors();
		  String rslt = "";
		  //error를 담을 Map
		  Map<String, String> errorMap = new HashMap<>();
		  //error가 있을시 errors 변수에 담긴 error들을 list로 저장
		  List<ObjectError> errorList = errors.getAllErrors();
		  if(valid) {
			  //위도 경도로 변환하는 geocorder
			  if(!storVO.getWareAddr().isEmpty()) {
				  LatLng location = addressService.getCoordinate(storVO.getWareAddr());		  
				  storVO.setWareLatitude(String.valueOf(location.lat));
				  storVO.setWareLongitude(String.valueOf(location.lng));				  
			  }
			   //로직수행
			    ServiceResult result  = service.createStorage(storVO);
			    switch(result) {
				case OK:
					storVO.setWareTemp("Y");
					model.addAttribute("storVO",storVO);
					errorMap.put("rslt", "success");
					break;
				default:
					model.addAttribute("message", "서버오류입니다. 다시 입력해 주세요");
					errorMap.put("rslt", "fail");
				}
		  }else {
			  //error가 잇을경우 
			  errorMap.put("rslt", "fail");
			  for (ObjectError error : errorList) {
	                FieldError fieldError = (FieldError) error;
	                String fieldName = fieldError.getField();
	                String errorMessage = error.getDefaultMessage();
	                errorMap.put(fieldName, errorMessage);	            
		      }
		  }
		  model.addAttribute("errors", errorMap);
		  return "jsonView";
	  }
	  
	  
	  
	  @GetMapping("/form") 
	  public String storageFormView(){
		  //우선냅둬
		  return "storage/storageForm";
	  }		
	  
	  @PutMapping
	  public String updateStorage(@Validated(UpdateGroup.class) @RequestBody StorageVO storVO, Errors errors,Model model ) {
		  
		  boolean valid = !errors.hasErrors();
		  String rslt = "";
		  Map<String, String> errorMap = new HashMap<>();
		  List<ObjectError> errorList = errors.getAllErrors();
		  
		  if(valid) {
			  if(!storVO.getWareAddr().isEmpty()) {
				  LatLng location = addressService.getCoordinate(storVO.getWareAddr());		  
				  storVO.setWareLatitude(String.valueOf(location.lat));
				  storVO.setWareLongitude(String.valueOf(location.lng));				  
				  log.info("값좀보자 : {}",storVO);
			  }
			  
			    ServiceResult result  = service.modifyStorage(storVO);
			    switch(result) {
				case OK:
					model.addAttribute("storVO",storVO);
					errorMap.put("rslt", "success");
					break;
				default:
					model.addAttribute("message", "서버오류입니다. 다시 입력해 주세요");
					errorMap.put("rslt", "fail");
				}
		  }else {
			  errorMap.put("rslt", "fail");
			  
			  for (ObjectError error : errorList) {
	                FieldError fieldError = (FieldError) error;
	                String fieldName = fieldError.getField();
	                String errorMessage = error.getDefaultMessage();

	                errorMap.put(fieldName, errorMessage);	            
		      }
		  }
		  
		  model.addAttribute("errors", errorMap);
		  return "jsonView";
	  }
	  
	  
	  @ResponseBody
	  @PutMapping("{wareCd}")
	  public String unUseUpdateStorage(@PathVariable String wareCd) {
		  
		  ServiceResult result =  service.modifyUnUseStorage(wareCd);
		  
		  switch(result) {
		   case OK:
			  	return "success";
		   default:
				return "fail";
			}
		  
	  }
	  
	  @ResponseBody
	  @PutMapping("/use/{wareCd}")
	  public String useUpdateStorage(@PathVariable String wareCd) {
		  
		  ServiceResult result =  service.modifyUseStorage(wareCd);
		  
		  switch(result) {
		  case OK:
			  return "success";
		  default:
			  return "fail";
		  }
		  
	  }
	  
}
