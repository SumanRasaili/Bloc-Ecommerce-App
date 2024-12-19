import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  AppUrls._();
  static  String baseUrl = dotenv.get("BASE_URL");
  static  String productUrl = "$baseUrl/products";
}