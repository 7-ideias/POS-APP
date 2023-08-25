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

  ObjVendaEServico(
      {
        this.id,
        this.idCodigoProduto,
        this.codigoDeBarras,
        this.descricaoProduto,
        this.qt,
        this.vlUnitario,
        this.vlTotal,
        this.idColaboradorResponsavelPeloServico,
        this.nomeColaboradorResponsavel
      });

  ObjVendaEServico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCodigoProduto = json['idCodigoProduto'];
    codigoDeBarras = json['codigoDeBarras'];
    descricaoProduto = json['descricaoProduto'];
    qt = json['qt'];
    vlUnitario = json['vlUnitario'];
    vlTotal = json['vlTotal'];
    idColaboradorResponsavelPeloServico =
    json['idColaboradorResponsavelPeloServico'];
    nomeColaboradorResponsavel = json['nomeColaboradorResponsavel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idCodigoProduto'] = this.idCodigoProduto;
    data['codigoDeBarras'] = this.codigoDeBarras;
    data['descricaoProduto'] = this.descricaoProduto;
    data['qt'] = this.qt;
    data['vlUnitario'] = this.vlUnitario;
    data['vlTotal'] = this.vlTotal;
    data['idColaboradorResponsavelPeloServico'] =
        this.idColaboradorResponsavelPeloServico;
    data['nomeColaboradorResponsavel'] = this.nomeColaboradorResponsavel;
    return data;
  }
}
