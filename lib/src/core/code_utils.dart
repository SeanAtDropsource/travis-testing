import 'dart:math';

import 'package:analyzer/dart/ast/ast.dart' as ast;
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/src/dart/scanner/reader.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/generated/parser.dart';
import 'package:analyzer/src/string_source.dart';
import 'package:dart_style/src/source_visitor.dart';
import 'package:dart_style/dart_style.dart';

final Set<String> _widgetClassNames =
    Set.from(["StatefulWidget", "StatelessWidget", "Widget"]);

/**
 * Extract all class declarations in the given compilation unit that are subtypes of the Widget base class.
 */
List<ast.ClassDeclaration> extractWidgets(ast.CompilationUnit cu) =>
    cu.declarations
        .whereType<ast.ClassDeclaration>()
        .where(classDeclarationIsWidget)
        .toList();

/**
 * Helper function to determine if a ClassDeclaration extends Widget
 */
bool classDeclarationIsWidget(ast.ClassDeclaration ce) {
  final superClass = ce.extendsClause?.superclass?.name?.name;

  if (superClass != null && _widgetClassNames.contains(superClass)) return true;

  final implements =
      ce.implementsClause?.interfaces?.map((tn) => tn.name.name)?.toSet() ??
          Set.from([]);

  return implements.intersection(_widgetClassNames).isNotEmpty;
}

/**
 * Parse the given code (extracted from a file) into a CompilationUnit.
 */
ast.CompilationUnit parseCompilationUnit(String code, {String filePath}) {
  final errorListener = ThrowAnalysisErrorListener();
  final reader = CharSequenceReader(code);
  final stringSource = StringSource(code, filePath);
  final scanner = Scanner(stringSource, reader, errorListener);
  final startToken = scanner.tokenize();
  return Parser(stringSource, errorListener).parseCompilationUnit(startToken);
}

/**
 * Helper AnalysisErrorListener that attempts to capture surrouncing code for an error location before throwing the error.
 */
class ThrowAnalysisErrorListener extends AnalysisErrorListener {
  @override
  void onError(AnalysisError error) {
    print(error.message);
    print(error.source.contents.data.substring(max(error.offset - 200, 0),
        min(error.offset + 200, error.source.contents.data.length)));
    throw error;
  }
}

/**
 * Format the given raw unformatted code into clean code using the DartFormatter library
 */
String formatSourceCode(String unformatted) => _formatter.format(unformatted);

DartFormatter _formatter = new DartFormatter();
