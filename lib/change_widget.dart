// ignore_for_file: prefer_const_constructors

import 'package:bloc_2/ProciderOFcontext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeWidget extends StatelessWidget {
  const ChangeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var model = Provider.of<Model>(
    //   context,listen: true
    //
    return Center(
      child: Column(
        children: [
          //watch: like provider.of<PROVIDER> -> listen: true
          Text(context.watch<Model>().name),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              //read : like provider.of<PROVIDER> -> listen: false
              context.read<Model>().changeName();
            },
            child: Text(context.read<Model>().button),
          )
        ],
      ),
    );
  }
}
