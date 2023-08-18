// To parse this JSON data, do
//
//     final objetivo = objetivoFromJson(jsonString);

import 'dart:convert';

Objetivo objetivoFromJson(String str) => Objetivo.fromJson(json.decode(str));

String objetivoToJson(Objetivo data) => json.encode(data.toJson());

class Objetivo {
    Objetivo1Class objetivo1;
    Objetivo1Class objetivo2;
    Objetivo1Class objetivo3;

    Objetivo({
        required this.objetivo1,
        required this.objetivo2,
        required this.objetivo3,
    });

    factory Objetivo.fromJson(Map<String, dynamic> json) => Objetivo(
        objetivo1: Objetivo1Class.fromJson(json["objetivo1"]),
        objetivo2: Objetivo1Class.fromJson(json["objetivo2"]),
        objetivo3: Objetivo1Class.fromJson(json["objetivo3"]),
    );

    Map<String, dynamic> toJson() => {
        "objetivo1": objetivo1.toJson(),
        "objetivo2": objetivo2.toJson(),
        "objetivo3": objetivo3.toJson(),
    };
}

class Objetivo1Class {
    String tipo;

    Objetivo1Class({
        required this.tipo,
    });

    factory Objetivo1Class.fromJson(Map<String, dynamic> json) => Objetivo1Class(
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "tipo": tipo,
    };
}
