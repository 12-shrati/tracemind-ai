import 'package:dio/dio.dart';

import 'constants.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Map<String, dynamic>> getDashboard() async {
    final response = await dio.get(AppConstants.latestAnalysis);

    return response.data;
  }

  Future<String> askDashboardChat(
    String question,
    Map<String, dynamic> dashboard,
  ) async {
    final response = await dio.post(
      "/chat",
      data: {"question": question, "dashboard": dashboard},
    );

    return response.data["answer"];
  }
}
