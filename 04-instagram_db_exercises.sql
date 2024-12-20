-- 3 users with highest IDs
-- SELECT * FROM users
-- ORDER BY id DESC
-- LIMIT 3;

-- show username of user with ID 200 and captions of all their posts
-- SELECT users.username, posts.caption
-- FROM posts
-- JOIN users
-- ON users.id = posts.user_id
-- WHERE users.id = 200;

-- show each username and the number of likes they have created
-- SELECT username, COUNT(*)
-- FROM likes
-- JOIN users ON users.id = likes.user_id
-- GROUP BY username;
