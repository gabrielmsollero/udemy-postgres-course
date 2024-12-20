-- count the amount of likes in posts and comments per week

-- -- query 1 (slow):
-- -- every row will either have a post_id and post data or comment_id and comment data
-- -- date_trunc will round the date to the nearest previous week start
-- SELECT
-- 	date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
-- 	COUNT(posts.id) AS num_likes_for_posts,
-- 	COUNT(comments.id) AS num_likes_for_comments
-- FROM likes
-- LEFT JOIN posts ON posts.id = likes.post_id
-- LEFT JOIN comments ON comments.id = likes.comment_id
-- GROUP BY week
-- ORDER BY week;

-- -- materialized view from query:
-- CREATE MATERIALIZED VIEW weekly_likes AS (
-- 	SELECT
-- 		date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
-- 		COUNT(posts.id) AS num_likes_for_posts,
-- 		COUNT(comments.id) AS num_likes_for_comments
-- 	FROM likes
-- 	LEFT JOIN posts ON posts.id = likes.post_id
-- 	LEFT JOIN comments ON comments.id = likes.comment_id
-- 	GROUP BY week
-- 	ORDER BY week
-- ) WITH DATA; -- run it once created

-- -- query 2 (fast):
-- SELECT * FROM weekly_likes;

-- DELETE FROM posts
-- WHERE created_at < '2010-02-01';

-- SELECT * FROM weekly_likes; -- will still contain data about posts from january 2010

-- REFRESH MATERIALIZED VIEW weekly_likes;

-- SELECT * FROM weekly_likes; -- now the posts from january 2010 should not show up
