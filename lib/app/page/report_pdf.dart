import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pos_app/app/page/pdf_view_page.dart';
import '../../dtos/objetos/obj-venda-e-servico.dart';
import '../../dtos/operacao-dto-nova.dart';
import '../../utilitarios/utils.dart';

reportView(context, int index, Ops? operacao) async {
  final Document pdf = Document();

  paginaDeVenda(pdf, index, operacao);

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);

  await file.writeAsBytes(await pdf.save());

  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}

void paginaDeVenda(Document pdf, int index, Ops? operacao) {
  List<ObjVendaEServico>? opsList = operacao?.vendaList;
  List<Map<String, dynamic>> data = [];
  if (opsList != null) {
    data = opsList.map((venda) {
      return {
        'código': venda.codigoDeBarras,
        'descrição do produto': venda.descricaoProduto,
        'quantidade': venda.qt,
        'valor unitário': venda.vlUnitario,
        'valor total': venda.vlTotal
      };
    }).toList();
  }

  double sum = 0.0;
  data.forEach((row) {
    sum += row['valor total'];
  });

  List<List<dynamic>> tableData = [];
  tableData.add(data[0].keys.toList()); // Adiciona a primeira linha com os nomes das colunas

  data.forEach((row) {
    tableData.add(row.values.toList());
  });

  tableData.add(['', '', '', '', sum]);

  pdf.addPage(
    MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: CrossAxisAlignment.start,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return SizedBox();
          }

          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: PdfColors.grey)),
              child: Text('Comprovante',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        footer: (Context context) {
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: Text(
                  'Página ${context.pageNumber} de ${context.pagesCount}',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (Context context) {
          return vendaList(operacao, context, tableData);
        }),
  );
}

List<Widget> vendaList(
    Ops? operacao, Context context, List<List<dynamic>> tableData) {
  return <Widget>[
    Center(child: Text('SUA LOJA')),
    Divider(),
    SizedBox(height: 5),
    Center(
      child: Text('DOCUMENTO AUXILIAR DE VENDA'),
    ),
    SizedBox(height: 5),
    Text('ENDERECO: RUA BERNARDINO RAMOS 285'),
    SizedBox(height: 5),
    Text('CNPJ: 27111222000109 - INSCRICAO: ISENTO'),
    SizedBox(height: 5),
    Text('CONTATO: 35992736863 - carlos@seteideias.com.br'),
    Divider(),
    SizedBox(height: 20),
    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text('ordem - '),
      Text('${operacao!.codigoProprioDaOperacao}',
          style: TextStyle(fontWeight: FontWeight.bold)),
    ]),
    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text('data - '),
      Text(
          Utils.converterData(
              operacao.objInformacoesDoCadastro!.dataCadastro.toString()),
          style: TextStyle(fontWeight: FontWeight.bold)),
    ]),
    Paragraph(text: 'CLIENTE'),
    Padding(padding: const EdgeInsets.all(10)),
    TableHelper.fromTextArray(context: context, data: tableData),
    SizedBox(height: 20),
    SizedBox(height: 5),
    Positioned(
      right: 0,
      child: BarcodeWidget(
        drawText: false,
        barcode: Barcode.qrCode(),
        data: operacao!.codigoProprioDaOperacao.toString(),
        // width: 200,
        height: 50,
      ),
    ),
  ];
}
