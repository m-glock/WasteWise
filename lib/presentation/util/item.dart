import 'package:recycling_app/presentation/util/waste_bin_category.dart';

class Item {
  final String title;
  final String explanation;
  final String material;
  final String subcategory;
  final WasteBinCategory wasteBin;
  final bool bookmarked;

  Item(this.title, this.explanation, this.material, this.subcategory,
      this.wasteBin,
      {this.bookmarked = false});
}
