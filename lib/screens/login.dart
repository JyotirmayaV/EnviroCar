import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    var imgBackground = AssetImage('assets/images/img_map.jpg');

    var imgLogo = Image.asset('assets/images/img_envirocar_logo_white.png');

    var txtSignIn = Text('Sign In', textAlign: TextAlign.center,
    style: TextStyle(fontSize: 18,color: Color(0xFFF2F2F2),));

    var txtUsername = TextField(
      decoration: InputDecoration(
          hintText: "Username",
          prefixIcon: Icon(Icons.person_outline),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {username = value},
    );

    var txtPassword = TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {password = value},
    );

    var btnLogin = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('Login'),
        onPressed: () {
          Navigator.pushNamed(context, "trial");
        },
      ),
    );

    var txtQuestion = Text('Do you do not have an account yet ?', textAlign: TextAlign.center);

    var rtxtRegister = RichText(
      text: TextSpan(
        text: 'Register Here!',
        style: TextStyle(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          Navigator.pushNamed(context, "register");
        }
      ),
    );

    // var txtRegister = Text('Register Here!', textAlign: TextAlign.center,
    // style: TextStyle(fontSize: 18,color: Color(0xFFFFFFFF),),);

    var spaceSizedBox = SizedBox(
      height: 25,
    );

    return Scaffold(
      body: Container(
        //color: Color(0xFA0065A0),
        //decoration: BoxDecoration(image: DecorationImage(image: imgBackground)),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          //image: DecorationImage(image: imgBackground,),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Color(0x000065A0),Color(0xFF0065A0)],
            tileMode: TileMode.mirror,
            )
        ),
        
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imgLogo,
                spaceSizedBox,
                txtSignIn,
                spaceSizedBox,
                txtUsername,
                spaceSizedBox,
                txtPassword,
                spaceSizedBox,
                btnLogin,
                spaceSizedBox,
                txtQuestion,
                rtxtRegister,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
