import 'package:text_metrics/text_metrics.dart';

class TextLinesMetrics {
  final TextMetricsBase base;
  TextLinesMetrics(this.base);

  /// Retorna todas as linhas do texto, incluindo vazias
  /// Remove apenas a última linha se estiver vazia
  List<String> get _lines {
    if (base.data.isEmpty) return const [];

    final lines = base.data.split('\n');

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
}
