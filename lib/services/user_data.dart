import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:core';

class UsersData extends ChangeNotifier {
  final String _baseUrl = 'industrial-e474b-default-rtdb.firebaseio.com';

  final List<User> users = [];

  User tempUser = User();
  cleanUser() {
    users.clear();
    notifyListeners();
  }

  bool isLoading = true;
  // String id = '';

  Future<String> load() async {
    return loadUsers(readTokenE());
  }

  Future<String> loadUsers(Future<String> id) async {
    final idA = await id;
    
    if (idA.isNotEmpty || idA != '') {

      final url = Uri.https(_baseUrl, "gymtesis/data/users/$idA.json");
      
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> usersMap = json.decode(response.body);
        users.clear();

        usersMap.forEach((key, value) {
          final tempUsers = User.fromJson(value);
          tempUsers.id = key;

          users.add(tempUsers);
        });
        isLoading = false;
        notifyListeners();
        return "usuario cargado";
      } else {
        throw Exception('Failed to load users');
      }
    } else {
      return '';
    }
  }

  Future<User> createUser(User user, String id) async {
    final url = Uri.https(_baseUrl, "gymtesis/data/users/$id.json");

    final response = await http.post(url, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? userId = responseData['name'];
      user.id = userId;
      users.add(user);
      notifyListeners();

      return user;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<String?> upLoadImg(File path) async {
    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dwsvl2eqw/auto/upload?upload_preset=unexhyvd");
    final imageUploadResquest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', path.path);
    imageUploadResquest.files.add(file);

    final streanResponde = await imageUploadResquest.send();
    final resp = await http.Response.fromStream(streanResponde);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    final decodedData = json.decode(resp.body);

    return decodedData['secure_url'];
  }

  Future<User> updateUser(User user) async {
    String id = await readTokenE();

    final url =
        Uri.https(_baseUrl, "gymtesis/data/users/$id/${users[0].id}.json");
    final response = await http.put(url, body: json.encode(user.toJson1()));
    if (response.statusCode == 200) {
      final index = users.indexWhere((element) => element.id == user.id);
      if (index != -1) {
        users[index] = user;
        notifyListeners();
      }
      return user;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    final url = Uri.https(_baseUrl, "gymtesis/users/$userId.json");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      users.removeWhere((element) => element.id == userId);
      notifyListeners();
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<CronoCaloriaDia> createDiaCronCal(CronoCaloriaDia cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_caloria_dia.json");

    final response = await http.post(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? userId = responseData['name'];
      cronCal.id = userId;
      users[0].cronoCaloriaDia!.add(cronCal);
      users[0].cronoCaloriaDiaS!.add(cronCal);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma caloria');
    }
  }

  Future<CronoDiaWork> createDiaWork(CronoDiaWork cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(
        _baseUrl, "gymtesis/data/users/$id/${users[0].id}/crono_dia_work.json");

    final response = await http.post(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? userId = responseData['name'];
      cronCal.id = userId;
      users[0].cronoDiaWork!.add(cronCal);
      users[0].cronoDiaWorkS!.add(cronCal);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma Dia trabajado');
    }
  }

  Future<CronoAgua> createAguaCron(CronoAgua cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(
        _baseUrl, "gymtesis/data/users/$id/${users[0].id}/cron_agua.json");

    final response = await http.post(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? userId = responseData['name'];
      cronCal.id = userId;

      users[0].cronoAgua!.add(cronCal);
      users[0].cronoAguaS!.add(cronCal);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma caloria');
    }
  }

  Future<CronoPeso> createPesoCron(CronoPeso cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(
        _baseUrl, "gymtesis/data/users/$id/${users[0].id}/crono_peso.json");

    final response = await http.post(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? userId = responseData['name'];
      cronCal.id = userId;
      users[0].cronoPeso!.add(cronCal);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma peso');
    }
  }

  Future<CronoAgua> upDateAguaCron(CronoAgua cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/cron_agua/${cronCal.id}.json");

    final response = await http.put(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final index = users[0]
          .cronoAgua!
          .indexWhere((element) => element!.id == cronCal.id);
      final index2 = users[0]
          .cronoAguaS!
          .indexWhere((element) => element!.id == cronCal.id);
      if (index != -1) {
        users[0].cronoAgua![index] = cronCal;
        users[0].cronoAguaS![index2] = cronCal;
        notifyListeners();
      }

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma caloria');
    }
  }

  Future<CronoDiaWork> upDateDiaWork(CronoDiaWork cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_dia_work/${cronCal.id}.json");

    final response = await http.put(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final index = users[0]
          .cronoDiaWork!
          .indexWhere((element) => element!.id == cronCal.id);
      final index2 = users[0]
          .cronoDiaWorkS!
          .indexWhere((element) => element!.id == cronCal.id);
      if (index != -1) {
        users[0].cronoDiaWork![index] = cronCal;
        users[0].cronoDiaWorkS![index2] = cronCal;

        notifyListeners();
      }

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma caloria');
    }
  }

  Future<CronoCaloriaDia> upDateDiaCron(CronoCaloriaDia cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_caloria_dia/${cronCal.id}.json");

    final response = await http.put(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final index = users[0]
          .cronoCaloriaDia!
          .indexWhere((element) => element!.id == cronCal.id);
      final index2 = users[0]
          .cronoCaloriaDiaS!
          .indexWhere((element) => element!.id == cronCal.id);
      if (index != -1) {
        users[0].cronoCaloriaDia![index] = cronCal;
        users[0].cronoCaloriaDiaS![index2] = cronCal;
        notifyListeners();
      }

      return cronCal;
    } else {
      throw Exception('Failed to create dia cronograma caloria');
    }
  }

  Future<CronoPeso> upDatePeso(CronoPeso cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_peso/${cronCal.id}.json");

    final response = await http.put(url, body: json.encode(cronCal.toJson()));
    if (response.statusCode == 200) {
      final index = users[0]
          .cronoPeso!
          .indexWhere((element) => element!.id == cronCal.id);

      if (index != -1) {
        users[0].cronoPeso![index] = cronCal;
        notifyListeners();
      }

      return cronCal;
    } else {
      throw Exception('Failed to UpDate dia cronograma Peso');
    }
  }

  Future<CronoPeso> deletePeso(CronoPeso cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_peso/${cronCal.id}.json");

    final response =
        await http.delete(url);
    if (response.statusCode == 200) {
      users[0].cronoPeso!.removeWhere((element) => element!.id == cronCal.id);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to UpDate dia cronograma Peso');
    }
  }

  Future<CronoCaloriaDia> deleteCaloria(CronoCaloriaDia cronCal) async {
    String id = await readTokenE();
    final url = Uri.https(_baseUrl,
        "gymtesis/data/users/$id/${users[0].id}/crono_caloria_dia/${cronCal.id}.json");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      users[0]
          .cronoCaloriaDia!
          .removeWhere((element) => element!.id == cronCal.id);
      users[0]
          .cronoCaloriaDiaS!
          .removeWhere((element) => element!.id == cronCal.id);
      notifyListeners();

      return cronCal;
    } else {
      throw Exception('Failed to UpDate dia cronograma Caloria');
    }
  }

  // Future<User> updateCroCalo(User user) async {
  //   String id = await readTokenE();

  //   final indexC =
  //       user.cronoCaloriaDia!.indexWhere((element) => element!.id == user.id);
  //   final url = Uri.https(_baseUrl,
  //       "gymtesis/data/users/$id/${user.id}/${user.cronoCaloriaDia![indexC]!.id}.json");
  //   final response = await http.put(url, body: json.encode(user.toJson()));
  //   if (response.statusCode == 200) {
  //     final index = users.indexWhere((element) => element.id == user.id);
  //     if (index != -1) {
  //       users[index] = user;
  //       notifyListeners();
  //     }
  //     return user;
  //   } else {
  //     throw Exception('Failed to update user');
  //   }
  // }
}
