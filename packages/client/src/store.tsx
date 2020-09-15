import React from 'react'
import { ApolloClient, ApolloProvider, InMemoryCache, HttpLink } from '@apollo/client'

const cache = new InMemoryCache()
const link = new HttpLink({
  uri: process.env.HASURA_GRAPHQL_ENDPOINT,
  headers: {
    'x-hasura-admin-secret': process.env.HASURA_GRAPHQL_ADMIN_SECRET,
  },
})

const client = new ApolloClient({
  cache,
  link,
})

type AppProviderProps = {
  children: React.ReactChild
}

const AppProvider = ({ children }: AppProviderProps) => {
  return <ApolloProvider client={client}>{children}</ApolloProvider>
}

export default AppProvider
