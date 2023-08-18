class ObjAssistenciaTecnicaPode {
  bool? lancaServico;
  bool? ehUmTecnicoEFazAssistenciaTecnica;
  double? comissaoDeAssistencia;

  ObjAssistenciaTecnicaPode.fromJson(Map<String, dynamic> json) {
    lancaServico = json['lancaServico'] != null ? json['lancaServico'] : null;
    ehUmTecnicoEFazAssistenciaTecnica =
        json['ehUmTecnicoEFazAssistenciaTecnica'] != null
            ? json['ehUmTecnicoEFazAssistenciaTecnica']
            : null;
    comissaoDeAssistencia = json['comissaoDeAssistencia'] != null
        ? json['comissaoDeAssistencia']
        : null;
  }
}