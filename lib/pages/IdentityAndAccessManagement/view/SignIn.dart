import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/signIn.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/services/FarmerService.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/services/SignInService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/principalView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInModel? signInModel;
  dynamic account;
  Farmer? farmer;
  HttpSignInService? signInService;
  FarmerService? farmerService;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    signInService = HttpSignInService();
    farmerService = FarmerService();
    super.initState();
  }

  Future signInServiceAccount() async {
    signInModel =
        SignInModel(emailAddress: emailAddress.text, password: password.text);
    account = await signInService?.signIn(signInModel!);
    setState(() {
      if (account is Account) {
        account = account;
        getFarmer(account!);
      } else if (account is String) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white, // Fondo blanco
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)), // Bordes redondeados
              ),
              content: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/error.png',
                      height: 100,
                    ),
                    SizedBox(height: 16),
                    Text(
                      account,
                      style: TextStyle(
                        fontFamily: 'Poppins', // Fuente Poppins
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  Future getFarmer(Account account) async {
    farmer = await farmerService!.getFarmerByAccountId(account.id!);
    setState(() {
      farmer = farmer;
      if (farmer != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Principalview(farmer!, account!)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'Log In',
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
                  labelText: 'Email Address',
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              margin:
                  EdgeInsets.only(bottom: 15), // Posiciona el texto al final
              child: Text(
                'Did you forget your password?',
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
                signInServiceAccount();
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
                'Enter',
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
  }
}
