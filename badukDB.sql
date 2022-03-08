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