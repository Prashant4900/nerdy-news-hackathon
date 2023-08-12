part of 'reader_mode_cubit.dart';

abstract class ReaderModeState extends Equatable {
  const ReaderModeState({required this.readerMode});

  final bool readerMode;

  @override
  List<Object> get props => [readerMode];
}

class ReaderModeInitialState extends ReaderModeState {
  const ReaderModeInitialState({required super.readerMode});

  @override
  List<Object> get props => [readerMode];
}

class ReaderModeChangeState extends ReaderModeState {
  const ReaderModeChangeState({required super.readerMode});

  @override
  List<Object> get props => [readerMode];
}
