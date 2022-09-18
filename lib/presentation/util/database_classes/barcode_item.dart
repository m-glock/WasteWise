import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class BarcodeItem {
  final String title;
  final String? material;
  final List<WasteBinCategory> wasteBin;

  BarcodeItem(this.title, {this.material, required this.wasteBin});
}