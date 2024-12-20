-- -- simple CTE
-- WITH tags AS (
-- 	SELECT user_id, created_at FROM caption_tags
-- 	UNION ALL
-- 	SELECT user_id, created_at FROM photo_tags
-- )
-- SELECT username, tags.created_at
-- FROM users
-- JOIN tags ON tags.user_id = users.id
-- WHERE tags.created_at < '2010-01-07';

-- -- recursive CTE
-- WITH RECURSIVE countdown(val) AS (
-- 	SELECT 3 AS val -- initial/non-recursive query
-- 	UNION
-- 	SELECT val - 1 FROM countdown WHERE val > 1 -- recursive query
-- )
-- SELECT * FROM countdown;

-- -- a more practical example: follow suggestions
WITH RECURSIVE suggestions(leader_id, follower_id, depth) AS (
		SELECT leader_id, follower_id, 1 AS depth
		FROM followers
		WHERE follower_id = 1000 -- my ID
	UNION
		SELECT followers.leader_id, followers.follower_id, depth + 1
		FROM followers
		JOIN suggestions ON suggestions.leader_id = followers.follower_id
		WHERE depth < 3
)
SELECT DISTINCT users.id, users.username
FROM suggestions
JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 30;