import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = [];
  TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      items = prefs.getStringList('items') ?? [];
    });
  }

  void saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', items);
  }

  void addItem() {
    setState(() {
      items.add(itemController.text);
      itemController.clear();
      saveItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: itemController,
              decoration: InputDecoration(
                labelText: 'Novo Item',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addItem,
            child: Text('Adicionar Item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
