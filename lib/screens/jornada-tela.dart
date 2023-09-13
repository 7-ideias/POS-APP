import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../service/voltar_a_tela_de_encolha.dart';

class JornadaTela extends StatefulWidget {
  @override
  _JornadaTelaState createState() => _JornadaTelaState();
}

class _JornadaTelaState extends State<JornadaTela> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.7,
                width: screenWidth,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset(
                    'assets/dusk-forest-skyline-lo-fi.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.7,
                width: screenWidth,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset('assets/astronaut.json',fit: BoxFit.cover)
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(VariaveisGlobais.idiomaDto.frase1DeIntroducao.toString(),
                            style : GoogleFonts.bebasNeue(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/astronaut-floating.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(VariaveisGlobais.idiomaDto.frase2DeIntroducao.toString(),
                            style : GoogleFonts.bebasNeue(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/astronaut-floating-with-balloons.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            VariaveisGlobais.idiomaDto.frase3DeIntroducao.toString(),
                            style : GoogleFonts.bebasNeue(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/astronaut-with-space-shuttle.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            VariaveisGlobais.idiomaDto.frase4DeIntroducao.toString(),
                            style : GoogleFonts.bebasNeue(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Lottie.asset(
                                  'assets/astronaut-sitting-planet-waving-hand.json',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 16.0,
                                bottom: 16.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward,size: 60,),
                                    onPressed: () {
                                      voltarEscolha(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            VariaveisGlobais.idiomaDto.frase5DeIntroducao.toString(),
                            style : GoogleFonts.bebasNeue(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == i ? Colors.red : Colors.grey[300],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          if(_currentPage == 4) GestureDetector(
            onTap: (){
              voltarEscolha(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color:  Colors.red ,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              height: 50,
              width: 200,
              child: Center(child: Text('seguir',style: GoogleFonts.bebasNeue(fontSize: 25,color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}

class OutraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/login',arguments: 'usuario');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text('já tenho uma conta',style : GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/login',arguments: 'colaborador');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text('sou um colaborador',style : GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/login',arguments: 'novo');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text('sou novo.\nQuero uma conta',style : GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
