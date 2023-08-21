import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/colors.dart';
import '../model/item.dart';
import '../widgets/grocery_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Box<Item> box = Hive.box<Item>('items');
  // final itemList = Item.itemList();
  List<Item> foundItemList = [];
  final TextEditingController _newItemController = TextEditingController();
  bool showToast = false;

  @override
  void initState() {
    // foundItemList = itemList;
    foundItemList = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          'Grocery items',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Item item in foundItemList.reversed)
                        GroceryItem(
                          item: item,
                          onItemChange: _handleItemChange,
                          onItemDelete: _deleteItem,
                        ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 60,
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _newItemController,
                    decoration: const InputDecoration(
                        hintText: 'Add new item', border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addItem(_newItemController.text);
                      if (showToast) {
                        _showSnackBar(context, "Item added Successfully!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }

  void _handleItemChange(Item item) {
    setState(() {
      item.isDone = true;
      box.put(item.id, item);
      foundItemList = box.values.toList();
    });
  }

  void _deleteItem(int id) {
    setState(() {
      // itemList.removeWhere((item) => item.id == id);
      box.delete(id);
      foundItemList = box.values.toList();
    });
  }

  void _addItem(String name) {
    setState(() {
      if (name.isNotEmpty) {
        Item item = Item(id: DateTime.now().millisecond, name: name);
        // itemList.add(item);
        box.put(item.id, item);
        foundItemList = box.values.toList();
      }
      _newItemController.clear();
      showToast = true;
    });
  }

  void _doFilterItem(String value) {
    List<Item> result = [];
    if (value.isEmpty) {
      result = box.values.toList();
    } else {
      result = box.values.toList()
          .where((element) => element.name.toLowerCase().contains(value))
          .toList();
    }
    setState(() {
      foundItemList = result;
    });
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        height: 30,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: tdSoftGreen,
          borderRadius: BorderRadius.circular(5),
        ),
        child:
            Text(msg, style: const TextStyle(color: tdDarkGreen, fontSize: 16)),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _doFilterItem(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }
}
