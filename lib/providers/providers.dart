import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reno_email/core/enums.dart';

final languageProvider = StateProvider<String>((ref) {
  return Language.English.name;
});

final toneTypeProvider = StateProvider<String>((ref) {
  return ToneType.Formal.name;
});

final textLengthProvider = StateProvider<String>((ref) {
  return TextLength.Short.name;
});
