import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item),
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
          const Text("Material: Kunststoff"),
          const Text("Tonne: Wertstofftonne"),
          const Text("Mehr info zu Verpackungsmüll")
        ],
      ),
    );
  }
}
