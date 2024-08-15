import 'package:triviapro/model/question_model.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

class QuestionApi{
  List<QuestionModel> questions = [];

  loadQuestionsFromJson(String path) async{
    final jsonString = await rootBundle.loadString(path);
    final jsonData = convert.jsonDecode(jsonString);
    List<dynamic> temp = jsonData.toList();
    List<QuestionModel> questionList = [];
    for(var i in temp){
      questionList.add(QuestionModel.fromJson(i));
    }
    return questionList;
  }
}