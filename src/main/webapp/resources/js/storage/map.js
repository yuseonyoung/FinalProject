/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 10.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 



	function myMap(){
      var mapOptions = { 
            center:new google.maps.LatLng(37.5400456, 126.9921017 ),
            zoom:5
      };
 
      var map = new google.maps.Map( 
             document.getElementById("googleMap") 
            , mapOptions );
   }
