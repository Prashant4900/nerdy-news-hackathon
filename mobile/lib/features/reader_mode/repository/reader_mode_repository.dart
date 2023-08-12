import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

abstract class ReaderModeRepository {
  Future<bool> getReaderMode();
  Future<bool> saveReaderMode({required bool readerMode});
}

class ReaderModeRepositoryImpl implements ReaderModeRepository {
  ReaderModeRepositoryImpl();

  @override
  Future<bool> getReaderMode() async {
    return CacheHelper.getReaderMode();
  }

  @override
  Future<bool> saveReaderMode({required bool readerMode}) async {
    return CacheHelper.saveReaderMode(
      key: PreferenceKey.readerMode,
      readerMode: readerMode,
    );
  }
}
