import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:news/data/new_model.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<NewsModel> newsList = [];

  void getNews() async {
    try {
      emit(NewsLoading());

      var url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=9ae3dfbd879840248b0c03e65dc9ad77');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var convertedResponse = jsonDecode(response.body);
        List listFromApi = convertedResponse['articles'];
        for (var element in listFromApi) {
          newsList.add(NewsModel.fromJson(element));
        }
        emit(NewsSuccess());
      } else {
        debugPrint('status : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(NewsError());
    }
  }

  static Future<void> launchUrls(String newsUrl) async {
    final Uri url = Uri.parse(newsUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

