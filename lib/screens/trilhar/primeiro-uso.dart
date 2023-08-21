import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/001_login/new-login-page.dart';
 class PrimeiroUso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff376bb6)
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Lottie.asset('assets/New user sign up.json',
                            fit: BoxFit.cover,
                            )),
                      ),
                      const Text(textAlign: TextAlign.center,
                        'Vou criar uma \n nova conta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Opacity(
                        opacity: 0.5,
                        child: Text(textAlign: TextAlign.center,
                          'Descrição do título aqui',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navegar para o segundo caminho
                        },
                        child: Lottie.asset(
                          'assets/Relaxed Employee.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(textAlign: TextAlign.center,
                        'Sou um colaborador \n e tenho acesso',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Opacity(
                        opacity: 0.5,
                        child: Text(textAlign: TextAlign.center,
                          'Descrição do título aqui',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 800),
                              pageBuilder: (_, __, ___) => const NewLoginPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Lottie.asset('assets/User Interface.json'),
                      ),
                      const Text(textAlign: TextAlign.center,
                        'Já possuo conta, quero entrar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Opacity(
                        opacity: 0.5,
                        child: Text(textAlign: TextAlign.center,
                          'Descrição do título aqui',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}