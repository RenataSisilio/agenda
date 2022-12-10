import 'package:dio/dio.dart';

class HomeRepository {
  final String _url =
      'https://renatasisilio.github.io/api_simulation/library.json';

  Future<bool> getData() async {
    try {
      final response = await Dio().get(_url);
      return response.data.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
