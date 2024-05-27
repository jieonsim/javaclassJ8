show tables;

CREATE TABLE categories (
    categoryIdx INT AUTO_INCREMENT PRIMARY KEY,
    categoryName ENUM('바', '카페', '음식점', '디저트 / 베이커리', '포토존', '광장', '관광지', '종교시설', '역사 유적지', '자연', '복합문화공간', '박물관', '음악', '전시', '공연', '도서관', '샵', '서점', '시장', '쇼핑몰', '호텔', '스테이', '미용 / 스파', '오락', '운동', '스튜디오 / 클래스', '골프장', '캠핑장') NOT NULL
);

CREATE TABLE categories (
    categoryIdx INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL,
    categoryType ENUM('식음료', '여행', '문화', '쇼핑', '숙박', '액티비티') NOT NULL
);

INSERT INTO categories (categoryName, categoryType) VALUES 
('바', '식음료'),
('카페', '식음료'),
('음식점', '식음료'),
('디저트 / 베이커리', '식음료'),
('포토존', '여행'),
('광장', '여행'),
('관광지', '여행'),
('종교시설', '여행'),
('역사 유적지', '여행'),
('자연', '여행'),
('복합문화공간', '문화'),
('박물관', '문화'),
('음악', '문화'),
('전시', '문화'),
('공연', '문화'),
('도서관', '문화'),
('샵', '쇼핑'),
('서점', '쇼핑'),
('시장', '쇼핑'),
('쇼핑몰', '쇼핑'),
('호텔', '숙박'),
('스테이', '숙박'),
('미용 / 스파', '액티비티'),
('오락', '액티비티'),
('운동', '액티비티'),
('스튜디오 / 클래스', '액티비티'),
('골프장', '액티비티'),
('캠핑장', '액티비티');

select * from categories;

desc categories;
select * from categories;

drop table categories;