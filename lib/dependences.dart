import 'package:flutter_simple_dependency_injection/injector.dart';

import 'global_translate/global_translate.dart';

Injector get injector => Injector.getInjector();

Injector initialise() {
  injector.map<GlobalTranslations>((injector) => GlobalTranslations(), isSingleton: true);
  return injector;
}