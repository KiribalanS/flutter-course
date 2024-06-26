import 'package:flutter/material.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/models/meal_modal.dart';
import 'package:meals/widgets/meal_widget.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key, required this.title, required this.meals});
  final List<Meal> meals;
  final String title;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  // // final List<Meal> _favouriteMeals = [];
  // void toggleFavourite(Meal meal) {
  //   if (favouriteMeals.contains(meal)) {
  //     setState(() {
  //       favouriteMeals.remove(meal);
  //     });
  //   } else {
  //     setState(() {
  //       favouriteMeals.add(meal);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title == ""
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: widget.meals.isEmpty
          ? Center(
              child: Text(
                textAlign: TextAlign.center,
                "No meals found!!\nTry another Category :>",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 25,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: widget.meals.length,
              itemBuilder: (context, index) => MealWidget(
                meal: widget.meals[index],
                // toggleFavourite: (meal) => toggleFavourite(meal),
              ),
            ),
    );
  }
}
