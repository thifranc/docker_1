import {
    GraphQLObjectType as ObjectType,
    GraphQLInt as Int,
    GraphQLString as StringType,
    GraphQLNonNull as NonNull,
    GraphQLList as List,
} from 'graphql';

import ImageType from './ImageType';

const ProductType = new ObjectType({
    name: 'Product',
    sqlTable: 'product',
    uniqueKey: 'id',
    fields: {
        id: { type: new NonNull(Int) },
        name: { type: StringType },
        description: { type: StringType },
        images: {
            type: new List(ImageType),
            joinTable: 'product_image',
            sqlJoins: [
                (productTable, relationTable) => `${productTable}.id = ${relationTable}.product_id`,
                (relationTable, imageTable) => `${relationTable}.image_id = ${imageTable}.id`,
            ]
        }
    },
});

export default ProductType;
