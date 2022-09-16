import 'package:json_annotation/json_annotation.dart';

part 'generated/myth.g.dart';

@JsonSerializable()
class Myth{

  final String question;
  final String answer;
  final bool isCorrect;

  Myth(this.question, this.answer, this.isCorrect);

  static Myth fromGraphQlData(Map<dynamic, dynamic> myth){
    return Myth(myth["question"], myth["answer"],
        myth["category_myth_id"]["is_correct"]);
  }

  factory Myth.fromJson(Map<String, dynamic> json) => _$MythFromJson(json);

  Map<String, dynamic> toJson() => _$MythToJson(this);
}