// maps will give us nice stack traces.
import 'source-map-support/register';

// Polyfill "fetch" api, required by apollo.
import 'isomorphic-fetch';

import express from 'express';
import compression from 'compression';
import bodyParser from 'body-parser';
import { graphqlExpress, graphiqlExpress } from 'graphql-server-express';
import cookieParser from 'cookie-parser';
import formidable from 'formidable';

import graphqlSchema from './graphql/schema';
import cors from 'cors';
import config from './config';

// Create our express based server.
const app = express();
app.use(cookieParser());
app.use(bodyParser.json());
app.use(cors({origin: new RegExp('http://monsieur.localhost')}));

// Don't expose any software information to potential hackers.
app.disable('x-powered-by');

// Gzip compress the responses.
app.use(compression());

// Our apollo stack graphql server endpoints.

let graphqlRoute = new RegExp('\/(fr|en)\/graphql');

app.use(graphqlRoute, cors(), bodyParser.json(), graphqlExpress((req) => {

  let lang = req.baseUrl.match(graphqlRoute)[1];
  let queriesToAddLang = new RegExp(config.queriesToAddLang.join('|'));

  if (req.body.query.match(queriesToAddLang)) {
    let wordFound = req.body.query.match(queriesToAddLang)[0];
    let oldquery = req.body.query.replace(/\s+/g, ' ');
    let query = oldquery.replace(/ (?={)/g, '');

    let pos = query.indexOf(wordFound) + wordFound.length + 1;
    let output = query.substr(0, pos) + 'lang{name __typename}' + query.substr(pos);
    req.body.query = output;
  }

  return ({
    schema: graphqlSchema,
    context: {lang},
  });

}));

app.post('/getCookie', (req, res) => {
  const form = new formidable.IncomingForm();

  form.parse(req, function(err, field, files) {

    res.set({
      'Access-Control-Allow-Credentials': true,//to allow cookie to be set in response
    });
    if (!err && 'locale' in field) {

      res.cookie('lang', field.locale, {expires: new Date(Date.now() + 900000000), domain: 'api.monsieurtshirt.localhost'});
      res.status(200).end(JSON.stringify({status: 'success', msg: 'well done'}));
    } else {
      res.status(200).end(JSON.stringify({status: 'error', msg: 'fail'}));
    }
  });

});

// Enable the useful graphiql tool for development only.
if (config.env === 'development') {
  app.use('/graphiql', graphiqlExpress({ endpointURL: '/fr/graphql' }));
}

// Create an http listener for our express app.
const port = 3000;
const listener = app.listen(port, () =>
  console.log(`Server listening on port ${port}`)
);
