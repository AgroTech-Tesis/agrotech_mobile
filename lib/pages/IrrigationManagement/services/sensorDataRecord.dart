import 'dart:convert';
import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/sensorDataRecord.dart';
import 'package:http/http.dart' as http;

class SensordatarecordService {

  SensordatarecordService();
  String urlService = "${localhost}sensor-data-record/pagination";

  Future<List<SensorDataRecord>> getAllSensorDataRecord({Map<String, dynamic>? params}) async {
    final Uri uri = Uri.parse(urlService).replace(queryParameters: params);
  
    final response = await http.get(uri);

    if (response.statusCode == 200) { 
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((zone) => SensorDataRecord.fromJson(zone)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}