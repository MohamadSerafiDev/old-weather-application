// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_widget.dart';

class Prociderofcontext extends StatefulWidget {
  const Prociderofcontext({super.key});

  @override
  State<Prociderofcontext> createState() => _ProciderofcontextState();
}

class _ProciderofcontextState extends State<Prociderofcontext> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: ChangeWidget(),
      ),
    );
  }
}

class Model extends ChangeNotifier {
  String name = 'mohamad';
  String button = 'press';
  changeName() {
    name = 'aaa';
    notifyListeners();
  }
}
