import '../dtos/usuario-dto.dart';

class VariaveisGlobais {
  static final String NOME_SISTEMA = 'POS';
  static final String NOVO_PRODUTO = 'novo produto';
  static final String minhaVariavel = 'Valor da minha variável';
  static final String endPoint = 'https://sixbackend-70ed1c73ebec.herokuapp.com';
  // static final String endPoint = 'http://192.168.1.107:8082';
  static const String PREFERENCIASDOUSUARIO = 'preferenciasDoUsuario';
  static UsuarioDto usuarioDto = UsuarioDto();
  static String? idUsuario = usuarioDto.id;
  static String? idColaborador = usuarioDto.objUser?.objEmpresa?.objColaborador?.id;

  static Map<String, String> headers() => {"Content-Type": "application/json","idUser":"{$idUsuario}","idColaborador":"{$idUsuario}"};
  static final headersGlobal = {'Content-Type': 'application/json','idUser': '{$idUsuario}','idColaborador': '{$idUsuario}'};
  static String idioma = "ingles";

  static double converterMoedaEmDoble(String aConverter){
    aConverter.isEmpty ? aConverter = "0.00" : aConverter;
    return double.parse(aConverter.replaceAll(RegExp('[^0-9]'), '')) / 100;
  }
}