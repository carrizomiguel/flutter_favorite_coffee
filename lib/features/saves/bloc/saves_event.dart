part of 'saves_bloc.dart';

sealed class SavesEvent extends Equatable {
  const SavesEvent();
}

class SavesToggled extends SavesEvent {
  const SavesToggled({
    required this.url,
    required this.image,
  });

  final String url;
  final Uint8List image;

  @override
  List<Object> get props => [url, image];
}
