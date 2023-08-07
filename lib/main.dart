import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/page/pdf_page.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Invoice';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            textTheme: GoogleFonts.lobsterTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.deepOrange
        ),
        home: PdfPage(),
      );
}
