import 'dart:io';
import 'package:flutter/material.dart';
import '../core/io_utils.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({this.projectPath});

  final String projectPath;

  Directory get projectDirectory => Directory(projectPath);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: _body,
      );

  Widget get _appBar => AppBar(title: const Text('Butterfree'));

  Widget get _body => Row(
        children: <Widget>[
          Text(
            'Project Location: $projectPath',
          ),
          FutureBuilder<List<String>>(
            future: listDartFiles(projectDirectory).map((f) => f.path).toList(),
            builder: (_, snapshot) => snapshot.hasData
                ? FilesListWidget(paths: snapshot.data)
                : CircularProgressIndicator(),
          )
        ],
      );
}

class FilesListWidget extends StatelessWidget {
  const FilesListWidget({this.paths});
  final List<String> paths;
  @override
  Widget build(BuildContext context) => ListView(
        children: paths
            .map(
              (p) => ListTile(title: Text(p)),
            )
            .toList(),
      );
}
