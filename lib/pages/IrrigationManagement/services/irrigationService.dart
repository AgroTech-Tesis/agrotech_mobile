import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/irrigation.dart';
import 'package:http/http.dart' as http;

class IrrigationService {

  IrrigationService();
  String urlService = "${localhost}irrigation";

  Future<Irrigation?> createIrrigation(Irrigation irrigation) async {
    var uri = Uri.parse(urlService);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    }, body: jsonEncode(irrigation));
    print(response.body);

    if (response.statusCode == 200) {
      return Irrigation.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Irrigation?> updateIrrigation(Irrigation irrigation) async {
    var uri = Uri.parse('$urlService/${irrigation.id}');
    final response = await http.put(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    }, body: jsonEncode(irrigation));
    print(response.body);

    if (response.statusCode == 200) {
      return Irrigation.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Irrigation?> getIrrigations(int riceCropId) async {
    var uri = Uri.parse('$urlService/rice-crops/$riceCropId');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Irrigation.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}