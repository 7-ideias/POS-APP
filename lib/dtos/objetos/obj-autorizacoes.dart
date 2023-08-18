import '../feitoObjetos/obj-assistencia-tecnica-pode.dart';
import 'obj-clientes-pode.dart';
import 'obj-lancamentos-financeiros-pode.dart';
import 'obj-produtos-pode.dart';
import 'obj-relatorios-pode.dart';
import 'obj-vendas-pode.dart';

class ObjAutorizacoes {
  bool? podeFazerDevolucao;
  bool? podeCadastrarProduto;
  ObjProdutosPode? objProdutosPode;
  ObjVendasPode? objVendasPode;
  ObjAssistenciaTecnicaPode? objAssistenciaTecnicaPode;
  ObjClientesPode? objClientesPode;
  ObjRelatoriosPode? objRelatoriosPode;
  ObjLancamentosFinanceirosPode? objLancamentosFinanceirosPode;

  ObjAutorizacoes.fromJson(Map<String, dynamic> json) {
    podeFazerDevolucao =
        json['podeFazerDevolucao'] != null ? json['podeFazerDevolucao'] : null;
    podeCadastrarProduto = json['podeCadastrarProduto'] != null
        ? json['podeCadastrarProduto']
        : null;
    objProdutosPode =
        json['objProdutosPode'] != null ? json['objProdutosPode'] : null;
    objVendasPode =
        json['objVendasPode'] != null ? json['objVendasPode'] : null;
    objAssistenciaTecnicaPode = json['objAssistenciaTecnicaPode'] != null
        ? json['objAssistenciaTecnicaPode']
        : null;
    objClientesPode =
        json['objClientesPode'] != null ? json['objClientesPode'] : null;
    objRelatoriosPode =
        json['objRelatoriosPode'] != null ? json['objRelatoriosPode'] : null;
    objLancamentosFinanceirosPode =
        json['objLancamentosFinanceirosPode'] != null
            ? json['objLancamentosFinanceirosPode']
            : null;
  }
}