class Language {
  final String code, language;

  Language(this.code, this.language);

  factory Language.fromMap(Map data) =>
      Language(data['code'], data['language']);
}
