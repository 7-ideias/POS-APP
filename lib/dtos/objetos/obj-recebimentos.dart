import 'obj-grana.dart';

class ObjRecebimentos {
  String? data;
  String? idDeQuemRegistrou;
  ObjGrana? objGrana;

  ObjRecebimentos.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? json['data'] : null;
    idDeQuemRegistrou =
        json['idDeQuemRegistrou'] != null ? json['idDeQuemRegistrou'] : null;
    objGrana = json['objGrana'] != null ? json['objGrana'] : null;
  }
}