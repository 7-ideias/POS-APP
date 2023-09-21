
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pos_app/screens/TelaTeste.dart';

import '../controller/app_controller.dart';
import 'VariaveisGlobais.dart';

bool dark = false;
bool isDartTheme = AppController.instance.isDartTheme;


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
        child: Card(
          color: AppController.instance.isDartTheme ? AppController.instance.corPrincipal : AppController.instance.corTelaAcima,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.06,
                        decoration: BoxDecoration(
                            color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(
                            'Selecione uma cor',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      color: Colors.transparent,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                AppController.instance.isDartTheme = !AppController.instance.isDartTheme; // Inverte o valor ao tocar
                                if (AppController.instance.isDartTheme) {
                                  AppController.instance.mudarCores(!dark);// Altera o tema
                                } else {
                                  AppController.instance.mudarCores(dark);
                                }// Fecha o modal após a alteração
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                margin: EdgeInsets.only(top: 10),
                                height: 60,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  color: AppController.instance.isDartTheme ? Color(0xFF423966) : Color(0xFF9EE3FB),
                                ),
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      duration: Duration(milliseconds: 500),
                                      top: 12,
                                      left: AppController.instance.isDartTheme ? 10 : 50, // Lua à esquerda, sol à direita
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppController.instance.isDartTheme ? Colors.white : Color(0xFF9EE3FB),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 5,
                                              spreadRadius: 0,
                                              color: Color(0xFFD9FBFF),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          AppController.instance.isDartTheme ? Icons.brightness_3 : Icons.wb_sunny,
                                          size: 30,
                                          color: AppController.instance.isDartTheme ? Colors.grey : Colors.yellow,
                                        ).animate(onPlay: (controller) => controller.repeat(),)
                                            .moveY(begin: -2.8, end: 0.5, curve: Curves.easeInOut, duration: 1500.milliseconds)
                                            .then()
                                            .moveY(begin: 0.5, end: -2.8, curve: Curves.easeInOut),

                                      ).animate(onPlay: (controller) => controller.repeat(),)
                                          .moveY(begin: -2.8, end: 0.5, curve: Curves.easeInOut, duration: 1500.milliseconds)
                                          .then()
                                          .moveY(begin: 0.5, end: -2.8, curve: Curves.easeInOut),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                          color: AppController.instance.isDartTheme ? AppController.instance.corPrincipal.shade800 : AppController.instance.corTelaAcima,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                AppController.instance.corPrincipal = Colors.cyan;
                                AppController.instance.mudarCores(dark);
                              },
                              child: CircleAvatar(
                                maxRadius: 30,
                                backgroundColor: Colors.cyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.65,
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                      color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Selecione uma fonte',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                        ),
                        child: Center(
                          child: Text(
                            'PlayfairDisplay',
                            style:
                            TextStyle(fontSize: 25, fontFamily: 'PlayfairDisplay'),
                          ),
                        ),
                      ),
                      onTap: () => AppController.instance.mudaFonte('PlayfairDisplay'),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                        ),
                        child: Center(
                          child: Text(
                            'Montserrat',
                            style:
                            TextStyle(fontSize: 25, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                      onTap: () => AppController.instance.mudaFonte('Montserrat'),
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
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                        ),
                        child: Center(
                          child: Text(
                            'Roboto',
                            style:
                            TextStyle(fontSize: 25, fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                      onTap: () => AppController.instance.mudaFonte('Roboto'),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppController.instance.isDartTheme ? Colors.white24 : Color(0xfffe3e3e3),
                        ),
                        child: Center(
                          child: Text(
                            'Caprasimo',
                            style:
                                TextStyle(fontSize: 25, fontFamily: 'Caprasimo'),
                          ),
                        ),
                      ),
                      onTap: () => AppController.instance.mudaFonte('Caprasimo'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
