show tables;

CREATE TABLE guestBooks (
    guestBookIdx INT AUTO_INCREMENT PRIMARY KEY COMMENT '방명록 고유번호',
    userIdx INT NOT NULL COMMENT '유저 고유번호',
    placeIdx INT NOT NULL COMMENT '장소 고유번호',
    visitDate DATE NOT NULL COMMENT '방문일자',
    content TEXT COMMENT '방명록 내용',
    companions ENUM('부모님 & 가족', '친구', '연인', '아이', '혼자', '반려견', '기타') DEFAULT NULL COMMENT '동반인',
    visibility ENUM('public', 'private') NOT NULL DEFAULT 'public' COMMENT '방명록 공개여부',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    hostIp VARCHAR(50) NOT NULL COMMENT '작성자 호스트 아이피',
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (placeIdx) REFERENCES places(placeIdx)
);

desc guestBooks;

drop table guestBooks;


select * from guestBooks;



CREATE TABLE guestbooks (
    guestBookIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    placeIdx INT NOT NULL,
    visitDate DATE NOT NULL,
    content TEXT,
    companions VARCHAR(255),
    visibility VARCHAR(255),
    hostIp VARCHAR(255),
    FOREIGN KEY (userIdx) REFERENCES users2 (userIdx),
    FOREIGN KEY (placeIdx) REFERENCES places (placeIdx)
);


ALTER TABLE guestBooks ADD COLUMN createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE guestBooks ADD COLUMN updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

