import 'package:flutter/material.dart';

class ConfiguracoesTela extends StatefulWidget {

  @override
  State<ConfiguracoesTela> createState() => _ConfiguracoesTelaState();
}

class _ConfiguracoesTelaState extends State<ConfiguracoesTela> {

  bool detalhes = false;

  bool realizarVendas = false;

  bool semEsqoeu = false;

  bool relaizarOrdensDeServico = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuracoes'),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  permite realizar vendas',
                          style: TextStyle(fontSize: 20)),
                      Switch(
                        value: realizarVendas,
                        onChanged: (bool value) {
                          setState(() {
                            realizarVendas = !realizarVendas;
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                mostrarDetalhes('com essa acao voce podera fazer vendas bla bla bla'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  permite vender sem estoque',
                          style: TextStyle(fontSize: 20)),
                      Switch(
                        value: false,
                        onChanged: (bool value) {
                          // Lógica para lidar com a mudança de estado do switch
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                mostrarDetalhes('com essa acao voce podera fazer vendas bla bla bla'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  permite realizar ordens de serviço',
                          style: TextStyle(fontSize: 20)),
                      Switch(
                        value: false,
                        onChanged: (bool value) {
                          // Lógica para lidar com a mudança de estado do switch
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                mostrarDetalhes('com essa acao voce podera fazer ordens de serviço. Voce ainda poderá limitar o colaborador que podera bla bla '),
              ],
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        onPressed: () {
          setState(() {
            detalhes = !detalhes;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('mostrando detalhes abaixo das opções'),
            ),
          );
        },
      ),
    );

  }

  Widget mostrarDetalhes(String texto) {
    return detalhes == true ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepOrange,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(texto),
                  ),),
              ) : Container( );
  }
}
