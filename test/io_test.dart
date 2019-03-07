import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:butterfree/src/core/io_utils.dart';
import 'package:path/path.dart' as path;

void main() {
  Directory _tmpTestDir;
  setUpAll(() async {
    _tmpTestDir = await Directory.systemTemp.createTemp('butterfree_test');
    final fixturesSampleDir = Directory('./test/fixtures/sample');

    await cloneFiles(fixturesSampleDir, _tmpTestDir);

    await for (final f in _tmpTestDir.list(recursive: true)) {
      if (f is File && f.path.endsWith('.t')) {
        final newPath = f.path.substring(0, f.path.length - 2);
        await f.rename(newPath);
      }
    }
  });

  test('A user can open a Flutter project from their local filesystem', () {
    fail('Not Implemented');
  });

  test('All files can be listed from the project', () async {
    final files = await listFiles(_tmpTestDir).toList();

    expect(files.length, 2);
  });

  test('All dart files can be listed from the project', () async {
    final files = await listDartFiles(_tmpTestDir).toList();
    expect(files.length, 1);
  });

  test('Widget definitions can be extracted from the project', () {
    fail('Not Implemented');
  });

  test('A new widget file can be created', () {
    fail('Not Implemented');
  });

  test('An existing widget file can be updated/saved', () {
    fail('Not Implemented');
  });
}
