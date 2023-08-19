import 'package:pos_app/dtos/produto-dto.dart';

class ProdutoDtoList {
  double qtNoEstoque;
  double qtSemEstoque;
  double vlEstoqueEmGrana;
  List<ProdutoDto> produtosList;

  ProdutoDtoList({
    required this.qtNoEstoque,
    required this.qtSemEstoque,
    required this.vlEstoqueEmGrana,
    required this.produtosList,
  });

  factory ProdutoDtoList.fromJson(Map<String, dynamic> json) {
    List<dynamic> produtosJson = json['produtosList'];
    List<ProdutoDto> produtosList = produtosJson
        .map((elemento) => ProdutoDto.fromJson(elemento))
        .toList();

    return ProdutoDtoList(
      qtNoEstoque: json['qtNoEstoque'],
      qtSemEstoque: json['qtSemEstoque'],
      vlEstoqueEmGrana: json['vlEstoqueEmGrana'],
      produtosList: produtosList,
    );
  }
}