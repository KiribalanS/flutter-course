import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_new_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PLacesListScreen extends ConsumerStatefulWidget {
  const PLacesListScreen({super.key});

  @override
  ConsumerState<PLacesListScreen> createState() => _PLacesListScreenState();
}

class _PLacesListScreenState extends ConsumerState<PLacesListScreen> {
  late Future<void> didLoadedPlaces;
  @override
  void initState() {
    super.initState();
    didLoadedPlaces = ref.read(userPlaces.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(userPlaces);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNewPlace(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: didLoadedPlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return PlacesList(places: places);
        },
      ),
    );
  }
}
