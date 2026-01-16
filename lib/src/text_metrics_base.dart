/// Text Metrics
/// Domínio completo de análise de texto em Dart
sealed class TextMetricsBase {
  final String data;

  /// Construtor padrão (não faz normalização)
  TextMetricsBase(this.data);

  /* =====================================================
   *  INTERNAL HELPERS
   * ===================================================== */

  /// Retorna todas as linhas do texto, incluindo vazias
  /// Remove apenas a última linha se estiver vazia
  List<String> get _lines {
    if (data.isEmpty) return const [];

    final lines = data.split('\n');

    if (lines.isNotEmpty && lines.last.isEmpty) {
      return lines.sublist(0, lines.length - 1);
    }

    return lines;
  }

  /// Retorna apenas linhas que não estão vazias (ignora espaços)
  List<String> get nonEmptyLines =>
      _lines.where((l) => l.trim().isNotEmpty).toList();

  /// Quantidade total de linhas, incluindo vazias
  int get lineCount => _lines.length;

  /// Quantidade de linhas que possuem conteúdo
  int get nonEmptyLineCount => nonEmptyLines.length;

  /// Quantidade de linhas vazias
  int get emptyLineCount => (lineCount - nonEmptyLineCount).abs();

  /// Quantidade de linhas considerando remoção da última linha vazia
  int get lineCountTrimmed => _lines.isNotEmpty && _lines.last.isEmpty
      ? _lines.length - 1
      : _lines.length;

  /// Retorna a linha pelo índice (null-safe)
  /// Retorna null se o índice estiver fora do intervalo
  String? lineAt(int index) {
    if (index < 0 || index >= _lines.length) return null;
    return _lines[index];
  }

  /* =====================================================
   *  CARACTERES
   * ===================================================== */

  /// Quantidade total de caracteres, incluindo espaços e quebras de linha
  int get charCount => data.length;

  /// Quantidade de caracteres excluindo espaços simples
  int get charCountWithoutSpaces => data.replaceAll(' ', '').length;

  /// Quantidade de caracteres excluindo todos os whitespaces (\t, \n, \r, etc.)
  int get charCountWithoutWhitespace =>
      data.replaceAll(RegExp(r'\s'), '').length;

  /// Quantidade de letras (considera letras acentuadas)
  int get letterCount => RegExp(r'[A-Za-zÀ-ÿ]').allMatches(data).length;

  /// Quantidade de letras maiúsculas
  int get uppercaseCount => RegExp(r'[A-ZÀ-Ý]').allMatches(data).length;

  /// Quantidade de letras minúsculas
  int get lowercaseCount => RegExp(r'[a-zà-ÿ]').allMatches(data).length;

  /// Quantidade de dígitos (0-9)
  int get digitCount => RegExp(r'\d').allMatches(data).length;

  /// Quantidade de símbolos (qualquer caractere não alfanumérico nem espaço)
  int get symbolCount => RegExp(r'[^\w\s]').allMatches(data).length;

  /// Conta ocorrências de um caractere específico
  int countChar(String char) {
    if (char.length != 1) {
      throw ArgumentError('char deve conter apenas um caractere');
    }
    return RegExp(RegExp.escape(char)).allMatches(data).length;
  }

  /// Conta ocorrências de qualquer caractere presente no conjunto fornecido
  int countChars(Set<String> chars) {
    if (chars.isEmpty) return 0;
    final pattern = chars.map(RegExp.escape).join();
    return RegExp('[$pattern]').allMatches(data).length;
  }

  /// Frequência de cada caractere no texto
  Map<String, int> get charFrequency {
    final map = <String, int>{};
    for (final c in data.split('')) {
      map[c] = (map[c] ?? 0) + 1;
    }
    return map;
  }

  /* =====================================================
   *  LINHAS
   * ===================================================== */

  /// Comprimento da linha mais longa
  int get longestLineLength =>
      _lines.fold(0, (max, l) => l.length > max ? l.length : max);

  /// Comprimento da linha não vazia mais curta
  int get shortestNonEmptyLineLength {
    final lines = nonEmptyLines;
    if (lines.isEmpty) return 0;
    return lines.fold(
      lines.first.length,
      (min, l) => l.length < min ? l.length : min,
    );
  }

  /// Retorna o texto sem linhas vazias
  String get withoutEmptyLines => nonEmptyLines.join('\n');

  /// Retorna o texto com linhas já aparadas (trim) de espaços
  String get trimmedLines => _lines.map((l) => l.trim()).join('\n');

  /* =====================================================
   *  PALAVRAS
   * ===================================================== */

  /// Lista de palavras (separadas por qualquer whitespace)
  List<String> get words =>
      data.trim().isEmpty ? const [] : data.trim().split(RegExp(r'\s+'));

  /// Quantidade de palavras no texto
  int get wordCount => words.length;

  /// Frequência de cada palavra no texto
  Map<String, int> get wordFrequency {
    final map = <String, int>{};
    for (final word in words) {
      map[word] = (map[word] ?? 0) + 1;
    }
    return map;
  }

  /// Conta a ocorrência de uma palavra específica
  /// Pode ser sensível ou insensível a maiúsculas/minúsculas
  int countWord(String word, {bool caseSensitive = false}) {
    if (word.isEmpty) return 0;
    final pattern = RegExp(
      r'\b' + RegExp.escape(word) + r'\b',
      caseSensitive: caseSensitive,
      unicode: true,
    );
    return pattern.allMatches(data).length;
  }

  /// Verifica se o texto contém determinada palavra
  bool containsWord(String word) => countWord(word) > 0;

  /* =====================================================
   *  ESPAÇOS / WHITESPACE
   * ===================================================== */

  /// Quantidade de espaços em branco (\t, \n, espaços etc.)
  int get whitespaceCount => RegExp(r'\s').allMatches(data).length;

  /* =====================================================
   *  VOGAIS / CONSOANTES
   * ===================================================== */

  /// Conjunto de vogais (maiúsculas, minúsculas e acentuadas)
  static const _vowels = 'aeiouAEIOUáàâãéèêíìîóòôõúùûÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛ';

  /// Conta o número de vogais no texto
  int get vowelCount => RegExp('[$_vowels]').allMatches(data).length;

  /// Conta o número de consoantes no texto
  int get consonantCount => RegExp(
    r'[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]',
  ).allMatches(data).length;

  /* =====================================================
   *  MÉTRICAS DERIVADAS
   * ===================================================== */

  /// Média de palavras por linha
  double get averageWordsPerLine => lineCount == 0 ? 0 : wordCount / lineCount;

  /// Média de caracteres por linha
  double get averageCharsPerLine => lineCount == 0 ? 0 : charCount / lineCount;

  /// Densidade de palavras em relação ao total de caracteres
  double get wordDensity => charCount == 0 ? 0 : wordCount / charCount;

  /// Proporção de espaços em relação ao total de caracteres
  double get whitespaceRatio =>
      charCount == 0 ? 0 : whitespaceCount / charCount;

  /* =====================================================
   *  NORMALIZAÇÃO / LIMPEZA
   * ===================================================== */

  /// Normaliza todos os espaços, removendo múltiplos espaços e trims
  String get normalizedWhitespace =>
      data.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Remove pontuação
  String get withoutPunctuation => data.replaceAll(RegExp(r'[^\w\s]'), '');

  /// Retorna apenas letras, removendo dígitos, símbolos e espaços
  String get onlyLetters => data.replaceAll(RegExp(r'[^A-Za-zÀ-ÿ]'), '');

  /// Normaliza acentos para ASCII (minúsculas e cedilha)
  String get normalizedAscii => data
      .toLowerCase()
      .replaceAll(RegExp(r'[áàâã]'), 'a')
      .replaceAll(RegExp(r'[éèê]'), 'e')
      .replaceAll(RegExp(r'[íìî]'), 'i')
      .replaceAll(RegExp(r'[óòôõ]'), 'o')
      .replaceAll(RegExp(r'[úùû]'), 'u')
      .replaceAll(RegExp(r'ç'), 'c');
}

/// Implementação concreta
final class TextMetrics extends TextMetricsBase {
  TextMetrics(super.data);
}
