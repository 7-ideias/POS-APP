import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PdfView(
        path: path,
      ),
    );
  }
}