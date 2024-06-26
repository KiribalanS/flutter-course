import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/models/meal_modal.dart';
import 'package:meals/providers/favourite_meals.dart';
import 'package:meals/providers/meals_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
    // required this.toggleFavourite,
  });
  final Meal meal;
  // final void Function(Meal meal) toggleFavourite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFavourite =
        ref.watch(favouritesProvider).contains(meal) ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isAdded =
                  ref.read(favouritesProvider.notifier).toggleFavourites(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded
                      ? "Added to favourites"
                      : "Removed from favourites"),
                ),
              );
            },
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(18),
                ),
                clipBehavior: Clip.hardEdge,
                child: Hero(
                  tag: meal.id,
                  child: Image.network(
                    fit: BoxFit.cover,
                    meal.imageUrl,
                  ),
                ),
              ),
            ),
            customText(context, "Ingredients", meal.ingredients),
            const SizedBox(
              height: 12,
              child: Divider(
                endIndent: 10,
                indent: 10,
                thickness: 2,
              ),
            ),
            customText(context, "Steps", meal.steps),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget customText(context, content, map) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        children: [
          Text(
            content,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(
            height: 25,
          ),
          ...map.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                e,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
