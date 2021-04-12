import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:enviroCar/model/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username = "";
  String email = "";
  String password = "";
  String cnfPassword = "";
  bool acknowledgement = false;
  bool privacy = false;
  bool progressSpin = false;
  bool passwordVisible = true;
  bool cnfPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    //----------------------My functions--------------------------

    void passwordVisibilty() {
      setState(() {
        passwordVisible = !passwordVisible;
      });
    }

    void cnfPasswordVisibilty() {
      setState(() {
        cnfPasswordVisible = !cnfPasswordVisible;
      });
    }

    displaySnackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    bool checkCredentials() {
      if (username == "") {
        displaySnackbar("Username cannot be blank");
        return false;
      } else if (email == "") {
        displaySnackbar("Email cannot be blank");
        return false;
      } else if (password == "") {
        displaySnackbar("Password cannot be blank");
        return false;
      } else if (cnfPassword == "") {
        displaySnackbar("Confirm Password cannot be blank");
        return false;
      } else if (password != cnfPassword) {
        displaySnackbar("Passwords do not match");
        return false;
      } else if (acknowledgement == false) {
        displaySnackbar("You need to select the acknowledgemnet checkbox");
        return false;
      } else if (privacy == false) {
        displaySnackbar("You need to select the privacy checkbox");
        return false;
      }
      return true;
    }

    Future<bool> register() async {
      try {
        var response = await http.post(
          Uri.https('envirocar.org', '/api/dev/users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': username,
            'mail': email,
            'token': password,
            'acceptedPrivacy': true,
            'acceptedTerms': true,
          }),
        );

        if (response.statusCode == 200) {
          //print(response.body);
          print(jsonDecode(response.body));
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
    }

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
      colors: [Color(0x8C03769B), Color(0x9D03769B)],
    ));

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
      autofocus: true,
    );

    var txtEmail = TextField(
      decoration: InputDecoration(
          hintText: "E-mail",
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {email = value},
      autocorrect: true,
    );

    var txtPassword = TextField(
      obscureText: passwordVisible,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          suffix: InkWell(
            onTap: passwordVisibilty,
            child: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (value) => {password = value},
    );

    var txtCnfPassword = TextField(
        obscureText: cnfPasswordVisible,
        decoration: InputDecoration(
            hintText: "Confirm Password",
            prefixIcon: Icon(Icons.lock),
            suffix: InkWell(
              onTap: cnfPasswordVisibilty,
              child: Icon(
                cnfPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        onChanged: (value) => {cnfPassword = value});

    var txtAcknowledgement = Text(
      'I acknowledge I have read and agree to enviroCar\'s Terms and Conditions',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFFFFFFFF),
      ),
    );

    var cbAcknowledgement = CheckboxListTile(
      title: txtAcknowledgement,
      value: acknowledgement,
      onChanged: (value) {
        setState(() {
          acknowledgement = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    var txtPrivacy = Text(
      'I have taken note of the privacy Statement.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFFFFFFFF),
      ),
    );

    var cbPrivacy = CheckboxListTile(
      title: txtPrivacy,
      value: privacy,
      onChanged: (value) {
        setState(() {
          privacy = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    var btnSubmit = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('Register'),
        onPressed: () async {
          if (checkCredentials() == true) {
            setState(() {
              progressSpin = true;
            });
            bool action = await register();
            if (action) {
              Navigator.pushNamedAndRemoveUntil(context, "home",(r) => false,arguments: {"name" : username});
            }
            setState(() {
              progressSpin = false;
            });
          }
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
              Navigator.pushNamedAndRemoveUntil(context, "login", (r) => false);
            }),
    );

    var spaceSizedBox = SizedBox(
      height: 25,
    );

    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: progressSpin,
      child: Scaffold(
          body: Stack(children: <Widget>[
        Container(decoration: decorationBackgroundImage),
        Container(
          decoration: decorationBackgroundColor,
          child: Center(
            child: Container(
              width: 300,
              child: Column(
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
                          Center(child: rtxtSignIn),
                          spaceSizedBox,
                          spaceSizedBox,
                          spaceSizedBox,
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ])),
    ));
  }
}
