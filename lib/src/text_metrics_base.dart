import 'package:text_metrics/src/text_char_metrics.dart';
import 'package:text_metrics/src/text_lines_metrics.dart';
import 'package:text_metrics/src/text_vowel_consonant_metrics';
import 'package:text_metrics/src/text_words_metrics.dart';

/// Text Metrics
/// Domínio completo de análise de texto em Dart
sealed class TextMetricsBase {
  final String data;

  /// Construtor padrão (não faz normalização)
  TextMetricsBase(this.data);
}

final class TextMetrics extends TextMetricsBase {
  TextMetrics(super.data);

  TextLinesMetrics get lines => TextLinesMetrics(this);
  TextCharMetrics get chars => TextCharMetrics(this);
  TextWordMetrics get words => TextWordMetrics(this);
  TextVowelConsonantMetrics get vowels => TextVowelConsonantMetrics(this);
  TextNormalizationMetrics get normalize => TextNormalizationMetrics(this);

  /// Média de palavras por linha
  double get averageWordsPerLine =>
      lines.lineCount == 0 ? 0 : words.wordCount / lines.lineCount;

  /// Média de caracteres por linha
  double get averageCharsPerLine =>
      lines.lineCount == 0 ? 0 : chars.charCount / lines.lineCount;

  /// Densidade de palavras em relação ao total de caracteres
  double get wordDensity =>
      chars.charCount == 0 ? 0 : words.wordCount / chars.charCount;

  /// Proporção de espaços em relação ao total de caracteres
  double get whitespaceRatio =>
      chars.charCount == 0 ? 0 : chars.whitespaceCount / chars.charCount;
}
