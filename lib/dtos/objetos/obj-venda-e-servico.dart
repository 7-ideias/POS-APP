class ObjVendaEServico {
  String? id;
  String? idCodigoProduto;
  String? codigoDeBarras;
  String? descricaoProduto;
  double? qt;
  double? vlUnitario;
  double? vlTotal;
  String? idColaboradorResponsavelPeloServico;
  String? nomeColaboradorResponsavel;

  ObjVendaEServico({
    required this.id,
     this.idCodigoProduto,
     this.codigoDeBarras,
     this.descricaoProduto,
     this.qt,
     this.vlUnitario,
     this.vlTotal,
     this.idColaboradorResponsavelPeloServico,
     this.nomeColaboradorResponsavel,
    });

  ObjVendaEServico.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    idCodigoProduto =
        json['idCodigoProduto'] != null ? json['idCodigoProduto'] : null;
    codigoDeBarras =
        json['codigoDeBarras'] != null ? json['codigoDeBarras'] : null;
    descricaoProduto =
        json['descricaoProduto'] != null ? json['descricaoProduto'] : null;
    qt = json['qt'] != null ? json['qt'] : null;
    vlUnitario = json['vlUnitario'] != null ? json['vlUnitario'] : null;
    idColaboradorResponsavelPeloServico =
        json['idColaboradorResponsavelPeloServico'] != null
            ? json['idColaboradorResponsavelPeloServico']
            : null;
    nomeColaboradorResponsavel = json['nomeColaboradorResponsavel'] != null
        ? json['nomeColaboradorResponsavel']
        : null;
  }

}
