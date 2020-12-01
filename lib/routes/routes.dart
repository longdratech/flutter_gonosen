import 'package:flutter/material.dart';

Route onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text(
          settings.name.split('/')[1],
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('${settings.name.split('/')[1]} Comming soon..'),
      ),
    ),
  );
}
