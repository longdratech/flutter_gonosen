import 'package:flutter/material.dart';

abstract class AppBase extends StatelessWidget {
  AppBase({Key key}) : super(key: key ?? GlobalKey());
}

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiUrl,
    this.apiUsername,
    this.apiPassword,
    this.wss,
    this.oneSignalID,
    @required Widget child,
  }) : super(child: Material(child: child)) {
    _globalKey = child.key;
  }

  ///name of app
  final String appName;

  ///environment development (main/dev/testing)
  final AppFlavor flavorName;

  ///url of api
  final String apiUrl;

  ///wss(web socket server). use with graphql
  final String wss;

  ///use for connect with id one signal to push notify
  final String oneSignalID;
  final String apiUsername;
  final String apiPassword;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey _globalKey;

  static GlobalKey get globalKey => _globalKey;

  static AppConfig get instance => _globalKey.currentContext
      .dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  bool get isDevelopment => flavorName == AppFlavor.DEVELOPMENT;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
