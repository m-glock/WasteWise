class Item{
  final String title;
  final String synonyms;
  /*final String material;
  final String explanation;
  final WasteBinCategory wasteBin;*/

  Item(this.title, this.synonyms/*, this.material, this.explanation, this.wasteBin*/);

  String getWords(){
    return "$title, $synonyms";
  }
}