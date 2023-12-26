<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div id="disp"></div>
    <input type="text" jbTxt value="">
    <button onclick="fSend()">떤송</button>
<script>
    const jbDisp = document.querySelector("#disp");
    const jbTxt = document.querySelector("[jbTxt]");

   let alarmSocket =  new WebSocket("ws://localhost/alarm");  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함
    
   // 연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
   const fSocOpen = () =>{
    console.log("연결성공");
    alarmSocket.send("서버야 내 메세지 받앙");

   }
   
   const fSocMsg = () => {
	   console.log("서버에서 온 메세지" + event.data);
       jbDisp.innerHTML += event.data;
   }
   
   function fSend(){
    alarmSocket.send(jbTxt.value);
    alarmSocket.send(JSON.stringify({
        senderNm:"JB",
        sender:"kGB",
        userId:"AAA",
    	sessionId:"KDJFKEEJF",
    	userNm:"이름",
    	userEml:"KKK"
    }));
   }


   alarmSocket.onopen =fSocOpen;
   
   //서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
   alarmSocket.onmessage = fSocMsg;
   
</script>
</body>
</html>