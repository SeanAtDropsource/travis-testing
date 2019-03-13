import 'package:flutter/cupertino.dart';
import './project.dart';
import 'package:file_chooser/file_chooser.dart' as file_chooser;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoApp(
        title: 'Butterfree',
        home: MainPageBody(),
      );
}

class MainPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: Column(
          children: <Widget>[
            const Text('Welcome to Butterfree'),
            CupertinoButton(
              child: const Text('Open Project'),
              onPressed: () {
                _displayFileChooser(context);
              },
            ),
          ],
        ),
      );

  void _displayFileChooser(BuildContext context) => file_chooser.showOpenPanel(
        (result, paths) {
          if (paths.isNotEmpty) _openProject(context, paths.first);
        },
        canSelectDirectories: true,
        allowsMultipleSelection: false,
      );
  void _openProject(BuildContext context, String projectPath) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ProjectPage(projectPath: projectPath),
        ),
      );
}
