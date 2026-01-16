import 'package:test/test.dart';
import 'package:text_metrics/text_metrics.dart';

void main() {
  group('TextMetrics', () {
    final text = '''
Olá, mundo!
Este é um texto de teste.
Ele contém múltiplas linhas,
números 12345 e símbolos !@#\$%.

Linha vazia abaixo:

Fim do teste.
''';

    final metrics = TextMetrics(text);

    test('Contagem de linhas', () {
      expect(metrics.lines.lineCount, 8);
      expect(metrics.lines.nonEmptyLineCount, 6);
      expect(metrics.lines.emptyLineCount, 2);
      expect(metrics.lines.lineAt(0), 'Olá, mundo!');
      expect(metrics.lines.lineAt(100), isNull);
    });

    test('Contagem de caracteres', () {
      expect(metrics.chars.charCount, text.length);
      expect(
        metrics.chars.charCountWithoutSpaces,
        text.replaceAll(' ', '').length,
      );
      expect(
        metrics.chars.charCountWithoutWhitespace,
        text.replaceAll(RegExp(r'\s'), '').length,
      );
    });

    test('Contagem de letras, maiúsculas e minúsculas', () {
      expect(
        metrics.chars.letterCount,
        RegExp(r'[A-Za-zÀ-ÿ]').allMatches(text).length,
      );
      expect(
        metrics.chars.uppercaseCount,
        RegExp(r'[A-ZÀ-Ý]').allMatches(text).length,
      );
      expect(
        metrics.chars.lowercaseCount,
        RegExp(r'[a-zà-ÿ]').allMatches(text).length,
      );
    });

    test('Contagem de dígitos e símbolos', () {
      expect(metrics.chars.digitCount, 5);
      expect(
        metrics.chars.symbolCount,
        RegExp(r'[^\w\s]').allMatches(text).length,
      );
    });

    test('Palavras', () {
      expect(metrics.words.wordCount, metrics.words.words.length);
      expect(metrics.words.containsWord('teste'), isTrue);
      expect(metrics.words.countWord('teste'), 2);
    });

    test('Whitespace', () {
      expect(
        metrics.chars.whitespaceCount,
        RegExp(r'\s').allMatches(text).length,
      );
    });

    test('Vogais e consoantes', () {
      expect(
        metrics.vowels.vowelCount,
        RegExp(
          '([aeiouAEIOUáàâãéèêíìîóòôõúùûÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛ])',
        ).allMatches(text).length,
      );
      expect(
        metrics.vowels.consonantCount,
        RegExp(
          r'[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]',
        ).allMatches(text).length,
      );
    });

    test('Normalizações', () {
      expect(metrics.normalize.normalizedWhitespace.contains('\n'), isFalse);
      expect(
        metrics.normalize.withoutPunctuation.contains(RegExp(r'[^\w\s]')),
        isFalse,
      );
      expect(
        metrics.normalize.onlyLetters.contains(RegExp(r'[^A-Za-zÀ-ÿ]')),
        isFalse,
      );
      expect(
        metrics.normalize.normalizedAscii.contains(
          RegExp(r'[áàâãéèêíìîóòôõúùûç]'),
        ),
        isFalse,
      );
    });
  });
}
