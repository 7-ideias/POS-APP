
class IdiomaDto {
  String? bomDia;
  String? boaTarde;
  String? boaNoite;
  String? frase1DeIntroducao;
  String? frase2DeIntroducao;
  String? frase3DeIntroducao;
  String? frase4DeIntroducao;
  String? frase5DeIntroducao;

  IdiomaDto({
    this.bomDia,
    this.boaTarde,
    this.boaNoite,
    this.frase1DeIntroducao,
    this.frase2DeIntroducao,
    this.frase3DeIntroducao,
    this.frase4DeIntroducao,
    this.frase5DeIntroducao,
  });

  factory IdiomaDto.fromJson(Map<String, dynamic> json) {
    return IdiomaDto(
      bomDia: json['bomDia'] == null? 'SEM DADOS' : json['bomDia'],
      boaTarde: json['boaTarde'] == null? 'SEM DADOS' : json['boaTarde'],
      boaNoite: json['boaNoite'] == null? 'SEM DADOS' : json['boaNoite'],

      frase1DeIntroducao: json['frase1DeIntroducao'] == null? 'SEM DADOS' : json['frase1DeIntroducao'],
      frase2DeIntroducao: json['frase2DeIntroducao'] == null? 'SEM DADOS' : json['frase2DeIntroducao'],
      frase3DeIntroducao: json['frase3DeIntroducao'] == null? 'SEM DADOS' : json['frase3DeIntroducao'],
      frase4DeIntroducao: json['frase4DeIntroducao'] == null? 'SEM DADOS' : json['frase4DeIntroducao'],
      frase5DeIntroducao: json['frase5DeIntroducao'] == null? 'SEM DADOS' : json['frase5DeIntroducao'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bomDia'] = this.bomDia;
    data['boaTarde'] = this.boaTarde;
    data['boaNoite'] = this.boaNoite;
    return data;
  }
}
