
CREATE TABLE places (
    placeIdx INT AUTO_INCREMENT PRIMARY KEY COMMENT '장소 고유번호',
    placeName VARCHAR(255) NOT NULL COMMENT '장소 이름',
    region1DepthName VARCHAR(255) NOT NULL COMMENT '장소 첫번째 구분',
    region2DepthName VARCHAR(255) NOT NULL COMMENT '장소 두번째 구분',
    categoryName ENUM('바', '카페', '음식점', '디저트 / 베이커리', '포토존', '광장', '관광지', '종교시설', '역사 유적지', '자연', '복합문화공간', '박물관', '음악', '전시', '공연', '도서관', '샵', '서점', '시장', '쇼핑몰', '호텔', '스테이', '미용 / 스파', '오락', '운동', '스튜디오 / 클래스', '골프장', '캠핑장') NOT NULL COMMENT '카테고리 소분류',
    createdBy INT NOT NULL COMMENT '장소 최초 등록 userIdx',
    updatedBy INT DEFAULT NULL COMMENT '장소 수정한 사람 userIdx',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '장소 생성일자',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '장소 수정일자',
    FOREIGN KEY (createdBy) REFERENCES users2(userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2(userIdx)
);

CREATE TABLE places (
    placeIdx INT AUTO_INCREMENT PRIMARY KEY COMMENT '장소 고유번호',
    placeName VARCHAR(255) NOT NULL COMMENT '장소 이름',
    region1DepthName VARCHAR(255) NOT NULL COMMENT '장소 첫번째 구분',
    region2DepthName VARCHAR(255) NOT NULL COMMENT '장소 두번째 구분',
    categoryIdx INT NOT NULL COMMENT '카테고리 고유번호',
    createdBy INT NOT NULL COMMENT '장소 최초 등록 userIdx',
    updatedBy INT DEFAULT NULL COMMENT '장소 수정한 사람 userIdx',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '장소 생성일자',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '장소 수정일자',
    FOREIGN KEY (categoryIdx) REFERENCES categories(categoryIdx),
    FOREIGN KEY (createdBy) REFERENCES users2(userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2(userIdx)
);

show tables;
desc places;

drop table places;

CREATE TABLE places (
    placeIdx INT AUTO_INCREMENT PRIMARY KEY,
    placeName VARCHAR(255) NOT NULL,
    region1DepthName VARCHAR(255) NOT NULL,
    region2DepthName VARCHAR(255) NOT NULL,
    categoryIdx INT NOT NULL,
    createdBy INT NOT NULL,
    updatedBy INT DEFAULT NULL,
    FOREIGN KEY (categoryIdx) REFERENCES categories (categoryIdx),
    FOREIGN KEY (createdBy) REFERENCES users2 (userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2 (userIdx) ON DELETE SET NULL ON UPDATE CASCADE
);
