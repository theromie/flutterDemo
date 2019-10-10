import 'package:flutter/material.dart';

import 'package:epaisa/blocs/login_provider.dart';
import 'package:epaisa/UI/home_details.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    return _buildFbLoginBt(bloc);
  }

  Widget _buildFbLoginBt(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.facebookToken,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return HomeDetails();
          }
          return Scaffold(
              appBar:
                  AppBar(title: Text('Login'), centerTitle: true, elevation: 0),
              body: Container(
                  child: Center(
                      child: FlatButton(
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Login with Facebook',
                      style: TextStyle(fontSize: 20.0, letterSpacing: 1.0),
                    )),
                color: Color(0XFF3b5998),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onPressed: !snapshot.hasData
                    ? () async {
                        bloc.sigInFacebook();
                      }
                    : null,
              ))));
        });
  }
}
