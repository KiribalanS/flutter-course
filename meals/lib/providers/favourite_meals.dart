import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_modal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);
  bool toggleFavourites(Meal meal) {
    if (state.contains(meal)) {
      // state.remove(meal);
      state = state.where((e) => meal.id != e.id).toList(); // remove the meal
      return false;
    } else {
      state = [...state, meal]; //add meal
      return true;
      // state.add(meal);
    }
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
  (ref) => FavouriteMealsNotifier(),
);
