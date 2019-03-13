import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/io_utils.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({this.projectPath});

  final String projectPath;

  Directory get projectDirectory => Directory(projectPath);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: _appBar,
        child: _body,
      );

  Widget get _appBar =>
      CupertinoNavigationBar(middle: Text('Project: $projectPath'));

  Widget get _body => Column(
        children: <Widget>[
          Text(
            'Project Location: $projectPath',
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future:
                  listDartFiles(projectDirectory).map((f) => f.path).toList(),
              builder: (_, snapshot) => snapshot.hasData
                  ? FilesListWidget(paths: snapshot.data)
                  : CupertinoActivityIndicator(),
            ),
          ),
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
              (p) => Text(p),
            )
            .toList(),
      );
}
