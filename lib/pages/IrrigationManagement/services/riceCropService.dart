import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';
import 'package:http/http.dart' as http;

class Ricecropservice {

  Ricecropservice();
  String urlService = "${localhost}rice-crops";

  Future<RiceCrop?> createRiceCrop(RiceCrop riceCrop) async {
    var uri = Uri.parse(urlService);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    }, body: jsonEncode(riceCrop));

    if (response.statusCode == 200) {
      return RiceCrop.fromJson(jsonDecode(response.body));
    }
    return null;
  }
  
  Future<RiceCrop?> getRiceCropById(int id) async {
    var uri = Uri.parse('$urlService/farmer/$id');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      return RiceCrop.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}