CREATE TABLE ci_board(  
    _id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key, 게시물 번호',
    title VARCHAR(255) NOT NULL COMMENT '게시물 제목',
    content TEXT NOT NULL COMMENT '게시물 내용',
    board_name VARCHAR(100) NOT NULL COMMENT '바둑이야기 / 바둑뉴스 / 기력향상',
    view_count int DEFAULT 0 COMMENT '조회 수',
    member_id INT NOT NULL COMMENT '회원 키(member._id)',
    created_at DATETIME DEFAULT NOW() COMMENT '작성 시간 = 현재 시간',
    status INT DEFAULT 0 COMMENT '상태 플래그 (1은 삭제)'
) DEFAULT CHARSET UTF8 COMMENT '게시물 테이블';

CREATE TABLE ci_comment(
    _id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    content TEXT NOT NULL COMMENT '댓글 내용',
    member_id int NOT NULL COMMENT '회원 키 (member._id)',
    board_id int NOT NULL COMMENT '게시물 키 (board._id)',
    created_at DATETIME DEFAULT NOW() COMMENT '작성 시간 = 현재 시간',
    status INT DEFAULT 0 COMMENT '상태 플래그 (1은 삭제)'
) DEFAULT CHARSET UTF8 COMMENT '댓글 테이블';

CREATE TABLE ci_member(  
    _id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    email VARCHAR(255) COMMENT '이메일',
    pw VARCHAR(255) COMMENT '패스워드',
    name VARCHAR(255) COMMENT '이름',
    status INT DEFAULT 0 COMMENT '상태 플래그 (1은 삭제)'
) DEFAULT CHARSET UTF8 COMMENT '회원 테이블';

SELECT 
    ci_board.title, 
    ci_board.content,
    (SELECT count(*) FROM ci_comment WHERE ci_comment.board_id = ci_board._id ) AS comment_count
FROM 
    ci_board as ci_board;


TRUNCATE TABLE ci_board;
DROP TABLE ci_board;
DROP TABLE ci_comment;
DROP TABLE ci_member;

select 
    _id,
    title,
    content,
    board_name,
    view_count,
    member_id,
    created_at,
    (SELECT count(*) FROM ci_comment WHERE ci_comment.board_id = ci_board._id ) AS comment_count,
    (select email from ci_member where _id = ci_board.member_id) as email_name
from 
    ci_board as ci_board
where 
    status = 0 
    AND title LIKE "%a%"
order by _id desc
limit 1,10;


CREATE TABLE user (
  _id INT AUTO_INCREMENT COMMENT '회원 고유번호', 
  email VARCHAR(30) NOT NULL COMMENT '이메일',
  nickName VARCHAR(30) NOT NULL COMMENT '대화명',
  pw INT NOT NULL COMMENT '비밀번호'
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci; 

-- 0-2. 사진 게시물 테이블
CREATE TABLE photo_post (
  _id INT AUTO_INCREMENT COMMENT '게시물 고유번호', 
  title VARCHAR(20) NOT NULL COMMENT '게시물 제목',
  list_id INT NOT NULL COMMENT '리스트 고유번호와 관계 형성',
  img_url VARCHAR(1000) NOT NULL COMMENT '이미지 주소',
  post_status INT NOT NULL COMMENT '게시물 삭제 여부'
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

-- 0-3. 사진 게시물 리스트 쿼리
CREATE TABLE post_list (
  _id INT AUTO_INCREMENT COMMENT '리스트 고유번호', 
  user_id INT NOT NULL COMMENT '회원 고유번호와 관계 형성',
  date TIMESTAMP NOT NULL COMMENT '사진 업로드 날짜'
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;


CREATE TABLE survey_collector(
  _id INT AUTO_INCREMENT COMMENT '설문수집자 고유번호',
  name VARCHAR(30) NOT NULL COMMENT '수집자 이름',
  pw INT NOT NULL COMMENT '비밀번호'
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;