import 'dart:typed_data';

import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:very_good_example/app/app.dart';

import '../../helpers/helpers.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  initHydratedStorage();

  late CoffeeRepository repository;

  setUp(() {
    repository = MockCoffeeRepository();
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      when(
        () => repository.getRandomCoffee(),
      ).thenAnswer((_) async => Result.ok(('', Uint8List.fromList([0]))));

      await tester.pumpWidget(App(repository: repository));

      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
