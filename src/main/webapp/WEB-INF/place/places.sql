
CREATE TABLE places (
    placeIdx INT AUTO_INCREMENT PRIMARY KEY,
    placeName VARCHAR(255) NOT NULL,
    region1DepthName VARCHAR(255) NOT NULL,
    region2DepthName VARCHAR(255) NOT NULL,
    categoryName ENUM('바', '카페', '음식점', '디저트 / 베이커리', '포토존', '광장', '관광지', '종교시설', '역사 유적지', '자연', '복합문화공간', '박물관', '음악', '전시', '공연', '도서관', '샵', '서점', '시장', '쇼핑몰', '호텔', '스테이', '미용 / 스파', '오락', '운동', '스튜디오 / 클래스', '골프장', '캠핑장') NOT NULL,
    createdBy INT NOT NULL,
    updatedBy INT DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (createdBy) REFERENCES users2(userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2(userIdx)
);

show tables;
desc places;



drop table places;