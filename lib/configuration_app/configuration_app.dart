import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiUrl,
    @required this.secret,
    @required this.clientId,
    this.wss,
    @required Widget child,
  }) : super(child: child) {
    _globalKey = child.key;
  }

  final String appName;
  final AppFlavor flavorName;
  final String apiUrl;
  final String secret;
  final String wss;
  final int clientId;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey _globalKey;

  static GlobalKey get globalKey => _globalKey;

  static AppConfig get instance => _globalKey.currentContext
      .dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
