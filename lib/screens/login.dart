import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  bool progressSpin = false;

  @override
  Widget build(BuildContext context) {
    //----------------------My functions--------------------------

    // myweb() async {
    //   print("hh");
    //   var url = Uri.https('envirocar.org', '/api/dev/users/Jyotirmaya',
    //       {'X-User': '{Jyotirmaya}', 'X-Token': '{password}'});
    //   var r = await http.get(url);
    //   var data = r.body;
    //   var fdata = convert.jsonDecode(data);
    //   print(fdata);
    // }

    displaySnackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    bool checkCredentials() {
      if (username == "") {
        displaySnackbar("Username cannot be blank");
        return false;
      } else if (password == "") {
        displaySnackbar("Password cannot be blank");
        return false;
      }
      return true;
    }

    Future<bool> signIn() async {
      try {
        var response = await http.get(
            Uri.https('envirocar.org', '/api/dev/users/$username'),
            headers: {
              'X-User': username,
              'X-Token': password,
            });
        if (response.statusCode == 200) {
          //print(jsonDecode(response.body));
          return true;
        } else if (response.statusCode == 400) {
          print("inside 400 error");
          var error = jsonDecode(response.body);
          print(error);
          var errorMessage = error['details']['errors'][0]["message"];
          print(errorMessage);
          displaySnackbar(errorMessage);
        } else {
          print(response.body);
          var error = jsonDecode(response.body);
          var errorMessage = error['message'];
          print(errorMessage);
          displaySnackbar(errorMessage);
        }
        return false;
      } //try
      on Exception catch (exception) {
        print("Exception Block");
        print(exception);
        displaySnackbar(exception.toString());
      } catch (error) {
        print("error Block");
        print(error);
        displaySnackbar(error.toString());
      }
      return false;
    } //closing of signIn function

    //----------------------MY Widegts------------------------

    var imgBackground = AssetImage('assets/images/img_map.jpg');

    var decorationBackgroundImage = BoxDecoration(
      image: DecorationImage(
        image: imgBackground,
        fit: BoxFit.cover,
      ),
    );

    var decorationBackgroundColor = BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0x830065A0), Color(0xFF0065A0)],
    ));

    var imgLogo = Image.asset('assets/images/img_envirocar_logo_white.png');

    var txtSignIn = Text('Sign In',
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
      autofocus: true,
    );

    var txtPassword = TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.indigo),
      onChanged: (value) => {password = value},
    );

    var btnLogin = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('Login'),
        onPressed: () async {
          //print('here');
          //myweb();
          if (checkCredentials() == true) {
            setState(() {
              progressSpin = true;
            });
            bool action = await signIn();
            if (action) {
              Navigator.pushNamedAndRemoveUntil(context, "home",(r) => false,arguments: {"name" : username});
            }
            setState(() {
              progressSpin = false;
            });
          } //check credentials if clause closing
        }, //function on prssed closing
      ),
    );

    var txtQuestion = Text('Do you do not have an account yet ?',
        textAlign: TextAlign.center);

    var rtxtRegister = RichText(
      text: TextSpan(
          text: 'Register Here!',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "register", (r) => false);
            }),
    );

    // var txtRegister = Text('Register Here!', textAlign: TextAlign.center,
    // style: TextStyle(fontSize: 18,color: Color(0xFFFFFFFF),),);

    var spaceSizedBox = SizedBox(
      height: 25,
    );

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: progressSpin,
        child: Stack(
          children: <Widget>[
            Container(decoration: decorationBackgroundImage),
            Container(
              decoration: decorationBackgroundColor,
              child: Center(
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            spaceSizedBox,
                            spaceSizedBox,
                            spaceSizedBox,
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
                            spaceSizedBox,
                            Center(child: rtxtRegister),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
