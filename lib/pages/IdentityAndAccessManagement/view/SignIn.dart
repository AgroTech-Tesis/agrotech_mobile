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
  Account? account;
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
                      margin: EdgeInsets.only(
                          bottom: 15), // Posiciona el texto al final
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
