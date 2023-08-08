
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;
import 'package:pos_app/app/page/pdf_view_page.dart';

reportView(context) async {
  final Document pdf = Document();

  pdf.addPage(MultiPage(
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
                border:
                Border.all(width: 0.5, color: PdfColors.grey)),
            child: Text('Report',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
            level: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('RELATORIO', textScaleFactor: 2),
                  PdfLogo()
                ])),
        Header(level: 1, text: 'Texto no header RR\$'),
        Paragraph(
            text:
            'BLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLABLA BLA'),
        Padding(padding: const EdgeInsets.all(10)),
        Table.fromTextArray(context: context, data: const <List<String>>[
          <String>['Year', 'Ipsum', 'Lorem'],
          <String>['2000', 'Ipsum 1.0', 'Lorem 1'],
          <String>['2001', 'Ipsum 1.1', 'Lorem 2'],
        ]),
      ]));

  //save PDF

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
