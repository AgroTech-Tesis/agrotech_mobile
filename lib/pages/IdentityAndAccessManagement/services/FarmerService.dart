import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:http/http.dart' as http;

class FarmerService {
  var proposal = http.Client();
  String urlService = "${localhost1}farmer";

  Future<Farmer?> getFarmerByAccountId(int id) async {
    var uri = Uri.parse('$urlService/account/$id');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      return Farmer.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}