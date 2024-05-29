show tables;

drop table bookmarks;

desc bookmarks;
desc likes;

CREATE TABLE bookmarks (
    bookmarkIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    itemIdx INT,  -- 로컬로그 또는 큐레이션의 IDX
    itemType ENUM('localLog','curation') NOT NULL,  -- 항목 타입 구분
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx)
);

CREATE TABLE likes (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    itemIdx INT,  -- 방명록, 로컬로그 또는 큐레이션의 IDX
    itemType ENUM('guestBook', 'localLog', 'curation') NOT NULL,  -- 항목 타입 구분
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx)
);