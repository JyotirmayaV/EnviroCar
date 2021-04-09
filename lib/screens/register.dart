import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username;
  String email;
  String password;
  String cnfPassword;
  bool acknowledgement;
  bool privacy;

  @override
  Widget build(BuildContext context) {
    var imgBackground = AssetImage('assets/images/img_map.jpg');

    var imgLogo = Image.asset('assets/images/img_envirocar_logo_white.png');

    var txtSignUp = Text('Sign Up',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFFF2F2F2),
        ));

    var txtUsername = TextField(
      decoration: InputDecoration(
          hintText: "Username",
          prefixIcon: Icon(Icons.person_outline),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {username = value},
    );

    var txtEmail = TextField(
      decoration: InputDecoration(
          hintText: "E-mail",
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {email = value},
    );

    var txtPassword = TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {password = value},
    );

    var txtCnfPassword = TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {cnfPassword = value},
    );

    var txtAcknowledgement = Text(
      'I acknowledge I have read and agree to enviroCar\'s Terms and Conditions',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
      ),
    );

    var cbAcknowledgement = CheckboxListTile(
      title: txtAcknowledgement,
      value: false,
      onChanged: (value) {
        acknowledgement = value;
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    var txtPrivacy = Text(
      'I have taken note of the privacy Statement.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
      ),
    );

    var cbPrivacy = CheckboxListTile(
      title: txtPrivacy,
      value: false,
      onChanged: (value) {
        privacy = value;
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    var btnSubmit = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('Submit'),
        onPressed: () {
          Navigator.pushNamed(context, "home");
        },
      ),
    );

    var txtQuestion =
        Text('Do you already have an account?', textAlign: TextAlign.center);

    var rtxtSignIn = RichText(
      text: TextSpan(
        text: 'Sign In Here!',
        style: TextStyle(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          Navigator.pushNamed(context, "login");
        }
      ),
    );

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
          colors: [Color(0x000065A0), Color(0xFF0065A0)],
          tileMode: TileMode.mirror,
        )),

        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imgLogo,
                spaceSizedBox,
                txtSignUp,
                spaceSizedBox,
                txtUsername,
                spaceSizedBox,
                txtEmail,
                spaceSizedBox,
                txtPassword,
                spaceSizedBox,
                txtCnfPassword,
                spaceSizedBox,
                cbAcknowledgement,
                cbPrivacy,
                spaceSizedBox,
                btnSubmit,
                spaceSizedBox,
                txtQuestion,
                rtxtSignIn
              ],
            ),
          ),
        ),
      ),
    );
  }
}
