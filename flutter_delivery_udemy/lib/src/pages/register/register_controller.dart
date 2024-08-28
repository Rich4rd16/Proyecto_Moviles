
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';

class RegisterController{

  BuildContext? context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future? init(BuildContext context){
    this.context = context;
    usersProvider.init(context);
  }

  void register() async{ // Para capturar lo que el usuario ingrese
    String email = emailController.text.trim(); //Para eviar el espacio en blanco al final del correo
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    //En caso de que el usuario no ingreso uno de los campos solicitados
    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password){
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if(password.length < 6){
      MySnackbar.show(context, 'La contraseña debe contener al menos 6 caracteres');
      return;
    }

    // El return permite que el código de abajo no se ejecute

    User user  = new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
    );

    ResponseApi responseApi = await usersProvider.create(user); // El await funciona con el future del users_providers

    MySnackbar.show(context, responseApi.message);

    print('RESPUESTA: ${responseApi.toJson()}'); // Nos trae los datos del responseApi del toJson
  }

}