class ObjPreferenciasDoAppRefleteParaTodosOsUsuarios {
  String? idiomaPadraoDoAppParaRelatoriosEComprovantes;
  String? moedaPadraoDoAppParaRelatoriosEComprovantes;

  ObjPreferenciasDoAppRefleteParaTodosOsUsuarios.fromJson(
      Map<String, dynamic> json) {
    idiomaPadraoDoAppParaRelatoriosEComprovantes =
        json['idiomaPadraoDoAppParaRelatoriosEComprovantes'] != null
            ? json['idiomaPadraoDoAppParaRelatoriosEComprovantes']
            : null;
    moedaPadraoDoAppParaRelatoriosEComprovantes =
        json['moedaPadraoDoAppParaRelatoriosEComprovantes'] != null
            ? json['moedaPadraoDoAppParaRelatoriosEComprovantes']
            : null;
  }
}