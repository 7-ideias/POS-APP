class VariaveisGlobais {
  static final String NOME_SISTEMA = 'POS';
  static final String minhaVariavel = 'Valor da minha variável';
  static final String endPoint = 'https://sixbackend-70ed1c73ebec.herokuapp.com';
  // static final String endPoint = 'http://localhost:8081';

  static Map<String, String> headers() => {"Content-Type": "application/json"};
  static final headersGlobal = {'Content-Type': 'application/json','idUser': 'appPOS'};
  static String idioma = "ingles";
}