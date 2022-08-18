import 'package:flutter/services.dart';

class Repository{
  late String baseURL;
  
}

Future<String> loadFile(String path) async{
  return await rootBundle.loadString(path);
}