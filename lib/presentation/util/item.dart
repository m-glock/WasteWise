import 'package:recycling_app/presentation/util/waste_bin_category.dart';

class Item{

  final String title;
  final String? explanation;
  final String material;
  final WasteBinCategory? wasteBin;

  Item(this.title, this.explanation, this.material, this.wasteBin);
}