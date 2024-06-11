import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:http/http.dart' as http;

class Deviceservice {

  Deviceservice();
  String urlService = "${localhost}device";
  
  Future<String?> deviceIotRiceCrop(int riceCropId) async {
    var uri = Uri.parse('$urlService/rice-crop/$riceCropId');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}