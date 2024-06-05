show tables;

desc likes_localLog;

DROP TABLE likes_localLog;

CREATE TABLE likes_localLog (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    localLogIdx INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx) ON DELETE CASCADE,
    FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx) ON DELETE CASCADE
);

-- 기존 외래 키 제약 조건 제거
ALTER TABLE likes_localLog DROP FOREIGN KEY likes_locallog_ibfk_1;
ALTER TABLE likes_localLog DROP FOREIGN KEY likes_locallog_ibfk_2;

-- 새로운 외래 키 제약 조건 추가
ALTER TABLE likes_localLog ADD CONSTRAINT fk_userIdx FOREIGN KEY (userIdx) REFERENCES users2(userIdx) ON DELETE CASCADE;
ALTER TABLE likes_localLog ADD CONSTRAINT fk_localLogIdx FOREIGN KEY (localLogIdx) REFERENCES localLogs(localLogIdx) ON DELETE CASCADE;

-- 유효하지 않은 userIdx 확인
SELECT ll.userIdx
FROM likes_localLog ll
LEFT JOIN users2 u ON ll.userIdx = u.userIdx
WHERE u.userIdx IS NULL;

-- 유효하지 않은 localLogIdx 확인
SELECT ll.localLogIdx
FROM likes_localLog ll
LEFT JOIN localLogs l ON ll.localLogIdx = l.localLogIdx
WHERE l.localLogIdx IS NULL;

-- 유효하지 않은 userIdx 데이터 삭제
DELETE ll
FROM likes_localLog ll
LEFT JOIN users2 u ON ll.userIdx = u.userIdx
WHERE u.userIdx IS NULL;

-- 유효하지 않은 localLogIdx 데이터 삭제
DELETE ll
FROM likes_localLog ll
LEFT JOIN localLogs l ON ll.localLogIdx = l.localLogIdx
WHERE l.localLogIdx IS NULL;


-- 중복된 userIdx와 localLogIdx 조합 찾기
SELECT userIdx, localLogIdx, COUNT(*)
FROM likes_localLog
GROUP BY userIdx, localLogIdx
HAVING COUNT(*) > 1;

-- 중복된 userIdx와 guestBookIdx 조합 찾기
SELECT userIdx, guestBookIdx, COUNT(*)
FROM likes_guestBook
GROUP BY userIdx, guestBookIdx
HAVING COUNT(*) > 1;

-- 중복된 레코드 삭제
DELETE FROM likes_localLog
WHERE (userIdx, localLogIdx) IN (
    SELECT userIdx, localLogIdx
    FROM (
        SELECT userIdx, localLogIdx
        FROM likes_localLog
        GROUP BY userIdx, localLogIdx
        HAVING COUNT(*) > 1
    ) AS duplicates
)
AND id NOT IN (
    SELECT MIN(id)
    FROM likes_localLog
    GROUP BY userIdx, localLogIdx
);



DROP TABLE likes_guestBook;

CREATE TABLE likes_guestBook (
    likeIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    guestBookIdx INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userIdx) REFERENCES users2(userIdx) ON DELETE CASCADE,
    FOREIGN KEY (guestBookIdx) REFERENCES guestBooks(guestBookIdx) ON DELETE CASCADE
);

-- 기존 외래 키 제약 조건 제거
ALTER TABLE likes_guestBook DROP FOREIGN KEY likes_guestBook_ibfk_1;
ALTER TABLE likes_guestBook DROP FOREIGN KEY likes_guestBook_ibfk_2;

-- 새로운 외래 키 제약 조건 추가
ALTER TABLE likes_guestBook ADD CONSTRAINT fk_userIdx FOREIGN KEY (userIdx) REFERENCES users2(userIdx) ON DELETE CASCADE;
ALTER TABLE likes_guestBook ADD CONSTRAINT fk_guestBookIdx FOREIGN KEY (guestBookIdx) REFERENCES guestBooks(guestBookIdx) ON DELETE CASCADE;





-- `userIdx` 값 확인
SELECT * FROM users2 WHERE userIdx = 43;  -- 43을 확인하려는 userIdx로 대체
SELECT * FROM users2 WHERE userIdx = 45;  -- 45을 확인하려는 userIdx로 대체

-- `localLogIdx` 값 확인
SELECT * FROM localLogs WHERE localLogIdx = 15;  -- 15을 확인하려는 localLogIdx로 대체


