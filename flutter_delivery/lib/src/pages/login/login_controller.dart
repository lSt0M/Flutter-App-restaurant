import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/push_notifications_provider.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_pref.dart';

class LoginController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson( await _sharedPref.read('user') ?? {});


    print('Usuario: ${user.toJson()}');


    if(user?.sessionToken != null){

      pushNotificationsProvider.saveToken(user, context);

      if(user.roles.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    if (responseApi.success){
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      pushNotificationsProvider.saveToken(user, context);

      print('USUARIO LOGEADO: ${user.toJson()}');
      if(user.roles.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    }
    else{
      MySnackbar.show(context, responseApi.message);
    }
  }
}
