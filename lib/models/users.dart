// To parse this JSON data, do
//
//     final userr = userrFromJson(jsonString);

import 'dart:core';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class User {
  String? id;
  String? plan;
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
  double? peso;
  String? objetivo;
  double? altura;
  double? icm;
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
      this.peso,
      this.cronoCaloriaDiaM,
      this.cronoDiaWorkM,
      this.cronoAguaM,
      this.cronoPesoM,
      this.gender,
      this.objetivo,
      this.altura,
      this.icm,
      this.plan});

  User copyWith({
    String? id,
    String? plan,
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
      peso: peso ?? this.peso,
      objetivo: objetivo ?? this.objetivo,
      altura: altura ?? this.altura,
      icm: icm ?? this.icm,
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
        peso: json['peso'].toDouble(),
        gender: json["gender"],
        objetivo: json["objetivo"],
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
        "peso": peso,
        "gender": gender,
        "objetivo": objetivo,
        "altura": altura,
        "icm": icm,
        "plan": plan,
      };

  Map<String, dynamic> toJson1() => {
        "crono_caloria_dia":
            cronoCaloriaDiaS != null ? mapaCalo(cronoCaloriaDiaS) : [],
        "crono_dia_work":
            cronoDiaWorkS != null ? mapaDiaWork(cronoDiaWorkS) : [],
        "cron_agua": cronoAguaS != null ? mapaAgua(cronoAguaS) : [],
        "crono_peso": cronoPeso != null ? mapaPeso(cronoPeso) : [],
        "id": id,
        "dias_work": diasWork,
        "edad": edad,
        "fecha_naci": fechaNaci,
        "full_name": fullName,
        "hora_rutina": horaRutina,
        "img": img,
        "masa_corpo": masaCorpo,
        "nivel_activ": nivelActiv,
        "peso": peso,
        "gender": gender,
        "objetivo": objetivo,
        "altura": altura,
        "icm": icm,
        "plan": plan,
      };
}

Map<String, CronoCaloriaDia> mapaCalo(List<CronoCaloriaDia?>? lista) {
  Map<String, CronoCaloriaDia> mapa = {
    for (var item in lista!) (item)!.id!: item
  };
  return mapa;
}

Map<String, CronoAgua> mapaAgua(List<CronoAgua?>? lista) {
  Map<String, CronoAgua> mapa = {for (var item in lista!) (item)!.id!: item};
  return mapa;
}

Map<String, CronoDiaWork> mapaDiaWork(List<CronoDiaWork?>? lista) {
  Map<String, CronoDiaWork> mapa = {for (var item in lista!) (item)!.id!: item};
  return mapa;
}

Map<String, CronoPeso> mapaPeso(List<CronoPeso?>? lista) {
  Map<String, CronoPeso> mapa = {for (var item in lista!) (item)!.id!: item};
  return mapa;
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

List<CronoCaloriaDia> getObjectsAfterLastSunday(
    Map<String, dynamic> dataMap, bool select) {
  if (dataMap.isNotEmpty) {
    late List<CronoCaloriaDia> objectsAfterLastSundayCal = [];
    final List<String> keys = dataMap.keys.toList();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    DateTime now = DateTime.now();

    DateTime lastSunday = now.subtract(Duration(days: now.weekday));

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime lastSundayFormatted =
        formatter.parse(dateFormat.format(lastSunday));

    if (select) {
      lastSundayFormatted =
          lastSundayFormatted.subtract(const Duration(days: 28));
    }

    bool foundLastSunday = false;
    objectsAfterLastSundayCal.clear();

    for (int i = keys.length - 1; i >= 0; i--) {
      final DateTime recordDate = formatter.parse(dataMap[keys[i]]['fecha']);

      if (lastSundayFormatted.isBefore(recordDate)) {
        final CronoCaloriaDia object = CronoCaloriaDia(
            id: keys[i],
            total: dataMap[keys[i]]['total'],
            fecha: dataMap[keys[i]]['fecha']);
        objectsAfterLastSundayCal.add(object);
        foundLastSunday = true;
      }
      if (foundLastSunday) {}
    }

    objectsAfterLastSundayCal = objectsAfterLastSundayCal.reversed.toList();

    return objectsAfterLastSundayCal;
  } else {
    return [CronoCaloriaDia(fecha: "01/01/2001", total: 10)];
  }
}

List<CronoAgua> getObjectsAgua(Map<String, dynamic> dataMap, bool select) {
  if (dataMap.isNotEmpty) {
    late List<CronoAgua> objectsAfterLastSundayCal = [];
    final List<String> keys = dataMap.keys.toList();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    DateTime now = DateTime.now();

    DateTime lastSunday = now.subtract(Duration(days: now.weekday));

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime lastSundayFormatted =
        formatter.parse(dateFormat.format(lastSunday));
    if (select) {
      lastSundayFormatted =
          lastSundayFormatted.subtract(const Duration(days: 28));
    }
    bool foundLastSunday = false;
    objectsAfterLastSundayCal.clear();

    for (int i = keys.length - 1; i >= 0; i--) {
      final DateTime recordDate = formatter.parse(dataMap[keys[i]]['fecha']);

      if (lastSundayFormatted.isBefore(recordDate)) {
        final CronoAgua object = CronoAgua(
            id: keys[i],
            total: dataMap[keys[i]]['total'],
            fecha: dataMap[keys[i]]['fecha']);

        objectsAfterLastSundayCal.add(object);
        foundLastSunday = true;
      }
      if (foundLastSunday) {}
    }

    objectsAfterLastSundayCal = objectsAfterLastSundayCal.reversed.toList();

    return objectsAfterLastSundayCal;
  } else {
    return [CronoAgua(fecha: "01/01/2001", total: 10)];
  }
}

List<CronoPeso> getPeso(Map<String, dynamic> dataMap) {
  if (dataMap.isNotEmpty) {
    late List<CronoPeso> objectsAfterLastSundayCal = [];
    final List<String> keys = dataMap.keys.toList();
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

    DateTime now = DateTime.now();

    DateTime lastSunday = now.subtract(Duration(days: now.weekday));

    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateTime lastSundayFormatted =
        formatter.parse(dateFormat.format(lastSunday));
    lastSundayFormatted =
        lastSundayFormatted.subtract(const Duration(days: 28));

    bool foundLastSunday = false;
    objectsAfterLastSundayCal.clear();

    for (int i = keys.length - 1; i >= 0; i--) {
      final DateTime recordDate = formatter.parse(dataMap[keys[i]]['fecha']);

      if (lastSundayFormatted.isBefore(recordDate)) {
        final CronoPeso object = CronoPeso(
            id: keys[i],
            total: dataMap[keys[i]]['total'],
            fecha: dataMap[keys[i]]['fecha']);

        objectsAfterLastSundayCal.add(object);
        foundLastSunday = true;
      }
      if (foundLastSunday) {}
    }

    objectsAfterLastSundayCal = objectsAfterLastSundayCal.reversed.toList();

    return objectsAfterLastSundayCal;
  } else {
    return [CronoPeso(fecha: "01/01/2001 15:30:45", total: 10)];
  }
}

List<CronoDiaWork> getObjectsAfterLastSundayWork(
    Map<String, dynamic> dataMap, bool select) {
  late List<CronoDiaWork> objectsAfterLastSunday = [];
  if (dataMap.isNotEmpty) {
    final List<String> keys = dataMap.keys.toList();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime now = DateTime.now();

    DateTime lastSunday = now.subtract(Duration(days: now.weekday));

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime lastSundayFormatted =
        formatter.parse(dateFormat.format(lastSunday));
    if (select) {
      lastSundayFormatted =
          lastSundayFormatted.subtract(const Duration(days: 28));
    }

    bool foundLastSunday = false;
    objectsAfterLastSunday.clear();

    for (int i = keys.length - 1; i >= 0; i--) {
      final DateTime recordDate = formatter.parse(dataMap[keys[i]]['fecha']);
      if (lastSundayFormatted.isBefore(recordDate)) {
        final CronoDiaWork object = CronoDiaWork(
            id: keys[i].toString(),
            estado: dataMap[keys[i]]['estado'],
            fecha: dataMap[keys[i]]['fecha']);
        objectsAfterLastSunday.add(object);

        foundLastSunday = true;
      }
      if (foundLastSunday) {}
    }
    objectsAfterLastSunday = objectsAfterLastSunday.reversed.toList();
    return objectsAfterLastSunday;
  } else {
    return [CronoDiaWork(estado: false, fecha: "01/01/2001")];
  }
}
