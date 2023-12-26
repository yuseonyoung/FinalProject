package kr.or.ddit.storage.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class AddressService {
    @Value("${google.api.key}")
    private String googleApiKey;
    
    public LatLng getCoordinate(String wareAddress){
	    String apiKey = "AIzaSyBX-OXAyoqxDI1o3Un-ZRkcNGsB6jrpD0g";
	
	    GeoApiContext context = new GeoApiContext.Builder().apiKey(apiKey).build();
	
	    String address = "대전광역시 유성구 궁동";
	    LatLng location = null;
	    try {
	        GeocodingResult[] results = GeocodingApi.geocode(context, address).await();
	
	        if (results != null && results.length > 0) {
	            location = results[0].geometry.location;
	            
	        } else {
	        	//주소 업승ㄹ땐 어떻게하냐
	        	log.info("어카라고");
	        }
	
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return location;
    }
}
