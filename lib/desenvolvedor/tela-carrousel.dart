import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/app/app.dart';

class TelaComCarousel extends StatefulWidget {
  @override
  _TelaComCarouselState createState() => _TelaComCarouselState();
}

class _TelaComCarouselState extends State<TelaComCarousel> {
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
                            child: Lottie.asset(
                              'assets/astronaut.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'controle \ntotal\n',
                            style: TextStyle(
                              fontSize: 50,
                              backgroundColor: Colors.transparent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
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
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        OutraTela(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
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
    );
  }
}

class OutraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/login');
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset(
                    'assets/moon.json',
                    width: 300,
                    height: 300,
                  ),
                  Lottie.asset(
                    'assets/cloud-astronaut.json',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/spaceship.json',
                  width: 400,
                  height: 400,
                ),
                Lottie.asset(
                  'assets/monster.json',
                  width: 300,
                  height: 300,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
