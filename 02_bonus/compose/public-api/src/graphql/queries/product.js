import {
  GraphQLNonNull as NonNull,
  GraphQLInt as Int,
} from 'graphql';

import joinMonster from 'join-monster';
import db from '../db';

import ProductType from '../types/ProductType';

const product = {
  type: ProductType,
  description: 'Return one product',
  args: {
    id: {type: new NonNull(Int)}
  },
  where: (productTable, args, context) => {
    if (args.id) {
      return `${productTable}.id = ${args.id}`
    }
  },
  resolve: (parent, args, context, resolveInfo) => {
    return joinMonster(resolveInfo, {}, sql => {
      return db.query(sql);
    });
  }

};

export default product;
