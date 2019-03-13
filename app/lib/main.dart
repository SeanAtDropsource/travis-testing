import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/cupertino.dart';
import './src/ui/app.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(CupertinoApp(
    title: 'Butterfree',
    home: MainPageBody(),
  ));
}
