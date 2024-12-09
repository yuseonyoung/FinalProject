# 📦 **AIM ERP System**

** ERP 프로그램 **

---

## 📋 프로젝트 개요
AIM 프로젝트는 재고관리, 창고관리, 구매 및 판매, 인사관리 프로세스를 통합하여 **효율적인 창고 및 재고 관리**를 목표로 한 ERP 시스템입니다.  
**E-COUNT ERP**를 벤치마킹하여 창고를 시각화하고 프로세스를 간소화함으로써 사용자 경험(UX)을 대폭 향상시켰습니다.

- **개발 기간**: 2023.10.26 ~ 2023.12.14  
- **팀 구성**: 7명 (PL, TA, AA × 2, BA, DA, UA)  
- **내 역할**: **프로젝트 리더 (PL)**  

---

## 🚀 주요 기능
- **품목관리**
- **창고관리**
- **창고구역관리**
- **발주요청관리**
- **재고입출고관리**
- 재고관리
- 발주관리  
- 단가요청서관리  
- 대시보드  
- 메일관리  
- 로그인/권한관리  
- 알람  
- 전자결재관리  
- 판매관리  
- 게시판관리  
- 인사관리
---

## 🛠 개발 환경
- **Backend**: Java, Spring Framework, MyBatis, TilesFramework  
- **Server**: Apache Tomcat  
- **Database**: Oracle  
- **Version Control**: SVN  
- **UI/UX**: HTML5, CSS3, JavaScript, jQuery, Bootstrap
- **Tool**: Eclipse, sqlDeveloper 

---

## 🔑 담당 기능

### **1. 품목관리**
- 품목 등록, 수정, 삭제 및 조회 기능 구현  
- 대량 데이터 페이징 처리 및 조건부 검색 최적화  
- **연계 기능**: 품목별 정보 연동 (재고수량, 단가, 품목의 상태 등등)  

### **2. 창고관리**
- 창고 등록,수정,삭제의 기능 구현
- 창고의 실제 위치를 Google Map을 통하여 실제 위치를 GIS기반으로 표출
- Kakao 주소 API를 통하여 정확한 창고주소를 등록하는 기능 구현

### **3. 창고구역관리**
- 창고 구역 등록 및 구역별 품목 배치 최적화 
- 비동기 처리로 빠른 구역 데이터 로딩  
- 창고 데이터와 구역 데이터 매핑
- 창고구역을 마우스를 통하여 직접 그리고 이동시켜 등록
- 실제 창고도면을 baseMap으로 설정하고 그 위에 [창고면적 : 창고구역]의 비율로 구역을 설정하여 등록
- floor별로 창고구역을 등록
- validation 적용 (창고구역 곂침, 창고구역의 면적이 일정수치 이하, ...)
- 창고 및 구역내 품목이동 기능 구현

### **4. 발주요청관리**
- 발주요청서 작성, 승인, 상태(대기/승인/반려) 관리
- 메일 알림 시스템 구축
- 비즈니스 로직 기반 트랜잭션 처리  

### **5. 재고입출고관리**
- 창고 입고관리 ( 발주서의 입고예정일을 기반으로 입고예정 품목을 모니터링하여 실입고를 확인하고 입고처리를 함)
- 창고 출고관리 ( 출하지시서의 출하예정일을 기반으로 출하예정품목을 모니터링하며 실출고를 할 때 출고처리를 함)
- 창고 입출고와 재고는 database의 trigger로 모두 연동됨
---

## 📈 성과 및 기여
- **프로젝트 리더십**: 일정 관리, 산출물 작성, 팀 간 커뮤니케이션 주도  
- **UI/UX 개선**: 창고구역 및 구역내 재고 시각화를 통하여 사용자가 직관적으로 창고의 정보를 알 수 있는 UI/UX체계 구축
- **트랜잭션 안정성 확보**: Spring 트랜잭션 관리로 시스템 안정성 향상
---

## 📂 벤치마킹 사례
- **E-COUNT ERP**: 프로세스 및 기능 설계 참고  

---

## 별첨자료
- 대시보드 및 실시간 알람
![대시보드](https://github.com/user-attachments/assets/437277da-369c-4949-96a9-42c54ff0ff62)

- 창고관리
1) 창고조회
![창고조회](https://github.com/user-attachments/assets/95959cd3-cb28-4c97-a7ca-91593ad93c77)

2) 창고 상세 조회
![창고상세조회](https://github.com/user-attachments/assets/68336435-349a-4bcb-b71e-d71442ae5a22)

3) 창고 위치 조회
![창고지도확인](https://github.com/user-attachments/assets/11673bd9-9e8b-4fd9-961f-d297728ad737)

- 창고구역관리
1) 창고구역 등록
https://github.com/user-attachments/assets/2d362156-64c2-4692-b852-fc84413af632

2) 창고구역 조회
![창고구역조회](https://github.com/user-attachments/assets/618b5ea5-0245-44ac-a61a-45615a21c5d4)

3) 창고품목이동 
![창고품목이동](https://github.com/user-attachments/assets/971dd904-db6d-4315-bc65-7bc289e15f60)

4) 창고품목이동 완료된 화면

㉠ 창고의 품목이 이동된 창고
![품목이이동된창고](https://github.com/user-attachments/assets/370b79b5-fcee-4dc4-b46c-0f12c0d3ed80)

㉡ 창고의 품목이 이동되는 창고
![품목이동되는창고](https://github.com/user-attachments/assets/ace0537f-b2b6-42b4-ae48-c20d8f4396ca)

- 창고입출고관리
1) 창고입고관리

㉠ 입고 예정 조회
![입고예정조회](https://github.com/user-attachments/assets/4d03cb8f-1359-4fdb-8364-50cf717f5368)

㉡ 입고될 창고 구역 입력
![창고구역입력](https://github.com/user-attachments/assets/c3e97e54-0ba0-41d3-b070-672144027d88)

㉢ 품목이 입고확정된 창고
![품목이입고확정된창고](https://github.com/user-attachments/assets/4353d049-a7d4-4039-9cb5-b75d30592f90)

2) 창고출고관리
㉠ 출하 예정 조회
![출하예정조회](https://github.com/user-attachments/assets/cd2e44e2-326c-48da-8992-65a05f8409d2)

㉡ 출하 확정 
![출하확정](https://github.com/user-attachments/assets/a086d1dc-b67a-46a8-9008-964ba82243ab)







