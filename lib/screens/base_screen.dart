import 'package:flutter/material.dart';

abstract class BaseScreens extends StatefulWidget {
  Widget content(BuildContext context);

  @override
  _BaseScreensState createState() => _BaseScreensState();
}

class _BaseScreensState extends State<BaseScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return widget.content(context);
  }
}
