class CollectionPointType{

  final String objectId;
  final String title;

  CollectionPointType(this.objectId, this.title);

  static CollectionPointType fromJson(dynamic collectionPointData){
    return CollectionPointType(
      collectionPointData["collection_point_type_id"]["objectId"],
      collectionPointData["title"],
    );
  }
}