import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

class Utils {

  static formataParaMoeda(double price) => '${VariaveisGlobais.moeda}${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);

  static SizedBox getEspacamento() {
    return const SizedBox( height: 12.00, );
  }

  static String converterData(String dataString) {
    DateTime data = DateTime.parse(dataString);
    DateFormat formato = DateFormat('dd/MM/yyyy');
    return formato.format(data);
  }

  static String exibicaoDeData(
      DateTime dataASerConvertidaEmStringParaExibicao) {
    String dia =
        dataASerConvertidaEmStringParaExibicao.day.toString().length == 1
            ? '0${dataASerConvertidaEmStringParaExibicao.day}'
            : dataASerConvertidaEmStringParaExibicao.day.toString();
    String mes =
        dataASerConvertidaEmStringParaExibicao.month.toString().length == 1
            ? '0${dataASerConvertidaEmStringParaExibicao.month}'
            : dataASerConvertidaEmStringParaExibicao.month.toString();
    return '$dia/$mes/${dataASerConvertidaEmStringParaExibicao.year}';
  }

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