class Tip {
  final String title;
  final String explanation;
  final String short;
  final String tipTypeId;
  final String categoryId;
  final String imageUrl;
  bool isBookmarked;

  Tip(this.title, this.explanation, this.tipTypeId, this.categoryId, this.imageUrl,
      {this.short = "", this.isBookmarked = false});
}
