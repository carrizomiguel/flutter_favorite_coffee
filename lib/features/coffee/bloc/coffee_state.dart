part of 'coffee_bloc.dart';

enum CoffeeStatus {
  loading,
  success,
  error,
  noConnection;

  bool get isLoading => this == CoffeeStatus.loading;
  bool get isNoSuccess =>
      this != CoffeeStatus.loading && this != CoffeeStatus.success;
}

class CoffeeState extends Equatable {
  const CoffeeState({
    this.status = CoffeeStatus.loading,
    this.currentUrl = '',
    this.currentCoffee,
  });

  final CoffeeStatus status;
  final String currentUrl;
  final Uint8List? currentCoffee;

  CoffeeState copyWith({
    CoffeeStatus? status,
    String? currentUrl,
    Uint8List? currentCoffee,
  }) {
    return CoffeeState(
      status: status ?? this.status,
      currentUrl: currentUrl ?? this.currentUrl,
      currentCoffee: currentCoffee ?? this.currentCoffee,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentUrl,
        currentCoffee,
      ];
}
