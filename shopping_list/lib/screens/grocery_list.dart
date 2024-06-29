import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/category.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add_new_grocery.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool isLoading = false;
  void removeItem(GroceryItem item) async {
    final int index = _groceryItems.indexOf(item);
    deleteItem(item);
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Removed!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _groceryItems.insert(index, item);
            });
          },
        ),
      ),
    );
  }
//restore data needs firebase sdk.
  // void restoreData(GroceryItem item) async {
  //   final url = Uri.parse(
  //       'https://dummy-sk-10a8a-default-rtdb.asia-southeast1.firebasedatabase.app/shopping_list.json');
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await http.post(
  //     url,
  //     body: json.encode(
  //       {
  //         item.id: {
  //           "title": item.name,
  //           "quantity": item.quantity,
  //           "category": item.category.title,
  //         }
  //       },
  //     ),
  //   );
  // }

  void deleteItem(GroceryItem item) async {
    final url = Uri.parse(
        'https://dummy-sk-10a8a-default-rtdb.asia-southeast1.firebasedatabase.app/shopping_list/${item.id}.json');
    await http.delete(url);
  }

  void getData() async {
    final url = Uri.parse(
        'https://dummy-sk-10a8a-default-rtdb.asia-southeast1.firebasedatabase.app/shopping_list.json');
    final response = await http.get(url);

    final Map<String, dynamic> data = json.decode(response.body);
    final List<GroceryItem> items = [];
    data.forEach(
      (key, value) {
        if (value == null) {
          return;
        }
        final color = categories.entries.firstWhere(
          (element) => element.value.title == value["category"],
        );
        items.add(
          GroceryItem(
            id: key,
            name: value["title"],
            quantity: value["quantity"],
            category: CategoryModal(
              value["category"],
              color.value.color,
            ),
          ),
        );
      },
    );
    setState(() {
      _groceryItems = items;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "Onnume illa\nPoi Ethavathu add pannu po...",
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: Key(_groceryItems[index].id),
          onDismissed: (direction) {
            removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewGrocery(),
                ),
              );
              if (result != null) {
                setState(() {
                  _groceryItems.add(result);
                });
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : content,
    );
  }
}
