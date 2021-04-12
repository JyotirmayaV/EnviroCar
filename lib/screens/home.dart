import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var rcvdData = ModalRoute.of(context)!.settings.arguments.toString();
    var username = rcvdData.substring(
      5,rcvdData.length-1
    );

    var imgBackground = AssetImage('assets/images/img_map.jpg');

    var imgLogo = Image.asset('assets/images/img_envirocar_logo_white.png');

    var txtSignIn =
        Text('Welcome User $username\nMore functionalities coming up soon...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF2F2F2),
            ));

    var btnLogOut = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('LogOut'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "login", (r) => false);
        },
      ),
    );

    var spaceSizedBox = SizedBox(
      height: 25,
    );

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: imgBackground,
          fit: BoxFit.cover,
        ),
      )),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [Color(0xAD03769B), Color(0xFF03769B)],
        )),
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
                btnLogOut,
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
