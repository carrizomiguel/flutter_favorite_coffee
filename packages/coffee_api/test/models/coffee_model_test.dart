import 'package:coffee_api/src/models/coffee_model.dart';
import 'package:test/test.dart';

void main() {
  const url = 'https://url.com';

  group('Coffee Model', () {
    test('supports value comparison', () {
      expect(const CoffeeModel(file: url), const CoffeeModel(file: url));
    });

    test('returns a CoffeeModel when fromJson is called', () {
      final json = {'file': url};

      final model = CoffeeModel.fromJson(json);

      expect(const CoffeeModel(file: url), model);
    });
  });
}
