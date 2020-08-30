DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT '������', -- COMMENT �� ������, ���� ��� �����������
    email VARCHAR(100) UNIQUE,
    password_hash varchar(100),
    phone BIGINT, 
    -- INDEX users_phone_idx(phone), -- ������: ��� �������� �������
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- ���� ����, �.�. ������� media ��� ���
);

-- NO ACTION
-- CASCADE 
-- RESTRICT
-- SET NULL
-- SET DEFAULT


ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (�������� �� ���������)
    ON DELETE restrict; -- (�������� �� ���������)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- ����� ����� ���� �� ��������� ��� ���� ��� �������

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- �������� �� ��������� ���� (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT UNSIGNED, -- � ���� ������ � ���� ������� �� �������� enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME on update now(),
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,

	INDEX communities_name_idx(name),
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- ����� �� ���� 2 ������� � ������������ � ����������
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

    -- ������� ����, ������� ������ ����� ������ (�������� ������)!
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    `size` INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) � ����� ���� � ��� ������ id � �������� PK
  	-- ������� ���������� ��������� ���� ������, ������������ �� ��������� �� ���� ������������� (����., ��������� �� ������� �����-�� �������)  

/* ��������� ������, ����� ������� ������� �� ���������� � ER-���������
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS `video_albums`;
CREATE TABLE `video_albums` (
	`id` SERIAL,
	`category` varchar(255) DEFAULT NULL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
	`id` SERIAL,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES video_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

drop table if exists `success_stories`;
create table `success_stories` (
	`id` SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	`story_id` BIGINT unsigned NOT NULL,
	`story` text,

	foreign key (story_id) references users(id),
	PRIMARY KEY (`id`)
);