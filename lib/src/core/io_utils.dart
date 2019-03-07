import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path;

/**
 * Returns a Stream of files in the given directory, recursively
 */
Stream<File> listFiles(Directory dir) =>
    dir.list(recursive: true).where((fe) => fe is File).cast<File>();

/**
 * Returns a Stream of .dart files in the given directory, recursively
 */
Stream<File> listDartFiles(Directory dir) =>
    listFiles(dir).where((f) => f.path.endsWith('.dart'));

/**
 * Clone the contents of the given source directory into the given destination directory.  If the destination directory does not exist, it will be created (with recursive parents)
 */
Future<void> cloneFiles(Directory source, Directory destination) async {
  if (!(await destination.exists())) {
    await destination.create(recursive: true);
  }
  await for (final fe in source.list()) {
    final targ = destination.path + '/' + path.basename(fe.path);
    if (fe is Directory) {
      await cloneFiles(fe, Directory(targ));
    } else if (fe is File) {
      await fe.copy(targ);
    }
  }
}
