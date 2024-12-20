const format = require('pg-format');
const pool = require('../pool');
const { default: migrate } = require('node-pg-migrate');
const { randomBytes } = require('crypto');

const DEFAULT_OPTS = {
  host: 'localhost',
  port: 5432,
  database: 'socialnetwork-test',
  user: 'postgres',
  password: 'test', // I know this shouldn't be exposed like this in a production system :)
};

class Context {
  static async build() {
    // make sure it starts with a letter
    const roleName = 'a' + randomBytes(4).toString('hex');

    // connect as postgres user, create new random user and schema and apply migrations
    await pool.connect(DEFAULT_OPTS);

    await pool.query(
      format('CREATE ROLE %I WITH LOGIN PASSWORD %L;', roleName, roleName)
    );

    await pool.query(
      format('CREATE SCHEMA %I AUTHORIZATION %I', roleName, roleName)
    );

    await pool.close();

    await migrate({
      schema: roleName,
      direction: 'up',
      log: () => {}, // discard logs
      noLock: true, // allow simultaneous migrations
      dir: 'migrations',
      databaseUrl: {
        host: 'localhost',
        port: 5432,
        database: 'socialnetwork-test',
        user: roleName,
        password: roleName,
      },
    });

    // connect as newly created role
    await pool.connect({
      host: 'localhost',
      port: 5432,
      database: 'socialnetwork-test',
      user: roleName,
      password: roleName, // I know this shouldn't be exposed like this in a production system :)
    });

    return new Context(roleName);
  }

  constructor(roleName) {
    this.roleName = roleName;
  }

  async reset() {
    return pool.query('DELETE FROM users;');
  }

  async close() {
    // disconnect from PG
    await pool.close();

    // connect as root user and delete temporary role and schema
    await pool.connect(DEFAULT_OPTS);
    await pool.query(format('DROP SCHEMA %I CASCADE;', this.roleName));
    await pool.query(format('DROP ROLE %I', this.roleName));
    await pool.close();
  }
}

module.exports = Context;
