import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class BarcodeResult{

  static List<int> binaryNumbers = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512];

  static Item getItemFromBarcodeInfo(String responseBody){
    List<String> values = responseBody.split("\n");
    String name = values.firstWhere((element) =>
        element.startsWith("name")).split("=")[1];
    String packNr = values.firstWhere((element) =>
        element.startsWith("pack")).split("=")[1];

    List<int> numbers = getValues(packNr);
    String material = getMaterial(numbers);
    String explanation = getExplanation(packNr);
    WasteBinCategory wasteBin = getWasteBin(packNr);
    return Item(
        name,
        explanation,
        material,
        wasteBin.title, //TODO subcategory
        wasteBin,
        false
    );
  }

  static List<int> getValues(String packNr){
    String binaryNumberString = int.parse(packNr).toRadixString(2);
    Characters chars = binaryNumberString.characters;
    Iterator<int> binaryIterator = binaryNumbers.iterator;
    List<int> numbers = [];
    for(int index = chars.length - 1; index >= 0; index--){
      binaryIterator.moveNext();
      int currentBinary = binaryIterator.current;
      int currentNumber = int.parse(chars.elementAt(index));
      if(currentNumber == 1) numbers.add(currentBinary);
    }
    return numbers;
  }

  // TODO: create short explanation depending on material?
  static String getExplanation(String packNr){
    return "No explanation available";
  }

  //TODO ignore 64 and up
  static String getMaterial(List<int> numbers){
    String material = "";
    for(int number in numbers) {
      switch (number) {
        case 1: material += "überwiegend Plastik"; break;
        case 2: material += "überwiegend Verbundmaterial"; break;
        case 4: material += "überwiegend Papier/Pappe"; break;
        case 8: material += "überwiegend Glas/Keramik/Ton"; break;
        case 16: material += "überwiegend Metall"; break;
        case 32: material += "unverpackt"; break;
        case 64: material += "komplett frei von Plastik"; break;
        case 128: material += "übertrieben stark verpackt"; break;
        case 256: material += "angemessen sparsam verpackt"; break;
        case 512: material += "Pfandsystem / Mehrwegverpackung"; break;
        default: material += "Unbekannt";
      }
    }
    return material;
  }

  //TODO: what if it does not fit into one/any category?
  static WasteBinCategory getWasteBin(String packNr){
    return DataHolder.categories.elementAt(2);
  }
}