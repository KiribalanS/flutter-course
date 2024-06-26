import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filters!",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SwitchListTile(
              value: currentFilters[Filters.isGlutenFree]!,
              onChanged: (val) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.isGlutenFree, val);
              },
              title: Text(
                "Gluten free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SwitchListTile(
              value: currentFilters[Filters.isVegan]!,
              onChanged: (val) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.isVegan, val);
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SwitchListTile(
              value: currentFilters[Filters.isLactoseFree]!,
              onChanged: (val) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.isLactoseFree, val);
              },
              title: Text(
                "Lactose free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SwitchListTile(
              value: currentFilters[Filters.isVegetarian]!,
              onChanged: (val) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.isVegetarian, val);
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
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
