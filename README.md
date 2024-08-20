# 로컬렌즈 Local Lens 📸
로컬렌즈는 사용자가 다녀온 여행지를 공유하고,<br>
자신의 취향에 맞는 공간을 발견 및 저장할 수 있는 웹 애플리케이션입니다.

> 제작 기간 : 2024.05.16 - 2024.06.06 (22일)<br>
> 인원 : 1명 (개인 프로젝트)

👉🏻 [배포 사이트 바로가기](http://49.142.157.251:9090/javaclassJ8/main)
- Test ID : `test123`
- Test PW : `test123^^!`

💁🏻 [프로젝트 PPT - PDF로 바로보기](https://drive.google.com/file/d/1-3gFmRyUddxaZVNbzJDbUWRgshxypzmL/view?usp=sharing)
<br>

📹 [발표 영상 - YouTube로 바로보기](https://youtu.be/CevBpGynJ34)

💭 [기획 및 제작과정 - PDF로 바로보기](https://docs.google.com/spreadsheets/d/1e1T5jBh-7tM7CjCwONiFs9F7OIGQVMUJmeAd8-6eK-Q/edit?usp=sharing)
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

## 2️⃣ 주요 기능

<div align="center">
  
| **기능 구분** | **세부 기능** |
|:---------------:|---------------|
| **회원**   | - 회원가입 <br> - 로그인 <br> - 아이디 찾기 <br> - 비밀번호 찾기 <br> - 회원정보수정 |
| **레코드** | - 로컬로그 CRUD <br> - 방명록 CRUD  - 로컬로그 북마크 <br> - 방명록 좋아요 |
| **북마크** | - 저장(북마크)한 로컬로그 목록 확인 |
| **아카이브** | - 사용자의 로컬로그와 방명록 확인 / 수정 / 삭제 |
| **맵** | - 구글 맵 API로 지도 보기 |

</div>
<hr>

## 3️⃣ 기능별 화면 및 소개
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
<img src="https://github.com/user-attachments/assets/6f시 자물쇠 아이콘 표기

⬇️ 로컬로그 수정
<p align="center">
<img src="https://github.com/user-attachments/assets/0ee10fe3-1797-4ac9-9703-fc92b2c1ce2d" alt="방명록 작성 GIF" width="70%">
</p>

### ✔ 북마크
- 본인이 북마크한 로컬로그 컨텐츠 확인 가능
- 북마크 페이지에서 편집을 통해 북마크 취소 가능
<p align="center">
<img src="https://github.com/user-attachments/assets/2c612979-f943-49c3-b593-c9ecf725a545" alt="북마크 GIF" width="70%">
</p>

