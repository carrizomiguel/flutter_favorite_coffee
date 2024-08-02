part of 'saves_bloc.dart';

class SavesState extends Equatable {
  const SavesState({
    this.saves = const {},
  });

  final Map<String, Uint8List> saves;

  SavesState copyWith({
    Map<String, Uint8List>? saves,
  }) {
    return SavesState(
      saves: saves ?? this.saves,
    );
  }

  @override
  List<Object> get props => [saves];
}
