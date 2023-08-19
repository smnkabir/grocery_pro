import 'package:hive_flutter/hive_flutter.dart';

class Item {
  int id;
  String name;
  bool isDone;
  double price = 0;

  Item({
    required this.id,
    required this.name,
    this.isDone = false,
    this.price = 0,
  });


  @override
  String toString() {
    return 'Item{id: $id, name: $name, isDone: $isDone, price: $price}';
  }

  static List<Item> itemList() {
    return [
      Item(id: 1, name: 'Alu', isDone: true),
      Item(id: 2, name: 'Potol',),
      Item(id: 3, name: 'Piaj',),
      Item(id: 4, name: 'Roshun',),
      Item(id: 5, name: 'Morich',),
      Item(id: 6, name: 'Morich1',),
      Item(id: 7, name: 'Morich2',),
      Item(id: 8, name: 'Morich3',),
      Item(id: 9, name: 'Morich4',),
    ];
  }
}

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0; // Assign a unique ID for the adapter

  @override
  Item read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final isDone = reader.readBool();
    final price = reader.readDouble();
    return Item(id: id, name: name, isDone: isDone, price: price);
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeBool(obj.isDone);
    writer.writeDouble(obj.price);
  }
}
