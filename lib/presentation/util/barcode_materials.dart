enum ItemMaterial{
  plastic,
  compositeMaterial,
  paper,
  glass,
  metal,
  unknown
}

extension ItemMaterialExtension on ItemMaterial{

  String get name {
    switch(this){
      case ItemMaterial.plastic: return "überwiegend Plastik";
      case ItemMaterial.compositeMaterial: return "überwiegend Verbundmaterial";
      case ItemMaterial.paper: return "überwiegend Papier/Pappe";
      case ItemMaterial.glass: return "überwiegend Glas/Keramik/Ton";
      case ItemMaterial.metal: return "überwiegend Metall";
      case ItemMaterial.unknown: return "Unbekannt";
    }
  }

}