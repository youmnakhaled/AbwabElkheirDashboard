import 'dart:convert';

import 'package:abwab_elkheir_dashboard/Constants/Endpoints.dart';
import 'package:abwab_elkheir_dashboard/Services/HTTPException.dart';
import 'package:dio/dio.dart';

class WebServices {
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.signin,
        data: json.encode(
          {
            "email": email,
            "password": password,
          },
        ),
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );

      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']).toString();
      }
      return response.data;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
