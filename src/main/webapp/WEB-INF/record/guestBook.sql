show tables;

CREATE TABLE guestBooks (
    guestBookIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    placeIdx INT NOT NULL,
    visitDate DATE NOT NULL,
    content TEXT,
    companions ENUM('부모님 & 가족', '친구', '연인', '아이', '혼자', '반려견', '기타') DEFAULT NULL,
    visibility ENUM('public', 'private') NOT NULL DEFAULT 'public',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    hostIp VARCHAR(50) NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (placeIdx) REFERENCES places(placeIdx)
);

desc guestBooks;

drop table guestBooks;