import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/widgets/scaffold/appBar.dart';
import 'package:mikazuki/mobile/widgets/scaffold/bottomNavigationBar.dart';

class MikazukiScaffold extends StatefulWidget {
  final Widget _body;

  MikazukiScaffold({ @required Widget body }) : _body = body;

  @override
  State<StatefulWidget> createState() => _MikazukiScaffoldState(_body);
}

class _MikazukiScaffoldState extends State<MikazukiScaffold> {
  Widget _body;

  _MikazukiScaffoldState(this._body);

  @override
  void initState() {
    super.initState();

    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MikazukiAppBar('Mikazuki'),
      // bottomNavigationBar: MikazukiBottomNavBar(),
      body: _body,
    );
  }
}
