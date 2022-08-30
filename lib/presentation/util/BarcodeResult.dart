import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';
import 'barcode_materials.dart';

class BarcodeResult{

  static List<int> binaryNumbers = [1, 2, 4, 8, 16];
  static List<String> materials = [];

  static Item? getItemFromBarcodeInfo(String responseBody){
    if(!responseBody.contains("error=0")) return null;

    List<String> values = responseBody.split("\n");
    String name = values.firstWhere((element) =>
        element.startsWith("name")).split("=")[1];
    String packNr = values.firstWhere((element) =>
        element.startsWith("pack")).split("=")[1];

    List<int> numbers = getValues(packNr);
    if(numbers.length == 1){
      String material = getMaterial(numbers).join(",");
      WasteBinCategory wasteBin = getWasteBin(packNr);

      return Item(
          name,
          null,
          material,
          null,
          wasteBin,
          false
      );
    } else {
      //TODO: handle this
      return Item("Unknown", "", "", "", DataHolder.categories.first, false);
    }
  }

  static List<int> getValues(String packNr){
    Characters chars = int.parse(packNr).toRadixString(2).characters;
    Iterator<int> binaryIterator = binaryNumbers.iterator;
    List<int> numbers = [];
    int endIndex = chars.length > binaryNumbers.length
        ? chars.length - binaryNumbers.length
        : 0;
    for(int i = chars.length - 1; i >= endIndex; i--){
      binaryIterator.moveNext();
      int currentBinary = binaryIterator.current;
      int currentNumber = int.parse(chars.elementAt(i));
      if(currentNumber == 1) numbers.add(currentBinary);
    }
    return numbers;
  }

  static List<String> getMaterial(List<int> numbers){
    List<String> material = [];
    for(int number in numbers) {
      switch (number) {
        case 1: material.add(ItemMaterial.plastic.name); break;
        case 2: material.add(ItemMaterial.compositeMaterial.name); break;
        case 4: material.add(ItemMaterial.paper.name); break;
        case 8: material.add(ItemMaterial.glass.name); break;
        case 16: material.add(ItemMaterial.metal.name); break;
        default: material.add(ItemMaterial.unknown.name);
      }
    }
    return material;
  }

  //TODO: what if it does not fit into one/any category?
  static WasteBinCategory getWasteBin(String packNr){
    return DataHolder.categories.elementAt(2);
  }
}