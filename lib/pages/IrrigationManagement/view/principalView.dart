import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/view/SignIn.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/plostView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/weatherForecast.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/weatherForecast.dart';

class Principalview extends StatefulWidget {
  const Principalview({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Principalview> {
  late Future<WeatherForecast> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherForecastService().getWeatherData('tumbes');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'RIEGO 2',
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
                        Container(
                            width: 48,
                            height: 24,
                            child: Stack(
                              children: [
                                Positioned(
                                  height: 24,
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFF297739), // Cambia el color según tus necesidades
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 20,
                                  height: 20,
                                  right: 2,
                                  top: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Cambia el color según tus necesidades
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            )),
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
                            PlostView(),
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
        ));
  }
}
