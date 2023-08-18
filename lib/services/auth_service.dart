import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gymtesis/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCCYaUwYlNtziYciTkG9117D_foUWRGUEY';

  final storage = const FlutterSecureStorage();
  DateTime fechaProrr = DateTime.now();

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    try {
      final url =
          Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (decodedResp.containsKey('idToken')) {
        // Token hay que guardarlo en un lugar seguro
        await storage.write(key: 'token', value: decodedResp['idToken']);
        // decodedResp['idToken'];
        return null;
      } else {
        return decodedResp['error']['message'];
      }
    } catch (e) {
      return 'No hay Internet';
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    try {
      final url = Uri.https(
          _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (decodedResp.containsKey('idToken')) {
        // Token hay que guardarlo en un lugar seguro
        // decodedResp['idToken'];
        await storage.write(key: 'token', value: decodedResp['idToken']);
        return null;
      } else {
        return decodedResp['error']['message'];
      }
    } catch (e) {
      return 'No hay Internet';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> verifyLogin(BuildContext context) async {
    String? token = await storage.read(key: 'token');
    int dias = 10;

    void navigateToDetails(BuildContext context) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(seconds: 0)));
    }

    if (await hasInternetConnection()) {
      final fechaUltimaCone = DateTime.now();
      String formattedExpirationDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaUltimaCone);
      await saveDateToPrefs(formattedExpirationDate);
    } else {
      fechaProrr = await getDateFromPrefs();
      fechaProrr = fechaProrr.add(const Duration(
        days: 10,
      ));
      Duration duracion = fechaProrr.difference(DateTime.now());
      dias = duracion.inDays;
    }
    if (dias <= 0) {
      await logout();
      // ignore: use_build_context_synchronously
      navigateToDetails(context);
    }

    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String? res = await login(payload['email'], '99999999999999');

      if (res == "USER_DISABLED" || res == "EMAIL_NOT_FOUND") {
        await logout();
        navigateToDetails(context);
      }

      // int expirationUnixTimestamp = payload["exp"];
      // DateTime expirationDateTime =
      //     DateTime.fromMillisecondsSinceEpoch(expirationUnixTimestamp * 1000);
    }

    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readToken() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);

      return payload['user_id'];
    } else {
      return '';
    }
  }

  Future<String> readEmail() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
  
      return payload['email'];
    } else {
      return '';
    }
  }

  Future<void> saveDateToPrefs(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate =
        date; // Convierte la fecha en una cadena de texto en el formato deseado
    await prefs.setString('my_date_key',
        formattedDate); // Guarda la cadena de texto en Shared Preferences con una clave única
  }

  Future<DateTime> getDateFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formattedDate = prefs.getString('my_date_key');
    if (formattedDate != null) {
      DateTime date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(formattedDate);
      return date;
    } // Convierte la cadena de texto en una fecha
    else {
      return DateTime(2000);
    }
  }
}

Future<String> readCorreo() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');

  if (token != null) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['user_id'];
  } else {
    return '';
  }
}

Future<String> readTokenE() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');

  if (token != null) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['user_id'];
  } else {
    return '';
  }
}
