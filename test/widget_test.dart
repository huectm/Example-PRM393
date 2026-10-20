import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_dart/main.dart';

void main() {
  testWidgets('Renders MyApp successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify main app renders without exceptions
    expect(find.byType(MyApp), findsOneWidget);
  });
}
