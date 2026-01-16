import 'package:test/test.dart';
import 'package:text_metrics/text_metrics.dart';
// ajuste o caminho para seu arquivo

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

    print(metrics.lineCount);

    test('Contagem de linhas', () {
      expect(metrics.lineCount, 8);
      expect(metrics.nonEmptyLineCount, 6);
      expect(metrics.emptyLineCount, 2);
      expect(metrics.lineAt(0), 'Olá, mundo!');
      expect(metrics.lineAt(100), isNull); // fora do range
    });

    test('Contagem de caracteres', () {
      expect(metrics.charCount, text.length);
      expect(metrics.charCountWithoutSpaces, text.replaceAll(' ', '').length);
      expect(
        metrics.charCountWithoutWhitespace,
        text.replaceAll(RegExp(r'\s'), '').length,
      );
    });

    test('Contagem de letras, maiúsculas e minúsculas', () {
      expect(
        metrics.letterCount,
        RegExp(r'[A-Za-zÀ-ÿ]').allMatches(text).length,
      );
      expect(
        metrics.uppercaseCount,
        RegExp(r'[A-ZÀ-Ý]').allMatches(text).length,
      );
      expect(
        metrics.lowercaseCount,
        RegExp(r'[a-zà-ÿ]').allMatches(text).length,
      );
    });

    test('Contagem de dígitos e símbolos', () {
      expect(metrics.digitCount, 5); // "12345"
      expect(metrics.symbolCount, RegExp(r'[^\w\s]').allMatches(text).length);
    });

    test('Palavras', () {
      expect(metrics.wordCount, metrics.words.length);
      expect(metrics.containsWord('teste'), isTrue);
      expect(metrics.countWord('teste'), 2);
    });

    test('Whitespace', () {
      expect(metrics.whitespaceCount, RegExp(r'\s').allMatches(text).length);
    });

    test('Vogais e consoantes', () {
      expect(
        metrics.vowelCount,
        RegExp(
          '([aeiouAEIOUáàâãéèêíìîóòôõúùûÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛ])',
        ).allMatches(text).length,
      );
      expect(
        metrics.consonantCount,
        RegExp(
          r'[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]',
        ).allMatches(text).length,
      );
    });

    test('Métricas derivadas', () {
      expect(
        metrics.averageWordsPerLine,
        metrics.wordCount / metrics.lineCount,
      );
      expect(
        metrics.averageCharsPerLine,
        metrics.charCount / metrics.lineCount,
      );
      expect(metrics.wordDensity, metrics.wordCount / metrics.charCount);
      expect(
        metrics.whitespaceRatio,
        metrics.whitespaceCount / metrics.charCount,
      );
    });

    test('Normalizações', () {
      expect(metrics.normalizedWhitespace.contains('\n'), isFalse);
      expect(metrics.withoutPunctuation.contains(RegExp(r'[^\w\s]')), isFalse);
      expect(metrics.onlyLetters.contains(RegExp(r'[^A-Za-zÀ-ÿ]')), isFalse);
      expect(
        metrics.normalizedAscii.contains(RegExp(r'[áàâãéèêíìîóòôõúùûç]')),
        isFalse,
      );
    });
  });
}
