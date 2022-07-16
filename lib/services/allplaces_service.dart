import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tourpoint/constants/strings.dart';

import '../models/places_response.dart';

class placesServices {
  late Dio dio;
  final String currentLang;

  placesServices({this.currentLang = "ar"}) {
    BaseOptions options = BaseOptions(
        baseUrl: placesUrl,
        //baseUrl for my api
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
        headers: {});
    dio = Dio(options);
  }

  Future<PlacesResponse> getAllPlacesRespons() async {
    try {
      Response response = await dio.get("GetPlaces.php");
      if (response.statusCode == 200) {
        print(
            "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        print(response.data);

        return PlacesResponse.fromJson(json.decode(response.data));
      } else {
        throw Exception("Oooooh,Status Code Error ,I didn't Find Your Data");
      }
    } catch (error) {
      print(error.toString());
      return PlacesResponse();
    }
  }
}
