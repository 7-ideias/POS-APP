import 'package:flutter/material.dart';

class ProdTela extends StatefulWidget {
  const ProdTela({Key? key}) : super(key: key);

  @override
  State<ProdTela> createState() => _ProdTelaState();
}

class _ProdTelaState extends State<ProdTela> {

  bool revelarFloats = true;

  @override
  void initState() {
    revelarFloats = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'produtos',
        textAlign: TextAlign.center,
      ))),
      floatingActionButton: revelarFloats == true? Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // Ação do botão
            },
            label: Text('novo produto'),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(height: 20,),
          FloatingActionButton.extended(
            onPressed: () {
              // Ação do botão
            },
            label: Text('filtros de pesquisa'),
            icon: Icon(Icons.search),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ) : null,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                color: Colors.indigoAccent,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  icon: Icon(Icons.search,)
                ),
                onTapOutside: (event) {
                  setState(() {
                    revelarFloats = true;
                  });
                },
                onTap: (){
                  setState(() {
                    revelarFloats = false;
                  });
                },
              ),
              Container(color: Colors.red, height: 50,),
              // Resto do conteúdo do ListView
            ],
          ),
        ],
      )
    );
  }
}
