import 'package:flutter/material.dart';

import 'package:shopping_list/models/category.dart';

const categories = {
  Categories.vegetables: CategoryModal(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: CategoryModal(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: CategoryModal(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: CategoryModal(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: CategoryModal(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: CategoryModal(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: CategoryModal(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: CategoryModal(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: CategoryModal(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: CategoryModal(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
