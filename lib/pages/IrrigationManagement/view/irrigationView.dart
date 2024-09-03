import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/view/SignIn.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/scheduleIrrigation.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/scheduleIrrigationService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IrrigationView extends StatefulWidget {
  RiceCrop riceCrop;
  IrrigationView(this.riceCrop, {super.key}) ;

  @override
  _IrrigationViewState createState() => _IrrigationViewState();
}

class _IrrigationViewState extends State<IrrigationView> {
  List<Scheduleirrigation>? irrigations;
   Scheduleirrigationservice? scheduleirrigationservice;
  @override
  void initState() {
    scheduleirrigationservice = Scheduleirrigationservice();
    getAllScheduleIrrigationByRiceCropId();
    //getSensorDataRecord();
    super.initState();
  }
  Future getAllScheduleIrrigationByRiceCropId() async{
    irrigations = await scheduleirrigationservice!.getIrrigationsByRiceCropId(widget.riceCrop.id!);
    setState(() {
      irrigations = irrigations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
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
                          'Irrigation',
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                itemCount: irrigations != null ? irrigations!.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RIEGO ${irrigations![index]}',
                                style: TextStyle(
                                  fontFamily: 'Droid Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 18 / 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Duración: ${irrigations![index].irrigationTime}',
                                style: TextStyle(
                                  fontFamily: 'Droid Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 18 / 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Fecha: ${irrigations![index].irrigationDate}',
                            style: TextStyle(
                              fontFamily: 'Droid Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 18 / 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFFFFFF),
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
                        'diegoporta20@gmail.com',
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
                          //Principalview(widget.farmer, widget.account),
                          SignIn(),
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
                        "Home",
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
                          //Principalview(widget.farmer, widget.account),
                          SignIn(),
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
                            Icons.sensors,
                            size: 23,
                          )),
                      Text(
                        "Parcels",
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
                              Icons.grass_outlined,
                              size: 23,
                              color: Colors.white,
                            )),
                        Text(
                          "Irrigation",
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
                            Icons.logout_outlined,
                            size: 23,
                          )),
                      Text(
                        "Sign Out",
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