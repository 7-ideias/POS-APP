import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/dtos/produto-dto.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../controller/app_controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../utilitarios/moeda_formatador.dart';
import '../utilitarios/utils.dart';
import '../utilitarios/widgetsGlobais.dart';
import 'operacao-escolhendo-produto.dart';

class InserindoProduto extends StatefulWidget {
  InserindoProduto({Key? key}) : super(key: key);

  @override
  State<InserindoProduto> createState() => _InserindoProdutoState();
}

class _InserindoProdutoState extends State<InserindoProduto> {


  late ProdutoDto produtoDto;

  TextEditingController _codigoProduto = TextEditingController();
  TextEditingController _vlUnitario = TextEditingController();
  TextEditingController _novo = TextEditingController();
  TextEditingController _acheiProduto = TextEditingController();

  bool _isAcheiProduto = false;

  bool liberBotaoInserirComValorValido = true;

  int _contador = 1;
  double vlTotalMultiplicado = 0.00;

  bool verEstoque = true;
  bool jaTemUmProduto = false;

  ObjVendaEServico objVendaEServico = ObjVendaEServico(
    id: '',
    idCodigoProduto: '',
    codigoDeBarras: '',
    descricaoProduto: '',
    qt: 1,
    vlUnitario:  0.00,
    vlTotal: 0.00,
    idColaboradorResponsavelPeloServico: '',
    nomeColaboradorResponsavel: '',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      calcularPrecoTotalMultiplicado();
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('escolha o produto')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //codigo de barras
                jaTemUmProduto == false ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      child: TextFormField(
                        onChanged: (valor){
                          _novo = TextEditingController(text: valor);
                          buscaDigitando(valor);
                        },
                        controller: _codigoProduto,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                        decoration: UtilsWidgets.buildInputDecoration('código produto',''),
                      ),
                    ),

                    //digitacao do codigo
                    // Container(
                    //   height: 50,
                    //   width: 200,
                    //   child: UtilsWidgets.textFormField(false,true,18,'não deixe isso vazio', _codigoProduto, TextInputType.number, 'código do item','', TextDirection.ltr),
                    // ),

                    // buscar
                    GestureDetector(
                        onTap: (){
                          retornoDaInformacao(context);
                        },
                        child: Container(width: 70,height: 70,
                          child: Icon(Icons.search,size: 50,),)),

                    // leitor de codigo
                    GestureDetector(
                        onTap: (){
                          scan();
                        },
                        child: Container(width: 70,height: 70,
                        child: Icon(Icons.qr_code_2,size: 50,),))
                  ],
                ):Container(),
                SizedBox(height: 30.0),
                if(_isAcheiProduto==true)Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppController.instance.buildThemeData().focusColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      children: [
                        Text('encontrei o produto',style: TextStyle(fontSize: 22)),
                        Text(_acheiProduto.text,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                      ],
                    )),

                SizedBox(height: 16.0),



                jaTemUmProduto == true ? UtilsWidgets.textFormField(false, false,18,'não deixe isso vazio', TextEditingController(text: produtoDto.codigoDeBarras),
                    TextInputType.number, 'código','', TextDirection.ltr):Container(),
                SizedBox(height: 16.0),
                //descricao do produto
                jaTemUmProduto == true ? UtilsWidgets.textFormField(false, false,18,'não deixe isso vazio', TextEditingController(text: produtoDto.nomeProduto),
                    TextInputType.number, 'descrição','', TextDirection.ltr): Container(),
                //contador
                if(jaTemUmProduto == true) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onLongPress: (){
                          setState(() {
                            _contador <= 1 ? _contador : _contador = _contador-10;
                            print(_contador);
                            calcularPrecoTotalMultiplicado();
                          });
                        },
                        onTap: (){
                          setState(() {
                            _contador <= 1 ? _contador : _contador--;
                            print(_contador);
                            calcularPrecoTotalMultiplicado();
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          child: Text('-',style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(_contador.toString(),style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onLongPress: (){
                          setState(() {
                            _contador = _contador+10;
                            print(_contador);
                            calcularPrecoTotalMultiplicado();
                          });
                        },
                        onTap: (){
                          setState(() {
                            _contador++;
                            print(_contador);
                            calcularPrecoTotalMultiplicado();
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          child: Text('+',style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                  ],
                ) ,
                SizedBox(height: 10.0),
                //PREÇOS
                if(jaTemUmProduto == true) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border:  Border.all(
                        )
                    ),
                    child: Column(
                      children: [
                        Text('preços'),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: //custo
                               Padding(
                                 padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 5),
                                child: TextFormField(
                                 onChanged: (valor){
                                     setState(() {
                                     calcularPrecoTotalMultiplicado();
                                     });
                                   },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'não deixe isso vazio';
                                      }
                                      return null;
                                    },
                                  textAlign: TextAlign.end,
                                  // style: TextStyle(fontSize: 18),
                                  controller: _vlUnitario,
                                  // enabled: editar,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [ FilteringTextInputFormatter.digitsOnly, FormatadorDeMoeda(),
                                  ],
                                  decoration: buildInputDecoration('preço unitário'),
                                ),
                              ) ,
                            ),
                            if(liberBotaoInserirComValorValido == true)const Spacer(),
                            //valor da venda
                            if(liberBotaoInserirComValorValido == true)Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child:
                              Padding(
                                padding: const EdgeInsets.only(left:5,top: 8,right: 8,bottom: 8),
                                child: TextFormField(
                                  enabled: false,
                                  onChanged: (valor){
                                    setState(() {
                                      calcularPrecoTotalMultiplicado();
                                    });
                                  },
                                  textAlign: TextAlign.end,
                                  // style: TextStyle(fontSize: 18),
                                  controller: TextEditingController(text: Utils.formataParaMoeda(vlTotalMultiplicado)) ,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [ FilteringTextInputFormatter.digitsOnly, FormatadorDeMoeda(),
                                  ],
                                  decoration: buildInputDecoration('preço total'),
                                ),

                                // TextFormField(
                                //   enabled: false,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'não deixe isso vazio';
                                //     }
                                //     return null;
                                //   },
                                //   style: TextStyle(fontSize: 20,),
                                //   textAlign: TextAlign.right,
                                //   controller:  TextEditingController(text: vlTotalMultiplicado.toString()).text == '0.0' ?
                                //   TextEditingController(text: _vlUnitario.text)
                                //       : TextEditingController(text: vlTotalMultiplicado.toString()) ,
                                //   // enabled: editar,
                                //   keyboardType:
                                //   TextInputType.numberWithOptions(decimal: true),
                                //   inputFormatters: <TextInputFormatter>[
                                //     FilteringTextInputFormatter.allow(
                                //         RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                                //   ],
                                //   decoration: InputDecoration(
                                //           border: OutlineInputBorder(borderRadius:BorderRadius.circular(60)),
                                //           enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(60)),
                                //           focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(60)),
                                //           labelText: 'preço total',
                                //         ),
                                //       ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),

                //_vlUnitario
                // jaTemUmProduto == true ? Container(
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   child:
                //   Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child : UtilsWidgets.textFormField(false,true,18,'não deixe isso vazio', _vlUnitario,
                //         TextInputType.numberWithOptions(decimal: true), 'preço unitário',VariaveisGlobais.moeda, TextDirection.ltr),
                //   ),
                // ): Container(),
                // SizedBox(height: 16.0),

                //estoque
                if(jaTemUmProduto == true)  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child : UtilsWidgets.textFormField(verEstoque, false,18,'não deixe isso vazio',
                            TextEditingController(text: produtoDto.objCalculosDeProdutoDoBackEnd.qtNoEstoque.toString()),
                            TextInputType.numberWithOptions(decimal: true), 'estoque atual','', TextDirection.rtl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: (){
                            setState(() {
                              verEstoque = ! verEstoque;
                            });
                          },
                          child: Icon(Icons.remove_red_eye,size: 30,)),
                    ),
                  ],
                ) ,
                SizedBox(height: 10.0),

                //botao confirmar
                if(liberBotaoInserirComValorValido == true)jaTemUmProduto == true ? GestureDetector(
                  onTap: (){
                    print('vlUnitario${_vlUnitario.value.text}');
                    objVendaEServico = ObjVendaEServico(
                        id: "id",
                        idCodigoProduto: produtoDto.id,
                        codigoDeBarras: produtoDto.codigoDeBarras,
                        descricaoProduto: produtoDto.nomeProduto,
                        idColaboradorResponsavelPeloServico: VariaveisGlobais.idDoTitularOuColaboradorQueEstaAcessando,
                        qt: double.parse(_contador.toString()),
                        vlUnitario: double.parse(Utils.converterMoedaEmDoble(_vlUnitario.value.text)),
                        vlTotal: double.parse(Utils.converterMoedaEmDoble(_vlUnitario.value.text)) *_contador
                    );
                    Navigator.pop(context, objVendaEServico);
                  },
                  child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoConfirmar,
                      'inserir'),
                ): Container(),

                //achei o produto
                _isAcheiProduto == true ? GestureDetector(
                  onTap: (){
                    setState(() {
                      jaTemUmProduto =true;
                      _vlUnitario = TextEditingController(text: produtoDto.precoVenda.toString());
                      _isAcheiProduto = false;
                    });
                  },
                  child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoConfirmar,
                      'confirmar o produto?'),
                ) : Container(),

                //botao cancelar
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoNegar,
                      'cancelar'),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String texto) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      enabledBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      focusedBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      labelText: texto,

    );
  }

  void calcularPrecoTotalMultiplicado(){
    print('vou calcular');
    var resultado = 0.00;

    try{
      resultado = double.parse(_contador.toString()) * double.parse(Utils.converterMoedaEmDoble(_vlUnitario.text));
      liberBotaoInserirComValorValido = true;
    }catch(ex){
      setState(() {
        liberBotaoInserirComValorValido = false;
      });
    }
    setState(() {
      vlTotalMultiplicado = double.parse(resultado.toStringAsFixed(2));
    });
    if(resultado == 0.00){
      print('caiu no if');
      setState(() {
        liberBotaoInserirComValorValido = false;
      });
    }else{
      print('caiu no else');

    }
  }


   void  buscaDigitando(String idProdutoABuscar) {

      var produtoList = VariaveisGlobais.produtoList;
      var list = produtoList.where((item) => item.codigoDeBarras.toLowerCase() == _novo.text).toList();

      print(list.isEmpty?"nao achei" : list[0].nomeProduto);

      if(list.isEmpty){
        setState(() {
          _isAcheiProduto = false;
          _acheiProduto = TextEditingController(text: '');
        });
      }else{
        setState(() {
          produtoDto = list.first;
          _isAcheiProduto = true;
          _acheiProduto = TextEditingController(text: produtoDto.nomeProduto);
        });
      }


  }

  Future<void> retornoDaInformacao(BuildContext context) async {
    produtoDto =  await Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => EscolhaOProduto()),
     );
    setState(() {
      jaTemUmProduto =true;
      _vlUnitario = TextEditingController(text: produtoDto.precoVenda.toString());
    });
  }

  Future<void> scan() async {
    String barCode = 'XXXXX';
    // try {
    //   barCode = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'cancelar', true, ScanMode.BARCODE);
    // } on PlatformException {
    //   barCode = 'falhou';
    // }
    if (!mounted) return;
    setState(() {
      _codigoProduto = TextEditingController(text: barCode);
      buscaDigitando(barCode);
    });
  }

}
