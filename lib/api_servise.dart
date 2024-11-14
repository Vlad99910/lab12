import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://lab12.requestcatcher.com/test'; // замініть на ваше посилання

  Future<void> sendRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/$endpoint', data: data);
      print('Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
