module.exports = {
  schema: [
    {
      [`${process.env.HASURA_GRAPHQL_ENDPOINT}`]: {
        headers: {
          'x-hasura-admin-secret': process.env.HASURA_GRAPHQL_ADMIN_SECRET,
        },
      },
    },
  ],
  documents: './src/graphql/*.graphql',
  overwrite: true,
  generates: {
    './src/types/graphql.ts': {
      plugins: ['typescript', 'typescript-operations', 'typescript-react-apollo'],
      config: {
        withHOC: false,
        withComponent: false,
        withHooks: true,
        reactApolloVersion: 3,
        gqlImport: '@apollo/client#gql',
        skipTypename: false,
        namingConvention: {
          transformUnderscore: true,
        },
      },
    },
  },
}
