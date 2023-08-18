// To parse this JSON data, do
//
//     final gym = gymFromJson(jsonString);


class Plan {
  String descripcion;
  List<DiaWork>? diasWork;
  String img;
  String nombre;
  String? id;

  Plan(
      {required this.descripcion,
      required this.diasWork,
      required this.img,
      required this.nombre,
      this.id});

  factory Plan.fromJson(Map<String, dynamic> json) {
   List<DiaWork> diasWork = [];
    json["dias_work"].forEach((key, value) {
      final tempCalo = DiaWork.fromJson(value);
      diasWork.add(tempCalo);
    });

    return Plan(
      descripcion: json["descripcion"],
      diasWork: diasWork,
      img: json["img"],
      nombre: json["nombre"],
    );
  }

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "dias_work": List<dynamic>.from(diasWork!.map((x) => x.toJson())),
        "img": img,
        "nombre": nombre,
        "id": id,
      };
}

class DiaWork {
  String descripcion;
  bool estado;
  String title;
  String video;
  String? id;

  DiaWork(
      {required this.descripcion,
      required this.estado,
      required this.title,
      required this.video,
      this.id});

  factory DiaWork.fromJson(Map<String, dynamic> json) => DiaWork(
        descripcion: json["descripcion"] ?? "",
        estado: json["estado"] ?? false,
        title: json["title"] ?? "",
        video: json["video"] ?? "",
        // id : json["id"]
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "estado": estado,
        "title": title,
        "video": video,
        "id": id,
      };
}
