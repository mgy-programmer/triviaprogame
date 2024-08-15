import 'package:flutter/cupertino.dart';
import 'package:triviapro/model/question_model.dart';
import 'package:triviapro/model_view/api_services/question_api.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuestionModel> question = [];
  int selectedQuestion = 0;

  fillQuestion(String path) async {
    question = await QuestionApi().loadQuestionsFromJson(path);
    selectedQuestion = 0;
    notifyListeners();
  }

  nextQuestion() {
    if (question.isNotEmpty && selectedQuestion < question.length - 1) {
      selectedQuestion++;
    } else {
      selectedQuestion = 0;
    }
    notifyListeners();
  }
}
