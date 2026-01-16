import 'package:text_metrics/text_metrics.dart';

void main() {
  final text = '''
  Olá, mundo!
  Este é um exemplo de texto.

  Com linhas vazias e símbolos: @#\$%!
  ''';

  final metrics = TextMetrics(text);

  print('Linhas totais: ${metrics.lineCount}');
  print('Linhas não vazias: ${metrics.nonEmptyLineCount}');
  print('Linhas vazias: ${metrics.emptyLineCount}');
  print('Maior linha: ${metrics.longestLineLength}');
  print('Menor linha (não vazia): ${metrics.shortestNonEmptyLineLength}');
  print('Sem pontuação: ${metrics.withoutPunctuation}');
  print('Apenas letras: ${metrics.onlyLetters}');
  print('Normalizado ASCII: ${metrics.normalizedAscii}');
}
