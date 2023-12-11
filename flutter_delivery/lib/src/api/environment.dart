import 'package:flutter_delivery/src/models/mercado_pago_credentials.dart';

class Environment {

  static const String API_DELIVERY = "192.168.0.113:3000";
  static const String API_KEY_MAPS = "AIzaSyDxTOuYOkoFi-jI6DvPwhG3fEAG-bD5-D4";

  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
      publicKey: 'TEST-1cafd578-ab17-4b67-a82d-1def124a1a42',
      accessToken: 'TEST-530896369771023-050202-764ffb664d79afcdef2b0c270506aeb3-1365082736'
  );
}

//api anterior
//android:value="AIzaSyCa6O7EQB0ka5MgfpmIvgUOzAswMCOtXKw"/>