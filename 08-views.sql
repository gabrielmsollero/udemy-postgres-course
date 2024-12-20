-- -- select users who were tagged the most
-- SELECT username, COUNT(*)
-- FROM users
-- JOIN ( -- repetition of this union in multiple places
-- 	SELECT user_id FROM photo_tags
-- 	UNION ALL
-- 	SELECT user_id FROM caption_tags
-- ) AS tags ON tags.user_id = users.id
-- GROUP BY username
-- ORDER BY COUNT(*) DESC

-- -- create a view that unites photo and caption tags
-- CREATE VIEW tags AS (
-- 	SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
-- 	UNION ALL
-- 	SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM caption_tags
-- );

-- -- original query, but using the created view
-- SELECT username, COUNT(*)
-- FROM users
-- JOIN tags ON tags.user_id = users.id
-- GROUP BY username
-- ORDER BY COUNT(*) DESC;

-- -- view for the 10 most recent posts
-- CREATE VIEW recent_posts AS (
-- 	SELECT * FROM posts
-- 	ORDER BY created_at DESC
-- 	LIMIT 10
-- );

-- -- update an existing view
-- CREATE OR REPLACE VIEW recent_posts AS (
-- 	SELECT * FROM posts
-- 	ORDER BY created_at DESC
-- 	LIMIT 15
-- );

-- -- delete a view
-- DROP VIEW recent_posts;