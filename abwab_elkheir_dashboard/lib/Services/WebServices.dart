import 'dart:convert';

import 'package:abwab_elkheir_dashboard/Constants/Endpoints.dart';
import 'package:abwab_elkheir_dashboard/Services/HTTPException.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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

  Future<Map<String, dynamic>> addCase(
    String title,
    String description,
    int totalPrice,
    List<String> images,
    bool isActive,
    String status,
    String token,
  ) async {
    try {
      print('Adding web');
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.addCase,
        data: json.encode(
          {
            "title": title,
            "description": description,
            "totalPrice": totalPrice,
            "images": images,
            "isActive": isActive,
            "status": status,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );

      print(response.data);

      Map<String, dynamic> results;

      if (response.statusCode == 201) {
        results = {
          "statusCode": 201,
          "data": response.data,
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
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> addHasad(
    String title,
    String link,
    String token,
  ) async {
    try {
      print('Adding Hasad');
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.addHasad,
        data: json.encode(
          {"title": title, "link": link},
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );

      print(response.data);

      Map<String, dynamic> results;

      if (response.statusCode == 201) {
        results = {
          "statusCode": 201,
          "data": response.data,
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
      print(error);
      throw error;
    }
  }

  Future<void> uploadImage(String url, Map<String, dynamic> fields) async {
    try {
      print('Uploading');
      FormData formData = new FormData.fromMap(fields);
      await Dio().post(url,
          data: formData, options: Options(contentType: 'multipart/form-data'));

      return;
    } catch (error) {
      print(error);
    }
  }

  // ignore: missing_return
  Future<List<dynamic>> getImagesUrls(
    XFile image,
    String token,
  ) async {
    try {
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.getImageUrls,
        data: {
          'images': [image.name],
        },
        options: Options(
          //contentType: "application/json",
          validateStatus: (_) {
            return true;
          },
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );

      // final response = await Dio().post(
      //   Endpoints.baseUrl + Endpoints.getImageUrls,
      //   data: formData,
      //   options: Options(
      //     //contentType: "application/json",
      //     validateStatus: (_) {
      //       return true;
      //     },
      //     headers: {
      //       "Authorization": "Bearer " + token,
      //     },
      //   ),
      // );

      // if (response.statusCode != 200) {
      //   throw HTTPException(response.data['message']).toString();
      // }
      return response.data;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> editCase(
      String id,
      String title,
      String description,
      int totalPrice,
      List<String> images,
      bool isActive,
      String status,
      String category,
      String token) async {
    try {
      print('Editing');
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.editCase,
        data: json.encode(
          {
            "_id": id,
            "title": title,
            "description": description,
            "totalPrice": totalPrice,
            "images": images,
            "isActive": isActive,
            "status": status,
            "category": category
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );

      Map<String, dynamic> results;

      if (response.statusCode == 200) {
        results = {
          "statusCode": 200,
          "data": response.data,
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
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchCases(
      String status, String startDate, String endDate, String token) async {
    try {
      print(status);
      print(startDate);
      print(endDate);
      final response = await Dio().get(
        Endpoints.baseUrl + Endpoints.cases,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
        queryParameters: {
          "status": status,
          "startDate": startDate,
          "endDate": endDate,
        },
      );

      Map<String, dynamic> results;

      if (response.statusCode == 200) {
        results = {
          "statusCode": 200,
          // "data": jsonDecode(response.data),
          "data": response.data,
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

  //////////////////////// Youtube Video link   ///////////
  Future<Map<String, dynamic>> editYoutubeLink(
      String youtubeLink, String token) async {
    try {
      print('Editing utube link');
      print(youtubeLink);
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.editYoutubeLink,
        data: json.encode(
          {"link": youtubeLink},
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );

      Map<String, dynamic> results;

      if (response.statusCode == 200) {
        results = {
          "statusCode": 200,
          "data": response.data,
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
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> getYoutubeLink(String token) async {
    try {
      final response =
          await Dio().get(Endpoints.baseUrl + Endpoints.getYoutubeLink,
              options: Options(
                headers: {
                  "Authorization": "Bearer " + token,
                },
                validateStatus: (_) {
                  return true;
                },
              ));

      Map<String, dynamic> results;

      if (response.statusCode == 200) {
        results = {
          "statusCode": 200,
          "data": response.data,
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
