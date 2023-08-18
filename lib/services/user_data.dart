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
      user.id = userId!;
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
    final response = await http.put(url, body: json.encode(user.toJson()));
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



}
