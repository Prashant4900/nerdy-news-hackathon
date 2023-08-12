import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reader_mode/repository/reader_mode_repository.dart';

part 'reader_mode_state.dart';

class ReaderModeCubit extends Cubit<ReaderModeState> {
  ReaderModeCubit() : super(const ReaderModeInitialState(readerMode: false));

  final readerModeRepo = ReaderModeRepositoryImpl();

  Future<void> changeReaderMode({required bool readerMode}) async {
    await readerModeRepo.saveReaderMode(readerMode: readerMode);
    emit(ReaderModeChangeState(readerMode: readerMode));
  }

  Future<void> getReaderMode() async {
    final readerMode = await readerModeRepo.getReaderMode();
    emit(ReaderModeChangeState(readerMode: readerMode));
  }
}
