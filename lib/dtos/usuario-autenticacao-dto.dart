class UsuarioAutenticacaoDto {
  final String id;

  UsuarioAutenticacaoDto({required this.id});

  factory UsuarioAutenticacaoDto.fromJson(Map<String, dynamic> json) {
    return UsuarioAutenticacaoDto(
      id: json['id'],
    );
  }

}
