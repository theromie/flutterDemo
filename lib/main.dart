import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:epaisa/UI/home_page.dart';

import 'package:epaisa/blocs/login_provider.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0XFF3b5998), // navigation bar color
      statusBarColor: Color(0XFF3b5998), // status bar color
      //statusBarColor: Colors.transparent,
    ));
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Login Provider to use Bloc Pattern
    return LoginProvider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ePaisa',
      theme: new ThemeData(
        fontFamily: 'Airbnb',
        primaryColor: Color(0XFF3b5998),
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    ));
  }
}
