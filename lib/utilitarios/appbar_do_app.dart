
import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import 'VariaveisGlobais.dart';

bool dark = false;

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    actions: [
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.settings,
            color: AppController.instance.corLetras,
            size: 35,
          ),
        ),
        onTap: () {
          buildShowModalBottomSheet(context);
        },
      ),
    ],
    title: Text(
      VariaveisGlobais.NOME_SISTEMA,
      style: TextStyle(color: AppController.instance.corLetras),
    ),
  );
}

Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 10,
                    width: 60,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('tema ',style: TextStyle()),
                ),
                Switch(
                  value: AppController.instance.isDartTheme,
                  activeColor: Colors.red,
                  onChanged: (bool value) {
                    dark = value;
                    AppController.instance.mudarCores(value);
                  },
                )

              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Escolha a cor do app ',style: TextStyle()),
                ),
                //cor azul
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AppController.instance.corPrincipal = Colors.indigo;
                      AppController.instance.mudarCores(dark);
                    },
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.indigo,
                    ),
                  ),
                ),
                //cor purple
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AppController.instance.corPrincipal = Colors.purple;
                      AppController.instance.mudarCores(dark);
                    },
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.purple,
                    ),
                  ),
                ),
                //cor laranja
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AppController.instance.corPrincipal = Colors.orange;
                      AppController.instance.mudarCores(dark);
                    },
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
