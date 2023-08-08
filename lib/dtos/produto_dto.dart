class ProdutoDto {
  final String id;
  final String nomeProduto;

  ProdutoDto({required this.id, required this.nomeProduto});

  factory ProdutoDto.fromJson(Map<String, dynamic> json) {
    return ProdutoDto(
      id: json['id'],
      nomeProduto: json['nomeProduto'],
    );
  }

}
