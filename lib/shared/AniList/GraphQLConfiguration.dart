import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class GraphQLConfiguration {
  static Link link;
  static HttpLink httpLink = HttpLink(uri: 'https://graphql.anilist.co/', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  static void setToken(String token) {
    AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

    GraphQLConfiguration.link = authLink.concat(httpLink);
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    return GraphQLConfiguration.link != null
      ? GraphQLConfiguration.link
      : GraphQLConfiguration.httpLink;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: InMemoryCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: getLink(),
      cache: InMemoryCache(),
    );
  }
}
