import 'package:flutter/material.dart';

String acaoBotao = ' vazio';
bool novaOperacaoEmProgresso = false;

class OperacaoNova extends StatefulWidget {
  const OperacaoNova({Key? key}) : super(key: key);
  @override
  State<OperacaoNova> createState() => _OperacaoNovaState();
}
class EscolhaUmaOpecaoEntreVendaEOrdemDeServico extends StatefulWidget {

  @override
  State<EscolhaUmaOpecaoEntreVendaEOrdemDeServico> createState() => _EscolhaUmaOpecaoEntreVendaEOrdemDeServicoState();
}
class NovoServico extends StatefulWidget {
  const NovoServico({Key? key}) : super(key: key);

  @override
  State<NovoServico> createState() => _NovoServicoState();
}
class NovoProduto extends StatefulWidget {
  const NovoProduto({Key? key}) : super(key: key);

  @override
  State<NovoProduto> createState() => _NovoProdutoState();
}

//telas abaixo

class _OperacaoNovaState extends State<OperacaoNova> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: novaOperacaoEmProgresso == false ? Center(
        child: Container(
          child: Text('aguardando nova...$acaoBotao'),
        ),
      ) : acaoBotao == 'venda' ? NovoProduto() : NovoServico(),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          novaOperacaoEmProgresso == false ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EscolhaUmaOpecaoEntreVendaEOrdemDeServico()),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    acaoBotao = value['acaoBotao'];
                    novaOperacaoEmProgresso = value['novaOperacaoEmProgresso'];
                  });
                }
              });
            }, label: Text('adicionar'),
          ) : Container(),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                acaoBotao = '';
                novaOperacaoEmProgresso = false;
                Navigator.pushReplacementNamed(context, '/operacoes');
              });
            }, label: Text('cancelar'),
          ),
        ],
      ),
    );
  }
}

class _EscolhaUmaOpecaoEntreVendaEOrdemDeServicoState extends State<EscolhaUmaOpecaoEntreVendaEOrdemDeServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  acaoBotao = 'venda';
                  novaOperacaoEmProgresso = true;
                  Navigator.pop(context, {'acaoBotao': acaoBotao, 'novaOperacaoEmProgresso': novaOperacaoEmProgresso});
                });
              },
              child: Text('novo produto'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  acaoBotao = 'servico';
                  novaOperacaoEmProgresso = true;
                  Navigator.pop(context, {'acaoBotao': acaoBotao, 'novaOperacaoEmProgresso': novaOperacaoEmProgresso});
                });
              },
              child: Text('novo serviço'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NovoProdutoState extends State<NovoProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.red,
      child: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.blue,
            height: 30,
            width: 150,
          ),
        ),
      ),),
    );
  }
}

class _NovoServicoState extends State<NovoServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green,),
    );
  }
}

