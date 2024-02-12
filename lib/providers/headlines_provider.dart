import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/headlines_model.dart';
import 'package:news_app/utils/config.dart';

class HeadlinesProvider extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = true;
  HeadlinesModel headlines = HeadlinesModel();

  void onRefresh(bool data) {
    isLoading = data;
    notifyListeners();
  }

  Future loadHeadlines() async {
    final response = await dio.get(Config.urlHeadLines);

    if (response.statusCode == 200) {
      headlines = HeadlinesModel.fromJson(response.data);
    }

    isLoading = false;
    notifyListeners();
  }
}
