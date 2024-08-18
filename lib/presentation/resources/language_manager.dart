enum LanguageType {
  ENGLISH,
  KOREAN,
}

const String ENGLISH = 'en';
const String KOREAN = 'ko';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.KOREAN:
        return KOREAN;
    }
  }
}
