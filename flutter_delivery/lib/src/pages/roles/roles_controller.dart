import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/utils/shared_pref.dart';


class RolesController {

  BuildContext context;
  Function refresh;
  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh )async {
    this.context = context;
    this.refresh = refresh;

    //desde aca se obtiene el usuario de sesion
    user = User.fromJson(await sharedPref.read('user')); // podria tardar un tiempo en obtener resultados
    refresh();
  }

  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

}