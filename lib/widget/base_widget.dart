import 'package:flutter/material.dart';
import 'package:flutter_gonosen/global_translate/global_translate.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  final GlobalTranslations translator = GlobalTranslations();
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final GlobalTranslations translator = GlobalTranslations();
}
