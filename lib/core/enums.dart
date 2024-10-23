enum ToneType { Formal, Friendly, Joyful, Thoughtful, Critical, Informative, Confident, Urgent }

enum Language {
  English('gb'),
  Vietnamese('vn');

  const Language(this.languageCode);

  final String languageCode;
}

enum TextLength { Short, Medium, Long }
