# I know this shouldn't be exposed like this in a production system :)
$env:DATABASE_URL="postgres://postgres:test@localhost:5432/socialnetwork-test";
npm run migrate up;