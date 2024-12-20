-- CREATE TABLE accounts (
-- 	id SERIAL PRIMARY KEY,
-- 	name VARCHAR(20) NOT NULL,
-- 	balance INTEGER NOT NULL
-- );

-- INSERT INTO accounts (name, balance)
-- VALUES
-- 	('Bibi', 100),
-- 	('Juju', 100);

-- 1) Regular transaction

-- BEGIN;

-- UPDATE accounts
-- SET balance = balance - 50
-- WHERE name = 'Bibi';

-- -- bibi will have $50. if you query from another connection, they'll still have 100
-- SELECT * FROM accounts;

-- UPDATE accounts
-- SET balance = balance + 50
-- WHERE name = 'Juju';

-- -- juju will now have $150. still no changes from other connections' perspectives
-- SELECT * FROM accounts;

-- COMMIT; -- now changes will be applied to main data pool and visible from other connections

-- 2) Simulate mid-transaction crash

-- BEGIN;

-- UPDATE accounts
-- SET balance = balance - 50
-- WHERE name = 'Bibi';

-- -- *manually close connection in dashboard*

-- -- Bibi should still have $100

-- 3) Rollback

-- BEGIN;

-- SELECT * FROM asjdklajslk;

-- SELECT * FROM accounts; -- ERROR:  current transaction is aborted, commands ignored until end of transaction block

-- ROLLBACK;

-- SELECT * FROM accounts; -- successful