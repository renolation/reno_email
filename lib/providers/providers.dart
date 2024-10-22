import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reno_email/core/enums.dart';

final languageProvider = StateProvider<String>((ref) {
  return Language.English.name;
});

final toneTypeProvider = StateProvider<String>((ref) {
  return ToneType.Formal.name;
});

final textLengthProvider = StateProvider<TextLength>((ref) {
  return TextLength.Short;
});
