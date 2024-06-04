show tables;

drop table likes;

desc likes;
desc likes;

CREATE TABLE bookmarks (
    bookmarkIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    itemIdx INT,  -- 로컬로그 또는 큐레이션의 IDX
    itemType ENUM('localLog','curation') NOT NULL,  -- 항목 타입 구분
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx)
);


CREATE TABLE bookmarks (
    bookmarkIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    localLogIdx INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx)
);


CREATE TABLE likes (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    itemIdx INT,
    itemType ENUM('guestBook', 'localLog') NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (itemIdx) REFERENCES localLogs(localLogIdx),
    FOREIGN KEY (itemIdx) REFERENCES guestBooks(guestBookIdx)
);

ALTER TABLE likes ADD COLUMN guestBookIdx INT;
ALTER TABLE likes ADD CONSTRAINT fk_guestBookIdx FOREIGN KEY (guestBookIdx) REFERENCES guestBooks(guestBookIdx) ON DELETE CASCADE;

ALTER TABLE likes ADD COLUMN localLogIdx INT;
ALTER TABLE likes ADD CONSTRAINT fk_localLogIdx FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx) ON DELETE CASCADE;


CREATE TABLE likes_localLog (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    localLogIdx INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx)
);

CREATE TABLE likes_guestBook (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    guestBookIdx INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (guestBookIdx) REFERENCES guestBooks(guestBookIdx)
);
