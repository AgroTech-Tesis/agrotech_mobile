import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/view/SignIn.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/irrigation.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/deviceService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/irrigationService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/riceCropService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/plostView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/weatherForecast.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/weatherForecast.dart';

class Principalview extends StatefulWidget {
  Farmer farmer;
  Account account;
  Principalview(this.farmer, this.account, {super.key});

  @override
  _PrincipalviewState createState() => _PrincipalviewState();
}

class _PrincipalviewState extends State<Principalview> {
  bool _isSwitched = false;
  RiceCrop? riceCrop;
  IrrigationService? irrigationService;
  Ricecropservice? ricecropservice;
  Irrigation? irrigations;
  Deviceservice? deviceservice;
  int daysPreviousIrrigation = 0;
  TextEditingController nameNewRiceCrop = TextEditingController();
  late Future<WeatherForecast> futureWeather;
  @override
  void initState() {
    ricecropservice = Ricecropservice();
    irrigationService = IrrigationService();
    deviceservice = Deviceservice();
    getRiceCropById(widget.farmer.id!);
    
    futureWeather = WeatherForecastService().getWeatherData('tumbes');
    super.initState();
  }

  Future getRiceCropById(int farmerId) async {
    riceCrop = await ricecropservice!.getRiceCropById(farmerId);
    setState(() {
      riceCrop = riceCrop;
      if(riceCrop != null){
        getIrrigation(riceCrop!.id!);
      }
    });
  }
  Future deviceIotRiceCrop(int riceCropId) async {
    var response = await deviceservice!.deviceIotRiceCrop(riceCropId);
    if(response != null){
      print(response);
    }
  }
  Future updateIrrigation() async {
    DateTime now = DateTime.now();
    Duration difference = now.difference(irrigations!.createdAt!);
    irrigations?.daysPreviousIrrigation = difference.inDays;
    if(_isSwitched)
      irrigations?.status = 'ACTIVE';
    else
      irrigations?.status = 'INACTIVE';
    irrigations = await irrigationService!.updateIrrigation(irrigations!);
    setState(() {
      irrigations = irrigations;
      _isSwitched = !_isSwitched;
    });
  }
  Future createIrrigation() async {
    Irrigation irrigation = Irrigation(
      riceCropId: riceCrop!.id,
    );
    irrigation = (await irrigationService!.createIrrigation(irrigation))!;
    setState(() {
      irrigation = irrigation;
    });
  }
  Future getIrrigation(int riceCropId) async {
    irrigations = await irrigationService!.getIrrigations(riceCropId);
    setState(() {
      irrigations = irrigations;
      daysPreviousIrrigation = irrigations != null ? irrigations!.daysPreviousIrrigation! : 0;
    });
  }
  Future createRiceCrop() async {
    riceCrop = RiceCrop(
      farmerId: widget.farmer.id,
      name: nameNewRiceCrop.text, //nameNewRiceCrop.text
      status: 'ACTIVE',
    );
    riceCrop = await ricecropservice!.createRiceCrop(riceCrop!);
    setState(() {
      riceCrop = riceCrop;
      if(riceCrop != null){
        getIrrigation(riceCrop!.id!);
        deviceIotRiceCrop(riceCrop!.id!);
      }
    });
  }
  void _toggleSwitch() {
    _showDialog();
  }
  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Permite cerrar el diálogo al tocar fuera de él
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
                Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset(
                  'assets/cosecha.png',
                  width: 100,
                  height: 100,
                )),

                Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(!_isSwitched ?
                  "¿Desea activar el riego?" : "¿Desea desactivar el riego? Recuerde que este proceso es de forma automática",
                  style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87
                              ),
                  textAlign: TextAlign.center,
                )),
                Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(_isSwitched){
                            createIrrigation();
                          }else{
                            updateIrrigation();
                          }
                        });
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(
                              0xFF297739,), // Color de fondo del botón en hexadecimal
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Bordes redondeados
                          ),
                        ),
                      ),
                      child: Text("Aceptar", style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                      )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(
                              0xFF297739,), // Color de fondo del botón en hexadecimal
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Bordes redondeados
                          ),
                        ),
                      ),
                      child: Text("Cancelar", style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                      )),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return riceCrop != null ? Scaffold(
        backgroundColor: Colors.white,
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
                            'Bienvenidos',
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
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tumbes, Perú',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<WeatherForecast>(
                          future: futureWeather,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final weather = snapshot.data!;
                              return Text(
                                '${weather.tempCelcius}°C',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            } else {
                              return Text('No data');
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/clima1.png',
                      width: 110,
                      height: 110,
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  child: Center(
                    child: Text(
                      'RIEGO  $daysPreviousIrrigation',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  child: Center(
                    child: Text(
                      '10 DIAS TRANSCURRIDOS',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: 25, bottom: 10, left: 25, right: 25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _toggleSwitch,
                          child: Container(
                            width: 48,
                            height: 24,
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 250),
                                  child: Positioned(
                                    height: 24,
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                    decoration: BoxDecoration(
                                      color: _isSwitched ? Color(0xFF297739) : Color(0xFF6E6E6E),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  )
                                ),
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 250),
                                  child: Positioned(
                                    width: 20,
                                    height: 20,
                                    top: _isSwitched ? 2 : 2,
                                    left: _isSwitched ? 2: 26,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                  ))
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Activar Riego',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                height: 150,
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cantidad de Agua",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          )),
                      Text("100 Lts",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF90A5B4),
                            ),
                          ))
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/amountOfWater.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  child: TextButton(
                    onPressed: () {
                      // Acción que se ejecutará al presionar el botón
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(
                            0xFF297739), // Color de fondo del botón en hexadecimal
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity,
                            55), // Ancho máximo y altura del botón
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Bordes redondeados
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.sensors,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Parcelas',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ))
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
                          widget.farmer.name!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF1A1B2D), // Color/Light/Body Text
                          ),
                        ),
                        Text(
                          widget.account.emailAddress!,
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
                margin:
                    EdgeInsets.only(left: 15, top: 25, right: 15, bottom: 10),
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
                              color: Colors.white,
                              size: 23,
                            )),
                        Text(
                          "Inicio",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white, // Color/Light/Body Text
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
                  color: Color(0xFFFAFAFA), // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(8), // Borde redondeado
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PlostView(widget.farmer, widget.account),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
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
                              Icons.menu,
                              size: 23,
                            )),
                        Text(
                          "Parcelas",
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
        )):
        Scaffold(
        backgroundColor: Colors.white,
          body: Center(
            child: ListView(
              children: [
                Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 25, right: 25),
                child: Row(
                  children: [
                    Builder(builder: (
                      BuildContext context) {
                        return IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
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
                              'Bienvenidos',
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
                  margin: const EdgeInsets.only(top: 50, bottom: 25),
                  height: 200,
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25, top: 25),
                  child: Center(
                    child: Text(
                      'No tienes cultivos activos',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20, // Tamaño de fuente más grande
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                      top: 25, bottom: 10, left: 25, right: 25),
                    child: TextButton(
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
                                Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Image.asset(
                                  'assets/agricultor.png',
                                  width: 100,
                                  height: 100,
                                )),
                                Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Text(
                                    "¿Desea crear un nuevo cultivo activo para gestionar su riego?",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TextField(
                                  controller: nameNewRiceCrop,
                                  decoration: InputDecoration(
                                    labelText: 'Ingrese el nombre del cultivo',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                                    ),
                                    prefixIcon: Icon(Icons.text_fields, color: Colors.green),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear, color: Colors.red),
                                      onPressed: () {
                                        // Acción para limpiar el texto
                                      },
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        createRiceCrop();
                                        Navigator.of(context).pop(); // Cerrar el diálogo
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                          Color(
                                              0xFF297739), // Color de fondo del botón en hexadecimal
                                        ),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8), // Bordes redondeados
                                          ),
                                        ),
                                      ),
                                      child: Text("Aceptar", style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      )),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Cerrar el diálogo
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                          Color(
                                              0xFF297739), // Color de fondo del botón en hexadecimal
                                        ),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8), // Bordes redondeados
                                          ),
                                        ),
                                      ),
                                      child: Text("Cancelar", style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ],
                                ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF297739),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Bordes redondeados
                      ),
                    ),
                  ),
                  child: Text(
                    'Crear un cultivo',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
  }
}
