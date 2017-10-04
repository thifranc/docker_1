import {

  GraphQLNonNull as NonNull,
  GraphQLString as StringType,
  GraphQLList as List
} from 'graphql';

import joinMonster from 'join-monster';
import db from '../db';

import ProductType from '../types/ProductType';

const products = {
  type: new List(ProductType),
  description: 'Return products',
  resolve: (parent, args, context, resolveInfo) => {

    return joinMonster(resolveInfo, context, sql => {
      return db.query(sql);
    });
  }

};

export default products;
