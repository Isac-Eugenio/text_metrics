import 'package:text_metrics/text_metrics.dart';

class TextWordMetrics {
  final TextMetricsBase base;
  TextWordMetrics(this.base);

  /// Lista de palavras (separadas por qualquer whitespace)
  List<String> get words => base.data.trim().isEmpty
      ? const []
      : base.data.trim().split(RegExp(r'\s+'));

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
    return pattern.allMatches(base.data).length;
  }

  /// Verifica se o texto contém determinada palavra
  bool containsWord(String word) => countWord(word) > 0;

  /// Retorna a maior palavra (pelo tamanho)
  String? get longestWord {
    if (words.isEmpty) return null;
    return words.reduce((current, next) {
      return next.length > current.length ? next : current;
    });
  }

  /// Retorna a menor palavra (pelo tamanho)
  String? get shortestWord {
    if (words.isEmpty) return null;
    return words.reduce((current, next) {
      return next.length < current.length ? next : current;
    });
  }
}
