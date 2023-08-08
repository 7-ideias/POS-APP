import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);


  static SizedBox getEspacamento() {
    return SizedBox( height: 12.00, );
  }
}