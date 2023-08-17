class PushDto {
  final String id;
  final String mensagem;
  final String tipoDeMovimentacaoEnum;
  final double valorTotal;

  PushDto({
    required this.id,
    required this.mensagem,
    required this.tipoDeMovimentacaoEnum,
    required this.valorTotal,
  });

  factory PushDto.fromJson(Map<String, dynamic> json) {
    return PushDto(
      id: json['id'],
      mensagem: json['mensagem'],
      tipoDeMovimentacaoEnum: json['tipoDeMovimentacaoEnum'],
      valorTotal: json['valorTotal'],
    );
  }
}
