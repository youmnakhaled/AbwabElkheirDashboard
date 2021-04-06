import 'dart:convert';

import 'package:abwab_elkheir_dashboard/Constants/Endpoints.dart';
import 'package:abwab_elkheir_dashboard/Services/HTTPException.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>> fetchCases() async {
    try {
      final response = await http.get(
        Endpoints.baseUrl + Endpoints.cases,
      );
      print(response);
      Map<String, dynamic> results;
      if (response.statusCode == 200) {
        results = {
          "statusCode": 200,
          "data": jsonDecode(response.body),
        };
      } else if (response.statusCode == 400) {
        results = {
          "statusCode": 400,
          "data": "Something went wrong",
        };
      } else if (response.statusCode == 404) {
        results = {
          "statusCode": 400,
          "data": "Something went wrong",
        };
      }
      return results;
    } catch (error) {
      return {
        "statusCode": 400,
        "data": "Something went wrong",
      };
    }
  }
}
