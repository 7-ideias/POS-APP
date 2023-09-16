class ObjVendaEServico {
  String? id;
  String? idCodigoProduto;
  String? codigoDeBarras;
  String? descricaoProduto;
  double? qt;
  double vlUnitario = 0.00;
  double vlTotal = 0.00;
  String? idColaboradorResponsavelPeloServico;
  String? nomeColaboradorResponsavel;
  String? tipoPoduto;

  ObjVendaEServico(
      {
        this.id,
        this.idCodigoProduto,
        this.codigoDeBarras,
        this.descricaoProduto,
        this.qt,
        required this.vlUnitario,
        required this.vlTotal,
        this.idColaboradorResponsavelPeloServico,
        this.nomeColaboradorResponsavel,
        this.tipoPoduto,
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
    tipoPoduto = json['tipoPoduto'];
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
    data['tipoPoduto'] = this.tipoPoduto;
    return data;
  }
}

class ObjVendaEServicoFormatoString {
  String? codigoDeBarras;
  String? descricaoProduto;
  String? qt;
  String? vlUnitario;
  String? vlTotal;

  ObjVendaEServicoFormatoString(
      {
        this.codigoDeBarras,
        this.descricaoProduto,
        this.qt,
        this.vlUnitario,
        this.vlTotal,
      });

  ObjVendaEServicoFormatoString.fromJson(Map<String, dynamic> json) {
     codigoDeBarras = json['codigoDeBarras'];
    descricaoProduto = json['descricaoProduto'];
    qt = json['qt'];
    vlUnitario = json['vlUnitario'];
    vlTotal = json['vlTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoDeBarras'] = this.codigoDeBarras;
    data['descricaoProduto'] = this.descricaoProduto;
    data['qt'] = this.qt;
    data['vlUnitario'] = this.vlUnitario;
    data['vlTotal'] = this.vlTotal;
    return data;
  }
}