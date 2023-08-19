import 'package:pos_app/dtos/objetos/obj-recebimentos.dart';
class ObjRecebimentosList {
  List<ObjRecebimentos>? objRecebimentosList;

  ObjRecebimentosList({
     this.objRecebimentosList,
  });

  factory ObjRecebimentosList.fromJson(List<dynamic> jsonList) {
    List<ObjRecebimentos> list = jsonList.map((json) => ObjRecebimentos.fromJson(json)).toList();
    return ObjRecebimentosList(
      objRecebimentosList: list,
    );
  }
}
