import "package:flutter/material.dart";
import 'package:flutter_gonosen/configuration_app/configuration_app.dart';
import 'package:flutter_gonosen/secure_storage/secure_storage.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  final SecureStorage storage = SecureStorage();
  String token;

  Future getToken() async {
    token = await storage.getToken;
  }

  static Link link;
  static HttpLink httpLink = HttpLink(
    uri: AppConfig.instance.apiUrl,
  );

  static void setToken(String token) {
    final AuthLink authLink = AuthLink(
      getToken: () {
        return token;
      },
    );
    final WebSocketLink socketLink = WebSocketLink(
      url: AppConfig.instance.wss,
      config: SocketClientConfig(
        autoReconnect: true,
        initPayload: () async {
          return {
            'Authorization': token,
          };
        },
      ),
    );
    GraphQLConfiguration.link =
        authLink.concat(GraphQLConfiguration.httpLink).concat(socketLink);
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    return GraphQLConfiguration.link ?? GraphQLConfiguration.httpLink;
  }

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  static GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: getLink(),
    );
  }
}