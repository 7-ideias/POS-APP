import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';

class NovoColaborador extends StatelessWidget {
  const NovoColaborador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(color: AppController.instance.corLetras),
            'Novo colaborador'),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                color: AppController.instance.corPrincipal,
                child: Image.asset('assets/employee-data-folder.png'),
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.22,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.09,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height*0.155 /1.8,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.1,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height*0.155 / 2,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/male-profile-picture.png'),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.13,
                child: GestureDetector(
                  child: Lottie.asset(
                      height: MediaQuery.of(context).size.height*0.155 / 1.5,
                      'assets/instagram-camera.json'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
