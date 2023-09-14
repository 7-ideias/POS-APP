import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';

import '../dtos/obj-idioma.dart';
import '../dtos/operacao-dto-nova.dart';
import '../dtos/produto-dto.dart';
import '../dtos/push-dto.dart';
import '../dtos/usuario-dto.dart';

class VariaveisGlobais {
  static const String NOME_SISTEMA = 'SIX POS';
  static const String NOVO_PRODUTO = 'novo produto';
  static final String minhaVariavel = 'Valor da minha variável';
  // static final String endPoint = 'https://sixbackend-70ed1c73ebec.herokuapp.com';
  static final String endPoint = 'http://192.168.1.113:8082'; //qintess
  // static final String endPoint = 'http://192.168.1.107:8082'; //hp
  static const String PREFERENCIASDOUSUARIO = 'preferenciasDoUsuario';//é o nome da chave do objeto salvo em memoria
  static const String IDIOMADOAPP = 'idiomaDoApp';//é o nome da chave do objeto salvo em memoria
  static String tipoTitularOuColaborador = 'VAZIO';//nao apague
  static UsuarioDto usuarioDto = UsuarioDto(tipoTitularOuColaborador: tipoTitularOuColaborador);
  static IdiomaDto idiomaDto = IdiomaDto();
  static String? idDeQuemEstaCadastrando = usuarioDto.idUsuario;
  static String moeda = 'R\$ ';
  // static String? moeda = usuarioDto.objPreferenciasDoAppRefleteParaTodosOsUsuarios?.moedaPadraoDoAppParaRelatoriosEComprovantes;


  static List<ProdutoDto> produtoList = [];
  static List<PushDto> pushList = [];
  static OperacoesDoBackEnd operacoesBackEnd = OperacoesDoBackEnd();

  static Map<String, String> headers() => {"Content-Type": "application/json","idUser":"{$idDeQuemEstaCadastrando}","idColaborador":"{$idDeQuemEstaCadastrando}"};
  static final headersGlobal = {'Content-Type': 'application/json','idUser': '{$idDeQuemEstaCadastrando}','idColaborador': '{$idDeQuemEstaCadastrando}'};
  static String idioma = "ingles";


  static String converterMoedaEmDoble(String valorString){
    if (!valorString.contains(',')) {
      return valorString;
    }
    valorString.isEmpty ? valorString = "0,0" : valorString;
    valorString = valorString.replaceAll('R', '').replaceAll(' ', '').replaceAll('\$', '');
    NumberFormat formatador = NumberFormat("#,##0.00", "pt_BR");
    num valor = formatador.parse(valorString);
    return valor.toString();
  }


}