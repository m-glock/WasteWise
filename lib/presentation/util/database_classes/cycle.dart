import 'package:json_annotation/json_annotation.dart';

part 'generated/cycle.g.dart';

@JsonSerializable()
class Cycle{

  final String title;
  final String explanation;
  final int position;
  final String imageUrl;

  Cycle(this.title, this.explanation, this.position, this.imageUrl);

  static Cycle fromGraphQLData(Map<dynamic, dynamic> cycleStep){
    return Cycle(
        cycleStep["title"],
        cycleStep["explanation"],
        cycleStep["category_cycle_id"]["position"],
        cycleStep["category_cycle_id"]["image"]["url"]);
  }

  factory Cycle.fromJson(Map<String, dynamic> json) => _$CycleFromJson(json);

  Map<String, dynamic> toJson() => _$CycleToJson(this);
}
