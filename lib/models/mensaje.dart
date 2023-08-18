



class Mensaje {
    String contenido;
    String fecha;
    String id;
    String urlImage;

    Mensaje({
        required this.contenido,
        required this.fecha,
        required this.id,
        required this.urlImage,
    });

    Mensaje copyWith({
        String? contenido,
        String? fecha,
        String? id,
        String? urlImage,
    }) => 
        Mensaje(
            contenido: contenido ?? this.contenido,
            fecha: fecha ?? this.fecha,
            id: id ?? this.id,
            urlImage: urlImage ?? this.urlImage,
        );

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        contenido: json["contenido"],
        fecha: json["fecha"],
        id: json["id"],
        urlImage: json["urlImage"],
    );

    Map<String, dynamic> toJson() => {
        "contenido": contenido,
        "fecha": fecha,
        "id": id,
        "urlImage": urlImage,
    };
}
