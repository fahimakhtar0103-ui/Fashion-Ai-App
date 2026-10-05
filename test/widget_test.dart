import 'package:flutter_test/flutter_test.dart';
import 'package:fashion_ai_app/main.dart';

void main() {
  testWidgets('Fashion AI app renders', (tester) async {
    await tester.pumpWidget(const FashionAiApp());

    expect(find.text('Fashion AI'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Templates'), findsOneWidget);
  });
}
