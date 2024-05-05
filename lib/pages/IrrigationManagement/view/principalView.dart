import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Principalview extends StatefulWidget {
  const Principalview({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Principalview> {
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
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
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
                    ),
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
                padding: EdgeInsets.only(top: 15, bottom: 15),
                margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '30°',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
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
                )
              ),
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
                  )
              ),
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
                                  color: Color(0xFF297739), // Cambia el color según tus necesidades
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            Positioned(
                              width: 20,
                              height: 20,
                              right:  2,
                              top: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Cambia el color según tus necesidades
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
                    )
                  ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 25, right: 25),
                child: Text("Cantidad de Agua"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/amountOfWater.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
