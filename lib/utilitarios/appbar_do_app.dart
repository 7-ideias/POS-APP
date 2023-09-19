
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
    ),
  );
}

Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          border: Border.all(color: Colors.transparent), // Definindo a borda como transparente
        ),
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
                  child: Text('tema ', style: TextStyle()),
                ),
                Switch(
                  value: AppController.instance.isDartTheme,
                  activeColor: Colors.green,
                  onChanged: (bool value) {
                    dark = value;
                    AppController.instance.mudarCores(value);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Escolha a cor do app ', style: TextStyle()),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
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
                //cor verde
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AppController.instance.corPrincipal = Colors.green;
                      AppController.instance.mudarCores(dark);
                    },
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                //cor pink
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AppController.instance.corPrincipal = Colors.pink;
                      AppController.instance.mudarCores(dark);
                    },
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.pink,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'PlayfairDisplay',
                          style:
                          TextStyle(fontSize: 25, fontFamily: 'PlayfairDisplay'),
                        ),
                      ),
                    ),
                    onTap: () => AppController.instance.fonte = 'PlayfairDisplay',
                  ),
                  GestureDetector(
                    child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Montserrat',
                          style:
                          TextStyle(fontSize: 25, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    onTap: () => AppController.instance.fonte = 'Montserrat',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Roboto',
                          style:
                          TextStyle(fontSize: 25, fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    onTap: () => AppController.instance.fonte = 'Roboto',
                  ),
                  GestureDetector(
                    child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Caprasimo',
                          style:
                              TextStyle(fontSize: 25, fontFamily: 'Caprasimo'),
                        ),
                      ),
                    ),
                    onTap: () => AppController.instance.fonte = 'Caprasimo',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
