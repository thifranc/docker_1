import {
    GraphQLSchema as Schema,
    GraphQLObjectType as ObjectType,
} from 'graphql';

import products from './queries/products';
import product from './queries/product'

const schema = new Schema({
    query: new ObjectType({
        name: 'Query',
        fields: {
            products,
            product
        },
    }),
});

export default schema;
