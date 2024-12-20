const pg = require('pg');

// conventional path:
// const pool = pg.Pool({
//   host: 'localhost',
//   port: 5432,
// });

// module.exports = pool;

// making it easier to work with multiple DBs:
class Pool {
  _pool = null;

  connect(options) {
    this._pool = new pg.Pool(options);

    // test connection to throw an error if it fails:
    return this._pool.query('SELECT 1 + 1;');
  }

  close() {
    return this._pool.end();
  }

  query(sql, params) {
    return this._pool.query(sql, params);
  }
}

module.exports = new Pool();
