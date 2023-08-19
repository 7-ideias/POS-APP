class ObjAgenda{
  bool? eventoUnico;
  String? tipoDeRecorrencia;
  String? dataDaUltimaOcorrencia;
  String? dataDeVencimentoParaEventoFuturo;

  ObjAgenda.fromJson(Map<String, dynamic> json) {
    eventoUnico = json['eventoUnico'] != null ? json['eventoUnico'] : null;
    tipoDeRecorrencia = json['tipoDeRecorrencia'] != null ? json['tipoDeRecorrencia'] : null;
    dataDaUltimaOcorrencia = json['dataDaUltimaOcorrencia'] != null ? json['dataDaUltimaOcorrencia'] : null;
    dataDeVencimentoParaEventoFuturo = json['dataDeVencimentoParaEventoFuturo'] != null ? json['dataDeVencimentoParaEventoFuturo'] : null;
  }
}