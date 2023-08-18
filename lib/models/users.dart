// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
import 'dart:core';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'dart:convert';

import 'mensaje.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? nombre;
  String? apellido;
  String? id;
  String? ubicacion;
  Map<String, Mensaje>? mensaje;
  List<Mensaje>? mensajeList;
  String? estadoCuenta;
  String? urlImagen;
  String? gender;

  User(
      {this.nombre,
      this.apellido,
      this.id,
      this.ubicacion,
      this.mensaje,
      this.estadoCuenta,
      this.urlImagen,
      this.gender,
      this.mensajeList});

  User copyWith(
          {String? nombre,
          String? apellido,
          String? id,
          String? ubicacion,
          Map<String, Mensaje>? mensaje,
          List<Mensaje>? mensajeList,
          String? estadoCuenta,
          String? urlImagen,
          String? gender}) =>
      User(
          nombre: nombre ?? this.nombre,
          apellido: apellido ?? this.apellido,
          id: id ?? this.id,
          ubicacion: ubicacion ?? this.ubicacion,
          mensaje: mensaje ?? this.mensaje,
          estadoCuenta: estadoCuenta ?? this.estadoCuenta,
          urlImagen: urlImagen ?? this.urlImagen,
          gender: gender ?? this.gender,
          mensajeList: mensajeList ?? this.mensajeList);

  factory User.fromJson(Map<String, dynamic> json) => User(
      nombre: json["Nombre"],
      apellido: json["Apellido"],
      id: json["id"],
      ubicacion: json["Ubicacion"],
      mensajeList:
          json["mensaje"] != null ? getMensa(json["mensaje"], false) : [],
      mensaje: json["mensaje"] != null
          ? Map.from(json["mensaje"])
              .map((k, v) => MapEntry<String, Mensaje>(k, Mensaje.fromJson(v)))
          : null,
      estadoCuenta: json["EstadoCuenta"],
      urlImagen: json["URL_Imagen"],
      gender: json["gender"]);

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Apellido": apellido,
        "id": id,
        "Ubicacion": ubicacion,
        "mensaje": Map.from(mensaje!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "EstadoCuenta": estadoCuenta,
        "URL_Imagen": urlImagen,
        "gender": gender
      };
}

List<Mensaje> getMensa(Map<String, dynamic> dataMap, bool select) {
  if (dataMap.isNotEmpty) {
    late List<Mensaje> objectsAfterLastSundayCal = [];
    final List<String> keys = dataMap.keys.toList();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    DateTime now = DateTime.now();

    bool foundLastSunday = false;
    objectsAfterLastSundayCal.clear();

    for (int i = keys.length - 1; i >= 0; i--) {
      final DateTime recordDate = formatter.parse(dataMap[keys[i]]['fecha']);

      final Mensaje object = Mensaje(
          id: keys[i],
          contenido: dataMap[keys[i]]['Contenido'],
          urlImagen: dataMap[keys[i]]['URL_Imagen'],
          fecha: dataMap[keys[i]]['fecha']);
      objectsAfterLastSundayCal.add(object);
      foundLastSunday = true;
    }

    objectsAfterLastSundayCal = objectsAfterLastSundayCal.reversed.toList();

    return objectsAfterLastSundayCal;
  } else {
    return [Mensaje(fecha: "01/01/2001", contenido: "", id: "", urlImagen: "")];
  }
}
