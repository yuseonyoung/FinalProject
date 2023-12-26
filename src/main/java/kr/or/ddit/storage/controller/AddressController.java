package kr.or.ddit.storage.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.storage.service.AddressService;

@RestController
public class AddressController {

	@Inject
    private AddressService addressService;

    public AddressController(AddressService addressService) {
        this.addressService = addressService;
    }

    @GetMapping("/address")
    public void address(){
        String location = "대전광역시 유성구 궁동";
        addressService.getCoordinate(location);

        //System.out.println(location + ": " + coords[0] + ", " + coords[1]);
    }
}
