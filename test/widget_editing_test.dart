import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('The widget\'s name can be set', () {
    fail('Not Implemented');
  });
  test('A new property can be added', () {
    fail('Not Implemented');
  });
  test('An existing property can be updated', () {
    fail('Not Implemented');
  });
  test('A property can be deleted', () {
    fail('Not Implemented');
  });

  test('The widget has its own sub-widget tree *if* it can have children.',
      () {
    fail('Not Implemented');
  });

  test('A root widget can be added to the tree', () {
    fail('Not Implemented');
  });

  // TODO: How will we handle widgets which don't define properties explicitly named child/children, like an AppBar's "actions" property?
  // Should we also inspect Type information on widget properties to see if they expect Widgets?
  // This may not actually matter for the MVP since we are solely focusing on "managed" widgets.
  test(
      'Other widgets can be drag-and-dropped into Widgets in the tree which have child/children properties',
      () {
    fail('Not Implemented');
  });
  // TODO: Certain Widgets were explicitly defined in the requirements like Row/Column.  This feature should generically apply to all types of parent widgets,
  // but certain ones are listed out of convenience to the user.  We can add additional tests later for the specific "wrapper" widgets.
  test('A widget in the tree can be wrapped with a parent widget', () {
    fail('Not Implemented');
  });

  test(
      'A widget in the tree can be extracted into its own separate managed widget definition.',
      () {
    fail('Not Implemented');
  });

  test(
      'Widgets in the tree have properties of their own which require arguments.  These arguments can be defined by the user.',
      () {
    fail('Not Implemented');
  });

  test('A widget in the tree can be removed', () {
    fail('Not Implemented');
  });
}
