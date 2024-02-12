import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/headlines_model.dart';
import 'package:news_app/utils/config.dart';

class SearchProvider extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = true;
  String? searchKeyword;
  HeadlinesModel headlines = HeadlinesModel();

  void onRefresh(bool data) {
    isLoading = data;
    notifyListeners();
  }

  loadNews() async {
    if (searchKeyword == null || searchKeyword!.isEmpty) {
      headlines = HeadlinesModel();
    } else {
      final response = await dio.get(Config.urlEverything + searchKeyword!);

      if (response.statusCode == 200) {
        headlines = HeadlinesModel.fromJson(response.data);
      }

      isLoading = false;
      notifyListeners();
    }
  }
}
