import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/data/dummy.dart';
import 'package:meals/models/categories.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/meals_screen.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key, required this.category});
  final Categories category;

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final avlMeals = ref.watch(filteredMealsProvider);
    return InkWell(
      onTap: () {
        final categoryMeal = avlMeals
            .where((meal) => meal.categories.contains(widget.category.id))
            .toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealsScreen(
              meals: categoryMeal,
              title: widget.category.title,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(23),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                widget.category.color.withOpacity(0.5),
                widget.category.color,
              ],
            ),
          ),
          child: Text(
            widget.category.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
