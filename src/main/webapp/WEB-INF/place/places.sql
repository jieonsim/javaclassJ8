
show tables;
desc places;

drop table places;

ALTER TABLE places MODIFY createdBy INT NULL;



CREATE TABLE places (
    placeIdx INT AUTO_INCREMENT PRIMARY KEY,
    placeName VARCHAR(255) NOT NULL,
    region1DepthName VARCHAR(255) NOT NULL,
    region2DepthName VARCHAR(255) NOT NULL,
    categoryIdx INT NOT NULL,
    createdBy INT NOT NULL,
    updatedBy INT DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoryIdx) REFERENCES categories (categoryIdx),
    FOREIGN KEY (createdBy) REFERENCES users2 (userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2 (userIdx) ON DELETE SET NULL ON UPDATE CASCADE
);

SELECT p.*, c.categoryName, u.nickname AS createdByNickname FROM places p JOIN categories c ON p.categoryIdx = c.categoryIdx JOIN users2 u ON p.createdBy = u.userIdx WHERE p.placeIdx = 15