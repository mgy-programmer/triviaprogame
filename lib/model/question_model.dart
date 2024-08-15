class QuestionModel{
  late int id;
  late String question;
  late List<String> option;
  late String correctOption;

  QuestionModel(this.id, this.question, this.option, this.correctOption);

  QuestionModel.fromJson(Map json){
    id = json["id"];
    question = json["question"];
    option = dynamicListToStringList(json["options"]);
    correctOption = json["correct_option"];
  }

  dynamicListToStringList(List<dynamic> list){
    List<String> options = [];
    for(var i in list){
      options.add(i);
    }
    return options;
  }
}