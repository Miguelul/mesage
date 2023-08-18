import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/mensaje.dart';
import 'auth_service.dart';
import 'user_data.dart';

class MensajeService extends ChangeNotifier {
 final String _baseUrl = 'industrial-e474b-default-rtdb.firebaseio.com';
  List<Mensaje> Mensajes = [];
  final storage = const FlutterSecureStorage();

  bool isLoading = true;

  Mensaje? positionProduLis;

  void selectTrack(Mensaje track) {
    positionProduLis = track;
    notifyListeners();
  }

  String? userId;
  cargarId(BuildContext context) {
    userId = Provider.of<UsersData>(context, listen: false).users[0].id;
  }

  Future<String> loadProduc(BuildContext context) async {
    final userId = Provider.of<UsersData>(context, listen: false).users[0].id;
    isLoading = true;
    String id = await readTokenE();
    final url =
        Uri.https(_baseUrl, "gymtesis/data/users/$id/$userId/mensaje.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> producMap = json.decode(response.body);

      Mensajes.clear();
      producMap.forEach((key, value) {
        final tempUsers = Mensaje.fromJson(value);
        tempUsers.id = key;
        Mensajes.add(tempUsers);
      });
      isLoading = false;
      notifyListeners();
      return "Mensajes cargado";
    } else {
      throw Exception('Failed to load Mensaje');
    }
  }

  Future<Mensaje> crearProduct(Mensaje mensaje) async {
    String id = await readTokenE();
    final url =
        Uri.https(_baseUrl, "gymtesis/data/users/$id/$userId/mensaje.json");
    final respond = await http.post(url, body: json.encode(mensaje.toJson()));
    print(url);
    if (respond.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(respond.body);
      final String? userId = responseData['name'];
      mensaje.id = userId!;
      Mensajes.add(mensaje);
      print("Mensaje registrado");
      print(respond.body);
      return mensaje;
    } else {
      throw Exception("Problema al resgistrar Mensaje");
    }
  }

  Future<Mensaje> updateProduc(Mensaje produc, BuildContext context) async {
    final userId = Provider.of<UsersData>(context, listen: false).users[0].id;
    String id = await readTokenE();
    print(produc.toJson());
    final url = Uri.https(
        _baseUrl, "gymtesis/data/users/$id/$userId/mensaje/${produc.id}.json");
    final response = await http.put(url, body: json.encode(produc.toJson()));
    if (response.statusCode == 200) {
      final index = Mensajes.indexWhere((element) => element.id == produc.id);
      if (index != -1) {
        Mensajes[index] = produc;
        notifyListeners();
      }
      return produc;
    } else {
      throw Exception('Failed to update Produco');
    }
  }

  Future<void> deleteProdu(String produId, BuildContext context) async {
    final userId = Provider.of<UsersData>(context, listen: false).users[0].id;
    String id = await readTokenE();
    final url = Uri.https(
        _baseUrl, "gymtesis/data/users/$id/$userId/mensaje/$produId.json");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      Mensajes.removeWhere((element) => element.id == produId);
      notifyListeners();
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
