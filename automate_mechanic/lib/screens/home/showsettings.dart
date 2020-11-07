import 'package:flutter/material.dart';
import 'package:mechanic_app/screens/home/settings_from.dart';

class ShowSettings extends StatefulWidget {
  @override
  _ShowSettingsState createState() => _ShowSettingsState();
}

class _ShowSettingsState extends State<ShowSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SettingsForm()
          ],
        ),
      ),
    );
  }
}