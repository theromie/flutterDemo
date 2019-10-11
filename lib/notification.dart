import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:epaisa/messaging.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageState();
  }
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  @override
  _MessageState();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String token;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String fcmTokenToServer = "";

  @override
  void initState() {
    super.initState();

    //Initialization to Firebase Messaging
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();

    //Methods for When some one recieve notifications
    _firebaseMessaging.configure(onLaunch: (Map<String, dynamic> msg) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Message()),
      );
    }, onResume: (Map<String, dynamic> msg) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Message()),
      );
    }, onMessage: (Map<String, dynamic> msg) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Message()),
      );
    });

    //Allow permission to iOS Device
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print("iOS");
    });
  }

  //Store FCM Token to server
  sendTokenToServer(String fcmToken) async {
    if (fcmToken != null) {
      //API Call here
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0XFF0f0815),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: Color(0XFF241232),
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            "Push Notification",
            style: TextStyle(
              color: Color(0XFFd47ea5),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Airbnb",
            ),
          ),
        ),
        body: Text("Hello"));
  }

  //Call Function for send notification
  Future sendNotification() async {
    await Messaging.sendTo(
      title: "Push Notification",
      body: "Hello",
      fcmToken: fcmTokenToServer,
    );
  }
}
