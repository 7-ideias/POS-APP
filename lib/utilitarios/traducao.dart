class Traducao {
  static String retornaPalavra(String palavra, String configuracao) {
    Map<String, dynamic> payload = {
      "configuração": {
        "pt": "configuração",
        "ingles": "setting"
      },
      "Tela Inicial": {
        "pt": "Tela Inicial",
        "ingles": "Main Screen"
      }
    };
    if (payload.containsKey(palavra) && payload[palavra].containsKey(configuracao)) {
      return payload[palavra][configuracao];
    } else {
      return palavra;
    }
  }
}