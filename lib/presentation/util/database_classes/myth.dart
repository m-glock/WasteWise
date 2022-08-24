class Myth{

  final String question;
  final String answer;
  final bool isCorrect;

  Myth(this.question, this.answer, this.isCorrect);

  static Myth fromJson(Map<dynamic, dynamic> myth){
    return Myth(myth["question"], myth["answer"],
        myth["category_myth_id"]["is_correct"]);
  }
}