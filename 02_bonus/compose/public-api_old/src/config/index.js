// Application Configuration.

import { getStringEnvVar, getIntEnvVar } from './internals/environmentVars';

const config = {
  // The port on which the server should run.
  port: getIntEnvVar('SERVER_PORT', 3000),
  publicApi: getStringEnvVar('PUBLIC_API', 'http://api.monsieurtshirt.localhost'),
  env: getStringEnvVar('NODE_ENV', 'development'),
  queriesToAddLang: ['products', 'legumes'],
  //node-pg config
  pgConfig: {
    user: getStringEnvVar('POSTGRES_USER', 'root'),
    database: getStringEnvVar('POSTGRES_DATABASE', 'monsieurtshirt'),
    password: getStringEnvVar('POSTGRES_PASSWORD', 'password'),
    host: getStringEnvVar('POSTGRES_HOST', 'localhost'),
    port: getIntEnvVar('POSTGRES_PORT', 5432),
    max:  getIntEnvVar('POSTGRES_MAX_CLIENTS', 10), // max number of clients in the pool
    idleTimeoutMillis: 30000, // how long a client is allowed to remain idle before being closed
  }
};

// Export the main config as the default export.
export default config;
