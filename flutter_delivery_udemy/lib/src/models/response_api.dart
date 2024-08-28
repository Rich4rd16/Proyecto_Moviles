import 'dart:convert';

ResponseApi responserApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responserApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  late String message;
  late String error;
  late bool success;
  dynamic data;

  ResponseApi({
    required this.message,
    required this.error,
    required this.success,
    this.data,
  });

  //retorno de valores
  ResponseApi.fromJson(Map<String, dynamic> json) {
    message = json["message"] ?? 'Mensaje no disponible';
    error = json["error"] ?? 'Error no disponible';
    success = json["success"] ?? false;
    data = json["data"];

    try{
      data = json['data'];
    } catch (e) {
      print('Exception data $e');
    }

  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "success": success,
    "data": data,
  };
}
