import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_task_app/models/covid_data_model.dart';
import 'package:http/http.dart';

class PostsService {
  // http api call
  static const fetchLimit = 15;
  final baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      final response =
          await get(Uri.parse("$baseUrl?_limit=$fetchLimit&_page=$page"));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (err) {
      return [];
    }
  }

// dio api call
  final Dio dio = Dio();
  final String url = 'https://api.covid19api.com/summary';

  Future<CovidModel> fetchCovidList() async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData =
            jsonDecode(jsonEncode(response.data)) as Map<String, dynamic>;
        // print(response.toString());
        return CovidModel.fromJson(responseData);
      } else {
        throw CovidModel.withError("error ocurred");
      }
    } on DioError {
      rethrow;
    } catch (e) {
      return CovidModel.withError("error ocurred");
    }
  }
}
