class ObjGrana {
  double? tipo1;
  double? tipo2;
  double? tipo3;
  double? tipo4;
  double? tipo5;

  ObjGrana.fromJson(Map<String, dynamic> json) {
    tipo1 = json['tipo1'] != null ? json['tipo1'] : null;
    tipo2 = json['tipo2'] != null ? json['tipo2'] : null;
    tipo3 = json['tipo3'] != null ? json['tipo3'] : null;
    tipo4 = json['tipo4'] != null ? json['tipo4'] : null;
    tipo5 = json['tipo5'] != null ? json['tipo5'] : null;
  }
}