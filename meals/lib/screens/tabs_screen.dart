import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourite_meals.dart';

import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/drawer_screen.dart';
import 'package:meals/screens/meals_screen.dart';

class TabBarScreen extends ConsumerWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeals = ref.watch(favouritesProvider);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: const DrawerScreen(),
        appBar: AppBar(
          title: const Text('Meals'),
        ),
        body: TabBarView(
          children: <Widget>[
            const CategoriesScreen(),
            MealsScreen(title: "", meals: favMeals),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.food_bank),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}
