import 'package:json_annotation/json_annotation.dart';

part 'generated/cycle.g.dart';

@JsonSerializable()
class Cycle{

  final String title;
  final String explanation;
  final int position;
  final String? imagePath;
  final String? additionalInfo;

  Cycle(this.title, this.explanation, this.position, {this.additionalInfo, this.imagePath});

  static Cycle fromGraphQLData(Map<dynamic, dynamic> cycleStep, String? imagePath){
    return Cycle(
        cycleStep["title"],
        cycleStep["explanation"],
        cycleStep["category_cycle_id"]["position"],
        additionalInfo: cycleStep["additional_info"],
        imagePath: imagePath);
  }

  factory Cycle.fromJson(Map<String, dynamic> json) => _$CycleFromJson(json);

  Map<String, dynamic> toJson() => _$CycleToJson(this);
}
