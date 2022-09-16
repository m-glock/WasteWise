String getTimeframe(DateTime createdAt){
  DateTime now = DateTime.now();
  Duration duration = now.difference(createdAt);
  if(duration.inDays > 14){
    return "vor mehr als zwei Wochen";
  } else if(duration.inDays > 7){
    return "vor einer Woche";
  } else if(duration.inDays > 1){
    return "vor ${duration.inDays} Tagen";
  } else if(duration.inDays == 1){
    return "vor einem Tag";
  } else if(duration.inHours > 1){
    return "vor ${duration.inHours} Stunden";
  } else if(duration.inHours == 1){
    return "vor einer Stunde";
  } else if(duration.inMinutes > 1){
    return "vor ${duration.inMinutes} Minuten";
  } else {
    return "gerade eben";
  }
}