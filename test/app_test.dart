import 'package:flutter_test/flutter_test.dart';
import 'package:payora/app.dart';
import 'package:payora/core/widgets/shell/index.dart';

void main() {
  group('App', () {
    testWidgets('renders ShellWidget', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ShellWidget), findsOneWidget);
    });
  });
}
