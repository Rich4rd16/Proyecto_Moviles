import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/api/environment.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider {

  String _url = Environment.API_DELIVERY; //Obtenemos la ip y puerto del Environment
  String _api = '/api/users';

  BuildContext? context;

  Future? init(BuildContext context){
    this.context = context;
  }
//Respuesta del tipo servidor
  Future<ResponseApi> create(User user) async{
    try{
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user); //Los datos que tenemos del usuario "email", "nombre", entre otros, es decir todos los daots del usert.dart del models
      Map<String, String> headers ={
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body); // la respuesta del responser_api.dart nos devuelve
      ResponseApi responseApi = ResponseApi.fromJson(data); //Mapa de valores
      return responseApi;
      
    }catch (e){
      return ResponseApi(
        message: 'Ocurrió un error al realizar la solicitud',
        error: e.toString(),
        success: false,
      );
    }

  }

  Future<ResponseApi> login(String email, String password) async{
    try{
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({
        'email': email,
        'password': password
      }); //Los datos que tenemos del usuario "email", "nombre", entre otros, es decir todos los daots del usert.dart del models
      Map<String, String> headers ={
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body); // la respuesta del responser_api.dart nos devuelve
      ResponseApi responseApi = ResponseApi.fromJson(data); //Mapa de valores
      return responseApi;

    }catch (e){
      return ResponseApi(
        message: 'Ocurrió un error al realizar la solicitud',
        error: e.toString(),
        success: false,
      );
    }
  }

}