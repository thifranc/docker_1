import pg from 'pg';
import config from '../config';

//this initializes a connection pool
//it will keep idle connections open for a 30 seconds
//and set a limit of maximum 10 idle clients
const pool = new pg.Pool(config.pgConfig);

module.exports = {
    query: function(text, values) {

        return new Promise(function (resolve, reject) {
            pool.connect(function(err, client, done) {
                if (err) {
                    reject(err);
                } else {
                    client.query(text, values, function(err, result) {
                        done();
                        if(err) {
                            reject(err);
                        } else {
                            resolve(result);
                        }
                    });
                }
            });

        });
    }
};

pool.on('error', function (err, client) {
    // if an error is encountered by a client while it sits idle in the pool
    // the pool itself will emit an error event with both the error and
    // the client which emitted the original error
    // this is a rare occurrence but can happen if there is a network partition
    // between your application and the database, the database restarts, etc.
    // and so you might want to handle it and at least log it out
    console.error('idle client error', err.message, err.stack)
});