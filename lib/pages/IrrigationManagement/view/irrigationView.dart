import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/view/SignIn.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/scheduleIrrigation.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/scheduleIrrigationService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/agregateIrrigation.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/plostView.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/principalView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IrrigationView extends StatefulWidget {
  RiceCrop riceCrop;
  Farmer farmer;
  Account account;
  IrrigationView(this.riceCrop, this.farmer, this.account, {super.key});

  @override
  _IrrigationViewState createState() => _IrrigationViewState();
}

class _IrrigationViewState extends State<IrrigationView> {
  List<Scheduleirrigation>? irrigations;
  Scheduleirrigationservice? scheduleirrigationservice;
  String? statusOption;
  @override
  void initState() {
    scheduleirrigationservice = Scheduleirrigationservice();
    getAllScheduleIrrigationByRiceCropId(null);
    //getSensorDataRecord();
    super.initState();
  }

  Future getAllScheduleIrrigationByRiceCropId(String? status) async {
    irrigations = await scheduleirrigationservice!
        .getIrrigationsByRiceCropId(widget.riceCrop.id!, status);
    setState(() {
      irrigations = irrigations;
    });
    statusOption = status;
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
                          'SCHEDULE IRRIGATION',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildStatusCard(
                    'assets/pending.png',
                    'Pending Irrigation',
                    Color(0xFF297739),
                    statusOption == 'PENDING',
                    () => getAllScheduleIrrigationByRiceCropId(
                        'PENDING'), // Acción al hacer clic
                  ),
                  buildStatusCard(
                    'assets/irrigation.png',
                    'Irrigation In Progress',
                    Colors.black,
                    statusOption == 'IRRIGATION',
                    () => getAllScheduleIrrigationByRiceCropId('IRRIGATION'),
                  ),
                  buildStatusCard(
                    'assets/finish.png',
                    'Irrigation Completed',
                    Colors.black,
                    statusOption == 'FINISHED',
                    () => getAllScheduleIrrigationByRiceCropId('IRRIGATION'),
                  ),
                  buildStatusCard(
                    'assets/clean.png',
                    'Clean',
                    Colors.black,
                    statusOption == null,
                    () => getAllScheduleIrrigationByRiceCropId(null),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AgregateIrrigation(widget.riceCrop, null),
                  ),
                );
                getAllScheduleIrrigationByRiceCropId(null);
              },
              child: Container(
                width: 88,
                height: 31,
                decoration: BoxDecoration(
                  color: Color(0xFF297739), // background color
                  borderRadius: BorderRadius.circular(6), // border-radius
                ),
                child: Center(
                  child: Text(
                    'Agregar',
                    style: TextStyle(
                      fontFamily: 'Droid Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 18 / 15, // line-height equivalent
                    ),
                  ),
                ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${irrigations![index].name}',
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha: ${DateFormat('dd/MM/yy \'at\' HH:mm').format(DateTime.parse(irrigations![index].irrigationDate!))}',
                                style: TextStyle(
                                  fontFamily: 'Droid Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 18 / 15,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                      child: TextButton(
                                        onPressed: () {
                                          scheduleirrigationservice!
                                              .DeleteIrrigation(
                                                  irrigations![index]);
                                          getAllScheduleIrrigationByRiceCropId(
                                              null);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 23,
                                          color: Color(0xFFCE3636),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgregateIrrigation(
                                                      widget.riceCrop,
                                                      irrigations![index]),
                                            ),
                                          );
                                          getAllScheduleIrrigationByRiceCropId(
                                              null);
                                        },
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 23,
                                          color: Color(0xFFE1A023),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
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
                          PlostView(
                              widget.riceCrop, widget.farmer, widget.account),
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

  Widget buildStatusCard(String image, String label, Color borderColor,
      bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: InkWell(
        onTap: onTap, // Acción que se ejecuta al hacer clic
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Colors.green
                      : borderColor, // Cambia el color si está seleccionado
                  width: isSelected
                      ? 3.0
                      : 1.0, // Borde grueso si está seleccionado
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 2.25,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
