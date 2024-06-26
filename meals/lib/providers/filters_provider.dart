import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters {
  isGlutenFree,
  isVegan,
  isVegetarian,
  isLactoseFree,
}

class FiltersProviderNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersProviderNotifier()
      : super({
          Filters.isGlutenFree: false,
          Filters.isVegan: false,
          Filters.isVegetarian: false,
          Filters.isLactoseFree: false,
        });
  void assignFilters(Map<Filters, bool> filters) {
    state = filters;
  }

  void setFilter(Filters filter, bool value) {
    state = {...state, filter: value};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProviderNotifier, Map<Filters, bool>>(
        (ref) => FiltersProviderNotifier());
