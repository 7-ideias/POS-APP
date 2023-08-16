import '../dtos/usuario-dto.dart';

class VariaveisGlobais {
  static final String NOME_SISTEMA = 'POS';
  static final String NOVO_PRODUTO = 'novo produto';
  static final String minhaVariavel = 'Valor da minha variável';
  static final String endPoint = 'https://sixbackend-70ed1c73ebec.herokuapp.com';
  // static final String endPoint = 'http://localhost:8082';
  static const String PREFERENCIASDOUSUARIO = 'preferenciasDoUsuario';
  static UsuarioDto usuarioDto = UsuarioDto();
  static String? idUsuario = usuarioDto.id;

  static Map<String, String> headers() => {"Content-Type": "application/json","idUser":"{$idUsuario}","idColaborador":"{$idUsuario}"};
  static final headersGlobal = {'Content-Type': 'application/json','idUser': '{$idUsuario}','idColaborador': '{$idUsuario}'};
  static String idioma = "ingles";
}