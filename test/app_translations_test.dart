import 'package:flutter_test/flutter_test.dart';
import 'package:pet_project/domain/services/translation/app_translations.dart';

void main() {
  test('AppTranslations should return path', () {
    final appTranslations = AppTranslations();
    var localPath = appTranslations.localePath('ru');
    expect(localPath, 'assets/locale/ru.json');
  });
}
