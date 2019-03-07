import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(title: 'Butterfree', home: TestWidget()));
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text('Foo');
}