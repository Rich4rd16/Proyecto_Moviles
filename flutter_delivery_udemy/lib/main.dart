import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/login/login_page.dart';
import 'package:flutter_delivery_udemy/src/pages/register/register_page.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) { // El build es el primer en correr y abre el Material App y adentro tiene el routes donde esta el Login
    return  MaterialApp(
      title: 'Proyecto Albán Lazo',
      debugShowCheckedModeBanner: false, // para quitar la etiqueta debug
      initialRoute: 'login', //Ruta del archivo principal que va a ejecutar nuestra aplicación
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register' : (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) => ClientProductsListPage(),
      },
      theme: ThemeData( //Colores para nuestra aplicación
        //fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}
