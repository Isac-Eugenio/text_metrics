# text_metrics

Uma biblioteca Dart para análise e métricas de texto, oferecendo contagem de linhas, palavras, caracteres, vogais, consoantes, normalizações e muito mais — tudo com uma API simples e eficiente.

---

## 🚀 Features

- 📄 Contagem de **linhas**, **linhas vazias** e **linhas não vazias**
- 🔤 Contagem de **caracteres**, **letras**, **dígitos**, **símbolos**
- 📝 Contagem de **palavras**, **frequência de palavras** e busca por palavras
- 🔤 Contagem de **vogais** e **consoantes**
- 📊 Métricas derivadas como:
  - média de palavras por linha
  - média de caracteres por linha
  - densidade de palavras
  - proporção de whitespace
- 🧼 Normalizações úteis:
  - remover pontuação
  - manter apenas letras
  - normalizar acentos para ASCII
  - normalizar espaços

---

## 📦 Getting started

### Requisitos

- Dart >= 2.18  
- Compatível com projetos Dart e Flutter

### Instalação

No arquivo `pubspec.yaml`:

```yaml
dependencies:
  text_metrics:
    git:
      url: https://github.com/seu-usuario/text_metrics.git
