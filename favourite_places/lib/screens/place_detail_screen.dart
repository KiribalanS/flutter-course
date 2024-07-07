import 'package:favourite_places/data/places_data.dart';
import 'package:favourite_places/models/places_modal.dart';
import 'package:favourite_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({required this.place, super.key});
  final PlacesModal place;
  String get locationImage {
    return "https://api.tomtom.com/map/1/staticimage?key=YOUR_API_KEY_TOM_TOM&zoom=9&center=${place.placeLocation.longitude},${place.placeLocation.latitude}&format=jpg&layer=basic&style=main&width=650&height=500&language=en-US";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placeName),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.55,
            child: Image.file(
              place.image,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapsScreen(
                            isSelection: false,
                            placeLocation: place.placeLocation,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 71,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    place.placeLocation.address,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
