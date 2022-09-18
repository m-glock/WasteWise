import 'package:flutter/material.dart';
import 'database_classes/barcode_item.dart';
import 'database_classes/barcode_material.dart';

class BarcodeResult {
  static List<int> binaryNumbers = [1, 2, 4, 8, 16];
  static List<String> materials = [];

  static BarcodeItem getItemFromBarcodeInfo(
      String responseBody, Map<int, BarcodeMaterial> barcodeMaterials) {
    List<String> values = responseBody.split("\n");
    String name = values
        .firstWhere((element) => element.startsWith("name"))
        .split("=")[1];
    String packNr = values
        .firstWhere((element) => element.startsWith("pack"))
        .split("=")[1];

    List<int> numbers = getValues(packNr);
    if (numbers.length <= 1) {
      BarcodeMaterial? material = numbers.isEmpty ? null : barcodeMaterials[numbers.first];

      return BarcodeItem(name, material: material?.title, wasteBin: material?.category);
    } else {
      //TODO: handle this
      for(int number in numbers){

      }
      return BarcodeItem("Unknown", material: "", wasteBin: null);
    }
  }

  static List<int> getValues(String packNr) {
    Characters chars = int.parse(packNr).toRadixString(2).characters;
    Iterator<int> binaryIterator = binaryNumbers.iterator;
    List<int> numbers = [];
    int endIndex = chars.length > binaryNumbers.length
        ? chars.length - binaryNumbers.length
        : 0;
    for (int i = chars.length - 1; i >= endIndex; i--) {
      binaryIterator.moveNext();
      int currentBinary = binaryIterator.current;
      int currentNumber = int.parse(chars.elementAt(i));
      if (currentNumber == 1) numbers.add(currentBinary);
    }
    return numbers;
  }
}
