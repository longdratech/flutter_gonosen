import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogger extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    debugPrint("on change $cubit $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint("on change $bloc $transition");
  }

  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    debugPrint("on change $cubit");
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    debugPrint("on change $cubit");
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    debugPrint("on change $cubit $error $stackTrace");
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint("on change $bloc $event");
  }
}