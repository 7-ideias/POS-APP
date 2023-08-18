class ObjPreferenciasDoApp {
  String? idioma;
  String? moeda;
  bool? fazOrdemDeServico;

  ObjPreferenciasDoApp.fromJson(Map<String, dynamic> json) {
    idioma = json['idioma'] != null ? json['idioma'] : null;
    moeda = json['moeda'] != null ? json['moeda'] : null;
    fazOrdemDeServico =
        json['fazOrdemDeServico'] != null ? json['fazOrdemDeServico'] : null;
  }
}