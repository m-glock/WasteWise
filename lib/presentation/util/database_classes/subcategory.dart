class Subcategory {
  final String title;
  final String objectId;
  final String parentId;

  Subcategory(this.title, this.objectId, this.parentId);

  static Subcategory fromJson(Map<dynamic, dynamic> subcategory){
    return Subcategory(
        subcategory["title"],
        subcategory["subcategory_id"]["objectId"],
        subcategory["subcategory_id"]["category_id"]["objectId"]);
  }
}
