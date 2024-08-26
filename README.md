# 로컬렌즈 Local Lens 📸
로컬렌즈는 사용자가 다녀온 여행지를 공유하고,<br>
자신의 취향에 맞는 공간을 발견 및 저장할 수 있는 웹 애플리케이션입니다.

> 제작 기간 : 2024.05.16 - 2024.06.06 (22일)<br>
> 인원 : 1명 (개인 프로젝트)

👉🏻 [배포 사이트 바로가기](http://49.142.157.251:9090/javaclassJ8/main)
- Test ID : `test123`
- Test PW : `test123^^!`

💁🏻 [프로젝트 PPT - PDF로 바로보기](https://drive.google.com/file/d/1tmYDJZYtSL24fWolg9wl8AunK0SSMpWr/view?usp=sharing)
<br>

📹 [발표 및 시연 영상 - YouTube로 바로보기](https://youtu.be/CevBpGynJ34)

💭 [요구사항명세서 및 DB 논리적 설계 - 구글 스프레드시트로 바로보기](https://docs.google.com/spreadsheets/d/1e1T5jBh-7tM7CjCwONiFs9F7OIGQVMUJmeAd8-6eK-Q/edit?usp=sharing)
<hr>

## 1️⃣ 사용 기술 스택
<div align="center">
<h4>Backend</h4>
<img src="https://img.shields.io/badge/Java8-007396?style=flat-square&logo=OpenJDK&logoColor=white">
<img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=flat-square&amp;logo=apachetomcat&amp;logoColor=black">
<br>
  
<h4>Database</h4>
<img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white">
<br>
  
<h4>Frontend</h4>
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat-square&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/jquery-0769AD?style=flat-square&logo=jquery&logoColor=white">
<img src="https://img.shields.io/badge/JSP-BEFCFF?style=flat-square&amp;logo=&amp;logoColor=white">
<img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logo=html5&logoColor=white"> 
<img src="https://img.shields.io/badge/css-1572B6?style=flat-square&logo=css3&logoColor=white"> 
<img src="https://img.shields.io/badge/bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white">
<br>

<h4>API</h4>
<img src="https://img.shields.io/badge/googlemaps-4285F4?style=flat-square&logo=googlemaps&logoColor=white">
</div>
<hr>

## 2️⃣ 주요 기술 및 아키텍처
- MVC 아키텍처 기반의 JSP와 Servlet을 활용하여 백엔드 시스템 구축
- MySQL과의 효율적인 데이터베이스 연동을 위한 DAO 패턴 구현 및 SQL 쿼리 최적화
- 세션 관리 및 사용자 인증 로직을 통한 보안 강화
- Servlet을 활용한 사용자 요청 처리 및 동적인 웹 페이지 생성
- JavaScript와 jQuery를 통한 프론트엔드 인터랙션 구현 및 AJAX를 통한 비동기 데이터 통신
- JSP 페이지에서의 커스텀 태그를 사용한 코드 재사용성 향상

<hr>

## 3️⃣ 주요 기능

<div align="center">
  
| **기능 구분** | **세부 기능** |
|:---------------:|---------------|
| **회원**   | - 회원가입 <br> - 로그인 <br> - 아이디 찾기 <br> - 비밀번호 찾기 <br> - 회원정보수정 |
| **레코드** | - 로컬로그 CRUD <br> - 방명록 CRUD <br> - 로컬로그 북마크 <br> - 방명록 좋아요 |
| **북마크** | - 저장(북마크)한 로컬로그 목록 확인 |
| **아카이브** | - 사용자의 로컬로그와 방명록 확인 / 수정 / 삭제 |
| **검색** | - 키워드 검색 및 필터로 상세 검색 |
| **맵** | - 구글 맵 API로 지도 보기 |

</div>
<hr>

## 4️⃣ ERD

<p align="center">
  <img src="https://github.com/user-attachments/assets/6e1aa055-998d-4e07-9e39-ef2976ce4599" alt="로컬로그 ERD" width="70%">
</p>

<hr>

## 5️⃣ 기능별 화면 및 소개
### ✔ 메인 화면
- 공개 상태인 로컬로그를 랜덤으로 보여주며, 카드 클릭 시 상세 로컬로그 확인 가능
- 무한스크롤 구현
<p align="center">
  <img src="https://github.com/user-attachments/assets/bf160325-330a-41f1-a998-afd578b3b539" alt="메인화면 GIF" width="70%">
</p>

### ✔ 회원가입
- 아이디, 비밀번호, 닉네임, 이름, 이메일 입력
- 프론트엔드 유효성 검사 처리
- 이름, 닉네임, 이메일 중복 체크
- randomUUID를 이용한 비밀번호 암호화
<p align="center">
<img src="https://github.com/user-attachments/assets/227678e7-a2d1-4678-8615-8ca808c63cac" alt="회원가입 GIF" width="70%">
</p>

### ✔ 로그인
- 아이디 / 비밀번호 각각 일치여부 확인
- 아이디 저장 구현
- 로그인 성공 시 홈화면으로 이동 및 헤더에 로그인한 아이디 노출
<p align="center">
<img src="https://github.com/user-attachments/assets/85126910-60cc-4f9a-929a-f8c6a656c92c" alt="로그인 GIF" width="70%">
</p>

### ✔ 아이디 찾기
- 이름 + 이메일 조합으로 아이디 찾기
- 계정이 존재할 경우 아이디와 가입일자를 안내
<p align="center">
<img src="https://github.com/user-attachments/assets/abc35796-a740-4ffa-b10c-e732dd865ca3" alt="아이디찾기 GIF" width="70%">
</p>

### ✔ 비밀번호 찾기
- 아이디 + 이메일 조합으로 계정 유무 확인
- 계정이 존재할 경우 새로운 비밀번호 재설정 가능
<p align="center">
<img src="https://github.com/user-attachments/assets/6fdf4fd8-af0d-4d8a-9c08-edce0c2186a7" alt="비밀번호찾기 GIF" width="70%">
</p>

### ✔ 회원 정보 수정
- 비밀번호 확인 후 수정 페이지 이동
- 프로필 사진, 닉네임, 소개글, 이름, 이메일, 비밀번호 수정 가능
<p align="center">
<img src="https://github.com/user-attachments/assets/bb2cec01-c1e1-4bc9-a20c-f0185a4907e4" alt="회원정보수정 GIF" width="70%">
</p>

### ✔ 방명록
- 쉽게 남기는 방문 기록
- 방문한 공간, 방문 날짜, 방명록 입력 및 동반인 / 공개여부 선택
- 공간이 등록되어있지 않을 경우 공간 등록 후 기록 가능
- 공개로 업로드 시 다른 사용자도 해당 방명록을 볼 수 있음

⬇️ 공간 추가
<p align="center">
<img src="https://github.com/user-attachments/assets/3bcd7a4e-8495-4682-b5b5-16cd94ddf7a6" alt="공간추가 GIF" width="70%">
</p>

⬇️ 방명록 작성
<p align="center">
<img src="https://github.com/user-attachments/assets/0ee10fe3-1797-4ac9-9703-fc92b2c1ce2d" alt="방명록 작성 GIF" width="70%">
</p>


### ✔ 로컬로그
- 사진과 함깨 남기는 방문 경험 기록
- 방문한 공간, 방문 날짜, 사진, 로컬로그 내용 입력 및 커뮤니티 / 공개여부 선택
- 공개로 업로드 시 메인 화면에 로컬로그 카드가 보여지고 다른 사용자가 해당 로컬로그를 볼 수 있음
<p align="center">
<img src="https://github.com/user-attachments/assets/f1cba5aa-4eed-43f7-857f-ed844eb5d19f" alt="로컬로그 작성 GIF" width="70%">
</p>

### ✔ 메인 화면 > 로컬로그 카드
- 로컬로그 카드 클릭 시 로컬로그 상세 페이지로 이동
- 로컬로그 상세 페이지 하단에 같은 공간에 기록된 방명록을 볼 수 있음
- 로컬로그 북마크 가능
- 방명록 도움이 됐어요 (좋아요) 가능
- 로컬로그 업로드한 사용자의 프로필 사진 클릭 시 아카이브로 이동되며,
  해당 사용자가 업로드한 공개 상태의 로컬로그와 방명록을 모두 볼 수 있음
<p align="center">
<img src="https://github.com/user-attachments/assets/110785e6-de01-4e2a-a18c-6b7579c3a1e2" alt="로컬로그 카드 GIF" width="70%">
</p>

### ✔ 아카이브
- 헤더의 아카이브 메뉴 클릭 시 본인의 아카이브 페이지로 이동
- 본인이 업로드한 모든 로컬로그와 방명록을 볼 수 있음
- 로컬로그 수정 / 방명록 비공개 전환 및 삭제 가능
- 비공개 전환 시 자물쇠 아이콘 표기

⬇️ 로컬로그 수정
<p align="center">
<img src="https://github.com/user-attachments/assets/b1d79b01-4095-4d7a-b890-e160d47ef9a5" alt="로컬로그 수정 GIF" width="70%">
</p>

⬇️ 방명록 비공개 전환 및 삭제
<p align="center">
<img src="https://github.com/user-attachments/assets/15f55a6a-a8e9-475a-9b8f-5be8f944a347" alt="방명록 비공개 전환 및 삭제 GIF" width="70%">
</p>

### ✔ 북마크
- 본인이 북마크한 로컬로그 컨텐츠 확인 가능
- 북마크 페이지에서 편집을 통해 북마크 취소 가능
<p align="center">
<img src="https://github.com/user-attachments/assets/2c612979-f943-49c3-b593-c9ecf725a545" alt="북마크 GIF" width="70%">
</p>

### ✔ 검색
- 헤더의 검색 인풋에 키워드 입력 후 검색
- 공간 이름, 공간 주소, 로컬로그 / 방명록 콘텐츠 내용, 로컬로그 커뮤니티로 검색 가능
- 검색 후 필터를 이용해 상세 검색 가능
<p align="center">
<img src="https://github.com/user-attachments/assets/5e33dc74-a76c-471e-ab24-832d4975fed3" alt="검색 GIF" width="70%">
</p>
