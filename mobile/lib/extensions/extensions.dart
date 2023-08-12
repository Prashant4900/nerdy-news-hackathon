import 'dart:developer' as developer;
import 'dart:math';

extension StringExtension on String {
  String get getFirstFewWords {
    final words = split(' ');
    if (words.length > 15) {
      return '${words.sublist(0, 15).join(' ')}...';
    } else {
      return this;
    }
  }
}

// Extension on List which randomly shuffles the list items
extension ListExtension<T> on List<T> {
  List<T> get randomize {
    final random = Random();
    final items = this;
    for (var i = items.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = items[i];
      items[i] = items[j];
      items[j] = temp;
    }
    return items;
  }
}

extension Logging on Object {
  void log([String tag = 'LOG']) {
    developer.log(toString(), name: tag);
  }
}
