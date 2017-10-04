import { exec } from '../utils';

const mode = process.env.NODE_ENV || 'development';

if (mode === 'production') {
    exec('babel src -d dist && npm start');
} else {
    exec('npm run dev');
}
