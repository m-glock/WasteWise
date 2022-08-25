class Tip {
  final String title;
  final String explanation;
  final String short;
  final String tipTypeId;
  final String categoryId;
  final String imageUrl;
  bool isBookmarked;

  Tip(this.title, this.explanation, this.tipTypeId, this.categoryId,
      this.imageUrl, this.short,
      {this.isBookmarked = false});

  static Tip fromJson(Map<dynamic, dynamic> tip) {
    return Tip(
        tip["title"],
        tip["explanation"],
        tip["tip_id"]["tip_type_id"]["objectId"],
        tip["tip_id"]["category_id"]["objectId"],
        tip["tip_id"]["image"]["url"],
        tip["short"]);
  }
}
