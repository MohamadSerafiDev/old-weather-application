// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderTest extends StatefulWidget {
  const ProviderTest({super.key});
  @override
  State<ProviderTest> createState() => _ProviderTestState();
}

class _ProviderTestState extends State<ProviderTest> {
  @override
  Widget build(BuildContext context) {
    //the provider work just in scope of 'ChangeNotifierProvider'
    return ChangeNotifierProvider(
      create: (context) => Change(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
        ),
        //refresh all consumer of type Change!!
        //using notify listeners (like set state but for one or multiple widgets not for all build method)
        body: ListView(
          children: [
            Center(
              //selector explaning:
              // --selector do rebuild just for the specifice
              //widget that connected to value in class of logic <change> and
              // we can set the value we will connect it to selector
              // --in selector: context for widget tree and another value is the thing name
              //  will change and we connect the value using selecor: using (=>) operetor
              //  so the var after => is what we use in our widget  : )......
              child: Selector<Change, String>(
                selector: (context, changeS1) => changeS1.one,
                builder: (context, value, child) {
                  print('selector text 1');
                  return Text(value);
                },
              ),
            ),
            Divider(),
            Center(
              child: Selector<Change, String>(
                builder: (context, value, child) {
                  print('selector text 2 ');
                  return Text(value);
                },
                selector: (context, changeS2) => changeS2.two,
              ),
            ),
            Divider(),
            Consumer<Change>(
              builder: (context, value, child) {
                print('consumer one ');
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(value.one),
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              value.changeNameOne();
                            },
                            icon: Icon(Icons.ads_click)),
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(),
            Consumer<Change>(
              builder: (context, value, child) {
                print('consumer two ');
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(value.two),
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              value.changeNameTwo();
                            },
                            icon: Icon(Icons.ads_click)),
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class Change extends ChangeNotifier {
  var one = 'one ';
  var two = 'two ';
  get showone => one;
  get showtwo => two;
  changeNameOne() {
    one = '${one}1';
    notifyListeners();
  }

  changeNameTwo() {
    two = '${two}1';

    notifyListeners();
  }
}
