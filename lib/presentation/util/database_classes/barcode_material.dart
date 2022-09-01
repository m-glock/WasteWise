import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class BarcodeMaterial{

  final String title;
  final int binaryValue;
  final WasteBinCategory category;

  BarcodeMaterial(this.title, this.binaryValue, this.category);
}