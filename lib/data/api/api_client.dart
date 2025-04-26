import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  final String baseUrl;

  ApiClient({required this.baseUrl}) {
    // Cấu hình baseUrl và timeout
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = Duration(seconds: 30);
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
