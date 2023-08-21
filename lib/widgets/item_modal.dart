import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/item.dart';

class ItemModal extends StatefulWidget {
  final Item item;
  final updatePrice;

  ItemModal({required this.item, required this.updatePrice});

  @override
  _ItemModalState createState() => _ItemModalState();
}

class _ItemModalState extends State<ItemModal> {
  late TextEditingController _priceController;
  double availableHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _priceController =
        TextEditingController(text: widget.item.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        availableHeight = constraints.maxHeight;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: availableHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase Amount of ${widget.item.name}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Tk',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      double newPrice = double.parse(_priceController.text);
                      widget.item.price = newPrice;
                      widget.updatePrice(widget.item);
                      Navigator.pop(context);
                    },
                    child: Text('Purchase'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
