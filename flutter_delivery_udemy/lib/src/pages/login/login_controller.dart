import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';


class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);

    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      // Navega a la página principal del cliente solo si la autenticación fue exitosa
      if (context != null) {
        Navigator.pushNamedAndRemoveUntil(
          context!,
          'client/products/list',
              (route) => false,
        );
      }
    } else {
      // Muestra un mensaje de error si la autenticación falla
      if (context != null) {
        MySnackbar.show(context!, responseApi.message);
      }
    }
  }
}