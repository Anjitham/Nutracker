import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class API {
  static const String baseUrl = "";
  static const String upload = "";

  static Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    try {
      String apiUrl = 'http://64.227.136.230:8000/upload/file';
      String fileName = imageFile.path.split('/').last;
      log(imageFile.toString());
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.toString(),
          filename: fileName,
        ),
      });

      Dio dio = Dio();

      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (error) {
      throw Exception('Failed to upload image: $error');
    }
  }
}
