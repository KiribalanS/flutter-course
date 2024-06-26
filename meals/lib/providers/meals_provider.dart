import 'package:meals/providers/filters_provider.dart';
import 'package:riverpod/riverpod.dart';

import 'package:meals/data/dummy.dart';

final mealsProvider = Provider(
  (ref) => dummyMeals,
);

final filteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final filter = ref.watch(filtersProvider);

    return meals.where((meal) {
      if (filter[Filters.isGlutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filter[Filters.isLactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filter[Filters.isVegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filter[Filters.isVegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  },
);
