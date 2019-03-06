import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('The widget\'s name can be set', () {});
  test('A new property can be added', () {});
  test('An existing property can be updated', () {});
  test('A property can be deleted', () {});

  test('The widget has its own sub-widget tree *if* it can have children.',
      () {});

  test('A root widget can be added to the tree', () {});

  // TODO: How will we handle widgets which don't define properties explicitly named child/children, like an AppBar's "actions" property?
  // Should we also inspect Type information on widget properties to see if they expect Widgets?
  test(
      'Other widgets can be drag-and-dropped into Widgets in the tree which have child/children properties',
      () {});
  // TODO: Certain Widgets were explicitly defined in the requirements like Row/Column.  This feature should generically apply to all types of parent widgets,
  // but certain ones are listed out of convenience to the user.  We can add additional tests later for the specific "wrapper" widgets.
  test('A widget in the tree can be wrapped with a parent widget', () {});

  test(
      'A widget in the tree can be extracted into its own separate managed widget definition.',
      () {});

  test(
      'Widgets in the tree have properties of their own which require arguments.  These arguments can be defined by the user.',
      () {});

  test('A widget in the tree can be removed', () {});
}
