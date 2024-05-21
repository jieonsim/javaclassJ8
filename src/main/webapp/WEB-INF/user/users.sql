show tables;

CREATE TABLE users2 (
    userIdx INT AUTO_INCREMENT PRIMARY KEY COMMENT '유저 고유 번호',
    id VARCHAR(50) NOT NULL COMMENT '유저 아이디',
    password VARCHAR(255) NOT NULL COMMENT '유저 비밀번호',
    nickname VARCHAR(50) NOT NULL COMMENT '유저 닉네임',
    name VARCHAR(100) NOT NULL COMMENT '유저 이름',
    email VARCHAR(255) NOT NULL COMMENT '유저 이메일',
    role ENUM('user', 'admin') NOT NULL DEFAULT 'user' COMMENT '유저/관리자 구별',
    introduction VARCHAR(255) COMMENT '프로필 소개서',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '계정 생성 일자',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 정보 업데이트 일자',
    profileImage VARCHAR(255) COMMENT '프로필 사진 경로',
    visibility ENUM('public', 'private') NOT NULL DEFAULT 'public' COMMENT '공개/비공개 구별',
);

desc users2;




drop table users2;