import 'package:text_metrics/text_metrics.dart';

void main() {
  final text = '''
  Olá, mundo!
  Este é um exemplo de texto.

  Com linhas vazias e símbolos: @#\$%!
  ''';

  final metrics = TextMetrics(text);
print('Linhas totais: ${metrics.lines.lineCount}');
print('Linhas não vazias: ${metrics.lines.nonEmptyLineCount}');
print('Linhas vazias: ${metrics.lines.emptyLineCount}');
print('Maior linha: ${metrics.lines.longestLineLength}');
print('Menor linha (não vazia): ${metrics.lines.shortestNonEmptyLineLength}');

print('Sem pontuação: ${metrics.normalize.withoutPunctuation}');
print('Apenas letras: ${metrics.normalize.onlyLetters}');
print('Normalizado ASCII: ${metrics.normalize.normalizedAscii}');
}