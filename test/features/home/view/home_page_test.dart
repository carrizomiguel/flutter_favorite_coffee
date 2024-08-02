import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  initHydratedStorage();

  late CoffeeRepository repository;

  setUp(() {
    repository = MockCoffeeRepository();

    when(
      () => repository.getRandomCoffee(),
    ).thenAnswer((_) async => Result.err(ConnectionFailure()));
  });

  group('Home Page', () {
    testWidgets('renders HomeView', (widgetTester) async {
      await widgetTester.pumpApp(
        const HomePage(),
        repository: repository,
      );

      expect(find.byType(HomeView), findsOneWidget);
    });

    group('Page View', () {
      testWidgets('go to saves page', (widgetTester) async {
        await widgetTester.pumpApp(
          const HomePage(),
          repository: repository,
        );

        final pageView = widgetTester.widget<PageView>(
          find.byType(PageView),
        );

        final initialPage = pageView.controller!.page;

        final button = find.byKey(const Key('nav_bar_save_button'));
        expect(button, findsOneWidget);

        await widgetTester.tap(button);
        await widgetTester.pumpAndSettle();

        final currentPage = pageView.controller!.page;
        expect(initialPage, isNot(currentPage));
        expect(initialPage, 0.0);
        expect(currentPage, 1.0);
      });
    });

    testWidgets('go to saves page', (widgetTester) async {
      await widgetTester.pumpApp(
        const HomePage(),
        repository: repository,
      );

      final pageView = widgetTester.widget<PageView>(
        find.byType(PageView),
      );

      final saveButton = find.byKey(const Key('nav_bar_save_button'));
      expect(saveButton, findsOneWidget);

      await widgetTester.tap(saveButton);
      await widgetTester.pumpAndSettle();

      final initialPage = pageView.controller!.page;

      final button = find.byKey(const Key('nav_bar_coffee_button'));
      expect(button, findsOneWidget);

      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();

      final currentPage = pageView.controller!.page;
      expect(initialPage, isNot(currentPage));
      expect(initialPage, 1.0);
      expect(currentPage, 0.0);
    });
  });
}
