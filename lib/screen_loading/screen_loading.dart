import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldLoading extends StatefulWidget {
  const ScaffoldLoading({
    Key key,
    this.body,
    this.appBar,
    this.loading = false,
    this.openMenuWhenPressBack = false,
    this.handleBackButtonPressed,
    this.handleNotification = true,
    this.loadingWidget,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget appBar;
  final bool loading;
  final bool openMenuWhenPressBack;
  final Function handleBackButtonPressed;
  final bool handleNotification;
  final Widget loadingWidget;

  @override
  _ScaffoldLoadingState createState() => _ScaffoldLoadingState();
}

class _ScaffoldLoadingState extends State<ScaffoldLoading> {
  @override
  Widget build(BuildContext context) {
    final scaffold = Stack(
      children: <Widget>[
        Positioned.fill(
          child: Scaffold(
            appBar: widget.appBar,
            body: widget.body,
          ),
        ),
        if (widget.loading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(150),
              child: Center(
                child: widget.loadingWidget,
              ),
            ),
          )
      ],
    );

    return scaffold;
  }
}
