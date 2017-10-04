import {
  GraphQLObjectType as ObjectType,
  GraphQLInt as Int,
  GraphQLString as StringType,
  GraphQLNonNull as NonNull,
} from 'graphql';

const ProductType = new ObjectType({
  name: 'image',
  sqlTable: 'image',
  uniqueKey: 'id',
  fields: {
    id: { type: new NonNull(Int) },
    url: { type: StringType }
  },
});

export default ProductType;
