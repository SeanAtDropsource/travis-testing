import 'package:flutter/material.dart';
import 'package:analyzer/dart/ast/ast.dart' as ast;

/**
 * A Widget Definition represents a Widget abstractly.  These Definitions can either be user-defined, or Dropsource-defined (in the case of internal widgets).
 */
abstract class WidgetDefinition {
  /**
   * Each Widget, internal or user-defined, must have a name.
   */
  String get name;

  /**
   * The properties for this definition, generally the "constructor" properties.
   */
  List<PropertyDefinition> get properties;

  /**
   * Eventually called when a Widget must be constructed and rendered to the user.  This is for rendering purposes only and doesn't actually impact the final output.
   * This Widget should also include any necessary drag-targets for accepting children.
   */
  Widget buildWidget(Map<String, dynamic> propertyValues);
}

/**
 * Each WidgetDefinition has a list of properties.  A Property has a name and a data type (which eventually gets mapped to a Dart type).
 * 
 */
class PropertyDefinition {
  const PropertyDefinition(
      {this.name, this.type, this.required, this.defaultValue});
  final String name;
  final String type;
  final bool required;
  final dynamic defaultValue;

  factory PropertyDefinition.fromFormalParameter(
      ast.FormalParameter formalParameter) {
    final name = formalParameter.identifier.name;
    String type;
    final bool required = formalParameter.isRequired;
    dynamic defaultValue;
    if (formalParameter is ast.SimpleFormalParameter) {
      type = formalParameter.type?.toString();
    } else if (formalParameter is ast.DefaultFormalParameter) {
      defaultValue = formalParameter.defaultValue;
      type = (formalParameter.parameter as ast.SimpleFormalParameter)
          .type
          ?.toString();
    }
    return PropertyDefinition(
      name: name,
      type: type,
      required: required,
      defaultValue: defaultValue,
    );
  }
}

class UserWidgetDefinition extends WidgetDefinition {
  UserWidgetDefinition({this.name, this.properties, this.root});
  final String name;
  final List<PropertyDefinition> properties;

  final AppliedWidgetDefinition root;

/**
 * TODO
 */
  Widget buildWidget(Map<String, dynamic> propertyValues) => null;

  /**
   * Extract the first [UserWidgetDefinition] from the given [ast.CompilationUnit].  The Compilation Unit is expected to have only
   *  one class declaration, and that class declaration is expected to be a Dropsource Widget.
   */
  factory UserWidgetDefinition.fromCompilationUnit(
          ast.CompilationUnit compilationUnit) =>
      UserWidgetDefinition.fromClassDeclaration(
          compilationUnit.declarations.whereType<ast.ClassDeclaration>().first);

  /**
   * Translate a [ast.ClassDeclaration] into a [UserWidgetDefinition].  The class's name is the Widget's name (of course).  The properties are determined from the first Constructor's parameter list.
   * TODO: For now, the "root" is just null.  We'll eventually need to parse the "build" method to extract the sub-widget tree.
   */
  factory UserWidgetDefinition.fromClassDeclaration(
      ast.ClassDeclaration classDeclaration) {
    final name = classDeclaration.name.name;
    var properties = <PropertyDefinition>[];
    final constructors =
        classDeclaration.members.whereType<ast.ConstructorDeclaration>();
    if (constructors.isNotEmpty) {
      properties = constructors.first.parameters.parameters.map(
        (formalParameter) =>
            PropertyDefinition.fromFormalParameter(formalParameter),
      );
    }
    return UserWidgetDefinition(name: name, properties: properties, root: null);
  }
}

/**
 * A helper bundle which includes a [WidgetDefinition] and Constructor arguments.
 */
class AppliedWidgetDefinition {
  AppliedWidgetDefinition({this.definition, this.arguments});
  final WidgetDefinition definition;
  final Map<String, dynamic> arguments;

  Widget get buildWidget => definition.buildWidget(arguments);
}

/**
 * Doesn't include any true functionality; just a helper mixin to be used by [WidgetDefinition]s that are represented internally (i.e. the base toolkit)
 */
abstract class InternalWidgetDefinition extends WidgetDefinition {}

/**
 * A "catalog" of all widgets accessible to the user.
 */
class WidgetCatalog {
  WidgetCatalog({this.userWidgets});

  /**
   * A list of widgets defined by the user.  These widgets are intended to be opened, edited, and saved.  These widgets generally map to
   * files in the user's Flutter project.
   */
  final List<UserWidgetDefinition> userWidgets;

  /**
   * A list of Dropsource-internal Widgets that the user can use as base/scaffolding for their own custom widgets.
   */
  static final List<InternalWidgetDefinition> internalWidgets = [
    RowDefinition(),
  ];
}

/**
 * A [WidgetDefinition] representing the built-in [Row] Widget
 */
class RowDefinition extends InternalWidgetDefinition {
  @override
  Widget buildWidget(Map<String, dynamic> propertyValues) => Row(
        children: propertyValues['children'],
      );

  @override
  final String name = 'Row';

  @override
  List<PropertyDefinition> get properties => [
        PropertyDefinition(
          name: 'children',
          type: 'List<Widget>',
        ),
      ];
}
