import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class Leitor extends StatefulWidget {
  const Leitor({Key? key}) : super(key: key);
  @override
  State<Leitor> createState() => _LeitorState();
}
class _LeitorState extends State<Leitor> {

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) =>
            Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('result ' + result),
                  ElevatedButton(onPressed: scan, child:
                  Text('scanear')
                  )
                ],
              ),
            ),

      ),
    );
  }

  Future<void> scan() async {
    String barCode = 'XXXXX';
    // try {
    //   barCode = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'cancelar', true, ScanMode.BARCODE);
    // } on PlatformException {
    //   barCode = 'falhou';
    // }
    if (!mounted) return;
    setState(() {
      result = barCode;
    });
  }

}
