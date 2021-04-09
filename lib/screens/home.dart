import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var imgBackground = AssetImage('assets/images/img_map.jpg');

    var imgLogo = Image.asset('assets/images/img_envirocar_logo_white.png');

    var txtSignIn = Text('Welcome User.More functionalities coming up soon...', textAlign: TextAlign.center,
    style: TextStyle(fontSize: 18,color: Color(0xFFF2F2F2),));

    var btnLogOut = Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        minWidth: 300,
        height: 40,
        child: Text('LogOut'),
        onPressed: () {
          Navigator.pushNamed(context, "login");
        },
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
                btnLogOut,
              ],
            ),
          ),
        ),
      ),
    );
  }
}