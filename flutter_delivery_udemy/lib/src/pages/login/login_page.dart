import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/pages/login/login_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart'; // Es importante en casi todas las clases

class LoginPage extends StatefulWidget { // stful para que cree solo el StatefulWidget
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

  // Se ejecuta primero antes de nuestros Widgets
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context);
    });

  }

  // String _name; privada
  // String name; publica

  @override
  Widget build(BuildContext context) {
    return Scaffold( // La etiqueta Scaffold crea casi toda la estructura de nuestra pantalla
      body: Stack(
        children: [
          Positioned( //Donde se quiere ubicar el circulo dentro de la pantalla
              top: -80,
              left: -100,
              child: _circleLogin()
          ),
          Positioned(
              child: _textLogin(),
              top: 60,
              left: 15,
          ),
          Container(
            width: double.infinity,// De toda la pantalla
            child: SingleChildScrollView(
              child: Column (
                children: [
                  _lottieAnimation(),
                  //_imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount()
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _lottieAnimation(){ //animaciones
    return Container(
      margin: EdgeInsets.only(
          top: 150,
          bottom: MediaQuery.of(context).size.height * 0.17 // Para poner el espacio debajo en porcentaje 0..2 es 22%
      ),
      child: Lottie.asset(
        'assets/json/delivery.json',
        width: 350,
        height: 200,
        fit: BoxFit.fill
      ),
    );
  }

  Widget _textLogin(){
    return Text(
      'INICIAR SESION',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        fontFamily: 'NimbusSans'
      ),

    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes Cuenta ?',
          style:TextStyle(
              color: MyColors.primaryColor
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(// para al dar clic en registrate se vaya a otra página
          onTap: _con.goToRegisterPage,
          child: Text(
            'Registrate',
            style:TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity, // double.infinity para que ocupe toda la pantalla horizontal
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text('Ingresar'),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor, //Para pintar de color rosado claro
          borderRadius: BorderRadius.circular(30) // Para el borde sea circular
      ),
      child: TextField(
          controller: _con.passwordController,
          obscureText: true, // Para evitar que la contrasela se vea
          decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none, // para quitar la linea de abajo
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark // Para el color dle texto
          ),
          prefixIcon: Icon( //icono de email
            Icons.lock,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor, //Para pintar de color rosado claro
        borderRadius: BorderRadius.circular(30) // Para el borde sea circular
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,// Para habilitar el arroba
        decoration: InputDecoration(
            hintText: 'Correo electrónico',
            border: InputBorder.none, // para quitar la linea de abajo
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark // Para el color dle texto
            ),
            prefixIcon: Icon( //icono de email
              Icons.email,
              color: MyColors.primaryColor,
            ),
        ),
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 100,
          bottom: MediaQuery.of(context).size.height * 0.18 // Para poner el espacio debajo en porcentaje 0..2 es 22%
      ),
      child: Image.asset(
        'assets/img/delivery.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
