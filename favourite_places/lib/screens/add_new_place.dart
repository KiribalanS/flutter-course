import 'dart:io';
import 'package:favourite_places/models/location_modal.dart';
import 'package:favourite_places/models/places_modal.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/place_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({super.key});

  @override
  ConsumerState<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlace> {
  final TextEditingController titleController = TextEditingController();
  late File pickedImage;
  late PlaceLocationModal placeLocation;
  void saveData() {
    final val = titleController.text.trim();
    if (val.length < 2 || pickedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Add a title and image"),
        ),
      );
      return;
    }
    if (placeLocation == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Add a Location"),
        ),
      );
      return;
    }
    ref.read(userPlaces.notifier).addNewPlace(
          pickedImage,
          val,
          placeLocation,
        );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Place Name"),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              ImageInput(
                setImage: (File image) {
                  pickedImage = image;
                },
              ),
              const SizedBox(height: 16),
              PlaceLocationInput(
                onPlaceLocationChanged: (PlaceLocationModal location) {
                  // if (location == null) {
                  //   return;
                  // }
                  placeLocation = location;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: saveData,
                  child: const Text("Add Place"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
