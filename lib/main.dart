import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../screens/home.dart';
import 'model/item.dart';

void main() async {

  // init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  // opent box
  var box = await Hive.openBox<Item>('items');

  // box.put(1, Item(id: 1, name: 'Jk'));
  // box.put(2, Item(id: 2, name: 'Hk'));

  print(box.values.toList());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocer Pro',
      home: Home(),
    );
  }
}
