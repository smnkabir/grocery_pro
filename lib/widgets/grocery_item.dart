import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/item.dart';

class GroceryItem extends StatelessWidget {
  final Item item;
  final onItemChange;
  final onItemDelete;

  const GroceryItem({Key? key, required this.item, required this.onItemChange, required this.onItemDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onItemChange(item);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          item.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          item.name!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: item.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed:() {onItemDelete(item.id);},
          ),
        ),
      ),
    );
  }
}
