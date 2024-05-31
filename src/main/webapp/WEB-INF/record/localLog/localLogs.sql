show tables;

desc localLogs;
drop table localLogs;

select * from localLogs;

CREATE TABLE localLogs (
    localLogIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    placeIdx INT,
    content TEXT,
    fileName VARCHAR(255) NOT NULL,
    fileSystemName VARCHAR(255) NOT NULL,
    coverPhoto VARCHAR(255) NOT NULL,
    fileSize BIGINT NOT NULL,
    visitDate DATE NOT NULL,
    community ENUM('여행', '문화생활', '커피', '미식', '건축', '아웃도어', '워크스페이스', '술', '반려', '차', '아이와 함께'),
    visibility ENUM('public', 'private') DEFAULT 'public',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    hostIp VARCHAR(45),
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (placeIdx) REFERENCES places(placeIdx)
);

------------------------------------------------------------------------
CREATE TABLE localLogs (
    localLogIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    placeIdx INT,
    content TEXT,
    photos VARCHAR(255) NOT NULL,
    visitDate DATE NOT NULL,
    community ENUM('여행', '문화생활', '커피', '미식', '건축', '아웃도어', '워크스페이스', '술', '반려', '차', '아이와 함께'),
    visibility ENUM('public', 'private') NOT NULL DEFAULT 'public',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    hostIp VARCHAR(45),
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (placeIdx) REFERENCES places(placeIdx)
);


SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName FROM localLogs ll JOIN places p ON ll.placeIdx = p.placeIdx WHERE ll.userIdx = 16 ORDER BY ll.visitDate DESC;



SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName FROM localLogs ll JOIN places p ON ll.placeIdx = p.placeIdx JOIN categories c ON p.categoryIdx = c.categoryIdx WHERE ll.localLogIdx = 15



-- 인덱스 추가
CREATE INDEX idx_localLogs_userIdx ON localLogs(userIdx);
CREATE INDEX idx_localLogs_placeIdx ON localLogs(placeIdx);

CREATE INDEX idx_bookmarks_userIdx ON bookmarks(userIdx);
CREATE INDEX idx_bookmarks_itemIdx_itemType ON bookmarks(itemIdx, itemType);

CREATE INDEX idx_likes_userIdx ON likes(userIdx);
CREATE INDEX idx_likes_itemIdx_itemType ON likes(itemIdx, itemType);

