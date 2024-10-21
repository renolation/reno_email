

extension EmailContentParsing on String {
  // Extension method to extract the subject
  String extractSubject() {
    if (startsWith("Subject: ")) {
      final breakIndex = indexOf('\n');
      if (breakIndex != -1) {
        return substring(9, breakIndex).trim();
      }
    }
    return "";
  }

  // Extension method to extract text after the subject
  String extractTextAfterSubject() {
    if (startsWith("Subject: ")) {
      final breakIndex = indexOf('\n');
      if (breakIndex != -1) {
        return substring(breakIndex + 1).trim();
      }
    }
    return trim();
  }
}
