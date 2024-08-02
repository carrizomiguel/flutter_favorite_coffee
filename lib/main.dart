import 'package:coffee_repository/coffee_repository.dart';
import 'package:very_good_example/app/app.dart';
import 'package:very_good_example/bootstrap.dart';

void main() {
  final repository = CoffeeRepository();

  bootstrap(() => App(repository: repository));
}
