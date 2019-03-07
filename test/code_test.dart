import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:butterfree/src/core/code_utils.dart';
import 'package:path/path.dart' as path;

void main() {
  test('A .dart file can be parsed into a compilation unit', () async {
    final mainDartFile = File('./test/fixtures/sample/lib/main.dart.t');
    final raw = await mainDartFile.readAsString();
    final cu = parseCompilationUnit(raw, filePath: mainDartFile.path);
    expect(cu.declarations.isNotEmpty, true);
  });

  test('Widgets can be extracted from a .dart file', () async {
    final mainDartFile = File('./test/fixtures/sample/lib/main.dart.t');
    final raw = await mainDartFile.readAsString();
    final cu = parseCompilationUnit(raw, filePath: mainDartFile.path);

    final widgets = extractWidgets(cu);
    expect(widgets[0].name.name, 'TestWidget');
  });
}
