
class Mensaje {
  String? fecha;
  String? id;
  String? contenido;
  String? idUsuario;
  String? urlImagen;

  Mensaje({
    this.fecha,
    this.id,
    this.contenido,
    this.idUsuario,
    this.urlImagen,
  });

  Mensaje copyWith({
    String? fecha,
    String? id,
    String? contenido,
    String? idUsuario,
    String? urlImagen,
  }) =>
      Mensaje(
        fecha: fecha ?? this.fecha,
        id: id ?? this.id,
        contenido: contenido ?? this.contenido,
        idUsuario: idUsuario ?? this.idUsuario,
        urlImagen: urlImagen ?? this.urlImagen,
      );

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        fecha: json["fecha"] ?? "fecha",
        id: json["id"] ?? "id",
        contenido: json["Contenido"] ?? "Contenido",
        idUsuario: json["Id_Usuario"] ?? "user",
        urlImagen: json["URL_Imagen"] ?? "img",
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "id": id,
        "Contenido": contenido,
        "Id_Usuario": idUsuario,
        "URL_Imagen": urlImagen,
      };
}
