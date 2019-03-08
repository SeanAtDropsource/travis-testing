import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

void main() {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    runApp(Butterfree());
}

class Butterfree extends StatelessWidget {

  @override Widget build(BuildContext context) =>
    MaterialApp(title: 'Butterfree', home: const Text('Welcome to Butterfree'));
}