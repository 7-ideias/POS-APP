class ObjPreferenciasDoUsuarioDoApp {
  String? idioma;
  String? temaDoApp;

  ObjPreferenciasDoUsuarioDoApp.fromJson(Map<String, dynamic> json) {
    idioma = json['idioma'] != null ? json['idioma'] : null;
    temaDoApp = json['temaDoApp'] != null ? json['temaDoApp'] : null;
  }
}