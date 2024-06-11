import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/view/SignIn.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/sensorDataRecord.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/zone.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/zoneDetail.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/sensorDataRecord.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/zoneService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/principalView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlostView extends StatefulWidget {
  Farmer farmer;
  Account account;
   PlostView(this.farmer, this.account, {super.key});

  @override
  _PlostViewState createState() => _PlostViewState();
}

class _PlostViewState extends State<PlostView> {
  List<Zone>? plosts;
  List<SensorDataRecord>? sensorDataRecords;
  List<String> typeSensorData = ['SENSOR DE CAUDAL', 'SENSOR DE HUMEDAD', 'SENSOR DE TEMPERATURA'];
  Map<String, dynamic> queryParams = {
    'zoneId': '',
  };
  ZoneDetail zoneDetail = ZoneDetail();
  ZoneService? zoneService;
  SensordatarecordService sensorDataRecordSenvice = SensordatarecordService();

  @override
  void initState() {
    zoneService = ZoneService();
    getAllZone();
    //getSensorDataRecord();
    super.initState();
  }

  Future getAllZone() async {
    plosts = await zoneService?.getAllZone();
    setState(() {
      plosts = plosts;
    });
    print(sensorDataRecords);
  }
  
  void getSensorDataRecord(String zoneId) async {
    var roomTemperature = 0;
    var roomHumidity = 0;
    var waterConsumption = 0;
    queryParams['zoneId'] = zoneId;
    sensorDataRecords = await sensorDataRecordSenvice.getAllSensorDataRecord(params: queryParams);
    setState(() {
      sensorDataRecords = sensorDataRecords;
    });
    sensorDataRecords?.forEach((element) {
      if(element.typeSensor == typeSensorData[0])
        roomTemperature += element.lastValue!.toInt();
      if(element.typeSensor == typeSensorData[1])
        roomHumidity += element.lastValue!.toInt();
      if(element.typeSensor == typeSensorData[2])
        waterConsumption += element.lastValue!.toInt();
    });
    zoneDetail = ZoneDetail(
      naHumidityOfFloor: roomHumidity.toString(),
      roomTemperature: roomTemperature.toString(),
      waterConsumption: waterConsumption.toString(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              child: Row(
                children: [
                  Builder(builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        print("object");
                        Scaffold.of(context).openDrawer();
                      },
                      color: Colors.white,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF297739)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Ajusta este valor según tu preferencia
                          ),
                        ),
                      ),
                    );
                  }),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Parcelas',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: plosts?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int imageIndex = index % 4;
                  return MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible:
                            true, // Permite cerrar el diálogo al tocar fuera de él
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/waterDetail.png', // Ruta de la imagen
                                    height: 150,
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: Text(
                                      'Título del Diálogo',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Humedad del suelo: ',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      ),
                                      Text(
                                        '50%',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Temperatura ambiente: ',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      ),
                                      Text(
                                        '28°C',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Consumo de agua: ',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      ),
                                      Text(
                                        '10000 m³%',
                                        style: GoogleFonts.rubik(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: Color(0xFF297739),
                                    textColor: Colors.white,
                                    child: Text('Cerrar'),
                                    height: 45, // Altura del botón
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        child: Column(
                      children: [
                        Image.asset(
                          'assets/parcela$imageIndex.png',
                          height: 130,
                        ),
                        Text(plosts![index].name!),
                      ],
                    )),
                  );
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFFFFFF),
        // Configura el ancho del Drawer al 75% de la pantalla
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 15, top: 26),
              width: 262,
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD88D), // Color/Accent/05
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/person.png'), // URL de la imagen
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(256.905), // 81
                      ),
                    ),
                  ),
                  SizedBox(width: 12), // Espacio entre el avatar y el nombre
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Diego Porta Ñaña',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color(0xFF1A1B2D), // Color/Light/Body Text
                        ),
                      ),
                      Text(
                        'ashfaksayem@gmail.com',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Color(0xFF535763), // Color/Dark/Grey V.2
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 25, right: 15, bottom: 10),
              width: 262,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA), // Color de fondo del contenedor
                borderRadius: BorderRadius.circular(8), // Borde redondeado
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Principalview(widget.farmer, widget.account),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.home,
                            size: 23,
                          )),
                      Text(
                        "Inicio",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF535763), // Color/Light/Body Text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              width: 262,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF297739), // Color de fondo del contenedor
                borderRadius: BorderRadius.circular(8), // Borde redondeado
              ),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.menu,
                              size: 23,
                              color: Colors.white,
                            )),
                        Text(
                          "Parcelas",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white, // Color/Light/Body Text
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              width: 262,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA), // Color de fondo del contenedor
                borderRadius: BorderRadius.circular(8), // Borde redondeado
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.menu,
                            size: 23,
                          )),
                      Text(
                        "Cerrar Sesión",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF535763), // Color/Light/Body Text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
