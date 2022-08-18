import 'package:flutter/material.dart';
import '../../util/item.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image(image: image),
            Container(
              width: 50,
              height: 50,
              color: Colors.black12,
            ),
            Text("Material: Kunststoff"),
            Text("Tonne: Wertstofftonne"),
            Text("Mehr info zu Verpackungsmüll")
          ],
      ),
    );
  }
}
