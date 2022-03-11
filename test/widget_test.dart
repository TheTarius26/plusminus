// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plusminus/data/model/cell.dart';
import 'package:plusminus/data/model/cell_status.dart';

import 'package:plusminus/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Create list of cells', () {
    final cell = Cell.createTable(200, 3);

    expect(3, cell.length);
    expect(3, cell[0].length);
    expect(CellStatus.active, cell[0][0].status);
    expect(CellStatus.active, cell[0][1].status);
    expect(CellStatus.active, cell[0][2].status);
    expect(CellStatus.inactive, cell[1][0].status);
    expect(CellStatus.inactive, cell[1][1].status);
    expect(CellStatus.inactive, cell[1][2].status);
  });
}
