import 'package:agrotech_mobile/notification/notificationService.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/signIn.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/services/FarmerService.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/services/SignInService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/principalView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInModel? signInModel;
  Account? account;
  Farmer? farmer;
  List<DocumentSnapshot>? documents;
  HttpSignInService? signInService;
  FarmerService? farmerService;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    signInService = HttpSignInService();
    farmerService = FarmerService();
    signInWithEmailAndPassword();
    super.initState();
  }
  Future signInServiceAccount() async{
    signInModel = SignInModel(emailAddress: emailAddress.text, password: password.text);
    account = await signInService?.signIn(signInModel!);
    setState(() {
      account = account;
      if(account != null){
        getFarmer(account!);
      }
    });
  }
  signInWithEmailAndPassword() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: "diegoporta20@hotmail.com", password: "123456789");
      print("FIRE BASE");
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        print('No user found for that email');
      } else if(e.code == 'wrong-password'){
        print('Wrong password provided for that user');
      }
    }
  }
  Future getFarmer(Account account) async{
    farmer = await farmerService!.getFarmerByAccountId(account.id!);
    setState(() {
      farmer = farmer;
      if(farmer != null){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Principalview(farmer!, account!)),);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots){
            if(snapshots.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshots.hasError){
              return Center(
                child: Text('Error: ${snapshots.error}'),
              );
            }
            documents = snapshots.data!.docs;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/Vector.png', // Ruta de la imagen de fondo
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Center(
                      child: ListView(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 15),
                      height: 200,
                      child: Image.asset('assets/logo.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15, top: 15),
                      child: Text(
                        'Iniciar Sesión',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 22, // Tamaño de fuente más grande
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF635C5C),
                          ),
                          border: OutlineInputBorder(),
                          // Otros atributos de decoración que desees agregar
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF635C5C),
                          ),
                          border: OutlineInputBorder(),
                          // Otros atributos de decoración que desees agregar
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(
                          bottom: 15), // Posiciona el texto al final
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xFF635C5C),
                        ),
                      ),
                    ),
                    Container(
                        child: TextButton(
                      onPressed: () {
                        NotificacionService().pusherNotificaation(
                          title: 'Hola',
                          body: 'Mundo',
                          token: documents![0]['notificationToken'].toString(),
                        );
                        //signInServiceAccount();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF297739),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(double.infinity, 60),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Bordes redondeados
                          ),
                        ),
                      ),
                      child: Text(
                        'Ingresar',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ))
                  ])),
                )
              ],
            );
          },
        )
        );
  }
}
