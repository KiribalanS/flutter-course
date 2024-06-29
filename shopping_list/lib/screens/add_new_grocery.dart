import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class AddNewGrocery extends StatefulWidget {
  const AddNewGrocery({super.key});

  @override
  State<AddNewGrocery> createState() => _AddNewGroceryState();
}

class _AddNewGroceryState extends State<AddNewGrocery> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  var title;
  var quantity;
  var category;

  Future<void> sendData() async {
    final url = Uri.parse(
        'https://dummy-sk-10a8a-default-rtdb.asia-southeast1.firebasedatabase.app/shopping_list.json');
    setState(() {
      isLoading = true;
    });
    await http
        .post(
      url,
      body: json.encode(
        {
          "title": title,
          "quantity": quantity,
          "category": category.title,
        },
      ),
    )
        .then(
      (value) {
        final response = json.decode(value.body);
        var id = response["name"];
        setState(() {
          isLoading = false;
        });
        Navigator.pop(
          context,
          GroceryItem(
            id: id,
            name: title,
            quantity: quantity,
            category: category,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new item"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 2) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  title = newValue;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Please enter valid input';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          quantity = int.tryParse(newValue);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButtonFormField(
                      value: categories[Categories.meat],
                      items: categories.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    color: e.value.color,
                                  ),
                                  const SizedBox(width: 19),
                                  Text(e.value.title),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        category = value;
                      },
                      onSaved: (newValue) {
                        category = newValue;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    formKey.currentState!.reset();
                  },
                  child: const Text("Reset"),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            sendData();
                          }
                        },
                  child: isLoading
                      ? const Text("Saving")
                      : const Text("Save data"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
