// To parse this JSON data, do
//
//     final objetivo = objetivoFromJson(jsonString);


class Frase {
  String cancion;
  String frace;
  String ? id;
  Frase({
    required this.cancion,
    required this.frace,
    this.id
  });

  factory Frase.fromJson(Map<String, dynamic> json) => Frase(
        cancion: json["cancion"],
        frace: json["frase"],
      );

  Map<String, dynamic> toJson() => {
        "cancion": cancion,
        "frase": frace,
      };
}
