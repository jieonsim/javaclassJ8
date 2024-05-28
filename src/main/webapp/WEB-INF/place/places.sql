
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
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoryIdx) REFERENCES categories (categoryIdx),
    FOREIGN KEY (createdBy) REFERENCES users2 (userIdx),
    FOREIGN KEY (updatedBy) REFERENCES users2 (userIdx) ON DELETE SET NULL ON UPDATE CASCADE
);