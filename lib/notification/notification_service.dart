
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  Future <void> requestPermition() async {
    PermissionStatus status = await Permission.notification.request();
    if(status != PermissionStatus.granted){
      throw Exception("Permission no granted");
    }
  }
}