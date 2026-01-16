import 'package:text_metrics/text_metrics.dart';

class TextCharMetrics {
  final TextMetricsBase base;
  TextCharMetrics(this.base);

  /// Quantidade total de caracteres, incluindo espaços e quebras de linha
  int get charCount => base.data.length;

  /// Quantidade de caracteres excluindo espaços simples
  int get charCountWithoutSpaces => base.data.replaceAll(' ', '').length;

  /// Quantidade de caracteres excluindo todos os whitespaces (\t, \n, \r, etc.)
  int get charCountWithoutWhitespace =>
      base.data.replaceAll(RegExp(r'\s'), '').length;

  /// Quantidade de letras (considera letras acentuadas)
  int get letterCount => RegExp(r'[A-Za-zÀ-ÿ]').allMatches(base.data).length;

  /// Quantidade de letras maiúsculas
  int get uppercaseCount => RegExp(r'[A-ZÀ-Ý]').allMatches(base.data).length;

  /// Quantidade de letras minúsculas
  int get lowercaseCount => RegExp(r'[a-zà-ÿ]').allMatches(base.data).length;

  /// Quantidade de dígitos (0-9)
  int get digitCount => RegExp(r'\d').allMatches(base.data).length;

  /// Quantidade de símbolos (qualquer caractere não alfanumérico nem espaço)
  int get symbolCount => RegExp(r'[^\w\s]').allMatches(base.data).length;

  /// Conta ocorrências de um caractere específico
  int countChar(String char) {
    if (char.length != 1) {
      throw ArgumentError('char deve conter apenas um caractere');
    }
    return RegExp(RegExp.escape(char)).allMatches(base.data).length;
  }

  /// Conta ocorrências de qualquer caractere presente no conjunto fornecido
  int countChars(Set<String> chars) {
    if (chars.isEmpty) return 0;
    final pattern = chars.map(RegExp.escape).join();
    return RegExp('[$pattern]').allMatches(base.data).length;
  }

  /// Frequência de cada caractere no texto
  Map<String, int> get charFrequency {
    final map = <String, int>{};
    for (final c in base.data.split('')) {
      map[c] = (map[c] ?? 0) + 1;
    }
    return map;
  }

  /// Quantidade de espaços em branco (\t, \n, espaços etc.)
  int get whitespaceCount => RegExp(r'\s').allMatches(base.data).length;
}
