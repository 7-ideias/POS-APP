import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

class Utils {
  static formataParaMoeda(double price) => '${VariaveisGlobais.moeda}${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);

  static SizedBox getEspacamento() {
    return const SizedBox( height: 12.00, );
  }
}