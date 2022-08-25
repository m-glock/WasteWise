class Cycle{

  final String title;
  final String explanation;
  final int position;
  final String imageUrl;

  Cycle(this.title, this.explanation, this.position, this.imageUrl);

  static Cycle fromJson(Map<dynamic, dynamic> cycleStep){
    return Cycle(
        cycleStep["title"],
        cycleStep["explanation"],
        cycleStep["category_cycle_id"]["position"],
        cycleStep["category_cycle_id"]["image"]["url"]);
  }
}
