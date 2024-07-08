import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:juiceapps/models/reseler_model.dart';

class ReselerApi {
  final String baseUrl = "https://api.kartel.dev";

  Future<List<Reseler>> fetchReselers() async {
    final response = await http.get(Uri.parse('$baseUrl/sales'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Reseler> reselers =
          body.map((dynamic item) => Reseler.fromJson(item)).toList();
      return reselers;
    } else {
      throw "Failed to load reseler";
    }
  }

  Future<bool> createReseler(
    String buyer,
    String phone,
    String date,
    String status,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sales'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "buyer": buyer,
        "phone": phone,
        "date": date,
        "status": status,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateReseler(Reseler reseler, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sales/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "buyer": reseler.buyer,
        "phone": reseler.phone,
        "date": reseler.date,
        "status": reseler.status,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteReseler(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/sales/$id'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
