import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:file_chooser/file_chooser.dart' as file_chooser;
import './src/ui/project.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(Butterfree());
}

class Butterfree extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Butterfree',
        home: _body(context),
      );

  Widget _body(BuildContext context) => Row(
        children: <Widget>[
          const Text('Welcome to Butterfree'),
          FlatButton(
            child: const Text('Open Project'),
            onPressed: () => _displayFileChooser(context),
          ),
        ],
      );

  void _displayFileChooser(BuildContext context) => file_chooser.showOpenPanel(
        (result, paths) {
          if (result == file_chooser.FileChooserResult.ok && paths.isNotEmpty)
            _openProject(context, paths.first);
        },
        canSelectDirectories: true,
        allowsMultipleSelection: false,
      );
  void _openProject(BuildContext context, String projectPath) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectPage(projectPath: projectPath),
        ),
      );
}
