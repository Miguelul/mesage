// To parse this JSON data, do
//
//     final userr = userrFromJson(jsonString);

import 'dart:core';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'mensaje.dart';

class User {
  String? id;
  String? plan;
  List<Mensaje>? mensaje;
  List<CronoCaloriaDia?>? cronoCaloriaDia;
  List<CronoDiaWork?>? cronoDiaWork;
  List<CronoAgua?>? cronoAgua;
  List<CronoCaloriaDia?>? cronoCaloriaDiaS;
  List<CronoDiaWork?>? cronoDiaWorkS;
  List<CronoAgua?>? cronoAguaS;
  List<CronoPeso?>? cronoPeso;
  Map<String, CronoCaloriaDia?>? cronoCaloriaDiaM;
  Map<String, CronoDiaWork?>? cronoDiaWorkM;
  Map<String, CronoAgua?>? cronoAguaM;
  Map<String, CronoPeso?>? cronoPesoM;
  int? diasWork;
  String? gender;
  int? edad;
  String? fechaNaci;
  String? fullName;
  String? horaRutina;
  String? img;
  double? masaCorpo;
  int? nivelActiv;

  User(
      {this.id,
      this.cronoCaloriaDia,
      this.cronoDiaWork,
      this.cronoAgua,
      this.cronoCaloriaDiaS,
      this.cronoDiaWorkS,
      this.cronoAguaS,
      this.cronoPeso,
      this.diasWork,
      this.edad,
      this.fechaNaci,
      this.fullName,
      this.horaRutina,
      this.img,
      this.masaCorpo,
      this.nivelActiv,
      this.cronoCaloriaDiaM,
      this.cronoDiaWorkM,
      this.cronoAguaM,
      this.cronoPesoM,
      this.gender,
      this.plan});

  User copyWith({
    String? id,
    String? plan,
    List<Mensaje>? mensaje,
    List<CronoCaloriaDia?>? cronoCaloriaDia,
    List<CronoDiaWork?>? cronoDiaWork,
    List<CronoAgua?>? cronoAgua,
    List<CronoCaloriaDia?>? cronoCaloriaDiaS,
    List<CronoDiaWork?>? cronoDiaWorkS,
    List<CronoAgua?>? cronoAguaS,
    List<CronoPeso?>? cronoPeso,
    Map<String, CronoCaloriaDia?>? cronoCaloriaDiaM,
    Map<String, CronoDiaWork?>? cronoDiaWorkM,
    Map<String, CronoAgua?>? cronoAguaM,
    Map<String, CronoPeso?>? cronoPesoM,
    int? diasWork,
    String? gender,
    int? edad,
    String? fechaNaci,
    String? fullName,
    String? horaRutina,
    String? img,
    double? masaCorpo,
    int? nivelActiv,
    double? peso,
    String? objetivo,
    double? altura,
    double? icm,
  }) {
    return User(
      id: id ?? this.id,
      plan: plan ?? this.plan,
      cronoCaloriaDia: cronoCaloriaDia ?? this.cronoCaloriaDia,
      cronoDiaWork: cronoDiaWork ?? this.cronoDiaWork,
      cronoAgua: cronoAgua ?? this.cronoAgua,
      cronoCaloriaDiaS: cronoCaloriaDiaS ?? this.cronoCaloriaDiaS,
      cronoDiaWorkS: cronoDiaWorkS ?? this.cronoDiaWorkS,
      cronoAguaS: cronoAguaS ?? this.cronoAguaS,
      cronoPeso: cronoPeso ?? this.cronoPeso,
      diasWork: diasWork ?? this.diasWork,
      gender: gender ?? this.gender,
      edad: edad ?? this.edad,
      fechaNaci: fechaNaci ?? this.fechaNaci,
      fullName: fullName ?? this.fullName,
      horaRutina: horaRutina ?? this.horaRutina,
      img: img ?? this.img,
      masaCorpo: masaCorpo ?? this.masaCorpo,
      nivelActiv: nivelActiv ?? this.nivelActiv,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        diasWork: json['dias_work'],
        edad: json['edad'],
        fechaNaci: json['fecha_naci'],
        fullName: json['full_name'],
        horaRutina: json['hora_rutina'],
        img: json['img'],
        masaCorpo: json['masa_corpo'],
        nivelActiv: json['nivel_activ'],
        gender: json["gender"],
        plan: json["plan"]);
  }

  Map<String, dynamic> toJson() => {
        "crono_caloria_dia": cronoCaloriaDiaM != null
            ? Map<String, dynamic>.from(
                cronoCaloriaDiaM!.map(
                  (key, value) => MapEntry<String, dynamic>(
                    key,
                    value?.toJson(),
                  ),
                ),
              )
            : null,
        "crono_dia_work": cronoDiaWorkM != null
            ? Map<String, dynamic>.from(
                cronoDiaWorkM!.map(
                  (key, value) => MapEntry<String, dynamic>(
                    key,
                    value?.toJson(),
                  ),
                ),
              )
            : null,
        "cron_agua": cronoAguaM != null
            ? Map<String, dynamic>.from(
                cronoAguaM!.map(
                  (key, value) => MapEntry<String, dynamic>(
                    key,
                    value?.toJson(),
                  ),
                ),
              )
            : null,
        "crono_peso": cronoPesoM != null
            ? Map<String, dynamic>.from(
                cronoPesoM!.map(
                  (key, value) => MapEntry<String, dynamic>(
                    key,
                    value?.toJson(),
                  ),
                ),
              )
            : null,
        "id": id,
        "dias_work": diasWork,
        "edad": edad,
        "fecha_naci": fechaNaci,
        "full_name": fullName,
        "hora_rutina": horaRutina,
        "img": img,
        "masa_corpo": masaCorpo,
        "nivel_activ": nivelActiv,
        "gender": gender,
        "plan": plan,
      };

  Map<String, dynamic> toJson1() => {
        "id": id,
        "dias_work": diasWork,
        "edad": edad,
        "fecha_naci": fechaNaci,
        "full_name": fullName,
        "hora_rutina": horaRutina,
        "img": img,
        "masa_corpo": masaCorpo,
        "nivel_activ": nivelActiv,
        "gender": gender,
        "plan": plan,
      };
}

class CronoCaloriaDia {
  int total;
  String fecha;
  String? id;

  CronoCaloriaDia({required this.total, required this.fecha, this.id});

  factory CronoCaloriaDia.fromJson(Map<String, dynamic> json) {
    return CronoCaloriaDia(
        total: json["total"] ?? 100, fecha: json["fecha"] ?? "01/01/2001");
  }

  Map<String, dynamic> toJson() => {"total": total, "fecha": fecha};
}

class CronoAgua {
  int total;
  String fecha;
  String? id;

  CronoAgua({required this.total, required this.fecha, this.id});

  factory CronoAgua.fromJson(Map<String, dynamic> json) {
    return CronoAgua(
        total: json["total"] ?? 100, fecha: json["fecha"] ?? "01/01/2001");
  }

  Map<String, dynamic> toJson() => {"id": id, "total": total, "fecha": fecha};
}

class CronoPeso {
  double total;
  String fecha;
  String? id;

  CronoPeso({required this.total, required this.fecha, this.id});

  factory CronoPeso.fromJson(Map<String, dynamic> json) {
    return CronoPeso(
        total: json["total"] ?? 100, fecha: json["fecha"] ?? "01/01/2001");
  }

  Map<String, dynamic> toJson() => {"id": id, "total": total, "fecha": fecha};
}

class CronoDiaWork {
  bool estado;
  String fecha;
  String? id;

  CronoDiaWork({
    required this.estado,
    required this.fecha,
    this.id,
  });

  factory CronoDiaWork.fromJson(Map<String, dynamic> json) {
    return CronoDiaWork(
      estado: json["estado"] ?? false,
      fecha: json["fecha"] ?? "01/01/2001",
    );
  }
  Map<String, dynamic> toJson() => {
        "estado": estado,
        "fecha": fecha,
      };
}




