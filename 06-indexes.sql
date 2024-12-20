-- CREATE INDEX ON users (username);

-- EXPLAIN ANALYZE SELECT *
-- FROM users
-- WHERE username = 'Emil30';
-- .05 to .08ms, on average

-- DROP INDEX users_username_idx;

-- EXPLAIN ANALYZE SELECT *
-- FROM users
-- WHERE username = 'Emil30';
-- 1.2 to 1.5ms, on average