import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/zone.dart';
import 'package:http/http.dart' as http;

class ZoneService {

  ZoneService();
  String urlService = "${localhost}zone";

  Future<List<Zone>?> getAllZone() async {
    var uri = Uri.parse(urlService);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });
    print(response.body);

    if (response.statusCode == 200) {
      var json = response.body;
      return zoneFromJson(json);
    }
    return null;
  }
}