import 'package:flutter_map/flutter_map.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

import 'database_classes/collection_point.dart';
import 'database_classes/collection_point_type.dart';

class DataHolder{

  static final List<WasteBinCategory> categories = [];
  static final Map<String, String> itemNames = {};
  static final List<CollectionPointType> collectionPointTypes = [];
  static final Map<Marker, CollectionPoint> markers = {};
  static final List<String> cpSubcategories = [];
}