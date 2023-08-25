class ObjAgenda{
  bool? eventoUnico;
  String? tipoDeRecorrencia;
  String? dataDaUltimaOcorrencia;
  String? dataDeVencimentoParaEventoFuturo;

  ObjAgenda({
    this.eventoUnico,
    this.tipoDeRecorrencia,
    this.dataDaUltimaOcorrencia,
    this.dataDeVencimentoParaEventoFuturo,
});

  ObjAgenda.fromJson(Map<String, dynamic> json) {
    eventoUnico = json['eventoUnico'] != null ? json['eventoUnico'] : null;
    tipoDeRecorrencia = json['tipoDeRecorrencia'] != null ? json['tipoDeRecorrencia'] : null;
    dataDaUltimaOcorrencia = json['dataDaUltimaOcorrencia'] != null ? json['dataDaUltimaOcorrencia'] : null;
    dataDeVencimentoParaEventoFuturo = json['dataDeVencimentoParaEventoFuturo'] != null ? json['dataDeVencimentoParaEventoFuturo'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventoUnico'] = this.eventoUnico;
    data['tipoDeRecorrencia'] = this.tipoDeRecorrencia;
    data['dataDaUltimaOcorrencia'] = this.dataDaUltimaOcorrencia;
    data['dataDeVencimentoParaEventoFuturo'] = this.dataDeVencimentoParaEventoFuturo;
    return data;
  }
}