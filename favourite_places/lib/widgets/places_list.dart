import 'package:favourite_places/models/places_modal.dart';
import 'package:favourite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.places, super.key});
  final List<PlacesModal> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No places added yet",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesScreen(place: places[index]),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].placeName,
          ),
          subtitle: Text(
            places[index].placeLocation.address,
          ),
        );
      },
    );
  }
}
