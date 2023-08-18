
import 'package:flutter/material.dart';
import 'package:gymtesis/models/plan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:core';

class PlanData extends ChangeNotifier {
  final String _baseUrl = 'industrial-e474b-default-rtdb.firebaseio.com';

  Plan plan = Plan(
      descripcion: "descripcion", diasWork: [], img: "img", nombre: "nombre"
      );

  bool isLoading = true;

  Future<String> loadPlan(String namePlan) async {
    final url = Uri.https(_baseUrl, "gymtesis/data/plans/$namePlan.json");
    
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> usersMap = json.decode(response.body);
      final tempPlan = Plan.fromJson(usersMap);
      tempPlan.id = namePlan;
      plan = tempPlan;
      isLoading = false;
      notifyListeners();
      return "Plan cargado";
    } else {
      throw Exception('Failed to load Plan');
    }
  }
}
