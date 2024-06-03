CREATE TABLE bookmarks (
    bookmarkIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    localLogIdx INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx),
    FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx)
);

show tables;

ALTER TABLE bookmarks ADD CONSTRAINT fk_userIdx FOREIGN KEY (userIdx) REFERENCES users2(userIdx) ON DELETE CASCADE;
ALTER TABLE bookmarks ADD CONSTRAINT fk_localLogIdx FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx) ON DELETE CASCADE;
