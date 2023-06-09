class Item {
  int? id;
  String? name;
  bool isDone;
  double price = 0;

  Item({
    required this.id,
    required this.name,
    this.isDone = false,
    this.price = 0,
  });

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
