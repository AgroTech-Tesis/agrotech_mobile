import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/scheduleIrrigation.dart';
import 'package:http/http.dart' as http;

class Scheduleirrigationservice {

  Scheduleirrigationservice();
  String urlService = "${localhost}irrigation-schedules";

  // Future<Irrigation?> createIrrigation(Irrigation irrigation) async {
  //   var uri = Uri.parse(urlService);
  //   final response = await http.post(uri, headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Accept": "application/json",
  //   }, body: jsonEncode(irrigation));
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     return Irrigation.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }

  Future<Scheduleirrigation?> updateIrrigation(Scheduleirrigation irrigation) async {
    var uri = Uri.parse('$urlService/${irrigation.id}');
    final response = await http.put(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    }, body: jsonEncode(irrigation));
    print(response.body);

    if (response.statusCode == 200) {
      return Scheduleirrigation.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List<Scheduleirrigation>?> getIrrigationsByRiceCropId(int riceCropId) async {
    var uri = Uri.parse('$urlService/rice-crops/$riceCropId');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var json = response.body;
      return scheduleirrigationFromJson(json);
    }
    return null;
  }
}